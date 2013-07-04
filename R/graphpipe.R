#' submit given a list of pipe-separated paths, create an igraph object
#'
#' @param paths a list of pipe-separated paths
#'
#' @return
#' a data.frame consisting of your query results.
#'
#' @export
#'
#' @examples
#' paths = c("open|action1|action2|action3|action4|exit",
#'           "open|action1|exit",
#'           "open|action1|action2|action1|exit")
#' g = graphpipe(paths)
#' graphpipe(g)
graphpipe <- function(paths, directed=TRUE) {

  # HELPER FX
  gen_edge_list <- function(event_path, rm_nas=TRUE) {
    event_path <- event_path[!is.na(event_path)]
    events = unlist(str_split(event_path, "\\|"))
    events <- events[!is.na(events) & events!=""]
    n = length(events) - 1
    if (rm_nas) {
      if (n>1 & !is.na(n)){
        event_df <- data.frame(Source=rep("", n), Target=rep("", n), stringsAsFactors=FALSE)
        for (i in 1:n) {
          event_df$Source[i] <- events[i]
          event_df$Target[i] <- events[i+1]
        }
        return(event_df)
      } else {
        event_df <- data.frame(Source=rep("", n), Target=rep("", n), stringsAsFactors=FALSE)
        for (i in 1:n) {
          event_df$Source[i] <- events[i]
          event_df$Target[i] <- events[i+1]
        }
        return(event_df)
      }
    }
  }

  edges_nodes_to_graph <- function(e, n, dir=TRUE) {

    # make necessary transformations
    d <- apply(as.matrix(e[,1:2]), 2, as.character)

    g <- graph.data.frame(d, directed=dir, vertices=n)
    E(g)$Weight <- e$Weight
    V(g)$Degrees <- degree(g)
    return(g)
  }

  #RUNNER
  cat("generating edgelists and reducting into single data.frame\n")
  edge_list <- ldply(paths, gen_edge_list, rm_nas=TRUE, .progress="text")

  # create node table
  cat("generating nodetable\n")
  node_ids <- c(edge_list$Source, edge_list$Target)
  t_nodes <- table(node_ids)
  nodes <- data.frame(Id=names(t_nodes), Events=as.numeric(t_nodes))

  # create simple edge table
  cat("aggregating edges\n")
  edge_ids <- paste(edge_list$Source, edge_list$Target, sep="|")
  t_edges <- table(edge_ids)
  edges <- ldply(names(t_edges), gen_edge_list, rm_nas=TRUE)
  edges$Weight = as.numeric(t_edges)

  # convert to graph
  cat("converting to graph\n")

  return(edges_nodes_to_graph(edges, nodes, dir=directed))
}