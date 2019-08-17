function  partcount(filtdata)
%矩阵分块
part1 = filtdata(1:59,1:59);

[x,y] = size(part1);
lsum = zeros(1,x);
delta = zeros(1,x);
%计算X
for i = 1 : x
       lsum(i) =   sum(part1(i,:))/y;
end

for i = 3 : (x-2)
   delta(i-2) = 2*(lsum(i+1)-lsum(i-1)) + (lsum(i+2)-lsum(i-2));
end

[maxdeta,maxwei] = max(delta);
[mindeta,minwei] = min(delta);

%计算y
xc = (maxwei + minwei)/2;
chawei = (minwei - maxwei)*2;
xczuo = xc -chawei;
xcyou = xc + chawei;
ypart1 = part1(xczuo:xcyou,:);
dx = xcyou - xczuo;
ysum = zeros(1,y);
ydelta = zeros(1,y);
for j = 1:y
    ysum(j) = sum(ypart1(:,j))/dx;
end

for i = 3 : (y-2)
   ydelta(i-2) = 2*(ysum(i+1)-ysum(i-1)) + (ysum(i+2)-ysum(i-2));
end

[maxydeta,ymaxwei] = max(ydelta);
[minydeta,yminwei] = min(ydelta);

figure
imshow(part1)
hold on

%用矩形框标记出匹配区域
 plot([ymaxwei,yminwei+3],[maxwei,maxwei]);
 plot([ymaxwei,ymaxwei],[maxwei,minwei+3]);
 plot([ymaxwei,yminwei+3],[minwei+3,minwei+3]);
 plot([yminwei+3,yminwei+3],[maxwei,minwei+3]);
 