rule vcf_stats:
    input:
        "../results/vcf/{sample}.vcf.gz"
    output:
        "../results/vcf/{sample}.stats"
    conda:
        "../envs/bcftools.yaml"
    shell:
        """
        bcftools stats {input} > {output}
        """

rule index_vcf:
    input:
        "../results/vcf/{sample}.vcf.gz"
    output:
        "../results/vcf/{sample}.vcf.gz.tbi"
    conda:
        "../envs/bcftools.yaml"
    shell:
        """
        tabix -p vcf {input}
        """