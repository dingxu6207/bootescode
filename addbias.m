function biasdata = addbias()
global minheng ;
global maxheng ;
global minlie;
global maxlie;

biasdata0 = fitsread('YFCf050026.fits','image');
biasdata1 = fitsread('YFCf050027.fits','image');
biasdata2 = fitsread('YFCf050028.fits','image');
biasdata3 = fitsread('YFCf050029.fits','image');
biasdata4 = fitsread('YFCf050030.fits','image');
biasdata5 = fitsread('YFCf050031.fits','image');
biasdata6 = fitsread('YFCf050032.fits','image');
biasdata7 = fitsread('YFCf050033.fits','image');
biasdata = (biasdata0 + biasdata1 + biasdata2 + biasdata3 +...
    biasdata4 + biasdata5 + biasdata6 + biasdata7 )/8;

biasdata = biasdata(minheng:maxheng,minlie:maxlie);
