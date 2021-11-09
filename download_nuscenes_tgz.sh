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

target_dir=~/data
mkdir -p ${target_dir}
cd ${target_dir}

for sequence in ${train_list[@]}; do
    tgz_file=${sequence}.tgz
    wget "https://s3.amazonaws.com/data.nuscenes.org/public/v1.0/${tgz_file}?AWSAccessKeyId=AKIA6RIK4RRMFUKM7AM2&Signature=03jADR95AFaXP0YUQedrqZzYaps%3D&Expires=1636880372" - O ${tgz_file}
    mkdir -p ${target_dir}/nuscenes/${sequence}
    tar zxvf ${tgz_file} -C ${target_dir}/nuscenes/${sequence} 
    #rm ${tgz_file}
done

