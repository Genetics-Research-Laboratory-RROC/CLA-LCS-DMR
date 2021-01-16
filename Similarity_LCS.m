% the similarity between model cells and cancer cells will be calculated.
function CoreMatix=Similarity_LCS(CoreMatix,ControlCell,SizeOfCoreMatrix)
for i=2:3:SizeOfCoreMatrix 
  
    if CoreMatix(i).Core==2 
        [r,~]=size(CoreMatix(i-1).CpGs);
        [r1,~]=size(CoreMatix(i).CpGs);
        [r2,~]=size(CoreMatix(i+1).CpGs);
        
        if CoreMatix(i).SelectLeftNeighbor==1            
            if r>0
                [CoreMatix(i-1).Similarity(1,2), ~, ~] = LCS(CoreMatix(i-1).CpGs,ControlCell(i-1).CpGs);
            else
                CoreMatix(i-1).Similarity(1,2)=CoreMatix(i-1).Similarity(1,1);
                CoreMatix(i-1).State=-1;%Cell is empty
            end
            if r1>0
                [CoreMatix(i).Similarity(1,2), ~, ~]= LCS(CoreMatix(i).CpGs,ControlCell(i).CpGs);
            else
                CoreMatix(i).Similarity(1,2)=CoreMatix(i).Similarity(1,1);
                CoreMatix(i).State=-1;%Cell is empty
            end
        elseif CoreMatix(i).SelectRightNeighbor==1  
            if r2>0
                [CoreMatix(i+1).Similarity(1,2), ~, ~] = LCS(CoreMatix(i+1).CpGs,ControlCell(i+1).CpGs);
            else
                CoreMatix(i+1).Similarity(1,2)=CoreMatix(i+1).Similarity(1,1);
                CoreMatix(i+1).State=-1;%Cell is empty
            end
            if r1>0
            [CoreMatix(i).Similarity(1,2), ~, ~]= LCS(CoreMatix(i).CpGs,ControlCell(i).CpGs);
            else
                CoreMatix(i).Similarity(1,2)=CoreMatix(i).Similarity(1,1);
                CoreMatix(i).State=-1;%Cell is empty
            end
        end
    end
end