% psnr
function result=psnr(in1,in2)
z=mse(in1,in2);
mm=max(max(in1,[],2));
result=10*(log(mm.^2/z)./(log(10)));
function z=mse(x,y)
x=double(x);
y=double(y);
[m,n]=size(x);
z=0;
for i=1:m
    for j=1:n
        z=z+(x(i,j)-y(i,j)).^2;
    end
end
z=z/(m*n);