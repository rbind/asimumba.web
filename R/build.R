options(stringsAsFactors = FALSE)
cargs = commandArgs(TRUE)
local = cargs[1] == 'TRUE'

build_one = function(io, external = FALSE)  {
  if (!file.exists(io[1])) {
    if (Sys.getenv('USER') == 'yihui') stop('File ', io[1], ' does not exist')
    return()
  }
  # if output is not older than input, skip the compilation
  if (!blogdown:::require_rebuild(io[2], io[1])) return()

  if (local) message('* knitting ', io[1])
  if (blogdown:::Rscript(shQuote(c('R/build_one.R', io, external))) != 0) {
    unlink(io[2])
    stop('Failed to compile ', io[1], ' to ', io[2])
  }
}


blogdown:::hugo_build(local = local)

if (!local) {
  message('Optimizing PNG files under static/')
  for (i in list.files('static', '[.]png$', full.names = TRUE, recursive = TRUE)) {
    system2('optipng', shQuote(i), stderr = FALSE)
  }
}

if (FALSE) {
  checkJS = function(name) {
    api = sprintf('https://api.bootcdn.cn/libraries/%s.json', name)
    jsonlite::fromJSON(api)$version
  }
  checkJS('highlight.js')
  checkJS('mathjax')
}
