using Unitful, LaTeXDatax, JuliaFormatter
using Test
# Supply "overwrite" as a commandline argument to overwrite in formatting step
overwrite = get(ARGS, 1, "") == "overwrite"

cd(@__DIR__)

@testset "LaTeXDatax.jl" begin
    io = IOBuffer()

    # Basic data printing
    LaTeXDatax.printdata(io, "String")
    @test String(take!(io)) == "String"

    LaTeXDatax.printdata(io, 1.25)
    @test String(take!(io)) == "\$1.25\$"

    LaTeXDatax.printdata(io, 3.141592; fmt="%.2f", unitformat=:siunitx)
    @test String(take!(io)) == "\\num{3.14}"

    # keyval printing
    LaTeXDatax.printkeyval(io, :a, 612.2u"nm")
    @test String(take!(io)) == "\\pgfkeyssetvalue{/datax/a}{\$612.2\\;\\mathrm{nm}\$}\n"

    # complete macro
    a = 2
    b = 3.2u"m"
    @datax a b c = 3 * a d = 27 unitformat := :siunitx io := io
    @test String(take!(io)) == """
    \\pgfkeyssetvalue{/datax/a}{\\num{2}}
    \\pgfkeyssetvalue{/datax/b}{\\qty{3.2}{\\meter}}
    \\pgfkeyssetvalue{/datax/c}{\\num{6}}
    \\pgfkeyssetvalue{/datax/d}{\\num{27}}
    """

    # Write to file
    rm.(("data.tex", "test.pdf", "test.log"); force=true)
    @datax a b c = 3 * a d = 27 unitformat := :siunitx filename := "data.tex"
    @test isfile("data.tex")
    @test_nowarn run(`pdflatex --file-line-error --interaction=nonstopmode test.tex`)
    rm("test.aux"; force=true)
end
@testset "Formatting" begin
    is_formatted = JuliaFormatter.format(LaTeXDatax; overwrite)
    @test is_formatted
    if ~is_formatted
        if overwrite
            println("The package has now been formatted. Review the changes and commit.")
        else
            println(
                "The package failed formatting check. Try `JuliaFormatter.format(LaTeXDatax)`",
            )
        end
    end
end
