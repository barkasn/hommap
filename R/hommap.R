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
    hs.mm.homologue %>% filter(hsapiens_homolog_associated_gene_name != "") 
    ## return
    hs.mm.homologue
}


#' Used during development to generate data objects that are saved with this package
generateDataObjects <- function() {
    hs.mm.homologue <- hommap.mm.2.hs.symbols()
    save(hs.mm.homologue,file='../data/hs.mm.homologue.RData')
}
