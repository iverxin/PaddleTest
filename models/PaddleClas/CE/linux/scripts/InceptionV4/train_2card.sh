export FLAGS_cudnn_deterministic=True
cd ${Project_path}
sed -i 's/RandCropImage/ResizeImage/g' ppcls/configs/ImageNet/Inception/InceptionV4.yaml #将 RandCropImage 字段替换为 ResizeImage
sed -ie '/RandFlipImage/d' ppcls/configs/ImageNet/Inception/InceptionV4.yaml #删除 RandFlipImage 字段行
sed -ie '/flip_code/d' ppcls/configs/ImageNet/Inception/InceptionV4.yaml #删除 flip_code 字段行
rm -rf dataset
ln -s ${Data_path} dataset
mkdir log
python -m pip install -r requirements.txt
python -m paddle.distributed.launch tools/train.py -c ppcls/configs/ImageNet/Inception/InceptionV4.yaml -o Global.epochs=2 -o Global.eval_during_train=False > log/inceptionv4_2card.log 2>&1
cat log/inceptionv4_2card.log | grep Avg | grep 'Epoch 2/2' > ../log/inceptionv4_2card.log
