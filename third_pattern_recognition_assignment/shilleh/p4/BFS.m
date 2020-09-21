function [features] = BFS(trainingdatawlabels,testdatawlabels,numofclasses)

SIZE1=size(trainingdatawlabels)
tensor=zeros(1,SIZE1(2),numofclasses)
features=[]

for i=1:SIZE1(1)
    index=trainingdatawlabels(i,end)
    tensor(:,:,index)=[tensor(:,1:end-1,index)+trainingdatawlabels(i,1:end-1) tensor(1,end,index)+1];
end

avgclassdata=zeros(1,SIZE1(2)-1,numofclasses);
for b=1:numofclasses
    avgclassdata(:,:,b)=tensor(:,1:end-1,b)/tensor(1,end,b);
end



while length(avgclassdata)>4
    SIZE2=size(testdatawlabels)
    successrate=[]
for j=1:SIZE2(2)-1
    counter=0;
    for h=1:SIZE2(1)
        if j==1
            testdatawlabelsdeleted=testdatawlabels(h,2:end-1);
            avgclassupdate=avgclassdata(:,2:end,:);
            tester=vecnorm((avgclassupdate-testdatawlabelsdeleted),2,2);
        else
            testdatawlabelsdeleted=[testdatawlabels(h,1:j-1) testdatawlabels(h,j+1:end-1)];
            avgclassupdate=[avgclassdata(1,1:j-1,:) avgclassdata(1,j+1:end,:)];
            tester=vecnorm((avgclassupdate-testdatawlabelsdeleted),2,2);
        end
            result=find(tester==min(tester));
            if result==testdatawlabels(h,end)
                counter=counter+1;
            end
    end
            successrate(j)=counter/SIZE2(1);
end
            worstfeature=max(successrate);
            featurenumber1=find(successrate==worstfeature);
            featurenumber1=featurenumber1(randperm(length(featurenumber1),1));
            avgclassdata(:,featurenumber1,:)=[];
            testdatawlabels(:,featurenumber1)=[];
            features=[features featurenumber1];
            
end

end
