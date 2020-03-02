function [performance] = KNNLDA6(testdata1,testdata2,testdata3,trainingdata1,trainingdata2,trainingdata3,P,K)
 
% x is the test sample, what you want to classify
% training data
% P is the prior
% K is the input for the KNN, how many points you want to include in the
% hypervolume
SIZE1=size(trainingdata1)
SIZE2=size(trainingdata2)
SIZE3=size(trainingdata3)
trainingdata2dimensional=[trainingdata1;trainingdata2;trainingdata3]

%LDA STUFF (h-L)
[y, v, d] = tamu_lda(trainingdata2dimensional, [ones((SIZE1(1)),1);2*ones((SIZE2(1)),1);3*ones((SIZE3(1)),1)]);

%Projecting training Data
projtrainingdata1=[trainingdata1*v(:,1),trainingdata1*v(:,2)]
projtrainingdata2=[trainingdata2*v(:,1),trainingdata2*v(:,2)]
projtrainingdata3=[trainingdata3*v(:,1),trainingdata3*v(:,2)]
STACKEDprojectedtrainingdata=[projtrainingdata1;projtrainingdata2;projtrainingdata3]
% Projecting test Data
pt1=[testdata1*v(:,1),testdata1*v(:,2)]
pt2=[testdata2*v(:,1),testdata2*v(:,2)]
pt3=[testdata3*v(:,1),testdata3*v(:,2)]

STACKEDprojectedtestdata=[pt1;pt2;pt3]






class1=0;
class2=0;
class3=0;

for H=1:length(STACKEDprojectedtestdata)
c1=0
c2=0
c3=0
for T=1:length(trainingdata2dimensional);
distance=norm(STACKEDprojectedtestdata(H,:)-STACKEDprojectedtrainingdata(T,:));

d(T)= distance;


end
[B,I] = sort(d);
B=B'
I=I'


B=B(1,1:K);
I=I(1,1:K);


for NY=1:length(I);
    if I(NY)<=97
        c1=c1+1;
    elseif I(NY)<=186
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

if H<=36
    counter1=class1;
    class2=0;
    class3=0;
elseif H<=62
    counter2=class2;
    class3=0;
else
    counter3=class3;
end

end
classifierrate=counter1/36+counter2/26+counter3/38;
performance=classifierrate/3;

end

