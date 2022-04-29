%Q.1
img=imread('leena_noisy.jpg');
I=rgb2gray(img);
gf=fspecial('gaussian',[7 7],1); % gaussian filter
U=convolve(I,gf); % convolving gaussian filter with image
figure,imshow(I);title('original image');
figure,imshow(U);title('gaussian filtered with kernel size = 7 and sigma = 1');
meanf=fspecial('average',[7 7]); % mean filter
V=convolve(I,meanf); % convolving mean filter with image
figure,imshow(V);title('mean filtered with kernel size = 7');
%%
%Q.2
template=imread('where-is-waldo.jpg'); % template image
tempgray=rgb2gray(template); 
target=imread('waldo.jpg'); % target image
targetgray=rgb2gray(target);
[G,a,b]=ncc(tempgray,targetgray); % performing normalized cross correlation between the template and the target
figure,imshow(template);title('the whole image');
figure,imshow(target);title('waldo');
figure,imshow(G);title('ncc map'); % G is the NCC map 
figure,imshow(template)
hold on % drawing a box around waldo in the template; [b,a] are the indices of waldo in the template
rectangle('Position',[(b-size(target,2)/2),(a-size(target,1)/2),size(target,2),size(target,1)],'EdgeColor','r','Linewidth',2);
title('waldo found!');
%%
%Q.3
im=imread('image1.jpg');
figure,imshow(im);title('original image');
sobh=fspecial('sobel'); % a 3X3 sobel kernel for y gradient
sobv=sobh'; % a 3X3 sobel kernel for x gradient
gx=convolve(im,sobv); % perfroming covolution for x gradient
figure,imshow(gx);title('x gradient');
gy=convolve(im,sobh); % perfroming covolution for y gradient
figure,imshow(gy);title('y gradient');
absg=gx+gy; % absolute magnitude of gradient
figure,imshow(absg);title('absolute gradient');
bw=imbinarize(absg,0.75); % thresholded for dominant edges
figure,imshow(bw);title('binarized image');


