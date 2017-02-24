cwlVersion: v1.0
class: CommandLineTool

doc: "pindel somatic mutation calling"

baseCommand: [python, /opt/pindel.py, -t, NORMAL, -t TUMOR]

hints:
  DockerRequirement:
    dockerPull: quay.io/opengenomics/pindel

inputs:
  normal:
    type: File
    inputBinding:
      prefix: -b

  tumor:
    type: File
    inputBinding:
      prefix: -b

  reference:
    type: File
    doc: |
      the genome reference file
    inputBinding:
      prefix: -r

  centromere:
    type: File?
    doc: |
      list of regions to exclude (chr, start, end)
    inputBinding:
      prefix: -J

  referenceName:
    type: string?
    doc: |
      the genome reference ID, e.g. HG19 (default: genome)
    inputBinding:
      prefix: -R

  windowSize:
    type: int?
    default: 2
    inputBinding:
      prefix: --window_size

  procs:
    type: int?
    default: 2
    inputBinding:
      prefix: --number_of_procs

  normal_insert_size:
    type: int?
    inputBinding:
      prefix: -s

  tumor_insert_size:
    type: int?
    inputBinding:
      prefix: -s

  report_inversions:
    type: boolean?
    default: false
    inputBinding:
      prefix: --report_inversions

  report_duplications:
    type: boolean?
    default: false
    inputBinding:
      prefix: --report_duplications

  report_long_insertions:
    type: boolean?
    default: false
    inputBinding:
      prefix: --report_long_insertions

  report_breakpoints:
    type: boolean?
    default: false
    inputBinding:
      prefix: --report_breakpoints

  report_only_close_mapped_reads:
    type: boolean?
    default: false
    inputBinding:
      prefix: -S

  outputRawFile:
    type: string?
    default: pindel.raw
    inputBinding:
      prefix: -o1
  
  outputVcfFile:
    type: string?
    default: pindel.vcf
    inputBinding:
      prefix: -o2
  
  outputSomaticVcfFile:
    type: string?
    default: pindel_somatic.vcf
    inputBinding:
      prefix: -o3
  
  somatic_vaf:
    type: float?
    default: 0.08
    inputBinding:
      prefix: --somatic_vaf

  somatic_cov:
    type: int?
    default: 20
    inputBinding:
      prefix: --somatic_cov

  somatic_hom:
    type: int?
    default: 6
    inputBinding:
      prefix: --somatic_hom

  min_inversion_size:
    type: int?
    default: 50
    inputBinding:
      prefix: --min_inversion_size

  min_num_matched_bases:
    type: int?
    default: 30
    inputBinding:
      prefix: -d

  max_range_index:
    type: int?
    default: 4
    inputBinding:
      prefix: -x

  additional_mismatch:
    type: int?
    default: 1
    inputBinding:
      prefix: -a
  
  min_perfect_match_around_BP:
    type: int?
    default: 3
    inputBinding:
      prefix: -m
  
  sequencing_error_rate:
    type: float?
    default: 0.01
    inputBinding:
      prefix: --sequencing_error_rate

  maximum_allowed_mismatch_rate:
    type: float?
    default: 0.02
    inputBinding:
      prefix: -u
  
  sensitivity:
    type: float?
    default: 0.95
    inputBinding:
      prefix: --sensitivity


outputs:
  vcf:
    type: File
    outputBinding:
      glob: $(inputs.outputVcfFile)

  somatic_vcf:
    type: File
    outputBinding:
      glob: $(inputs.outputSomaticVcfFile)
      
  rawFile:
    type: File
    outputBinding:
      glob: $(inputs.outputRawFile)

