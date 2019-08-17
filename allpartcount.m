function allpartcount(filtdata)
A = zeros(30,30);
daA = zeros(900,900);

for row = 1:30
    for col = 1:30
        A = filtdata(((row-1)*30+1):(row)*30,((col-1)*30+1):(col)*30);
        daA(((row-1)*30+1):(row)*30,((col-1)*30+1):(col)*30) = A;        
    end
end
ldaA = uint8(daA);
figure 
imshow(ldaA)
title('daAµÄÍ¼Ïñ')
end

