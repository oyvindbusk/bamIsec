import hts
import strutils
import argparse

var
  v:VCF
  b:Bam
  obam:Bam



# Open a vcf to get query coords:
doAssert(open(v, "tests/Dystoni.vcf"))
# open a bam/cram and look for the index.
doAssert(open(b, "tests/1731_20.bamout.bam", index=true, fai="/illumina/runs_diag/prod_pipeline/genomes/H_sapiens/b37/human_g1k_v37.fasta"))
# Open a bam for writing
doAssert(open(obam, "out.bam", mode="wb"))




# Write header:
obam.write_header(b.hdr)


# Iterate:
for rec in v:  
  for record in b.query($rec.CHROM, parseInt($rec.POS)-100, parseInt($rec.POS)+100 ):  
    if record.mapping_quality > 10u:
      obam.write(record)
    
obam.close