# AI-generated Solar Farside Magnetograms (AISFMs)

<p align="justify">
     AISFMs are line-of-sight magnetograms generated by deep learning from Solar TErrestrial RElations Observatory (STEREO) and Solar Dynamics Observatory (SDO) data sets.
     The solar farside magnetograms are data corresponding to the line-of-sight Extreme UltraViolet (EUV) observations of the STEREO Ahead (A) and Behind (B).
     The orbit of STEREO A & B is at a distance of about 1 AU, and drift away from the Earth at a rate of about 22° per year in opposite directions.
     The data products are produced by Sun and Space Weather Laboratory (SSWL) of Kyung Hee University (KHU) and released by Korea Astronomy and Space Science Institute (KASI).
     The 3rd version of the AISFMs is the first publicly available data, and they can be downloaded from the Korean Data Center (KDC) for SDO
page.
</p>

* [Where is STEREO?](https://stereo-ssc.nascom.nasa.gov/cgi-bin/make_where_gif) 
* [KDC for SDO](http://sdo.kasi.re.kr/)

<br/>

------------

<br/>


## Contents

<p align="justify">
     This repository contains several python codes to understand the AISFMs. More detailed information of the AISFMs can be found in our publications.
</p>

<br/>

#### Visualizations

* The *Visualizations_of_AISFMs.ipynb* opens data stored in an AISFM and displays it to the screen. 
> To be uploaded

<br/>

#### Coordinates

* The *Coordinates_of_AISFMs.ipynb* contains how to get the observer location from the AISFM data and interpret it.
> To be uploaded

<br/>

#### Reprojections

* The *Reprojections_of_AISFMs.ipynb* demonstrates how you can reproject AISFMs to the view from different observers. 
> To be uploaded

<br/>

#### Observations

* The *Observations_of_AISFMs.ipynb* shows how to check model input data from the AISFM data.
> To be uploaded

<br/>

#### STEREO data with poor quality

* The *poor_quality.ipynb* shows some examples of STEREO/EUVI images with poor quality.  
> To be uploaded

<br/>

------------

<br/>


## Deep Learning Code

We used *pix2pixCC* model to generate the AISFMs (ver. 3).

<br/>

The *pix2pixCC* code is available at https://github.com/JeongHyunJin/pix2pixCC. And we trained the model as below:

* Training options

      python pix2pixCC_Train.py \
      --dataset_name 'Jeong2021_AISFMs' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 --ch_balance 1.5 \
      --n_downsample 5 --n_gf 40 --n_df 40 \
      --padding_size 62 --display_scale 150 \
      --input_dir_train '../Datasets/Train_data/Train_input' \
      --target_dir_train '../Datasets/Train_data/Train_output' \
      --n_epochs 150 --save_freq 10000 --display_freq 5000

<br/>

We generate AISFMs by the tranined model as below:

>
* Generating options

      python pix2pixCC_Test.py \
      --dataset_name 'Jeong2021_AISFMs' --gpu_ids '0' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 \
      --n_downsample 5 --n_gf 40 \
      --input_dir_test '../STEREO_Datasets' \
      --iteration 400000

<br/>

Before the training and generating, our datasets are normalized from -1 to 1.

<br/>


------------

## Citation

If you use the AISFMs in your research, please consider citing our paper.

* AISFMs (ver. 3): Jeong et al. (2021)

      TBD

<br/>

* AISFMs (ver. 2): [Jeong et al. (2020)](https://iopscience.iop.org/article/10.3847/2041-8213/abc255), "Solar Coronal Magnetic Field Extrapolation from Synchronic Data with AI-generated Farside", The Astrophysical Journal Letters, Volume 903, Issue 2, id.L25, 9 pp.
* AISFMs (ver. 1): [Kim, Park, Lee et al. (2019)](https://www.nature.com/articles/s41550-019-0711-5), "Solar Farside Magnetograms from Deep Learning Analysis of STEREO/EUVI Data", Nature Astronomy, Volume 3, p. 397-400
