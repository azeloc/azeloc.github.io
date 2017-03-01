rmds <- list.files("content/post", pattern = "\\.Rmd$", full.names = T)

for(rmd in rmds){
  rmarkdown::render(rmd, output_format = rmarkdown::md_document(
    variant = 'markdown', preserve_yaml = F
  ))

  md <- gsub("\\.Rmd","\\.md",rmd) %>%
    readr::read_lines()

  titulos <- md %>%
    stringr::str_detect("title\\:") %>%
    which %>%
    dplyr::first()

  md[titulos] <- gsub("title\\: ","title\\: '",md[titulos]) %>%
    paste0("'")

  readr::write_lines(md, gsub("\\.Rmd","\\.md",rmd))
}

file.remove(rmds)

blogdown::install_hugo(version = "0.18")
blogdown::build_site()
