#' Get symbol level homology map between human and mouse
hommap.mm.2.hs.symbols <- function() {
    require('biomaRt');
    require('magrittr');
    require('tibble');
    require('dplyr')
    mart.obj <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = 'mmusculus_gene_ensembl')
    hs.mm.homologue <- getBM(
        attributes = c('external_gene_name','hsapiens_homolog_associated_gene_name'),
        mart=mart.obj
    )
    ## remove genes without mapping
    head(hs.mm.homologue)
    hs.mm.homologue <- as.tibble(hs.mm.homologue)
    hs.mm.homologue %>% filter(hsapiens_homolog_associated_gene_name != "") -> hs.mm.homologue
    ## return
    hs.mm.homologue
}

hommap.mm.symbol.2.entrezID <- function() {
    require('org.Mm.eg.db')
    require('reshape2')
    x <- org.Mm.egSYMBOL
    mapped_genes <- mappedkeys(x)
    xx <- as.list(x[mapped_genes])
    entrez2symbol <- melt(xx)
    rm(x, xx)
    names(entrez2symbol) <- c('symbol','entrezID')
    entrez2symbol
}


#' Used during development to generate data objects that are saved with this package
generateDataObjects <- function() {
    hs.mm.homologue <- hommap.mm.2.hs.symbols()
    save(hs.mm.homologue,file='../data/hs.mm.homologue.RData')

    mm.entrez2symbol <- hommap.mm.symbol.2.entrezID()
    save(mm.entrez2symbol,file='../data/mm.entrez2symbol.RData')
}
