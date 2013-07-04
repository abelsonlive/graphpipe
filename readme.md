# graphpipe
```
                                 ,-.
                                ( o )_, ,-.
                                 `-`./\( o )
                                    /`.\/-'
        ,--.                        \=+'  ,--.
       /  /|                         O   /  /|
      /  / |                            /  / |
     ,--:  \                           .--:  |
     |  | ,-:                          |  |  |
     |  |( o-);-.                      |  |  |
     |  \ `-'/\_ \_O                 ,'/  |  |
     |   \  '\-\`--'__          __,-' /   |  |
     |    `.( o')     ``------''    ,'    |  |
     |      `:-'                  ,'      |  |
     |        `-.__          __,-'        | /
     |             ``------''             |/
     `------------------------------------'

```

When tracking activity through a website, an easy way to capture the path of that activity is by recording every action and separating the list of all actions with pipes (`|`):
```
open|action1|action2|action3|action4|exit
```
Given lists of these pipe-delimited action paths, `graphpipe` will split these apart and create an aggregate of all possible paths, represented as an `R` `igraph` object:
```
paths = c("open|action1|action2|action3|action4|exit",
          "open|action1|exit",
          "open|action1|action2|action1|exit")
g = graphpipe(paths)
graphplot(g)

```
`graphplot` can accept some simple arguments to filter and style the resulting graph

```
graphplot(min_edge_weight = 2, # number of links necessary to include an edge
          edge_size = 20, # scale the edges
          vertex_size=20, # scale verticies
          arrow_width = 0.5, # scale arrow width
          arrow_size = 0.25 # scale arrow size
          )
```
## INSTALLATION
```
library("devtools")
install_github("abelsonlive", "graphpipe")
library("graphpipe")
```
