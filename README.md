# Datax
Save specified variables to a data file to be read into a LaTeX document using the accompanying package `datax.sty`.

## Installation
`using Pkg;Pkg.add("https://github.com/Datax-package/Datax.jl")`, and install [the datax package](https://github.com/Datax-package/Datax.sty).

## Usage
```julia
using Datax
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
