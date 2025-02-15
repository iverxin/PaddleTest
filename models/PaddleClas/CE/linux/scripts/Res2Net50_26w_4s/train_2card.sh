export FLAGS_cudnn_deterministic=True
cd ${Project_path}
sed -i 's/RandCropImage/ResizeImage/g'  ppcls/configs/ImageNet/Res2Net/Res2Net50_26w_4s.yaml
sed -ie '/RandFlipImage/d'  ppcls/configs/ImageNet/Res2Net/Res2Net50_26w_4s.yaml
sed -ie '/flip_code/d'  ppcls/configs/ImageNet/Res2Net/Res2Net50_26w_4s.yaml

rm -rf dataset
ln -s ${Data_path} dataset
mkdir log
python -m pip install -r requirements.txt
python -m paddle.distributed.launch tools/train.py -c ppcls/configs/ImageNet/Res2Net/Res2Net50_26w_4s.yaml -o Global.epochs=2 -o DataLoader.Train.sampler.shuffle=False -o DataLoader.Train.sampler.batch_size=4 -o DataLoader.Eval.sampler.batch_size=4 > log/Res2Net50_26w_4s_2card.log 2>&1
cat log/Res2Net50_26w_4s_1card.log | grep Train | grep Avg | grep 'Epoch 2/2' > ../log/Res2Net50_26w_4s_2card.log
