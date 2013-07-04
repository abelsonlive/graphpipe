GraphPipe
==========

When tracking activity through a website, an easy way to capture the path of that activity is by recording every action and separating the list of all actions with pipes (`|`):
```
open|action1|action2|action3|action4|exit
```
Given lists of these pipe-delimited action paths, `graph_pipe` will split these apart and create an aggregate of all possible paths, represented as an `R` `igraph` object:
```
paths = c("open|action1|action2|action3|action4|exit",
          "open|action1|exit",
          "open|action1|action2|action1|exit")
g = graphpipe(paths)
graphplot(g)
```
## INSTALLATION
```
library("devtools")
install_github("abelsonlive", "graphpipe")
library("graphpipe")
```