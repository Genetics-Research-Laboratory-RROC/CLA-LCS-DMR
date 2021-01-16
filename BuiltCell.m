%the initial Normal cells are build here. the model divided into the cells.
% The number of the regions in each model is equal with the number of CpG clusters 
% which determines the length of the CLA array using the following heuristics:
% If the number of CpGs in a CpG cluster is less than 9, the maximum number of CpGs in the corresponding cell will be 1.
% If the number of CpGs in a CpG cluster is between 10 and 99, the maximum number of CpGs in the corresponding cell will be 5.
% If the number of CpGs in a CpG cluster is between 100 and 999, the maximum number of CpGs in the corresponding cell will be 20
% If the number of CpGs in a CpG cluster is between 1000 and 9999, the maximum number of CpGs in the corresponding cell will be 30
% If the number of CpGs in a CpG cluster is higher than 10000, the maximum number of CpGs in the corresponding cell will be 50
%each Cell has 13 features: CpGs,Location,RegionsNumber,Similarity,DMRs,State,Core,SelectLeftNeighborProb,SelectLeftNeighbor,Alpha,
%SelectRightNeighborProb,SelectRightNeighbor,Beta  
function [Cell,NextStart]=BuiltCell(ModelCpG,ModelLoc,ModelRegionNumber,LenghtOfRegion,RegionsNumber,Start,MaxBoundry)
if LenghtOfRegion<=9
    NumberOfCpGs=1;
elseif LenghtOfRegion>=10 && LenghtOfRegion<=99
    NumberOfCpGs=5;
elseif LenghtOfRegion>=100 && LenghtOfRegion<=999
    NumberOfCpGs=20;
elseif LenghtOfRegion>=1000 && LenghtOfRegion<=9999
    NumberOfCpGs=30;
else
    NumberOfCpGs=50;
end
 Core=0;%Core=0 means initial value, core=-1 -> deactive cell, core=1 -> neighbor
        %, core=2 -> run automata for this cell
    DMRs=0;%Number Of differentioal methylation region
    State=0;%Hyper , Hypo
    Similarity=[0 0];%[OldSim NewSim]
    
    SelectLeftNeighborProb=1;
    SelectLeftNeighbor=0;
    
    SelectRightNeighborProb=1;
    SelectRightNeighbor=0;
    
    Alpha=1;%Alpha used for Left Side if Alpha>0 then Core will be larger else smaller 
    Beta=1;% same as Alpha but use for right side
    
    End=Start;
    while MaxBoundry >=End+1 && ModelRegionNumber(End)==ModelRegionNumber(End+1)
        End=End+1;
    end
    [r1,~]=size(ModelCpG);
    if Start<=r1 && End<=r1

        CpGs=ModelCpG(Start:End);
        Location=ModelLoc(Start:End);
        [r,~]=size(CpGs);
        if r<NumberOfCpGs
          Cell=struct('CpGs',CpGs,'Location',Location,'RegionsNumber',RegionsNumber,'Similarity',Similarity,'DMRs',DMRs,'State',State,'Core',Core,'SelectLeftNeighborProb',SelectLeftNeighborProb,'SelectLeftNeighbor',SelectLeftNeighbor,'Alpha',Alpha,'SelectRightNeighborProb',SelectRightNeighborProb,'SelectRightNeighbor',SelectRightNeighbor,'Beta',Beta);  
        else
            SubCell=ceil(r/NumberOfCpGs);
            S=1;
            E=NumberOfCpGs;
            for i=1:SubCell
                [r,~]=size(CpGs(S:end));
                if i==SubCell-1 && r<2*NumberOfCpGs
                    SubCpGs=CpGs(S:end);
                    SubLocation=Location(S:end);
                    Cell(i)=struct('CpGs',SubCpGs,'Location',SubLocation,'RegionsNumber',RegionsNumber,'Similarity',Similarity,'DMRs',DMRs,'State',State,'Core',Core,'SelectLeftNeighborProb',SelectLeftNeighborProb,'SelectLeftNeighbor',SelectLeftNeighbor,'Alpha',Alpha,'SelectRightNeighborProb',SelectRightNeighborProb,'SelectRightNeighbor',SelectRightNeighbor,'Beta',Beta);  
                    break
                else
                    SubCpGs=CpGs(S:E);
                    SubLocation=Location(S:E);
                    Cell(i)=struct('CpGs',SubCpGs,'Location',SubLocation,'RegionsNumber',RegionsNumber,'Similarity',Similarity,'DMRs',DMRs,'State',State,'Core',Core,'SelectLeftNeighborProb',SelectLeftNeighborProb,'SelectLeftNeighbor',SelectLeftNeighbor,'Alpha',Alpha,'SelectRightNeighborProb',SelectRightNeighborProb,'SelectRightNeighbor',SelectRightNeighbor,'Beta',Beta);  
                    S=E+1;
                    E=E+NumberOfCpGs;
                end

            end

        end
        NextStart=End+1;
         else
        Cell=[];
        NextStart=End;
    end
   
end