# PillarMotion
Course project. Re-implementation of the paper Luo et al., “Self-Supervised Pillar Motion Learning f or Autonomous Driving” CVPR 2021.

PillarMotion. 
After running `install.sh`,
```
git clone https://github.com/ajinkyakhoche/mmdetection3d.git
cd mmdetection3d

# create a symbolic link to nuscences dataset
mkdir -p data/nuscenes
# change to your own username
ln -s /Midgard/Data/nuscenes/* /Midgard/home/khoche/mmdetection3d/data/nuscenes/

# create meta json data
mkdir -p data/nuscenes/motion_mini

cd tools/optical_flow/correlation_package
python setup.py build install
cd ../..
python tools/create_data.py nuscenes --root-path data/nuscenes/ --version v1.0-mini \
    --out-dir data/nuscenes/motion_mini --max-sweeps 5 --extra-tag nus_5_sweeps

# train the network
python tools/train.py \
    configs/motionnet/motionnet_02pillar_stpn_cyclic_nus.py \
    --cfg-options data.samples_per_gpu=1 data.workers_per_gpu=0
```
