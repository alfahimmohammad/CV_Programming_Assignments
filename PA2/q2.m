img=imread('image7.jpg');
img1=rgb2gray(img);
img1=imgaussfilt(img1,7);%5 for img5 , 4.5 for img6, 7 for img7
I=edge(img1,'canny');
imshow(img);title('detected circles in image7.jpg');
axis on
[m ,n]= size(I);
p=zeros(3*m,3*n,50);

for l=1:n
    for b=1:m
        if I(b,l)==1
            for r=1:50
                for j=b-r:b+r
                    a = floor(l - sqrt(r^2 - (b-j)^2));
                    p(j+m,a+n,r) = p(j+m,a+n,r) + 1;
                end
            end
        end
    end
end
p=rescale(p);
indices = [0 0 0];
for r=1:35
    for i=1:3*n
        for j=1:3*m
            if p(j,i,r)>0.6 % 0.6 for img5 , 0.5 for img6 , 0.6 for img7
                indices=[indices; i j r];
            end
        end
    end
end
indices=indices(2:end,:);
for i=1:size(indices,1)
    a = indices(i,1);
    b = indices(i,2);
    r = indices(i,3);
    a = a - n;
    b = b - m;
    hold on
    circle(a,b,r);
end