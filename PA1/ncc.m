function [G , a, b] = ncc(target,temp)
%target->where-is-waldo.jpg
%temp->waldo.jpg(template)
%G->ncc map
%H->waldo identified image
[templ , tempb]=size(temp);
[targetl , targetb]=size(target);
p1=(templ-1)/2;
p2=(tempb-1)/2;
target=double(target);
temp=double(temp);
padtarget=padarray(target,[p1 p2],'replicate','both');
template=temp-mean(mean(temp));
x=sum(sum(template.^2));
G=zeros(targetl,targetb);
for i=1:size(padtarget,1)-templ+1
    for j=1:size(padtarget,2)-tempb+1
        tg=padtarget(i:i+templ-1,j:j+tempb-1);
        tg=tg-mean(mean(tg));
        num=sum(sum(tg.*template));
        den=sqrt(sum(sum(tg.^2))*x);
        d=num/den;
        G(i,j)=d;
    end
end
[a,b]=find(ismember(G,max(G(:))));
%G=uint8(G);

