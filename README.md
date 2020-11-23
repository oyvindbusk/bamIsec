<a href="https://github.com/oyvindbusk/bamIsec/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/oyvindbusk/bamIsec"></a> <a href="https://github.com/oyvindbusk/bamIsec/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/oyvindbusk/bamIsec"></a> [![Build Status](https://github.com/oyvindbusk/bamIsec/workflows/Build/badge.svg?branch=master)](https://github.com/oyvindbusk/bamIdex/actions) <a href="https://github.com/oyvindbusk/bamIsec/network"><img alt="GitHub forks" src="https://img.shields.io/github/forks/oyvindbusk/bamIsec"></a>




# Accumulating collection of command-line tools to do things with bams and vcfs using hts-nim


<h4>
Isec: Takes a bam and vcf, and extracts all active regions from bam that have variants (+- 100 bp) in the vcf.
</h4>


## Usage

bamIsec should eventually contain multiple tools for manipulating vcf or bam files. Many of the problems might be better solved by other tools, as this is primarily a way for me to learn

`isec` accepts a bam and a vcf, and extracts alignments from the bam in the positions (+-100 bp) where there exist variants in the vcf. The results are written to a new bam-file.

Run isec:
```
bamIsec isec \
--bam $bam \
--vcf $vcf \
--fasta $fasta
```

## Install:

Download the binary from the [releases](https://github.com/oyvindbusk/bamIsec/releases).


## Compile from source
Use the [static binary](https://github.com/brentp/hts-nim/releases/download/v0.2.8/hts_nim_static_builder) from https://github.com/brentp/hts-nim/#static-builds to build a binary without deps.

```sh
hts_nim_static_builder -n bamIsec.nimble -s src/bamIsec.nim
```

## Todo:
- [x] Make a static binary -> Release
- [ ] Add small example bam
- [ ] Output sorted bam
- [ ] Make unit tests
- [ ] Make dockerfile


### Add path (temp - not needed if using binary):
```sh
LD_LIBRARY_PATH=/usr/local/lib/
export LD_LIBRARY_PATH
```

### Genes in the dyt-list (temp):
> ANO3, ATP1A3, CACNA1B, COL6A3, GCH1, GNAL, HPCA, KCTD17, KMT2B, MECR, PNKD, PRKRA, PRRT2, SGCE, SLC2A1, TAF1, THAP1, TOR1A

### The output bam has to be sorted (hopefully temp):
```sh
# Temp - have to sort and index
samtools sort -o out.sorted.bam out.bam
samtools index out.sorted.bam
```

### Testing:
vcf=tests/Dystoni.vcf
bam=tests/1731_20.bamout.bam
fasta=/illumina/runs_diag/prod_pipeline/genomes/H_sapiens/b37/human_g1k_v37.fasta
