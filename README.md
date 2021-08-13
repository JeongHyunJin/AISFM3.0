# AISFMs

AI-generated Solar Farside Magnetograms (AISFMs)

<br/>

------------

<br/>


## Contents

This repository contains several python codes to understand the AISFMs. More detailed information of the AISFMs can be found in our paper.

<br/>

### Visualizations

* The *Visualizations_of_AISFMs.ipynb* notebook is
> To be uploaded

<br/>

### Coordinates

* The *Coordinates_of_AISFMs.ipynb* notebook is 
> To be uploaded

<br/>

### Reprojections

* The *Reprojections_of_AISFMs.ipynb* notebook is 
> To be uploaded

<br/>

### Observations

* The *Observations_of_AISFMs.ipynb* notebook is 
> To be uploaded

<br/>

------------

<br/>


## Model

We used pix2pixCC model to generate AISFMs from STEREO EUV observations.

* *pix2pixCC* : https://github.com/JeongHyunJin/pix2pixCC

      python pix2pixCC_Train.py \
      --dataset_name 'Jeong2021_AISFMs' --gpu_ids '0,1' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 --batch_size 2 \
      --n_downsample 5 --n_gf 42 --n_df 42 --n_CC 4 \
      --padding_size 62 --display_scale 150 \
      --input_dir_train '../Datasets/Train_data/Train_input' \
      --target_dir_train '../Datasets/Train_data/Train_output' \
      --n_epochs 120 --save_freq 10000 --display_freq 5000
>

      python pix2pixCC_Test.py \
      --dataset_name 'Jeong2021_AISFMs' --gpu_ids '0' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 \
      --n_downsample 5 --n_gf 42 \
      --input_dir_test '../STEREO_A_Datasets' \
      --iteration 400000

<br/>

------------

## Citation

If you use the AISFMs in your research, please consider citing our paper.

* AISFMs (ver. 3): Jeong et al. (2021)

      TBD

<br/>

* AISFMs (ver. 2): [Jeong et al. (2020)](https://iopscience.iop.org/article/10.3847/2041-8213/abc255), "Solar Coronal Magnetic Field Extrapolation from Synchronic Data with AI-generated Farside", The Astrophysical Journal Letters, Volume 903, Issue 2, id.L25, 9 pp.
* AISFMs (ver. 1): [Kim, Park, Lee et al. (2019)](https://www.nature.com/articles/s41550-019-0711-5), "Solar Farside Magnetograms from Deep Learning Analysis of STEREO/EUVI Data", Nature Astronomy, Volume 3, p. 397-400
