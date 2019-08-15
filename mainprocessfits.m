clc;clear;close all;
warning off all;
%���׺�ƽ��
biasdata = addbias();
flatdata = addflat();

%��ȡͼ������Աȶ�
imagedata = fitsread('YFCf050169.fits','image');
imagedata = imagedata(100:1000,100:1000);
adjustdata = adjustflat(imagedata,biasdata,flatdata);
reimagedata = operateimage(adjustdata);
lastdata = uint8(reimagedata);
filtdata = medfilt2(lastdata,[3,3]);

%��background 
backgroud = solvebackground(reimagedata);

%��ʾͼ��
figure
imshow(lastdata);
figure 
imshow(filtdata);
fitswrite(lastdata,'myfile.fits');
