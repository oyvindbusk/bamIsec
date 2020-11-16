# Nim script to intersect bam-file

Takes a bam and vcf, and extracts all active regions from bam that have variants (+- 100 bp) in the vcf.

## Install:
```sh
nimble build bamIsec.nimble
```

Add path:
```sh
LD_LIBRARY_PATH=/usr/local/lib/
export LD_LIBRARY_PATH
```


```sh
# Run like:
nim c --run src/bamIsec.nim

# Temporaryliy you have to sort and index
samtools sort -o out.sorted.bam out.bam
samtools index out.sorted.bam
```

### Genes in the dyt-list:
* ANO3
* ATP1A3
* CACNA1B
* COL6A3
* GCH1
* GNAL
* HPCA
* KCTD17
* KMT2B
* MECR
* PNKD
* PRKRA
* PRRT2
* SGCE
* SLC2A1
* TAF1
* THAP1
* TOR1A

