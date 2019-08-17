function adjustdata = adjustflat(imagedata,biasdata,flatdata)

[hang,lie] = size(biasdata);
Bba = sum(biasdata(:))/(hang*lie);
I = flatdata - Bba;
Iba = sum(I(:))/(hang*lie);
fenzi = imagedata - Bba;
fenmu = I;
you = Iba;

adjustdata = (fenzi./fenmu).*you+Bba;


