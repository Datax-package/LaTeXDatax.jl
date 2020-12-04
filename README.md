# LaTeXDatax
Save specified variables to a data file to be read into a LaTeX document using
the accompanying package `datax.sty`.

## Installation
`using Pkg;Pkg.add("LaTeXDatax")`, and install [the datax package
[ctan]](https://ctan.org/tex-archive/macros/latex/contrib/datax).

## Usage
```julia
using LaTeXDatax
filename = "datafile.tex"; # default is "data.tex"
a = 25;
b = "Something";
c = (300,"\\mega\\meter\\per\\second");

using Unitful
d = 4.2u"Hz";

@datax a b c d filename
# or, equivalently,
data(a=a, b="Something", c=c, d=d, filename="datafile.tex");
```

```latex
\documentclass{article}
\usepackage{siunitx}
\usepackage[dataxfile=datafile.tex]{datax}

\begin{document}
The speed of light is \datax{c}.
\end{document}
```

More detailed usage information is in the docstrings of the code, run `?datax`
and `?@datax` in REPL to read them.
