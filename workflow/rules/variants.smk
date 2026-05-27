rule haplotypecaller:
    input:
        bam="../results/bam/{sample,[^.]+}.sorted.bam",
        bai="../results/bam/{sample,[^.]+}.sorted.bam.bai",
        ref=config["reference"]
    output:
        "../results/vcf/{sample}.vcf.gz"
    threads: 4
    shell:
        """
        mkdir -p results/vcf

        gatk HaplotypeCaller \
            -R {input.ref} \
            -I {input.bam} \
            -O {output}
        """