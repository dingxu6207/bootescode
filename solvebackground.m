function background = solvebackground(reimagedata)
hang = 3;
lie = 3;
[m,n] = size(reimagedata);
submtr = zeros(hang,lie);
sub = [];
sortsub = [];
for i = 1:m-hang+1
    for j = 1:n-lie+1
       submtr =  reimagedata(i:i+hang-1,j:j+lie-1);
       sumsub = sum(submtr(:))/(hang*lie);
       sub(i+j) = sumsub;
    end
end

backgroundvalue = sort(sub);

background = (backgroundvalue(2)+backgroundvalue(3)+backgroundvalue(4))/3;

end