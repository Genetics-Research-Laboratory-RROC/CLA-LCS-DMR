%this function's porpuse is finding common locations between Cancer sample and
%normal model. the uncommon locations will be omitted from both normal model
%and cancer sample.
function [CpG,Loc,NewModel,lenght]=omitLocations(CancerCpGOld,CancerLocOld,model)
[~,ia,ib]=intersect(model(:,1),CancerLocOld);
Loc(:,1)=CancerLocOld(ib(:));
CpG(:,1)=CancerCpGOld(ib(:));
NewModel(:,:)=model(ia(:),:);
[MaxBoundry,~]=size(model);
u=unique(model(:,2));
[numReg,~]=size(u);
lenght=zeros(numReg,3);

Start=1;
End=1;
for i=1:numReg
    lenght(i,1)=model(Start,1);
    End=Start;
    NumberOfCpGInRegion=0;
    while MaxBoundry >=End+1 && model(End,2)==model(End+1,2)
        End=End+1;
        NumberOfCpGInRegion=NumberOfCpGInRegion+1;
    end
    lenght(i,2)=model(End,1);
    lenght(i,3)=lenght(i,2)-lenght(i,1);
    lenght(i,4)=NumberOfCpGInRegion+1;
    Start=End+1;   
end

