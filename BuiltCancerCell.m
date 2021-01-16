% the initial cancer cells are build here. this cells' locations are the
% same as models cells. Cells have 2 column: CpGs and Locations.
function [Cell,NextStart]=BuiltCancerCell(CancerCpG,CancerLoc,Start,EndOfRegion,StartOfRegion)
End=Start;
[r,~]=size(CancerLoc);
if End<=r
    while(EndOfRegion>=CancerLoc(End,1))
        End=End+1;
        if End>=r
            break;
        end
    end
end
if Start<=r
    while StartOfRegion>CancerLoc(Start,1)
          Start=Start+1;
        if Start>=r
            break;
        end
    end
end
if Start==End
   Location=CancerLoc(Start-1,1);
   CpGs=CancerCpG(Start-1,1);
else
    Location=CancerLoc(Start:End-1,1);
    CpGs=CancerCpG(Start:End-1,1);
end
Cell=struct('CpGs',CpGs,'Location',Location);
NextStart=End;
end