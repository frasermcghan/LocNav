#!/bin/bash

#SBATCH --job-name=ddppo_oracle
#SBATCH --output=logs/ddppo_oracle.out
#SBATCH --error=logs/ddppo_oracle.err

#SBATCH --nodes=6
#SBATCH --gres=gpu:2
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=20
#SBATCH --partition=gpu,gpu_v100
#SBATCH --exclusive

#SBATCH --requeue
#SBATCH --time=48:00:00
#SBATCH --signal=USR1@90

MAIN_ADDR=$(scontrol show hostnames "${SLURM_JOB_NODELIST}" | head -n 1)
export MAIN_ADDR
export GLOO_SOCKET_IFNAME=ib0
export NCCL_SOCKET_IFNAME=ib0

set -x
module load singularity
srun singularity exec --contain --nv --bind /scratch/LocNav:/mnt /scratch/LocNav/locnav.sif /bin/sh /mnt/scripts/train_oracle.sh