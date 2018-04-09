#' Cross-reactive probes/loci
#'
#' Get cross-reactive probe/locus IDs from internal data
#'
#' @details
#' The cross-reactive probes/loci of EPIC/850K are from papers:
#'
#' \enumerate{
#'   \item \href{https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1066-1}{Pidsley et al., Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling. Genome Biology (2016)}
#'   \item \href{https://www.sciencedirect.com/science/article/pii/S221359601630071X}{McCartney et al., Identification of polymorphic and off-target probe binding sites on the Illumina Infinium MethylationEPIC BeadChip. Genomics Data (2016)}
#' }
#'
#' The cross-reactive probes/loci of 450K are from papers:
#'
#' \enumerate{
#'   \item \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3592906/}{Chen et al., Discovery of cross-reactive probes and polymorphic CpGs in the Illumina Infinium HumanMethylation450 microarray. Epigenetics (2013)}
#'   \item \href{https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0569-x}{Benton et al., An analysis of DNA methylation in human adipose tissue reveals differential modification of obesity genes before and after gastric bypass and weight loss. Genome Biology (2015)}
#' }
#'
#' @param array_type A character scalar. One of "EPIC", "450K". Defaults
#' to "EPIC".
#' @return A character vector of probe IDs
#' @export
#' @examples
#' xloci <- xreactive_probes()
xreactive_probes <- function(array_type = "EPIC") {
  if (array_type == "EPIC") {
    return(xreactive_probes_epic)
  } else if (array_type == "450K") {
    return(xreactive_probes_450k)
  } else {
    stop("array_type is either EPIC or 450K")
  }
}


#' Drop cross-reactive probes/loci
#'
#' Remove cross-reactive probes from
#'
#' @param x A \code{minfi} object
#' @return An object of the same kind as the input, possibly with fewer
#' loci.
#' @examples
#' \dontrun{
#' suppressPackageStartupMessages(library(minfiData))
#' data(MsetEx)
#' MsetEx_noXloci <- dropXreactiveLoci(MsetEx)
#' nrow(MsetEx) - nrow(MsetEx_noXloci)
#' }
#' @export
dropXreactiveLoci <- function(x) {
  array_type <- get_array_type(x)
  xloci <- xreactive_probes(array_type = array_type)
  keep <- !(minfi::featureNames(x) %in% xloci)
  return(x[keep, ])
}


########################## Read raw data #######################

#' Read cross-reactive probes of 450K array from Chen et. al.
#'
#' The cross-reactive probes are from the paper \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3592906/}{Chen et al. (2013)}.
#'
#' @details
#' The cross-reactive probes are downloaded from file
#' \code{48639-non-specific-probes-Illumina450k.csv} of
#' \href{https://github.com/sirselim/illumina450k_filtering}{GitHub: sirselim/illumina450k_filtering}.
#'
#' @return A character vector of probe IDs
#' @noRd
read_xreactive_probes_450k_chen <- function() {
  infile <- system.file("extdata", "48639-non-specific-probes-Illumina450k.csv", package = "sjma")
  xreactive_probes <- utils::read.csv(infile, stringsAsFactors = FALSE)
  xreactive_probes_450k_chen <- as.character(xreactive_probes$TargetID)
  return(xreactive_probes_450k_chen)
}


#' Read cross-reactive probes of 450K array from Benton et. al.
#'
#' The cross-reactive probes are from the paper \href{https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0569-x}{Benton et al. (2015)}.
#'
#' @details
#' The cross-reactive probes are downloaded from file
#' \code{HumanMethylation450_15017482_v.1.1_hg19_bowtie_multimap.txt} of
#' \href{https://github.com/sirselim/illumina450k_filtering}{GitHub: sirselim/illumina450k_filtering}.
#'
#' @return A character vector of probe IDs
#' @noRd
read_xreactive_probes_450k_benton <- function() {
  infile <- system.file("extdata", "HumanMethylation450_15017482_v.1.1_hg19_bowtie_multimap.txt", package = "sjma")
  xreactive_probes <- utils::read.csv(infile, stringsAsFactors = FALSE, header = FALSE)
  xreactive_probes_450k_benton <- as.character(xreactive_probes$V1)
  return(xreactive_probes_450k_benton)
}


#' Read cross-reactive probes of 850K/EPIC array from Pidsley et. al.
#'
#' The cross-reactive probes are originally published in paper
#' \href{https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1066-1}{Pidsley et al. (2016)}.
#'
#' @details
#' The cross-reactive probes are downloaded from file
#' \code{EPIC/13059_2016_1066_MOESM1_ESM.csv} of
#' \href{https://github.com/sirselim/illumina450k_filtering}{GitHub: sirselim/illumina450k_filtering}.
#'
#' @return A character vector of probe IDs
#' @noRd
read_xreactive_probes_epic_pidsley <- function() {
  infile <- system.file("extdata", "13059_2016_1066_MOESM1_ESM.csv", package = "sjma")
  xreactive_probes <- utils::read.csv(infile, stringsAsFactors = FALSE, header = TRUE)
  return(as.character(xreactive_probes[, 1]))
}


#' Read cross-reactive probes of 850K/EPIC array from McCartney et. al.
#'
#' The cross-reactive probes are originally published in paper
#' \href{https://www.sciencedirect.com/science/article/pii/S221359601630071X}{McCartney et al. (2016)}.
#'
#' @details
#' The cross-reactive probes are downloaded from Table S2 and S3.
#'
#' @return A character vector of probe IDs
#' @noRd
read_xreactive_probes_epic_mccartney <- function() {
  s2_file <- system.file("extdata", "1-s2.0-S221359601630071X-mmc2.txt", package = "sjma")
  s3_file <- system.file("extdata", "1-s2.0-S221359601630071X-mmc3.txt", package = "sjma")
  xreactive_probes_cpg <- rutils::ead.csv(s2_file, stringsAsFactors = FALSE, header = FALSE)
  xreactive_probes_noncpg <- utils::read.csv(s3_file, stringsAsFactors = FALSE, header = FALSE)
  xreactive_probes <- unique(c(xreactive_probes_cpg, xreactive_probes_noncpg))
  return(xreactive_probes)
}
