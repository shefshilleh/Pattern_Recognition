function [labels] = hw3p4(test)
test=csvread(test);
a=size(test);
numofclasses=10
trainingdata=csvread('hw3p4_x1_updated.csv');
traininglabels=csvread('hw3p4_c1.csv');
trainingdatawlabels=[trainingdata traininglabels];
trainingdata=trainingdata(1:end,:);
SIZE1=size(trainingdatawlabels);
tensor=zeros(1,SIZE1(2),numofclasses);
features=[17 38 16 20 23 24 26 33 21];
test=test(1:end,features)

for i=1:SIZE1(1)
    index=trainingdatawlabels(i,end)
    tensor(:,:,index)=[tensor(:,1:end-1,index)+trainingdatawlabels(i,1:end-1) tensor(1,end,index)+1];
end

avgclassdata=zeros(1,SIZE1(2)-1,numofclasses);
for b=1:numofclasses
    avgclassdata(:,:,b)=tensor(:,1:end-1,b)/tensor(1,end,b);
end
avgclassdata=avgclassdata(:,features,:)
u=size(avgclassdata)
SIZE2=size(test);
counter=0;

for k=1:SIZE2(1)
    for beta=1:u(2)
    a(1,beta)=norm(avgclassdata(:,:,beta)-test(k,:));
    end
    result=find(a==min(a));
    labels(k,1)=result;
end
    csvwrite('test_labels.csv',labels);
end
