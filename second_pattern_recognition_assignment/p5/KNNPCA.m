function [performance] = KNNPCA(x,trainingdata,P,K)
 
% x is the test sample, what you want to classify
% training data
% P is the prior
% K is the input for the KNN, how many points you want to include in the
% hypervolume

SIZE=size(x);

classiferratetotal=zeros(1,SIZE(3));

trainingdata2dimensional=[trainingdata(:,:,1);trainingdata(:,:,2);trainingdata(:,:,3)];

testdata2d=[x(:,:,1);x(:,:,2);x(:,:,3)];

%PCA STUFF (d-g)
mutraining=mean(trainingdata2dimensional)
covtraining=cov(trainingdata2dimensional)
[vectors, values]=eig(covtraining)
eigenvalues=diag(values)
[descendingorder, index]=sort(eigenvalues,'descend')
[descendingordervectors]=vectors(:,index)
%Projecting training Data
projtrainingdata1=[trainingdata(:,:,1)*descendingordervectors(:,1),trainingdata(:,:,1)*descendingordervectors(:,2),trainingdata(:,:,1)*descendingordervectors(:,3)]
projtrainingdata2=[trainingdata(:,:,2)*descendingordervectors(:,1),trainingdata(:,:,2)*descendingordervectors(:,2),trainingdata(:,:,2)*descendingordervectors(:,3)]
projtrainingdata3=[trainingdata(:,:,3)*descendingordervectors(:,1),trainingdata(:,:,3)*descendingordervectors(:,2),trainingdata(:,:,3)*descendingordervectors(:,3)]
STACKEDprojectedtrainingdata=[projtrainingdata1;projtrainingdata2;projtrainingdata3]
% Projecting test Data
pt1=[x(:,:,1)*descendingordervectors(:,1),x(:,:,1)*descendingordervectors(:,2),x(:,:,1)*descendingordervectors(:,3)]
pt2=[x(:,:,2)*descendingordervectors(:,1),x(:,:,2)*descendingordervectors(:,2),x(:,:,2)*descendingordervectors(:,3)]
pt3=[x(:,:,3)*descendingordervectors(:,1),x(:,:,3)*descendingordervectors(:,2),x(:,:,3)*descendingordervectors(:,3)]

STACKEDprojectedtestdata=[pt1;pt2;pt3]




class1=0
class2=0
class3=0
for H=1:length(testdata2d)
c1=0
c2=0
c3=0
for T=1:length(STACKEDprojectedtrainingdata);
distance=norm(STACKEDprojectedtestdata(H,:)-STACKEDprojectedtrainingdata(T,:));

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

if H<=length(STACKEDprojectedtestdata)/3
    counter1=class1;
    class2=0;
    class3=0;
elseif H<=length(STACKEDprojectedtestdata)*2/3
    counter2=class2;
    class3=0;
else
    counter3=class3;
end

end
classifierrate=counter1/SIZE(1)+counter2/SIZE(1)+counter3/SIZE(1);
performance=classifierrate/3;

end

