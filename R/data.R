#' Generate internal data
#'
#' Generate internal data available to package functions.
#'
#' @return NULL
generate_internal_data <- function() {
  # Cross-reactive probes 450K
  xreactive_probes_450k_chen <- read_xreactive_probes_450k_chen()
  xreactive_probes_450k_benton <- read_xreactive_probes_450k_benton()
  xreactive_probes_450k <-
    unique(c(xreactive_probes_450k_chen, xreactive_probes_450k_benton))
  # Cross-reactive probes EPIC/850K
  xreactive_probes_epic_pidsley <- read_xreactive_probes_epic_pidsley()
  xreactive_probes_epic_mccartney <- read_xreactive_probes_epic_mccartney()
  xreactive_probes_epic <-
    unique(c(
      xreactive_probes_epic_pidsley,
      xreactive_probes_epic_mccartney
    ))
  # Probes overlapping with genetic variants EPIC/850K
  snp_probes_epic_pidsley <- loci_with_snps_epic_pidsley
  snp_probes_epic <- unique(c(snp_probes_epic_pidsley))
  # Probes overlapping with genetic variants 450K
  snp_probes_450k <- character() # placeholder
  devtools::use_data(xreactive_probes_450k,
                     xreactive_probes_epic,
                     snp_probes_epic,
                     snp_probes_450k,
                     internal = TRUE)
}
