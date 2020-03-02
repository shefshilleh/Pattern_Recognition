clear all
clc
close all 
images=dir('*.jpg');
HDspace=zeros(40,40);
for i=1:length(images)
    for j=1:length(images)
    images=dir('*.jpg');
    firstimage=imresize(rgb2gray((imread(images(i).name))),[64 64]);
    secondimage=imresize(rgb2gray((imread(images(j).name))),[64 64]);
    difference=firstimage-secondimage;
    differencepw2=difference.^2;
    pixeladdition=sqrt(sum(differencepw2(:)));
    HDspace(i,j)=pixeladdition;
%     images=images(i,:);
%     A=imread(images.name);
%     BW1=imresize(BW, [64 64]);
    end
end
figure(1)
imagesc(HDspace)
colorbar

%beginning low dimensional part
clear all
clc
images=dir('*.jpg');
AR=zeros();
maximum=zeros();
difference=zeros(1,length(images));
ratio=zeros(1,length(images));
ratio2=zeros(1,length(images));
for i=1:length(images)
    images=dir('*.jpg');
    images=images(i,:);
    A=imread(images.name);
    G=rgb2gray(A);
    BW = imbinarize(G);
    BW1=imcomplement(BW);
    BW2 = imfill(BW1,'holes');
    BW11=imresize(BW1, [128 128]);
    BW22=imresize(BW2, [128 128]);
    CBW=imcomplement(BW);
    AX=regionprops(CBW,'MajorAxisLength','MinorAxisLength');
    for k=1:length(AX);
        maxmajor(k)=AX(k).MajorAxisLength;
        maxminor(k)=AX(k).MinorAxisLength;
    end
    MA=max(maxmajor);
    MI=max(maxminor);
    AR(i)=MA/MI;
    difference(i)=sum(BW22(:))-sum(BW11(:));
    %the difference algorithm seperates the brackets away from the washers and nuts by closing the
    %hole in the image and taking the binary difference
    BW2=imresize(BW, [64 64]);
    J=imcrop(BW2,[30 30 4 4]);
    numberOfWhitePixels = sum(J(:));
    numberOfBlackPixels = numel(BW) - numberOfWhitePixels;
    ratio(i) = numberOfBlackPixels/numberOfWhitePixels;
    %ratio seperates washers and nuts from the rest 
    halfpic(CBW);
    [bp1,bp2]=halfpic(CBW);
    ratio2(i)=bp1/bp2;
    %ratio2 implements a function taken from an online source and compares
    %the left half and right half of the images, the idea is that washers
    %are more symmetric than nuts on average due to the fact that the
    %washers are circular and nuts tend to be hexagonal
end

combinedfeaturematrix=[AR', difference', ratio', ratio2'];
LDspace=zeros(40,40);
for i=1:40
    for j=1:40
        newdifference=combinedfeaturematrix(i,:)-combinedfeaturematrix(j,:)
        newdifferencepw2=newdifference.^2;
        featureaddition=sqrt(sum(newdifferencepw2(:)));
        LDspace(i,j)=featureaddition;
    end
end
    
figure(2)
imagesc(LDspace)
colorbar
