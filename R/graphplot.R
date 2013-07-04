#' simple plotting function for graph_pipe output
#'
#' @param g a igraph object
#'
#' @return
#' a circular network graph
#'
#' @export
#'
#' @examples
#' paths = c("open|action1|action2|action3|action4|exit",
#'           "open|action1|exit",
#'           "open|action1|action2|action1|exit")
#' g = graphpipe(paths)
#' graphplot(g)
library("igraph")

graphplot <- function(g,
                       min_edge_weight = 0,
                       edge_size = 10,
                       vertex_size=20,
                       arrow_width = 1,
                       arrow_size = 0.8
                       ) {
  g <- delete.edges(g, which(E(g)$Weight <= min_edge_weight))
  layout <- layout.circle(g)
  plot(g,
       layout=layout,
       edge.width=(E(g)$Weight/max(E(g)$Weight+1)) * edge_size,
       vertex.shape="circle",
       vertex.size=((V(g)$Events+1)/max(V(g)$Events+1)) * vertex_size,
       vertex.label=V(g)$name,
       edge.arrow.width = arrow_width,
       edge.arrow.size = arrow_size,
       vertex.label.font=2,
       vertex.label.cex=1,
       edge.curved=TRUE)
}