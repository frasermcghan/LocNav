export HABITAT_SIM_LOG=quiet 
export MAGNUM_LOG=quiet 
export HYDRA_FULL_ERROR=1

. /opt/miniconda/etc/profile.d/conda.sh
conda activate habitat
python -u -m habitat_baselines.run --config-name=pointnav/pretrained_encoder_orbslam.yaml