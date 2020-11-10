using Unitful,Datax
using Test

@testset "Datax.jl" begin
    io = IOBuffer();

    # Basic printing
    Datax.printdata(io,"String","%.4g")
    @test String(take!(io)) == "String"
    Datax.printdata(io,4.1,"%.4g")
    @test String(take!(io)) == "\\num{4.1}"
    Datax.printdata(io,[1.0,2.4,3.0],"%.4g")
    @test String(take!(io)) == "\\numlist{1;2.4;3;}"

    # Print units
    Datax.printdata(io,(1.0,"\\meter"),"%.4g")
    @test String(take!(io)) == "\\SI{1}{\\meter}"
    Datax.printdata(io,([1,2,3],"\\kilogram"),"%.4g")
    @test String(take!(io)) == "\\SIlist{1;2;3;}{\\kilogram}"

    # Format strings
    Datax.printdata(io,pi,"%.3g")
    @test String(take!(io)) == "\\num{3.14}"
    Datax.printdata(io,("%.2g",pi),"%.4g")
    @test String(take!(io)) == "\\num{3.1}"
    Datax.printdata(io,("%.5g",pi,"\\liter"),"%.4g")
    @test String(take!(io)) == "\\SI{3.1416}{\\liter}"

    # Unitful
    Datax.printdata(io,2u"m","%.4g")
    @test String(take!(io)) == "\\SI{2}{\\meter}"
    Datax.printdata(io,[1.4,2.8]u"g/J","%.4g")
    @test String(take!(io)) == "\\SIlist{1.4;2.8;}{\\gram\\per\\joule}"

end
