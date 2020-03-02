function [class1,class2,class3] = hw2p6(testdata)

% once the file is done running, the program writes a csv file with the
% labels as a column vector, this is not an output of the function but it
% should write the file into the directory the function is operating in...
% see line 113

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%USER HAS TO INPUT THE TEST DATA only in the following format:
% 'name_of_file.file_type' when calling this function, for example, if I wanted
% to put the sample you gave us in the homework I would write the
% following.... [class1,class2,class3]=hw2p6('hw2p6_x2.csv'). The same can
% be done for an excel file

% PRAYING IT WORKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testdata=importdata(testdata);
DIMENSION=size(testdata);

% Making sure my K Value is big but not too big because I do not know the
% size of the data you are putting

K=round(DIMENSION(1)/4);
if (round(DIMENSION(1)/4))>100;
    K=100;
else
    K=K;
end
  
%FIRST MAKE SURE THAT THE FILES BELOW ARE IN THE SAME DIRECTORY
Traininglabels = csvread('hw2p6_c1.csv');
Trainingvalues = csvread('hw2p6_x1.csv');
A=[Traininglabels,Trainingvalues];
B=sortrows(A);
trainingdata1=B(1:97,2:end);
trainingdata2=B(98:186,2:end);
trainingdata3=B(187:300,2:end);
trainingdata2dimensional=[trainingdata1;trainingdata2;trainingdata3];
SIZE1=size(trainingdata1);
SIZE2=size(trainingdata2);
SIZE3=size(trainingdata3);
%LDA STUFF 
[y, v, d] = tamu_lda(trainingdata2dimensional, [ones((SIZE1(1)),1);2*ones((SIZE2(1)),1);3*ones((SIZE3(1)),1)]);
%Projecting training Data
projtrainingdata1=[trainingdata1*v(:,1),trainingdata1*v(:,2)];
projtrainingdata2=[trainingdata2*v(:,1),trainingdata2*v(:,2)];
projtrainingdata3=[trainingdata3*v(:,1),trainingdata3*v(:,2)];
STACKEDprojectedtrainingdata=[projtrainingdata1;projtrainingdata2;projtrainingdata3];
% Projecting test Data
STACKEDprojectedtestdata=[testdata*v(:,1),testdata*v(:,2)];
X=size(STACKEDprojectedtestdata);

% Setting the class counter
class1=0;
class2=0;
class3=0;
% Setting the distance counter

for H=1:X(1)
c1=0;
c2=0;
c3=0;
for T=1:length(trainingdata2dimensional);
distance=norm(STACKEDprojectedtestdata(H,:)-STACKEDprojectedtrainingdata(T,:));

d(T)= distance;

end
[B,I] = sort(d);
B=B';
I=I';

B=B(1,1:K);
I=I(1,1:K);

for NY=1:length(I);
    if I(NY)<=97;
        c1=c1+1;
    elseif I(NY)<=186;
        c2=c2+1;
    else
        c3=c3+1;
    end
end

if c1==c2 && c1==c3;
    class1=class1+1;
    classlabelcolumnvector(H,1)=1;
elseif c1==c2 && c1>c3;
    class1=class1+1;
    classlabelcolumnvector(H,1)=1;
elseif c2==c3 && c2>c1;
    class2=class2+1;
    classlabelcolumnvector(H,1)=2;
elseif c3==c1 && c3>c2;
    class3=class3+1;
    classlabelcolumnvector(H,1)=3;
elseif c1>c2 && c1>c3;
     class1=class1+1;
     classlabelcolumnvector(H,1)=1;
 elseif c2>c1 && c2>c3;
     class2=class2+1;
     classlabelcolumnvector(H,1)=2;
 elseif c3>c1 && c3>c2;
     class3=class3+1;
     classlabelcolumnvector(H,1)=3;
end
end
% LOOK AT THE DIRECTORY AFTER THE FUNCTION IS RUN TO SEE THE PREDICTED
% CLASS LABEL OF EACH EXAMPLE, creates a file called test_labels.csv
csvwrite('test_labels.csv',classlabelcolumnvector)
end