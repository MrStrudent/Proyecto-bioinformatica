# Pipeline WGS con Snakemake

Pipeline de análisis bioinformático para Whole Genome Sequencing (WGS) desarrollado con Snakemake siguiendo el flujo del capítulo 27 del handbook:

:contentReference[oaicite:0]{index=0}

---

# Objetivo

Implementar un pipeline reproducible para:

- Control de calidad de lecturas FASTQ
- Alineamiento al genoma de referencia
- Procesamiento de archivos BAM
- Variant Calling
- Estadísticas y análisis de resultados

---

# Tecnologías utilizadas

- :contentReference[oaicite:1]{index=1}
- :contentReference[oaicite:2]{index=2}
- :contentReference[oaicite:3]{index=3}
- :contentReference[oaicite:4]{index=4}
- :contentReference[oaicite:5]{index=5}
- :contentReference[oaicite:6]{index=6}
- :contentReference[oaicite:7]{index=7}
- Conda / Mamba
- WSL Ubuntu
- VS Code

---

# Estructura del proyecto

```text
wgs_pipeline/
│
├── config/
│
├── data/
│   ├── fastq/
│   └── reference/
│
├── results/
│   ├── alignment/
│   ├── bam/
│   ├── multiqc/
│   ├── qc/
│   ├── stats/
│   └── vcf/
│
├── workflow/
│   ├── envs/
│   ├── rules/
│   └── Snakefile
│
└── samples.tsv
```

---

# Instalación

## 1. Instalar Miniforge/Mamba

:contentReference[oaicite:8]{index=8}

---

## 2. Crear entorno Snakemake

```bash
mamba create -n snakemake -c conda-forge -c bioconda snakemake pandas -y
```

---

## 3. Activar entorno

```bash
conda activate snakemake
```

---

# Datos utilizados

## Lecturas FASTQ

Ubicadas en:

```text
data/fastq/
```

Archivos:

```text
normal_R1.fastq.gz
normal_R2.fastq.gz
```

---

## Genoma de referencia

Ubicado en:

```text
data/reference/genome.fa
```

---

# Archivo samples.tsv

```text
sample
normal
```

---

# Flujo del pipeline

```text
FASTQ
  ↓
FastQC
  ↓
BWA MEM
  ↓
SAM → BAM
  ↓
Sort BAM
  ↓
Index BAM
  ↓
HaplotypeCaller
  ↓
VCF
  ↓
bcftools stats
  ↓
MultiQC
```

---

# Ejecución del pipeline

Desde la carpeta:

```text
workflow/
```

Ejecutar:

```bash
snakemake --cores 4
```

---

# Resultados generados

## Quality Control

```text
results/qc/
```

Archivos:
- FastQC HTML
- FastQC ZIP

---

## Reporte consolidado

```text
results/multiqc/multiqc_report.html
```

---

## Alignment

```text
results/alignment/
```

Archivo:
- SAM

---

## BAM Processing

```text
results/bam/
```

Archivos:
- BAM
- Sorted BAM
- BAM index (.bai)

---

## Estadísticas BAM

```text
results/stats/
```

Archivos:
- flagstat
- stats

---

## Variant Calling

```text
results/vcf/
```

Archivos:
- VCF.gz
- Index VCF (.tbi)
- bcftools stats

---

# Comandos útiles

## Ver variantes

```bash
bcftools view ../results/vcf/normal.vcf.gz | head
```

---

## Contar variantes

```bash
bcftools view -H ../results/vcf/normal.vcf.gz | wc -l
```

---

## Ver SNPs

```bash
bcftools view -v snps ../results/vcf/normal.vcf.gz
```

---

# Notas importantes

Durante el análisis se detectó que las lecturas FASTQ no correspondían completamente al genoma de referencia utilizado, por lo que el porcentaje de alineamiento fue 0%.

Sin embargo, el objetivo principal del proyecto fue implementar correctamente el flujo reproducible del pipeline WGS usando Snakemake y herramientas bioinformáticas estándar.

---

# Herramientas de visualización recomendadas

- :contentReference[oaicite:9]{index=9}

:contentReference[oaicite:10]{index=10}

---

# Integrantes

- Carlos Andrei Saucedo Aguilar
- Francisco Encarnacion Barragan

---

# Referencias

- :contentReference[oaicite:11]{index=11}
- :contentReference[oaicite:12]{index=12}
- :contentReference[oaicite:13]{index=13}
- :contentReference[oaicite:14]{index=14}
- :contentReference[oaicite:15]{index=15}
- :contentReference[oaicite:16]{index=16}