rule bwa_mem:
    input:
        ref=config["reference"],
        r1="../data/fastq/{sample}_R1.fastq.gz",
        r2="../data/fastq/{sample}_R2.fastq.gz"
    output:
        "../results/alignment/{sample}.sam"
    threads: 8
    shell:
        """
        mkdir -p results/alignment

        bwa mem -t {threads} \
            -R '@RG\\tID:{wildcards.sample}\\tSM:{wildcards.sample}\\tPL:ILLUMINA\\tLB:lib1\\tPU:unit1' \
            {input.ref} \
            {input.r1} \
            {input.r2} \
            > {output}
        """