check_package = function(pkg_name) {
  pkg_name %in% rownames(installed.packages())
}

generate_paths = function(from, to, pkg_name) {
  d = system.file(from, package = pkg_name, mustWork = F)
  if(nchar(d) == 0L) return("[]")
  fnames_full = list.files(d, full.names = TRUE)
  fnames_partial = list.files(d, full.names = FALSE)
  
  fnames_partial = file.path(to, fnames_partial)
  paths = paste0("[",fnames_full, ", ", fnames_partial, "]")
  paths = paste0(paths, collapse = ", ")
}

#' Get functions
#'
#' Helper functions
#' @param pkg_name The name of the package
#' @importFrom utils installed.packages
#' @export
get_files = function(pkg_name) {
  if(!check_package(pkg_name)) stop("Package no available", call. = FALSE)
  material = generate_paths(from= "material", to = "/etc/skel", pkg_name)
  setup = generate_paths("setup", "/etc/R", pkg_name)
  
  paste0("[", material, ", ", setup, "]", collapse = "")
}
