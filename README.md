# Evaluation of GNINA on CASF-2016 Benchmark

## Rewproducibility

### Signularity

```bash
cd singularity
sudo singularity build gnina.sif gnina.def
```
### Python

```dotnetcli
conda env create -f conda.yaml
conda activate gnina-casf
```