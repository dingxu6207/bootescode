clc;clear;close all;
warning off all;
%本底和平场
biasdata = addbias();
flatdata = addflat();

%读取图像，拉伸对比度
imagedata = fitsread('YFCf050169.fits','image');
imagedata = imagedata(100:1000,100:1000);
adjustdata = adjustflat(imagedata,biasdata,flatdata);
reimagedata = operateimage(adjustdata);
lastdata = uint8(reimagedata);
filtdata = medfilt2(lastdata,[3,3]);

%求background 
backgroud = solvebackground(reimagedata);

%显示图像
figure
imshow(lastdata);
figure 
imshow(filtdata);
fitswrite(lastdata,'myfile.fits');
