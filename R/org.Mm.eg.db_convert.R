## Convert all the tables in org.Mm.eg.db to data.frames

#' Entrez to GenBank
org.Mm.egACCNUM_2DF <- function() {
  require('org.Mm.eg.db')

  x <- org.Mm.egACCNUM
  mapped_genes <- mappedkeys(x)
  xx <- as.list(x[mapped_genes])

  res <- data.frame(
    entrezID = names(xx),
    first = lapply(xx,'[',1),
    all = lapply(xx, paste, collapse=';'),
    stringsAsFactors = FALSE
  )

  res
}


{
  if(length(xx) > 0) {
    # Get the ACCNUM for the first five genes
    xx[1:5]
    # Get the first one
    xx[[1]]
  }

  #For the reverse map ACCNUM2EG:
  # Convert to a list
  xx <- as.list(org.Mm.egACCNUM2EG)

  if(length(xx) > 0){
    # Gets the entrez gene identifiers for the first five Entrez Gene IDs
    xx[1:5]
    # Get the first one
    xx[[1]]
  }

}
