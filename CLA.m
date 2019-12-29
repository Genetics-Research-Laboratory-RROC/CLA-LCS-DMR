% automata try to evaluate its actions (the actions that selected in the
% RebuiltNormalCell function). if the cells similarity is improved, the
% actions recived reward otherwise they recive penalty
function [CoreMatix]=CLA(CoreMatix,SizeOfCoreMatrix,CoreMatixOld)
RewardProb=0.1;
RewardAlpha=0.05;
PenaltyProb=0.1; 
PenaltyAlpha=0.1;
for i=2:3:SizeOfCoreMatrix
    if CoreMatix(i).Core==2
        CoreDifference=CoreMatix(i).Similarity(1,2)-CoreMatix(i).Similarity(1,1);
        if CoreDifference<=0           
                if CoreMatix(i).SelectLeftNeighbor==1  
                    CoreMatix(i).SelectLeftNeighborProb=CoreMatix(i).SelectLeftNeighborProb+RewardProb;
                    if CoreMatix(i).SelectLeftNeighborProb+RewardProb>1
                        CoreMatix(i).SelectLeftNeighborProb=1;
                    end
                    CoreMatix(i).Alpha=CoreMatix(i).Alpha+RewardAlpha;
                    CoreMatix(i).SelectLeftNeighbor=0;
                    CoreMatix(i-1).Similarity(1,1)=CoreMatix(i-1).Similarity(1,2);
                    CoreMatix(i).Similarity(1,1)=CoreMatix(i).Similarity(1,2);

                else
                    if  CoreMatix(i).SelectRightNeighbor==1
                        CoreMatix(i).SelectRightNeighborProb=CoreMatix(i).SelectRightNeighborProb+RewardProb;
                        if CoreMatix(i).SelectRightNeighborProb>1
                            CoreMatix(i).SelectRightNeighborProb=1;
                        end
                        CoreMatix(i).Beta=CoreMatix(i).Beta+RewardAlpha;
                        CoreMatix(i).SelectRightNeighbor=0;

                        CoreMatix(i+1).Similarity(1,1)=CoreMatix(i+1).Similarity(1,2);
                        CoreMatix(i).Similarity(1,1)=CoreMatix(i).Similarity(1,2);
                    end
                end 
        else
            
            if CoreMatix(i).SelectLeftNeighbor==1
                
                CoreMatixOld(i).SelectLeftNeighborProb=CoreMatixOld(i).SelectLeftNeighborProb-PenaltyProb;
                CoreMatixOld(i).Alpha=CoreMatixOld(i).Alpha-PenaltyAlpha;
                if CoreMatixOld(i).SelectLeftNeighborProb<=-1
                    CoreMatixOld(i).SelectLeftNeighborProb=-1;                  
                end
                if  CoreMatixOld(i).SelectLeftNeighborProb<=0.3 
                        CoreMatixOld(i).SelectLeftNeighborProb=0.5;
                end
                
                CoreMatixOld(i).SelectLeftNeighbor=0;
                
                CoreMatix(i)=CoreMatixOld(i);
                CoreMatix(i-1)=CoreMatixOld(i-1);
            else
                if  CoreMatix(i).SelectRightNeighbor==1
                    if CoreMatixOld(i).SelectRightNeighborProb<=-1
                        CoreMatixOld(i).SelectRightNeighborProb=-1;
                    else
                        if CoreMatixOld(i).SelectRightNeighborProb<=0.3
                            CoreMatixOld(i).SelectRightNeighborProb=0.5;
                        end
                    end
                    CoreMatixOld(i).Beta=CoreMatixOld(i).Beta-PenaltyAlpha;
                    CoreMatixOld(i).SelectRightNeighbor=0;
                    CoreMatix(i)=CoreMatixOld(i);
                    CoreMatix(i+1)=CoreMatixOld(i+1);
                end
            end
            
        end
        
    end
end