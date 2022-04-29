function U = convolve(I,gf)
%I --> black and white input image
%fsize --> 2 element array representing filter size
%sigma --> sigma value for the gaussina filter
f=size(gf,1);
l=size(I,1);
b=size(I,2);
p=(f-1)/2;
Im=padarray(I,[p p],'replicate','both');
Im=double(Im);
U=zeros(l,b);
for i=1:size(Im,1)-f+1
    for j=1:size(Im,2)-f+1
        ig=Im(i:i+f-1,j:j+f-1);
        temp=ig.*gf;
        d=sum(sum(temp));
        U(i,j)=d;
    end
end
U=uint8(U);






