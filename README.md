# LocNav
![](./trained_agent_orbslam.gif)

This is the code used to run the experiments for the TAROS 2024 paper:

**Localisation-Aware Fine-Tuning for Realistic PointGoal Navigation**  
Fraser McGhan, Ze Ji, and Raphael Grech  
Cardiff University, Spirent Communications
```
@inproceedings{mcghan2024locnav,
  title     =     {Localisation-Aware Fine-Tuning for Realistic PointGoal Navigation},
  author    =     {Fraser McGhan and Ze Ji and Raphael Grech},
  booktitle =     {Towards Autonomous Robotic Systems (TAROS)},
  year      =     {2024}
}
```

## Setup
```
git clone --recurse-submodules https://github.com/frasermcghan/LocNav-Experiments.git
```

### Build LocNav Singularity Image
```
sudo apt-get install -y singularity-container
cd LocNav-Experiments
sudo singularity build --bind ./:/mnt locnav.sif locnav.def
```

### Download Habitat PointNav v2 Episodes
```
mkdir habitat_datasets
cd habitat_datasets
mkdir -p datasets/pointnav/gibson/v2
wget https://dl.fbaipublicfiles.com/habitat/data/datasets/pointnav/gibson/v2/pointnav_gibson_v2.zip
unzip pointnav_gibson_v2.zip -d datasets/pointnav/gibson/v2
```

### Download Gibson Scene Datasets (4+ version)
Follow instructions at https://github.com/facebookresearch/habitat-sim/blob/main/DATASETS.md to download Gibson v2 4+ scene dataset.  
```
mkdir -p scene_datasets/gibson
tar -xvzf gibson_v2_4+.tar.gz -C scene_datasets/gibson
```

### Download Pretrained Weights
```
mkdir model-weights
wget https://drive.google.com/file/d/1kumQhUEvHxy77RxMDsKevOj9f5Ymxtf_/view?usp=drive_link -d model-weights
wget https://dl.fbaipublicfiles.com/habitat/data/baselines/v1/habitat_baselines_v2.zip -d model-weights
unzip model-weights/habitat_baselines_v2.zip
```

### Extract ORB-SLAM2 Vocabulary File
```
cp ORB_SLAM2/Vocabulary/ORBvoc.txt.tar.gz .
tar -xvzf ORBvoc.txt.tar.gz -C orb_vocabulary.txt
```

### Evaluate Finetuned ORB-SLAM Agent
```
sudo singularity shell --nv --bind ./:/mnt locnav.sif
. activate habitat
python -u -m habitat_baselines.run --config-name=pointnav/pretrained_encoder_orbslam.yaml habitat_baselines.evaluate=True
```

### Multi-Node Training with SLURM
An example of how to run training on a SLURM cluster can be seen in [slurm/multi_node_orbslam.sh](./slurm/multi_node_orbslam.sh).
