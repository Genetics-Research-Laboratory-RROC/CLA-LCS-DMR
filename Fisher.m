function [DMRs1]=Fisher(DMRs1,NumOfCancerSamples,NumOfNormalSamples)
[r,c]=size(DMRs1);
%TotalSamples=TotalSamples+1;%add 4 because DMRs has 4 extra data(choromosom,start,end,number of CpG)
Y=NumOfCancerSamples+NumOfNormalSamples+4;
X=NumOfCancerSamples+5;
Z=NumOfCancerSamples+4;
for i=1:r
    [~,cc]=find(DMRs1(i,5:Z)~=-1);
    MeanCancer=mean(DMRs1(i,cc(1,:)+4));
    VarCancer=var(DMRs1(i,cc(1,:)+4));
    
    [~,cn]=find(DMRs1(i,X:Y)~=-1);
    MeanNormal=mean(DMRs1(i,cn(1,:)+Z));
    VarNormal=var(DMRs1(i,cn(1,:)+Z));
    %--------------Fisher---------------
    Fisher=(((MeanCancer-MeanNormal))^2/(VarCancer+VarNormal));
    DMRs1(i,c+2)=Fisher;
    clear cc cn Fisher H
end

