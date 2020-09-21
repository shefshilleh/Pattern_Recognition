function [features,bestfeaturesperformance] = SFS(trainingdatawlabels,testdatawlabels,numofclasses)

SIZE1=size(trainingdatawlabels);
SIZE2=size(testdatawlabels);
tensor=zeros(1,SIZE1(2),numofclasses);


features=[];

for i=1:SIZE1(1)
    index=trainingdatawlabels(i,end);
    tensor(:,:,index)=[tensor(:,1:end-1,index)+trainingdatawlabels(i,1:end-1) tensor(1,end,index)+1];
end

avgclassdata=zeros(1,SIZE1(2)-1,numofclasses);
for b=1:numofclasses
    avgclassdata(:,:,b)=tensor(:,1:end-1,b)/tensor(1,end,b);
end


for j=1:SIZE1(2)-1
    counter=0;
    for h=1:SIZE2(1)
        tester=vecnorm(avgclassdata(:,j,:)-testdatawlabels(h,j),2,2);
        result=find(tester==min(tester));
            if result==testdatawlabels(h,end)
                counter=counter+1;
            end
    end
        successrate(j)=counter/SIZE2(1);
end
        bestfirstfeature=max(successrate);
        featurenumber1=find(successrate==bestfirstfeature);
        featurenumber1=featurenumber1(randperm(length(featurenumber1),1));
        features=[features featurenumber1];
        
augment=testdatawlabels(:,featurenumber1);        
augmentavgclassdata=avgclassdata(:,featurenumber1,:)

for u=2:10
    
    for j=1:SIZE1(2)-1
        if ismember(j, features)
            successratenew(j)=0;
        else
            counter=0;
            augmentupdate=[augment testdatawlabels(:,j)];
            augmentavgclassdataupdate=[augmentavgclassdata avgclassdata(:,j,:)];
            for h=1:SIZE2(1)
                tester=vecnorm((augmentavgclassdataupdate-augmentupdate(h,:)),2,2);
                result=find(tester==min(tester));
                    if result==testdatawlabels(h,end)
                        counter=counter+1;
                    end
            end
            
        successratenew(j)=counter/SIZE2(1);
        end
    end
bestfeaturesperformance=max(successratenew);
featurenumberj=find(successratenew==bestfeaturesperformance);
%There is a weakness here, once I get to a certain point, the addition of
%some features produce the same classification rate somehow, so for the
%time being I am going to augment a random one from that list!
random=featurenumberj(randperm(length(featurenumberj),1));
augment=[augment testdatawlabels(:,random)];
augmentavgclassdata=[augmentavgclassdata avgclassdata(:,random,:)];
features=[features random];

end

end





