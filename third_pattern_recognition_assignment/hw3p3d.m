clear all
close all
clc
P=imresize(imread('hw3p3_im.jpg'),0.5);
SIZEP=size(P);
B=im2double(reshape(P,SIZEP(1)*SIZEP(2),3,[]));
% imagesc(B);
% colorbar
SIZE=size(B);
%You can changle the sample value if you want to look into the SSE

    
for K=1:10 %Randomizing the locations of the centroid in K locations
    
for SAMPLE=1:5
    centroids=(zeros(K,SIZE(2)));
    p=randperm(length(B),K);
for i=1:length(p)
    centroids(i,:)=B(p(i),:);
end


    % We know that if K is equal to one the centroid location is simply the
    % mean of the data set!
if K==1
        Bnew=zeros(SIZE(1),SIZE(2))
        centroidnew=mean(B);
        for J=1:SIZE(1)
            Bnew(J,:)=centroidnew;
        end
        P2=reshape(im2uint8(Bnew),SIZEP(1),SIZEP(2),3);
        H(SAMPLE)=immse(P2,P);

    % For K greater than one we actually have to implement the algorithm to
    % get the code book, first we assign an empty log that indexes the
    % amount of points that belong to each cantroid
    elseif K>1
        Bnew=zeros(SIZE(1),SIZE(2));
        indexlog=[];
        i=0;
    % Keep running the loop until the amount of points in each cluster
    % remain constant
     while true
        centroidnew=[zeros(K,SIZE(2)) zeros(K,1)];
        i=i+1;
        for zeta=1:SIZE(1)
            alpha=vecnorm(centroids-B(zeta,:),2,2);
            tau=min(alpha);
            result=find(alpha==tau);
            centroidnew(result,1:end-1)=centroidnew(result,1:end-1)+B(zeta,:);
            centroidnew(result,end)=centroidnew(result,end)+1;
        end
     indexlog(:,:,i)=centroidnew(:,end);
     if (i>1) & indexlog(:,:,i)==indexlog(:,:,i-1);
        for W=1:K
            centroids(W,:)=centroidnew(W,1:end-1)./(centroidnew(W,end));
        end
        for Q=1:SIZE(1)
            alpha=vecnorm(centroids-B(Q,:),2,2);
            tau=min(alpha);
            result=find(alpha==tau);
            Bnew(Q,:)=centroids(result,:);
        end
        P2=reshape(im2uint8(Bnew),SIZEP(1),SIZEP(2),3);
        H(SAMPLE)=immse(P2,P);
        break
     end
        for W=1:K
            centroids(W,:)=centroidnew(W,1:end-1)./(centroidnew(W,end));
        end
     end
end
end
    SSE(K)=min(H);
end
ax = gca;
ax.FontSize = 15;
figure
plot(SSE,1:K)
title('SSE vs Codebook Length')
xlabel('Codebook Length')
ylabel('SSE')
ax = gca;
ax.FontSize = 15;