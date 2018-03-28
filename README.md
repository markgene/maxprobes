## Cross-reactive probes/loci of methylation array

The `maxprobes` R package collects cross-reactive probes of Illumina methylation array 450K and EPIC/850K from papers. The cross-reactive probes/loci of EPIC/850K are from papers:

* [Pidsley et al., Critical evaluation of the Illumina MethylationEPIC BeadChip microarray for whole-genome DNA methylation profiling. Genome Biology (2016)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1066-1)

* [McCartney et al., Identification of polymorphic and off-target probe binding sites on the Illumina Infinium MethylationEPIC BeadChip. Genomics Data (2016)](https://www.sciencedirect.com/science/article/pii/S221359601630071X)

Those of 450K are from papers:

* [Chen et al., Discovery of cross-reactive probes and polymorphic CpGs in the Illumina Infinium HumanMethylation450 microarray. Epigenetics (2013)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3592906/)

* [Benton et al., An analysis of DNA methylation in human adipose tissue reveals differential modification of obesity genes before and after gastric bypass and weight loss. Genome Biology (2015)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0569-x)

## Install

```{r, install_maxprobes}
if (! ("devtools" %in% installed.packages()) install.packages("devtools")
devtools::install_github("markgene/maxprobes")
```

## Drop cross-reactive probes from *minfi* objects

Use the example data set in `minfiData`, which is 450K array comprising of 3 cancer samples and 3 normal controls.

```{r, load_minfi_data}
suppressPackageStartupMessages(library(minfiData))
data(MsetEx)
MsetEx

#> class: MethylSet 
#> dim: 485512 6 
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(485512): cg00050873 cg00212031 ... ch.22.47579720R
#>   ch.22.48274842R
#> rowData names(0):
#> colnames(6): 5723646052_R02C02 5723646052_R04C01 ...
#>   5723646053_R05C02 5723646053_R06C02
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Raw (no normalization or bg correction)
#>   minfi version: 1.21.2
#>   Manifest version: 0.4.0
```

Call `dropXreactiveLoci` function to remove cross-reactive probes/loci:

```{r, drop_demo}
library(maxprobes)
MsetEx_noXloci <- maxprobes::dropXreactiveLoci(MsetEx)
MsetEx_noXloci

#> class: MethylSet 
#> dim: 446571 6 
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(446571): cg00212031 cg00213748 ... ch.22.47579720R
#>   ch.22.48274842R
#> rowData names(0):
#> colnames(6): 5723646052_R02C02 5723646052_R04C01 ...
#>   5723646053_R05C02 5723646053_R06C02
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Raw (no normalization or bg correction)
#>   minfi version: 1.21.2
#>   Manifest version: 0.4.0
```

The probe/locus number (first number on `dim` row) drops from 485512 to 446571.

## Obtain cross-reactive probe/loci IDs

If you need to get the list of probes/loci (e.g. you do not use `minfi` objects), you can get it by `xreactive_probes` function. It takes an argument `array_type` which is either "EPIC" or "450K", for EPIC/850K and 450K arrays, respectively.

```{r, xloci_demo}
xloci <- maxprobes::xreactive_probes(array_type = "EPIC")
length(xloci)

#> [1] 43256

xloci <- maxprobes::xreactive_probes(array_type = "450K")
length(xloci)

#> [1] 38941
```
