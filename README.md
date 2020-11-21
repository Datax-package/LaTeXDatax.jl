# LaTeXDatax
Save specified variables to a data file to be read into a LaTeX document using the accompanying package `datax.sty`.

## Installation
`using Pkg;Pkg.add("https://github.com/Datax-package/LaTeXDatax.jl")`, and install [the datax package [ctan]](https://ctan.org/tex-archive/macros/latex/contrib/datax).

## Usage
```julia
using LaTeXDatax
a = 25;
b = "Something";
c = (300,"\\mega\\meter\\per\\second");
d = 4.2u"Hz";

@datax a b c d
```

```latex
...  
\usepackage{siunitx}
\usepackage{datax}
...
The speed of light is \datax{c}.
```
