% if cell's similarity is less than 20% this cells is a DMR and must be
% deative.
function [CoreMatix,NumberOfCore]=DetectActiveCore(CoreMatix,SizeOfCoreMatrix)
NumberOfCore=0;
for i=2:3:SizeOfCoreMatrix 
    if CoreMatix(i).Core==2 
        if CoreMatix(i).Similarity(1,2)<.2 && CoreMatix(i).State~=-1
          CoreMatix(i).Core=4;% Finish
          if CoreMatix(i-1).Similarity(1,2)<.2
              CoreMatix(i-1).Core=4;
          end
          if CoreMatix(i+1).Similarity(1,2)<.2
              CoreMatix(i+1).Core=4;
          end
        else
            NumberOfCore=NumberOfCore+1;
        end
    end
end
        