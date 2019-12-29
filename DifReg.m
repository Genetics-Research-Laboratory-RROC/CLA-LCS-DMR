%preparing the output DMRs. if a cell similarity is less than 20% and it is
%deactivate then this cell is a DMR and it will be consider as an output.
function [ModelCell]=DifReg(NumberOfCell,ModelCell)
DMRs=0;
for i=1:NumberOfCell
     if (ModelCell(i).Similarity(1,1)<=0.2 && ModelCell(i).Core~=-1)||(ModelCell(i).Similarity(1,2)<=0.2 && ModelCell(i).Core==4)
        if i==1
            ModelCell(i).DMRs=DMRs;
            DMRs=DMRs+1;
        elseif ModelCell(i-1).DMRs~=0 && ModelCell(i).RegionsNumber==ModelCell(i-1).RegionsNumber 
            ModelCell(i).DMRs=ModelCell(i-1).DMRs;
        elseif ModelCell(i-1).DMRs~=0 && ModelCell(i).RegionsNumber~=ModelCell(i-1).RegionsNumber 
            DMRs=DMRs+1;
            ModelCell(i).DMRs=DMRs;
        elseif ModelCell(i-1).DMRs==0
            DMRs=DMRs+1;
            ModelCell(i).DMRs=DMRs;
            
        end
     end
end