#!/bin/bash
# Add the following to train_list if you want to download them:
            # "v1.0-trainval_meta" 
            # "v1.0-trainval01_blobs"
            # "v1.0-trainval02_blobs"
            # "v1.0-trainval03_blobs"
            # "v1.0-trainval04_blobs"
            # "v1.0-trainval05_blobs"
            # "v1.0-trainval06_blobs"
            # "v1.0-trainval07_blobs"
            # "v1.0-trainval08_blobs"
            # "v1.0-trainval09_blobs"
            # "v1.0-trainval10_blobs" 
            
train_list=("v1.0-mini"
            )

target_dir = "~/data"
cd ${target_dir}

for sequence in ${train_list[@]}; do
    tgz_file=${sequence}.tgz
    wget https://s3.amazonaws.com/argoai-argoverse/${tar_file}
    mkdir -p ${target_dir}/nuscenes/${sequence}
    tar zxvf ${tgz_file} -C ${target_dir}/nuscenes/${sequence} 
    rm ${zip_file}
done

