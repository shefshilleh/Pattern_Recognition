function [performance] = KNNHD(x,trainingdata,P,K)
 
% x is the test sample, what you want to classify
% training data
% P is the prior
% K is the input for the KNN, how many points you want to include in the
% hypervolume

SIZE=size(x);

classiferratetotal=zeros(1,SIZE(3));

trainingdata2dimensional=[trainingdata(:,:,1);trainingdata(:,:,2);trainingdata(:,:,3)];

testdata2d=[x(:,:,1);x(:,:,2);x(:,:,3)];
 
class1=0;
class2=0;
class3=0;
for H=1:length(testdata2d)
c1=0
c2=0
c3=0
for T=1:length(trainingdata2dimensional);
distance=norm(testdata2d(H,:)-trainingdata2dimensional(T,:));

d(T)= distance;


end
[B,I] = sort(d);

B=B(1,1:K);
I=I(1,1:K);


for NY=1:length(I);
    if I(NY)<=length(trainingdata2dimensional)/3
        c1=c1+1;
    elseif I(NY)<=length(trainingdata2dimensional)*2/3
        c2=c2+1;
    else
        c3=c3+1;
    end
end
%This if statement floors it to classify as class one if theyre all equal,
%and so on. I am not sure if this logic produces the best classifier, the
%only other way would be to assign weights instead of doing it randomly
%like this
if c1==c2 && c1==c3
    class1=class1+1
elseif c1==c2 && c1>c3
    class1=class1+1
elseif c2==c3 && c2>c1
    class2=class2+1
elseif c3==c1 && c3>c2
    class3=class3+1
elseif c1>c2 && c1>c3
     class1=class1+1
 elseif c2>c1 && c2>c3
     class2=class2+1
 elseif c3>c1 && c3>c2
     class3=class3+1
end

if H<=length(testdata2d)/3
    counter1=class1;
    class2=0;
    class3=0;
elseif H<=length(testdata2d)*2/3
    counter2=class2;
    class3=0;
else
    counter3=class3;
end

end
classifierrate=counter1/SIZE(1)+counter2/SIZE(1)+counter3/SIZE(1);
performance=classifierrate/3;

end

