% this function try to make a model of normal chromosoms. for this purpose, the average value of Normals' CpG in a Location has been calculated.
% chromosome's model has 3 column, 1=Region's number,2=Location, 3= average Normal CpGs value in a location.
function Model(NumOfNormalSamples,NumOfCancerSamples,NumOfChromosoms,NumOfTotalSample)


%---------------Cancer----------------------
for chromosome=1:NumOfChromosoms
    for sampleNumber=1:NumOfCancerSamples
        A = importdata(strcat('Cancer/',num2str(sampleNumber),'/',num2str(chromosome),'.txt'));
        L=A.data(:,1);
        
        clear A
        if sampleNumber==1
            model1(:,1)=L;
            model1(:,2)=1;
        else
            [~,ia,~] = intersect(model1(:,1)',L');
            model1(ia(:),2)=model1(ia(:),2)+1;% faravanee hame sample ha dar in location
            clear ia
            
            [C,~] = setdiff(L,model1(:,1));
            [r,~]=size(model1);
            [r1,~]=size(C);
            model1(r+1:r+r1,1)=C(:,1);
            model1(r+1:r+r1,2)=1;
            clear ia C r r1
            
        end
        clear L
    end
    model1(:,3)=0;%majmoo normal ha dar in location
    model1(:,4)=0;%tedad normal haee ke shamel e in location hastand
    %-------------------Normal----------
    
    for sampleNumber=1:NumOfNormalSamples
        A = importdata(strcat('Normal/',num2str(sampleNumber),'/',num2str(chromosome),'.txt'));
        L=A.data(:,1);
        CpG=A.data(:,2);
        
        
        clear A
        
        [~,ia,ib] = intersect(model1(:,1)',L');
        model1(ia(:),2)=model1(ia(:),2)+1;
        model1(ia(:),3)=model1(ia(:),3)+CpG(ib(:),1);
        model1(ia(:),4)=model1(ia(:),4)+1;
        clear ia ib
        
        [C,ia] = setdiff(L,model1(:,1));
        [r,~]=size(model1);
        [r1,~]=size(C);
        model1(r+1:r+r1,1)=C(:,1);
        model1(r+1:r+r1,2)=1;
        model1(r+1:r+r1,3)=CpG(ia(:));
        model1(r+1:r+r1,4)=1;
        clear ia C r r1
        
        clear L CpG
    end
    model1(:,2)=model1(:,2)/NumOfTotalSample;%mohasebe darsad faravanee
    model1(:,3)=model1(:,3)./model1(:,4);
    model1(:,4)=[];
    [r,~]=find(model1(:,2)>=.75);
    model(:,:)=model1(r(:),:);
    model = sortrows(model);
    clear r
    
    [r,~]=size(model);
    Region=1;
    bound=100; % ~= Mean*2
    for i=1:r
        if i-1>0 && (model(i,1)-model(i-1,1))>=bound
            Region=Region+1;
        end
        model(i,2)=Region;
        
    end
    %---------Omit regions with #CPG<10
    model11=[];
    reg=1;
    for i=1:Region
        [r,~]=find(model(:,2)==i);
        [r1,~]=size(r);
        if (r1>=10)
            m2=model(r(:),:);
            m2(:,2)=reg;
            reg=reg+1;
            model11=cat(1,model11,m2);
            clear m2
        end
        clear r c r1 c1
    end
    dlmwrite(strcat('models/model',num2str(chromosome),'.txt'), model11,'precision','%.8f');
    clear model model1 model11
    
end

