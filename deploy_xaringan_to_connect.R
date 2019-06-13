# ?rsconnect::deployDoc

library(rsconnect)

deploy_xaringan <- function(doc){
  qualified_doc <- normalizePath(doc, winslash = "/")
  app_files <-  c(
    basename(qualified_doc),
    list.files("images", pattern = ".*.png", full.names = TRUE, recursive = TRUE),
    list.files("images", pattern = ".*.gif", full.names = TRUE, recursive = TRUE),
    list.files("include", pattern = ".*.png", full.names = TRUE, recursive = TRUE),
    list.files("include", pattern = ".*.jpg", full.names = TRUE, recursive = TRUE),
    list.files("theme", pattern = "*.png", full.names = TRUE, recursive = TRUE)
    # list.files("libs", full.names = TRUE, recursive = TRUE)
  )
  res_files <- rmarkdown::find_external_resources(qualified_doc)
  app_files <- c(app_files, res_files$path)
  rsconnect::deployApp(
    appDir = dirname(qualified_doc),
    appPrimaryDoc = basename(qualified_doc),
    appTitle = "Taking TensorFlow into Production Eoda 2019",
    appFiles = app_files,
    forceUpdate = TRUE,
    server = "colorado.rstudio.com"
  )
}

deploy_xaringan("tensorflow-production-2019-06.html")
