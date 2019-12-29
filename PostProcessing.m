% recheack the model cells to find the DMRs
function [ModelCells]=PostProcessing(CoreMatix,SizeOfCoreMatrix,Index,ModelCell)

for i=1:SizeOfCoreMatrix
    if CoreMatix(i).Core~=4 && CoreMatix(i).State~=-1 && CoreMatix(i).Similarity(1,2)<.3
        CoreMatix(i).Core=4;
    end
end
[~,c]=size(Index);
j=1;
Start1=1;
Start2=1;

for i=1:c  
    End2=Index(i)-1;
    End1=Start1+(End2-Start2);
    ModelCells(1,Start1:End1)=ModelCell(1,Start2:End2);
    ModelCells(1,End1+1)=CoreMatix(j);
    j=j+1;
    ModelCells(1,End1+2)=CoreMatix(j);
    j=j+1;
    ModelCells(1,End1+3)=CoreMatix(j);
    j=j+1;
    Start2=End2+2;
    Start1=End1+4;
end

[~,End2]=size(ModelCell);

Start2=Index(end)+1;

[~,Start1]=size(ModelCells);
Start1=Start1+1;
End1=Start1+(End2-Start2);

ModelCells(1,Start1:End1)=ModelCell(1,Start2:End2);

