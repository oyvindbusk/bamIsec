import hts
import strutils
import argparse
import tables
import strformat


var
  v:VCF
  b:Bam
  obam:Bam

proc bamisec_main() =
  let p = newParser("bamisec isec"):
    option("--bam", default="tests/1731_20.bamout.bam", help="path to bam file")
    option("--vcf", default="tests/Dystoni.vcf", help="path to vcf file")
    option("--fasta", default="/illumina/runs_diag/prod_pipeline/genomes/H_sapiens/b37/human_g1k_v37.fasta", help="path to fasta file")
  var argv = commandLineParams()
  if len(argv) > 0 and argv[0] == "isec":
    argv = argv[1..argv.high]
  if len(argv) == 0:
    argv.add("--help")

  var opts = p.parse(argv)
  if opts.help:
    quit 0
  if opts.bam == "":
    echo p.help
    stderr.write_line "[bamIsec] --bam is required."
    quit 1
  if opts.vcf == "":
    echo p.help
    stderr.write_line "[bamIsec] --vcf is required."
    quit 1
  if opts.fasta == "":
    echo p.help
    stderr.write_line "[bamIsec] --fasta is required."
    quit 1

  # Open a vcf to get query coords:
  doAssert(open(v, opts.vcf))  
  # open a bam/cram and look for the index.
  doAssert(open(b, opts.bam, index=true, fai=opts.fasta))
  # Open a bam for writing
  doAssert(open(obam, "out.bam", mode="wb"))

  
  # Write header:
  obam.write_header(b.hdr)


  # Iterate:
  for rec in v:  
    for record in b.query($rec.CHROM, parseInt($rec.POS)-100, parseInt($rec.POS)+100 ):  
      if record.mapping_quality > 10u:
        obam.write(record)

  
  v.close()
  b.close()
  obam.close()
  echo opts.vcf
  stderr.write_line &"[bamIsec] Finished"

proc main() =
  type pair = object
    fn: proc()
    description: string

  var dispatcher = {
    "isec": pair(fn:bamisec_main, description: "get the alignments from a bam that intersects with the variants from a vcf")
  }.toOrderedTable

  var args = commandLineParams()
  if len(args) > 0 and args[0] in dispatcher:
    dispatcher[args[0]].fn()
    return

  if len(args) == 0 or args[0] in ["-h", "--help"]:
    stdout.write_line "Commands: "
    for k, v in dispatcher:
      echo &"  {k:<19}:   {v.description}"
  else:
    echo &"unknown program '{args[0]}'"
    quit ""


when isMainModule:
  main()