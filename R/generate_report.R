#' Generate Automatic Report
#'
#' @param data A dataframe with climate and phenological data
#' @param output_file Path to the output file (default: "report.html")
#' @param output_format Format of the report: "html" or "pdf" (default: "html")
#'
#' @return Path to the generated report
#' @export
#'
#' @examples
#' generate_report(data = df, output_file = "rapport_olivier.html")
generate_report <- function(data, output_file = "report.html", output_format = "html") {
  if (!requireNamespace("rmarkdown", quietly = TRUE)) stop("Package 'rmarkdown' requis.")

  template <- system.file("templates", "report_template.Rmd", package = "olivePhenR")
  if (template == "") stop("Template de rapport introuvable.")

  rmarkdown::render(
    input       = template,
    output_file = output_file,
    output_format = if (output_format == "pdf") "pdf_document" else "html_document",
    params      = list(data = data)
  )

  return(output_file)
}
