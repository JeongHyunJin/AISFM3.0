# AI-generated Solar Farside Magnetograms (AISFMs) 3.0

<p align="justify">
     AISFMs are solar farside line-of-sight magnetograms generated by a deep learning model.
     We have generated the AISFMs by the model from the corresponding Extreme UltraViolet (EUV) observations of STEREO Ahead (A) or Behind (B).
     The orbit of STEREO A & B is at a distance of about 1 AU, and drift away from the Earth at a rate of about 22° per year in opposite directions.
     The AISFMs can offer a complete 360 degree view of the entire Sun with the frontside magnetograms.
</p>
<p align="justify">
     We have made an upgraded model including a CC-based objective with additional input data: not only the farside STEREO EUV images but also the frontside data pairs of SDO/AIA EUV images and HMI magnetograms as reference information.
     We expect that the frontside data pairs provide the historic information of magnetic field polarity distributions.
     More detailed information of our improved AISFMs can be found in our publications.
</p>
<p align="justify">
     The AI-generated data have produced by Sun and Space Weather Laboratory (SSWL) at Kyung Hee University (KHU) and released by Korea Astronomy and Space Science Institute (KASI).
     The AISFMs 3.0 are publicaly available at Korean Data Center (KDC) for SDO website.
</p>
<br/>

* [KDC for SDO](http://sdo.kasi.re.kr/)
* [Where is STEREO?](https://stereo-ssc.nascom.nasa.gov/cgi-bin/make_where_gif) 
* [Solar TErrestrial RElations Observatory (STEREO)](https://www.nasa.gov/mission_pages/stereo/sun/index.html)
* [Solar Dynamics Observatory (SDO)](https://sdo.gsfc.nasa.gov/mission/)

<br/>

------------

<br/>

## Example Gallery

<p align="justify">
     This repository contains several codes to understand the AISFM data. 
     The SunPy 3.1 module (https://sunpy.org) is used for the examples.
</p>

<br/>

* The <code>*Ex1_Visualizations_of_AISFMs.ipynb*</code> shows how to open and plot the AISFM data. 
<br/>

* The <code>*Ex2_Coordinates_of_AISFMs.ipynb*</code> shows how to get locations of the STEREOs from the corresponding AISFM data.
<br/>

* The <code>*Ex3_Reprojections_of_AISFMs.ipynb*</code> shows how you can reproject AISFMs to the view from different observers. 
<br/>

* The <code>*Ex4_Observations_of_AISFMs.ipynb*</code> shows how to check model inputs from the corresponding AISFM data.
<br/>

* The <code>*Ex5_STEREO_data_with_poor_quality.ipynb*</code> shows examples of STEREO/EUVI images with poor quality.  
<br/>

<br/>

------------

<br/>


## Acquirring the AISFMs

The following shows how to download the AISFMs from the [KDC for SDO](http://sdo.kasi.re.kr/) website.

<br/>

<img src="https://user-images.githubusercontent.com/68056295/164351068-287d7dc2-db83-4102-8752-bd55b0a65fdc.png" width="70%" height="70%"></center>

<br/>

<img src="https://user-images.githubusercontent.com/68056295/164351103-c1db9fb7-a90b-4bad-98ed-47620cec7326.png" width="70%" height="70%"></center>

<br/>

------------

<br/>

## Citation

If you use the AISFMs in your study, please consider citing our paper.

* AISFMs 3.0: Jeong et al. (2022)

      TBD

<br/>

* AISFMs 2.0: [Jeong et al. (2020)](https://iopscience.iop.org/article/10.3847/2041-8213/abc255), "Solar Coronal Magnetic Field Extrapolation from Synchronic Data with AI-generated Farside", The Astrophysical Journal Letters, Volume 903, Issue 2, id.L25, 9 pp.
* AISFMs 1.0: [Kim, Park, Lee et al. (2019)](https://www.nature.com/articles/s41550-019-0711-5), "Solar Farside Magnetograms from Deep Learning Analysis of STEREO/EUVI Data", Nature Astronomy, Volume 3, p. 397-400


<br/>

------------

<br/>

## Deep Learning Model

We used *Pix2PixCC* model to generate the AISFMs 3.0, and the codes are available at https://github.com/JeongHyunJin/Pix2PixCC. <br/>

We trained the model as below:

      python pix2pixCC_Train.py \
      --dataset_name 'aisfm_v3' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 --ch_balance 1.5 \
      --n_downsample 5 --n_gf 40 --n_df 40 \
      --padding_size 62 --display_scale 150 \
      --input_dir_train '../Datasets/Train_data/Train_input' \
      --target_dir_train '../Datasets/Train_data/Train_output' \
      --n_epochs 150 --save_freq 10000 --display_freq 5000

<br/>

We generated the AISFMs by the tranined model as below:

      python pix2pixCC_Test.py \
      --dataset_name 'aisfm_v3' \
      --data_format_input 'fits' --data_format_target 'fits' \
      --input_ch 7 --target_ch 1 \
      --n_downsample 5 --n_gf 40 \
      --input_dir_test '../STEREO_Datasets' \
      --iteration 760000

<br/>

<br/>
