module Datax
using  Requires

export datax,@datax

# TODO: use printf

"""
```julia
datax(...)
```
Print the arguments to a file readable by pgfkeys (Best for use with the `datax` LaTeX package)
There's also a macro form, `@datax`, which reuses the variable names from the script.

# Examples
```julia
datax(a=2,b=1.24,c="hi",d=(24,"\\meter"),e=15u"kg/s^2")
```
Save the given variables in siunitx form
"""
function datax(;kwargs...)
    datax(Dict(kwargs))
end

function datax(d::Dict{Symbol,<:Any};filename::String="data.tex")
    open(filename,"w") do f
        for (k,v) in d
            print(f,"\\pgfkeyssetvalue{/datax/$k}{")
            printdata(f,v)
            print(f,"}\n")
        end
    end
end

"""
```julia
@datax ...
```
Print the arguments to a file readable by pgfkeys (Best for use with the `datax` LaTeX package)
Use the variables' names.

# Examples
```julia
a=2;
b=3.2u"m"
c="hi"
@datax a b c
```
"""
macro datax(varargs...)
    return quote
        datax(
              Dict(
                   [
                    d => eval(d)
                    for d in $(esc(varargs))
                   ]
                  )
             )
    end
end

printdata(f::IO,v::String) = print(f,v)
printdata(f::IO,v::Number) = print(f,"\\num{$v}")
printdata(f::IO,v::Tuple{<:Number,String}) = print(f,"\\SI{$(v[1])}{$(v[2])}")

function __init__()
    @require Unitful="1986cc42-f94f-5a68-af5c-568840ba703d" begin

        function printdata(f::IO,v::Unitful.Quantity)
            print(f,"\\SI{$(v.val)}{")
            siunitxprint(f,Unitful.unit(v))
            print(f,"}")
        end

        function siunitxprint(f::IO,u::Unitful.FreeUnits)
            prefixes = Dict(
                            -24 => "\\yocto",
                            -21 => "\\zepto",
                            -18 => "\\atto",
                            -15 => "\\femto",
                            -12 => "\\pico",
                            -9  => "\\nano",
                            -6  => "\\micro",
                            -3  => "\\milli",
                            -2  => "\\centi",
                            -1  => "\\deci",
                            0   => "",
                            1   => "\\deka",
                            2   => "\\hecto",
                            3   => "\\kilo",
                            6   => "\\mega",
                            9   => "\\giga",
                            12  => "\\tera",
                            15  => "\\peta",
                            18  => "\\exa",
                            21  => "\\zetta",
                            24  => "\\yotta"
                           )
            for p in typeof(u).parameters[1]
                p.power<0 && print(f,"\\per")
                iszero(p.tens) || print(f,prefixes[p.tens])
                print(f,"\\$(lowercase(String(Unitful.name(p))))")
                abs(p.power)==1 || print(f,"\\tothe$(Int64(abs(p.power)))")
            end
        end

    end
end

end # module
