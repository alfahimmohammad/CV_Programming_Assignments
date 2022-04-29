%line detector
%filtering,and intialising parameter space
img=imread('image7.jpg');
img1=rgb2gray(img);
img1=imgaussfilt(img1,8);%6 for img3, 6 for img2, 4 for img1, 4 for img4 , 7 for img5, 8 for img7, 9 for img6
I=edge(img1,'canny');
imshow(img);title('detected lines in image6.png');
axis on
[m ,n]= size(I);
p=zeros(floor((m^2+n^2)^0.5),271);
p=p';
[theta,rho]=size(p);
%voting
for j=1:m
    for i=1:n
        if I(j,i)==1
            for k=-180:90
                p(k+181,floor(abs(cosd(k)*i-sind(k)*j))+1)=p(k+181,floor(abs(cosd(k)*i-sind(k)*j))+1)+1;
            end
        end
    end
end
p=uint8(p);
p=rescale(p);
%thresholding
q=zeros(theta,rho);
for i=1:theta
    for j=1:rho
        if p(i,j)>=0.75 %0.5 for img1,0.5 for img2 , 0.5 for img3, 0.7 for img4, 0.5 for img7-2, 0.75 for img7,  0.4 for img6,0.7 for img5
            q(i,j)=p(i,j);
        end
    end
end
indices=[0 0];

for i=1:size(q,1)
    for j=1:size(q,2)
        if q(i,j)>0
            indices=[indices; i j];
        end
    end
end
indices=indices(2:end,:);%contains all the rho and theta values
x=1:n;
%Plotting all the lines
for i = 1:size(indices,1)
    teta = indices(i,1);
    ro = indices(i,2);
    teta = teta - 181;
    ro = ro - 1;
    if teta ~= 0 && teta ~= -180 && teta ~= -90 && teta ~= 90 %&& teta == 45 && teta == -45
        y = -((1/sind(teta))*(ro-x*cosd(teta)));
        
    elseif teta == 0
        x = [ro ro];
        y = [1 m];
        
    elseif teta == -180
        x = [-ro -ro];
        y = [1 m];
        
    elseif teta == -90
        x = 1:n;
        y = abs(ro*ones(1,n));
        
    elseif teta == 90
        x = 1:n;
        y = ro*ones(1,n);
        
    end
    hold on 
    plot(x,y,'r');
  
end 
%%
%circle detector
%filtering,and intialising parameter space
img=imread('image7.jpg');
img1=rgb2gray(img);
img1=imgaussfilt(img1,7);%5 for img5 , 4.5 for img6, 7 for img7
I=edge(img1,'canny');
imshow(img);title('detected circles in image7.jpg');
axis on
[m ,n]= size(I);
p=zeros(3*m,3*n,50);
%voting
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
%thresholding and storing (a,b,r)
for r=1:35
    for i=1:3*n
        for j=1:3*m
            if p(j,i,r)>0.6 % 0.6 for img5 , 0.5 for img6 , 0.6 for img7
                indices=[indices; i j r];
            end
        end
    end
end
%plotting all the circles
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

