% Final function find locations which consider DMR's location in most of
% the Samples
function Final(NumOfCancerSamples,NumOfChromosoms,NumOfNormalSamples)
% NumOfNormalSamples=6;
% NumOfCancerSamples=32;
% NumOfChromosoms=22;
% NumOfTotalSample=NumOfCancerSamples+NumOfNormalSamples;
%------------ load date--------
 it=.1;
    DMRs1=[];
   for chromosome=1:NumOfChromosoms
    for SampleNumber=1:NumOfCancerSamples
  % for SampleNumber=39:70
         str=strcat('ModelCells/ModelCells',num2str(chromosome),'_',num2str(SampleNumber),'.mat');
         x=load(str);
%  str=strcat('ModelCells/ModelCells',num2str(chromosome),'_',num2str(SampleNumber),'.mat');
%         x=load(str);
        if isempty(x.ModelCells(end).Location)
            x.ModelCells(end)=[];
        end
        [~,c]=size(x);
        if c==0
            x.Location(end)=0;
        end
         eval(['ch',num2str(SampleNumber) '= x.ModelCells']);
         clear x c
         
    end

    %--------------End------------------
    %--------------Sparse Matrix--------
   X=eval(['ch',num2str(1)]);
%X=eval(['ch',num2str(39)]);
    m=[X(end).Location(end)];
    clear X
    for SampleNumber=2:NumOfCancerSamples
    %for SampleNumber=40:70
        X=eval(['ch',num2str(SampleNumber)]);
        m(end+1)=X(end).Location(end);
        clear X
    end
     Max=max(m);   
  

    %--------------End-------------
    DM=sparse(Max,1);
%for i=39:70
    for i=1:NumOfCancerSamples
        XX=eval(['ch',num2str(i)]);
        [~,c]=size(XX);
        [DM]=SortLocation(XX,DM,c,i);
        clear XX eval(['ch',num2str(i)]);
    end

    j=1;

    [r,~]=find(DM(:,1)/NumOfCancerSamples>=it);
    sss='find'
    [rr,~]=size(r);
    flag=0;
    for i=1:rr

        DMRs_Region(i,1)=r(i) ;
        flag=1;

    end
    %-----------Detect Regions---------------
    if flag==1
        [r,~]=size(DMRs_Region);
        Region=1;

        bound=100; % ~= Mean*2
        for i=1:r
            if i-1>0 && (DMRs_Region(i,1)-DMRs_Region(i-1,1))>=bound
                Region=Region+1;
            end
            DMRs_Region(i,2)=Region;  
        end

        DMRs=zeros(Region,4);
        [r,~]=size(DMRs_Region);
        j=1;
        for i=1:Region
            count=0;

            DMRs(i,2)=DMRs_Region(j,1);
            while DMRs_Region(j,2)==i && j<r
                count=count+1;
                j=j+1;
            end
            DMRs(i,3)=DMRs_Region(j-1,1);
            DMRs(i,4)=count;
        end
        if DMRs(end,4)==0
           DMRs(end,4)=1;
        end
         DMRs(:,1)=chromosome;
        [r,~,~]=find(DMRs(:,4)>=10);
        D1=DMRs(r(:),:);
        D2=meansOfSamplesInDMRs(D1,chromosome,NumOfCancerSamples,NumOfNormalSamples);
        DMRs1=cat(1,DMRs1,D2);
       else
        DMRs=[];
        end
        clear D1 D2 r DMRs DMRs_Region rr cc DM c m Max 
   end
    [DMRs1]=Fisher(DMRs1,NumOfCancerSamples,NumOfNormalSamples);
    XXXX=sort(DMRs1(:,end),'descend');
    [r1,c]=size(DMRs1);
    T=round(r1*15/100);
    T=XXXX(T);
    [r,c,~]=find(DMRs1(:,end)>=T);
    YY=DMRs1(r(:),:);
    AllDMRs=YY(:,1:3);
     dlmwrite(strcat('DMRs/FinalDMRs.txt'), AllDMRs,'precision','%.1f'); 