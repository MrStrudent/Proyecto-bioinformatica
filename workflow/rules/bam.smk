rule sam_to_bam:
    input:
        "../results/alignment/{sample}.sam"
    output:
        "../results/bam/{sample}.bam"
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        mkdir -p results/bam

        samtools view -Sb {input} > {output}
        """

rule sort_bam:
    input:
        "../results/bam/{sample}.bam"
    output:
        "../results/bam/{sample,[^.]+}.sorted.bam"
    threads: 4
    shell:
        """
        samtools sort \
            -@ {threads} \
            {input} \
            -o {output}
        """

rule index_bam:
    input:
        "../results/bam/{sample,[^.]+}.sorted.bam"
    output:
        "../results/bam/{sample,[^.]+}.sorted.bam.bai"
    shell:
        """
        samtools index {input}
        """