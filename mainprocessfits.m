clc;clear;close all;
warning off all;

%图像裁剪的全局变量
global minheng ;
global maxheng ;
global minlie;
global maxlie;

minheng = 101;
maxheng = 1000;
minlie = 101;
maxlie = 1000;

%本底和平场
biasdata = addbias();
flatdata = addflat();

%读取图像，拉伸对比度
imagedata = fitsread('YFCf050169.fits','image');
imagedata = imagedata(minheng:maxheng,minlie:maxlie);
adjustdata = adjustflat(imagedata,biasdata,flatdata);
reimagedata = operateimage(adjustdata);
lastdata = uint8(reimagedata);
filtdata = medfilt2(lastdata,[3,3]);

%求background 
backgroud = solvebackground(reimagedata);

partcount(filtdata);

allpartcount(filtdata);


%显示图像
figure 
imshow(filtdata);
fitswrite(lastdata,'myfile.fits');
