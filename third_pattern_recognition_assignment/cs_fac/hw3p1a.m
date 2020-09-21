clear all
clc
close all
images=dir('*.jpg');
J=images(1,:);
J1=imread(J.name);
m1=im2double(J1);
S=images(2,:);
S1=imread(S.name);
m2=im2double(S1);
Add=m1+m2;
SIZE1=size(images)
SIZE2=size(J1)
for i=3:length(images)
    W=images(i,:);
    W1=imread(W.name);
    X=im2double(W1);
    Add=Add+X;
end
Average=Add/length(images);
Convert=im2uint8(Average);
imshow(Convert)
title('Average Face','FontSize',35)
%%%%%%%% Using Snapshot
concatenate=zeros(SIZE2(1)*SIZE2(2),SIZE1(1));
for L=1:length(images)
    O=images(L,:);
    O1=imread(O.name);
    Zeta=im2double(O1);
    concatenate(:,L)=reshape(Zeta,SIZE2(1)*SIZE2(2),1);
end
    cm=mean(concatenate,2);
    
    
    
    
    
    
    
    
    T=concatenate-cm;
    TtT=T'*T
    [u1,d1]=eig(TtT)
    eigenvalues=diag(d1);
    %Sorted the eigenvalues from the line of code above from largest to
    %smallest
    [descendingorder, index]=sort(eigenvalues,'descend');
    % I arranged the eigenvectors from largest to smallest, starting with the
    % eigenvector that corresponds to the largest eigenvalue and etc.
    [descendingordervectors]=u1(:,index);
    eigS=T*descendingordervectors;
    
    
   
    
    
    %eigenfacesteps first convert double back to uint8
    eigS=im2uint8(eigS);
    
    for F=1:6
    eigenface1=reshape(eigS(:,F),SIZE2(1),SIZE2(2));
    figure(F)
    
    imshow(eigenface1)
    title('Eigen Face','FontSize',20)
    end
    
    %PCA components of average face
    figure(7)
    PCAnumber=6;
    
    for SP=1:PCAnumber
        for K=1:PCAnumber
        if SP==1
            sgtitle('PCA Comparison')
            subplot(PCAnumber,PCAnumber,K)
            
            scatter(concatenate'*im2double(eigS(:,SP)),concatenate'*im2double(eigS(:,K)),10,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5)
          
            xlabel(("PCA " + SP))
            ylabel(("PCA " + K))
        else
            subplot(PCAnumber,PCAnumber,PCAnumber*(SP-1)+K)
            scatter(concatenate'*im2double(eigS(:,SP)),concatenate'*im2double(eigS(:,K)),10,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1)
            xlabel(("PCA " + SP))
            ylabel(("PCA " + K))
        end
        end
    end
    
    
    
