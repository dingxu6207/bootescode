function flatdata = addflat()

flatdata0 = fitsread('YFCf050061.fits','image');
flatdata1 = fitsread('YFCf050062.fits','image');
flatdata2 = fitsread('YFCf050063.fits','image');
flatdata3 = fitsread('YFCf050064.fits','image');
flatdata4 = fitsread('YFCf050065.fits','image');
flatdata5 = fitsread('YFCf050066.fits','image');
flatdata6 = fitsread('YFCf050067.fits','image');
flatdata7 = fitsread('YFCf050068.fits','image');
flatdata = (flatdata0 + flatdata1 + flatdata2 + flatdata3 +...
    flatdata4 + flatdata5 + flatdata6 + flatdata7 )/8;

flatdata = flatdata(100:1000,100:1000);
