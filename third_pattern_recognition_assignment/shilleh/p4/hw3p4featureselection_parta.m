close all, clear all, clc 
classes=10
A=csvread('hw3p4_c1.csv');
B=csvread('hw3p4_x1.csv');


B=[B A];
SIZEBB=size(B);
Bzeroed=zeros(SIZEBB(1),SIZEBB(2))
for i=1:SIZEBB(1)
     for k=1:SIZEBB(2)
         if B(i,k)<0;
             Bzeroed(i,k)=0;
         else 
             Bzeroed(i,k)=B(i,k);
         end
     end
end
 
TE=zeros(1,SIZEBB(2),classes);

for i=1:SIZEBB(1)
    index=Bzeroed(i,end)
    TE(:,:,index)=[TE(:,1:end-1,index)+Bzeroed(i,1:end-1) TE(1,end,index)+1];
end

avgclassdata=zeros(1,SIZEBB(2)-1,classes);
for b=1:classes
    avgclassdata(:,:,b)=TE(:,1:end-1,b)/TE(1,end,b);
end

Bnew=zeros(SIZEBB(1),SIZEBB(2));
for i=1:SIZEBB(1)
     for k=1:SIZEBB(2)
         if B(i,k)<0;
             index=B(i,end);
             Bnew(i,k)=avgclassdata(1,k,index);
         else 
             Bnew(i,k)=B(i,k);
         end
     end
end
 
csvwrite('hw3p4_x1_updated.csv',Bnew(:,1:end-1))

% Trainingdata=Bnew(1:377,:);
% Testdata=Bnew(377:end,:);
% [features] = SFS(Trainingdata,Testdata,10);

% %with K-fold
% K=10
% LO=round(SIZEBB(1)/K);
% for I=1:K
%     if K==1
%         Testdata=Bnew(1:LO,:);
%         Trainingdata=Bnew(LO:end,:);
%         [features,performance(I)] = SFS(Trainingdata,Testdata,10);
%     elseif K>1
%         Trainingdata=[Bnew(1:LO*(K-1),:); Bnew(LO*(K-1)+LO:end,:)];
%         Testdata=Bnew(LO*(K-1)+1:LO*(K-1)+(LO-1),:);
%         [features,performance(I)] = SFS(Trainingdata,Testdata,10);
%     end
% end

[labels]=hw3p4('hw3p4_x1_updated.csv')
