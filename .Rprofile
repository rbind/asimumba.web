options(
  servr.daemon = FALSE, blogdown.yaml.empty = FALSE,
  blogdown.publishDir = '../zedr-public',  blogdown.author = "Aaron Simumba"
)

local({
  pandoc_path = Sys.getenv('RSTUDIO_PANDOC', NA)
  if (Sys.which('pandoc') == '' && !is.na(pandoc_path)) Sys.setenv(PATH = paste(
    Sys.getenv('PATH'), pandoc_path,
    sep = if (.Platform$OS.type == 'windows') ':' else ';'
  ))
})
