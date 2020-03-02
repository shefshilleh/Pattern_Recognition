function [performance] = quadratic(x,trainingdata,P)
 
% x is the test sample, what you want to classify
% training data
% P is the prior
 
% The input here is a three dimensional array with thickness of 3, so were
% getting three mean vectors and 3 covariance matrices for the threee
% different classes of training data that we will use to classify the test
% data in this function!
 
 
mu=mean(trainingdata);
covarianceOFfirstTrainingData=cov(trainingdata(:,:,1));
covarianceOFsecondTrainingData=cov(trainingdata(:,:,2));
covarianceOFthirdTrainingData=cov(trainingdata(:,:,3));
SIZE=size(x);
 
classiferratetotal=zeros(1,SIZE(3));
 
for E=1:SIZE(3)
c1=0
c2=0
c3=0
for H=1:length(x)
 
%First classifier
gx1=-0.5*(x(H,:,E)-mu(:,:,1))*inv(covarianceOFfirstTrainingData)*(x(H,:,E)-mu(:,:,1))'-(0.5)*log(det(covarianceOFfirstTrainingData))+log(P);
%Second classifier
gx2=-0.5*(x(H,:,E)-mu(:,:,2))*inv(covarianceOFsecondTrainingData)*(x(H,:,E)-mu(:,:,2))'-(0.5)*log(det(covarianceOFsecondTrainingData))+log(P);
%Third Classifier
gx3=-0.5*(x(H,:,E)-mu(:,:,3))*inv(covarianceOFthirdTrainingData)*(x(H,:,E)-mu(:,:,3))'-(0.5)*log(det(covarianceOFthirdTrainingData))+log(P);
 
if gx1>gx2 && gx1>gx3 
    c1=c1+1;
elseif gx2>gx1 && gx2>gx3
    c2=c2+1;
elseif gx3>gx1 && gx3>gx2
     c3=c3+1;
end
 
end
 
if E==1
  classifierrate=c1/SIZE(1);
elseif E==2
  classifierrate=c2/SIZE(1);
else 
    classifierrate=c3/SIZE(1);
end
classiferratetotal(E)=classifierrate;
end
performance=sum(classiferratetotal)/length(classiferratetotal);
 
 
end


