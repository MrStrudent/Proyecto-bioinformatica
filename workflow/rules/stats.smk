rule flagstat:
    input:
        "../results/bam/{sample}.sorted.bam"
    output:
        "../results/stats/{sample}.flagstat.txt"
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        mkdir -p ../results/stats

        samtools flagstat {input} > {output}
        """

rule bam_stats:
    input:
        "../results/bam/{sample}.sorted.bam"
    output:
        "../results/stats/{sample}.stats.txt"
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        mkdir -p ../results/stats

        samtools stats {input} > {output}
        """