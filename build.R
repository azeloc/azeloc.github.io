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

  bookdown:::writeUTF8(md, gsub("\\.Rmd","\\.md",rmd))
}

rejects <- list.files("content/post", pattern = 'knit|utf8', full.names = T)
file.remove(c(rmds, rejects))

blogdown::install_hugo(version = "0.18")
blogdown:::hugo_build()

files2copy <- list.files('content/post', pattern = 'files', full.names = T)

dir_folder <- gsub("content/","public/", files2copy) %>%
  gsub("_files(/)?","/",.)

file.copy(files2copy, dir_folder, recursive = T)


