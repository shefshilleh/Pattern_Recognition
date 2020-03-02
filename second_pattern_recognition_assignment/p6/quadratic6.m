function [performance] = quadratic6(x,trainingdata1,trainingdata2,trainingdata3,P)
 
% x all of the test samples, what you want to classify
% training(1,2,3) data of each class
% P is the prior
 
% Input is no longer a three dimensional array because I cannot create a
% tensor if the data is uneven, so I created a slightly different code that
% incorporates 2D arrays for the sake of problem 6
% 
 
 
mu1=mean(trainingdata1);
mu2=mean(trainingdata2);
mu3=mean(trainingdata3);
covarianceOFfirstTrainingData=cov(trainingdata1);
covarianceOFsecondTrainingData=cov(trainingdata2);
covarianceOFthirdTrainingData=cov(trainingdata3);
 
c1=0;
c2=0;
c3=0;
for H=1:length(x)
 
%First classifier
gx1=-0.5*(x(H,:)-mu1)*inv(covarianceOFfirstTrainingData)*(x(H,:)-mu1)'-(0.5)*log(det(covarianceOFfirstTrainingData))+log(P);
%Second classifier
gx2=-0.5*(x(H,:)-mu2)*inv(covarianceOFsecondTrainingData)*(x(H,:)-mu2)'-(0.5)*log(det(covarianceOFsecondTrainingData))+log(P);
%Third Classifier
gx3=-0.5*(x(H,:)-mu3)*inv(covarianceOFthirdTrainingData)*(x(H,:)-mu3)'-(0.5)*log(det(covarianceOFthirdTrainingData))+log(P);
 
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
