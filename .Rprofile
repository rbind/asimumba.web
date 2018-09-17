options(
        servr.daemon = TRUE,
        blogdown.yaml.empty = FALSE,
        blogdown.publishDir = '../aaronpublic',  
        blogdown.author = "Aaron Simumba",
        blogdown.generator.server = TRUE,
        blogdown.hugo.server = c('-D', '-F', '--navigateToChanged'),
        digits = 4,
        formatR.indent = 2,
        blogdown.title_case = function(x) {
          if (is.na(iconv(x, to = 'ASCII'))) return(x)
          # if the title is pure ASCII, use title case
          tools::toTitleCase(x)
        }
)


local({
  pandoc_path = Sys.getenv('RSTUDIO_PANDOC', NA)
  if (Sys.which('pandoc') == '' && !is.na(pandoc_path)) Sys.setenv(PATH = paste(
    Sys.getenv('PATH'), pandoc_path,
    sep = if (.Platform$OS.type == 'windows') ':' else ';'
  ))
})
