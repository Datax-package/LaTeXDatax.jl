# LaTeXDatax
Save specified variables to a data file to be read into a LaTeX document using
the accompanying package `datax.sty`.

## Installation
`using Pkg;Pkg.add("LaTeXDatax")`, and install [the datax package
[ctan]](https://ctan.org/tex-archive/macros/latex/contrib/datax).

## Usage
```julia
using LaTeXDatax, Unitful
a = 25;

@datax a b=3a c=3e8u"m/s" d="Raw string" filename:="data.tex"
```

```latex
\documentclass{article}
\usepackage{siunitx}
\usepackage[dataxfile=data.tex]{datax}

\begin{document}
The speed of light is \datax{c}.
\end{document}
```

More detailed usage information is in the docstrings of the code, run `?@datax`
in REPL to read them.
