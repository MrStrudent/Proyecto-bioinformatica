rule fastqc:
    input:
        r1="../data/fastq/{sample}_R1.fastq.gz",
        r2="../data/fastq/{sample}_R2.fastq.gz"
    output:
        html1="../results/qc/{sample}_R1_fastqc.html",
        zip1="../results/qc/{sample}_R1_fastqc.zip",
        html2="../results/qc/{sample}_R2_fastqc.html",
        zip2="../results/qc/{sample}_R2_fastqc.zip"
    conda:
        "../envs/fastqc.yaml"
    threads: 2
    shell:
        """
        mkdir -p ../results/qc

        fastqc \
            {input.r1} \
            {input.r2} \
            --outdir ../results/qc
        """
rule multiqc:
    input:
        "../results/qc/normal_R1_fastqc.zip",
        "../results/qc/normal_R2_fastqc.zip"
    output:
        "../results/multiqc/multiqc_report.html"
    conda:
        "../envs/multiqc.yaml"
    shell:
        """
        mkdir -p ../results/multiqc

        multiqc \
            ../results/qc \
            -o ../results/multiqc \
            -n multiqc_report.html
        """