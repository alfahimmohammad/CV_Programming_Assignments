img=imread('image2.png');
I=edge(img,'canny');
imshow(I);title('canny edge');
[m ,n]= size(I);
axis on
hold on 
x=1:n;
y=abs((1/sind(-135))*(202 - x*cosd(-135)));
plot(x,y,'r');
%%
img=imread('image4.png');
img=imgaussfilt(img,4);
I=edge(img,'canny');
[m ,n]= size(I);
imshow(I);title('canny edge');
axis on
hold on
x=1:n;
y=-(1/sind(-135))*(106-x*cosd(-135));
plot(x,y,'r');
%%
figure,
imshow(I)
