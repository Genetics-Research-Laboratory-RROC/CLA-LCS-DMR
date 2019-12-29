function DMRs=meansOfSamplesInDMRs(DMRs,chromosome,NumOfCancerSamples,NumOfNormalSamples)
%{
clc
clear all
choromosome=18;
D1 = dlmread(strcat('DMRs/DMRs',num2str(choromosome),'.txt'));
[r1,~,~]=find(D1(:,4)>=10);
DMRs=D1(r1(:),:);
%}
[r,c]=size(DMRs);
for sampleNumber=1:NumOfCancerSamples
    %for sampleNumber=39:70
    c=c+1;
    A = importdata(strcat('Cancer/',num2str(sampleNumber),'/',num2str(chromosome),'.txt'));
    Loctions=A.data(:,1);
    CpG=A.data(:,2);
    %      A = importdata(strcat('data/SRR18126',num2str(sampleNumber),'/SRR18126',num2str(sampleNumber),'_CPGInfo_Chr',num2str(choromosome),'.txt'));
    %      CpG=A.data(:,4);
    %      Loctions=A.data(:,2);
    
    
    for i=1:r
        [rr,~]=find(Loctions>=DMRs(i,2) & Loctions<=DMRs(i,3));
        if(rr~=0)
            X=CpG(rr,:);
            Mean=mean(X);
            
            
        else
            Mean=-1;
        end
        
        DMRs(i,c)=Mean;
    end
    clear A Loctions CpG rr
end

for sampleNumber=1:NumOfNormalSamples
    c=c+1;
    A = importdata(strcat('Normal/',num2str(sampleNumber),'/',num2str(chromosome),'.txt'));
    Loctions=A.data(:,1);
    CpG=A.data(:,2);
    
    %{
        for sampleNumber=71:76
    c=c+1;
       sampleNumber1=sampleNumber;
        switch sampleNumber
            case 73
               sampleNumber1=76;
            case 74
                sampleNumber1=78;
            case 75
                sampleNumber1=79;
            case 76
                sampleNumber1=80;
        end
        A = importdata(strcat('data/SRR18126',num2str(sampleNumber),'/SRR18126',num2str(sampleNumber1),'_CPGInfo_Chr',num2str(choromosome),'.txt'));
        CpG=A.data(:,4);
        Loctions=A.data(:,2);
     
    %}
    for i=1:r
        [rr,~]=find(Loctions>=DMRs(i,2) & Loctions<=DMRs(i,3));
        if(rr~=0)
            X=CpG(rr,:);
            Mean=mean(X);
        else
            Mean=-1;
        end
        DMRs(i,c)=Mean;
    end
    clear A Loctions CpG rr
end




