export FLAGS_cudnn_deterministic=True
cd ${Project_path}
sed -i 's/RandCropImage/ResizeImage/g' ppcls/configs/ImageNet/SwinTransformer/SwinTransformer_large_patch4_window12_384.yaml
sed -ie '/RandFlipImage/d' ppcls/configs/ImageNet/SwinTransformer/SwinTransformer_large_patch4_window12_384.yaml
sed -ie '/flip_code/d' ppcls/configs/ImageNet/SwinTransformer/SwinTransformer_large_patch4_window12_384.yaml

rm -rf dataset
ln -s ${Data_path} dataset
mkdir log
python -m pip install -r requirements.txt
python tools/train.py -c ppcls/configs/ImageNet/SwinTransformer/SwinTransformer_large_patch4_window12_384.yaml -o Global.epochs=2 -o DataLoader.Train.sampler.shuffle=False -o DataLoader.Train.sampler.batch_size=4 -o DataLoader.Eval.sampler.batch_size=4 -o Optimizer.lr.learning_rate=0.001 > log/SwinTransformer_large_patch4_window12_384_1card.log 2>&1
cat log/SwinTransformer_large_patch4_window12_384_1card.log | grep Train | grep Avg | grep 'Epoch 2/2' > ../log/SwinTransformer_large_patch4_window12_384_1card.log
