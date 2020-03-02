function [performance] = quadraticPCA6(testdata1,testdata2,testdata3,trainingdata1,trainingdata2,trainingdata3,P)
 
% x all of the test samples, what you want to classify
% training(1,2,3) data of each class
% P is the prior
 
% Input is no longer a three dimensional array because I cannot create a
% tensor if the data is uneven, so I created a slightly different code that
% incorporates 2D arrays for the sake of problem 6
 
 


%PCA STUFF
trainingdata2dimensional=[trainingdata1;trainingdata2;trainingdata3]
mutraining=mean(trainingdata2dimensional)
covtraining=cov(trainingdata2dimensional)
[vectors, values]=eig(covtraining)
eigenvalues=diag(values)
[descendingorder, index]=sort(eigenvalues,'descend')
[descendingordervectors]=vectors(:,index)

%Projecting training Data
projtrainingdata1=[trainingdata1*descendingordervectors(:,1),trainingdata1*descendingordervectors(:,2),trainingdata1*descendingordervectors(:,3)]
projtrainingdata2=[trainingdata2*descendingordervectors(:,1),trainingdata2*descendingordervectors(:,2),trainingdata2*descendingordervectors(:,3)]
projtrainingdata3=[trainingdata3*descendingordervectors(:,1),trainingdata3*descendingordervectors(:,2),trainingdata3*descendingordervectors(:,3)]

% Projecting test Data
pt1=[testdata1*descendingordervectors(:,1),testdata1*descendingordervectors(:,2),testdata1*descendingordervectors(:,3)]
pt2=[testdata2*descendingordervectors(:,1),testdata2*descendingordervectors(:,2),testdata2*descendingordervectors(:,3)]
pt3=[testdata3*descendingordervectors(:,1),testdata3*descendingordervectors(:,2),testdata3*descendingordervectors(:,3)]

STACKEDprojectedtestdata=[pt1;pt2;pt3]

mu1=mean(projtrainingdata1);
mu2=mean(projtrainingdata2);
mu3=mean(projtrainingdata3);
covarianceOFfirstTrainingData=cov(projtrainingdata1);
covarianceOFsecondTrainingData=cov(projtrainingdata2);
covarianceOFthirdTrainingData=cov(projtrainingdata3);



c1=0;
c2=0;
c3=0;
for H=1:length(STACKEDprojectedtestdata)
 
%First classifier
gx1=-0.5*(STACKEDprojectedtestdata(H,:)-mu1)*inv(covarianceOFfirstTrainingData)*(STACKEDprojectedtestdata(H,:)-mu1)'-(0.5)*log(det(covarianceOFfirstTrainingData))+log(P);
%Second classifier
gx2=-0.5*(STACKEDprojectedtestdata(H,:)-mu2)*inv(covarianceOFsecondTrainingData)*(STACKEDprojectedtestdata(H,:)-mu2)'-(0.5)*log(det(covarianceOFsecondTrainingData))+log(P);
%Third Classifier
gx3=-0.5*(STACKEDprojectedtestdata(H,:)-mu3)*inv(covarianceOFthirdTrainingData)*(STACKEDprojectedtestdata(H,:)-mu3)'-(0.5)*log(det(covarianceOFthirdTrainingData))+log(P);
 
if gx1>gx2 && gx1>gx3 
    c1=c1+1;
elseif gx2>gx1 && gx2>gx3
    c2=c2+1;
elseif gx3>gx1 && gx3>gx2
     c3=c3+1;
end
if H<=36
  counter1=c1;
  c2=0
  c3=0
elseif H<=62
  counter2=c2;
  c3=0
else 
    counter3=c3;
end

 
end
classifierrate=counter1/36+counter2/26+counter3/38;
performance=classifierrate/3;

end

