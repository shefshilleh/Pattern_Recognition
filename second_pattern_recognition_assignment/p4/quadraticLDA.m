function [gx1,gx2,gx3,performance] = quadraticLDA(x,trainingdata,P)

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
%LDA STUFF (h-L)
trainingdata2dimensional=[trainingdata(:,:,1);trainingdata(:,:,2);trainingdata(:,:,3)]
[y, v, d] = tamu_lda(trainingdata2dimensional, [ones(length(trainingdata),1);2*ones(length(trainingdata),1);3*ones(length(trainingdata),1)]);

%Projecting training Data
projtrainingdata1=[trainingdata(:,:,1)*v(:,1),trainingdata(:,:,1)*v(:,2)]
projtrainingdata2=[trainingdata(:,:,2)*v(:,1),trainingdata(:,:,2)*v(:,2)]
projtrainingdata3=[trainingdata(:,:,3)*v(:,1),trainingdata(:,:,3)*v(:,2)]
meanprojection=cat(3,mean(projtrainingdata1),mean(projtrainingdata2),mean(projtrainingdata3))
covprojection=cat(3,cov(projtrainingdata1),cov(projtrainingdata2),cov(projtrainingdata3))
% Projecting test Data
pt1=[x(:,:,1)*v(:,1),x(:,:,1)*v(:,2)]
pt2=[x(:,:,2)*v(:,1),x(:,:,2)*v(:,2)]
pt3=[x(:,:,3)*v(:,1),x(:,:,3)*v(:,2)]
pt=cat(3,pt1,pt2,pt3)


for E=1:SIZE(3)
c1=0
c2=0
c3=0
for H=1:length(pt)

%First classifier
gx1=-0.5*(pt(H,:,E)-meanprojection(:,:,1))*inv(covprojection(:,:,1))*(pt(H,:,E)-meanprojection(:,:,1))'-(0.5)*log(det(covprojection(:,:,1)))+log(P);
%Second classifier
gx2=-0.5*(pt(H,:,E)-meanprojection(:,:,2))*inv(covprojection(:,:,2))*(pt(H,:,E)-meanprojection(:,:,2))'-(0.5)*log(det(covprojection(:,:,2)))+log(P);
%Third Classifier
gx3=-0.5*(pt(H,:,E)-meanprojection(:,:,3))*inv(covprojection(:,:,3))*(pt(H,:,E)-meanprojection(:,:,3))'-(0.5)*log(det(covprojection(:,:,3)))+log(P);

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

