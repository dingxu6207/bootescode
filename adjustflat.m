function adjustdata = adjustflat(imagedata,biasdata,flatdata)
fenzi = imagedata - biasdata;
fenmu = flatdata - biasdata;

meandata = mean(fenmu(:));

fenmu = fenmu/meandata;

adjustdata = fenzi./fenmu;

