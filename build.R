rmds <- list.files("content/post", pattern = "\\.Rmd$", full.names = T)

for(rmd in rmds){
  rmarkdown::render(rmd, output_format = rmarkdown::md_document(
    variant = 'markdown', preserve_yaml = F
  ), clean = F)

  md <- gsub("\\.Rmd","\\.md",rmd) %>%
    readLines()

  titulos <- md %>%
    stringr::str_detect("title\\:") %>%
    which %>%
    dplyr::first()

  md[titulos] <- gsub("title\\: ","title\\: '",md[titulos]) %>%
    paste0("'")

  writeLines(md, gsub("\\.Rmd","\\.md",rmd))
}

file.remove(rmds)

blogdown::install_hugo(version = "0.18")
blogdown:::hugo_build()
