% the cancer's cell will be reconstruct considering the new model cells
function NewCancerCoreMatrix=ReBuiltCancerlCell(NumberOfCore,CancerCoreMatrix,CoreMatix)
j=1;
for i=1:NumberOfCore
    [r,~]=size(CoreMatix(j).Location);
    NewCancerCoreMatrix(j).CpGs=CancerCoreMatrix(i).CpGs(1:r);
    NewCancerCoreMatrix(j).Location=CancerCoreMatrix(i).Location(1:r);
    j=j+1;
    
    [r1,~]=size(CoreMatix(j).Location);
    NewCancerCoreMatrix(j).CpGs=CancerCoreMatrix(i).CpGs(r+1:r1+r);
    NewCancerCoreMatrix(j).Location=CancerCoreMatrix(i).Location(r+1:r1+r);   
    j=j+1;
    
    [r2,~]=size(CoreMatix(j).Location);
    NewCancerCoreMatrix(j).CpGs=CancerCoreMatrix(i).CpGs(r1+r+1:r2+r1+r);
    NewCancerCoreMatrix(j).Location=CancerCoreMatrix(i).Location(r1+r+1:r2+r1+r);
    j=j+1;
    
end
end