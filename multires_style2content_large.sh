# This variant of multires was used with 8 Tesla K80 11GB GPUs. The script may need to be adjusted depending on the content image size. 

CONTENT_IMAGE=content_image.jpg
STYLE_IMAGE=style_image.png

INTERPRETER=th # Replace with python/python3 for neural-style-pt
SCRIPT=neural_style.lua # Replace with neural_style.py for neural-style-pt

NEURAL_STYLE=$INTERPRETER
NEURAL_STYLE+=" "
NEURAL_STYLE+=$SCRIPT

# Uncomment if using pip package
#NEURAL_STYLE=neural-style


MULTIDEVICE_PARAMETER="-multigpu_strategy" # Replace -multigpu_strategy with -multidevice_strategy for neural-style-pt

#Histogram Matching from style image to content image:
python linear-color-transfer.py --target_image $CONTENT_IMAGE --source_image $STYLE_IMAGE --output_image content_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out1.png \
  -image_size 640 \
  -num_iterations 1500 
  
python linear-color-transfer.py --target_image out1.png --source_image $STYLE_IMAGE --output_image out1_hist_colored_pca.png
  
$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out1_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 500 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -output_image out2.png \
  -image_size 768 \
  -num_iterations 1000
 
python linear-color-transfer.py --target_image out2.png --source_image $STYLE_IMAGE --output_image out2_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out2_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1024 \
  -num_iterations 500 \
  -output_image out3.png \

python linear-color-transfer.py --target_image out3.png --source_image $STYLE_IMAGE --output_image out3_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out3_hist_colored_pca.png \
  -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1152 \
  -num_iterations 200 \
  -output_image out4.png \

python linear-color-transfer.py --target_image out4.png --source_image $STYLE_IMAGE --output_image out4_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out4_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1536 \
  -num_iterations 200 \
  -output_image out5.png \
  
python linear-color-transfer.py --target_image out5.png --source_image $STYLE_IMAGE --output_image out5_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out5_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1664 \
  -num_iterations 200 \
  -output_image out6.png \

python linear-color-transfer.py --target_image out6.png --source_image $STYLE_IMAGE --output_image out6_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out6_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune \
  -image_size 1920 \
  -num_iterations 200 \
  -output_image out7.png

python linear-color-transfer.py --target_image out7.png --source_image $STYLE_IMAGE --output_image out7_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out7_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2048 \
  -num_iterations 200 \
  -output_image out8.png

python linear-color-transfer.py --target_image out8.png --source_image $STYLE_IMAGE --output_image out8_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out8_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2432 \
  -num_iterations 200 \
  -output_image out9.png

python linear-color-transfer.py --target_image out9.png --source_image $STYLE_IMAGE --output_image out9_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out9_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2560 \
  -num_iterations 200 \
  -output_image out10.png

python linear-color-transfer.py --target_image out10.png --source_image $STYLE_IMAGE --output_image out10_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out10_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2816 \
  -num_iterations 200 \
  -output_image out11.png

python linear-color-transfer.py --target_image out11.png --source_image $STYLE_IMAGE --output_image out11_hist_colored_pca.png

$NEURAL_STYLE \
  -content_image content_colored_pca.png \
  -style_image $STYLE_IMAGE \
  -init image -init_image out11_hist_colored_pca.png \
  -gpu 0,1,2,3,4,5,6,7 $MULTIDEVICE_PARAMETER 3,6,12,15,20,26,31 -tv_weight 0 -seed 876 -save_iter 0 -print_iter 50 -init image -backend cudnn -cudnn_autotune -optimizer adam \
  -image_size 2944 \
  -num_iterations 200 \
  -output_image out12.png

python linear-color-transfer.py --target_image out12.png --source_image $STYLE_IMAGE --output_image out12_hist_colored_pca.png

# Luminance Transfer from histogram matched content image, to the final output:
python lum-transfer.py --output_lum2 out12.png --cp_mode lum2 --output_image out12_final.png --org_content content_colored_pca.png

# Luminance Transfer from unmodified content image, to the final output:
python lum-transfer.py --output_lum2 out12.png --cp_mode lum2 --output_image out12_final_2.png --org_content $CONTENT_IMAGE