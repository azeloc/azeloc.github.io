rmds <- list.files("content/post", pattern = "\\.Rmd$", full.names = T)

for(rmd in rmds){
  rmarkdown::render(rmd, output_format = rmarkdown::md_document(
    variant = 'markdown'
  ))
}

file.remove(rmds)

blogdown::install_hugo(version = "0.19")
blogdown::build_site()
