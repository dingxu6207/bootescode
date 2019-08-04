clc;clear;
biasdata = addbias();
flatdata = addflat();

imagedata = fitsread('YFCf050169.fits','image');
imagedata = imagedata(100:1000,100:1000);
adjustdata = adjustflat(imagedata,biasdata,flatdata);

reimagedata = operateimage(adjustdata);
lastdata = uint8(reimagedata);
filtdata = medfilt2(lastdata,[3,3]);
figure
imshow(lastdata);
figure 
imshow(filtdata);
fitswrite(lastdata,'myfile.fits');
