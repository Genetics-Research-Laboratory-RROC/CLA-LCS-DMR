% automata try to select two actions.one action is enlargening or
% shirinking from left side of centeral cell. another action is enlargening or
% shirinking from right side of centeral cell. the value of the alpha and
% beta determin the shirink or enlarge. if automata select the left side 
%and alphs is positive then centeral cell will be enlarge, otherwise it
%will be shirink. if automata select the right side 
%and beta is positive then centeral cell will be enlarge, otherwise it
%will be shirink. 
function NormalCell=RebuiltNormalCell(SizeOfCoreMatrix,NormalCell)
NormalCellOld=NormalCell;
for i=2:3:SizeOfCoreMatrix
    if NormalCell(i).Core==2
      probability=rand(1,1);
      y=probability*10;
      z=fix(y);
      probability=z/10;
      
 %----------------Left Side----------------
      if abs(NormalCell(i).SelectLeftNeighborProb)>=probability
          NormalCell(i).SelectLeftNeighbor=1;
         
          if NormalCell(i).Alpha>0
              if i>=2                                
                 %----------- using CpG ---------
                  [r1,~]=size(NormalCellOld(i-1).CpGs);
                  Left=NormalCell(i).Alpha*(1-NormalCell(i-1).Similarity(1,1));
                  SizeOfLeftNeighbor=r1-ceil(r1*Left);
                      [r1,~]=size(NormalCell(i-1).CpGs);
                  if SizeOfLeftNeighbor>0 
                      if SizeOfLeftNeighbor>r1
                          SizeOfLeftNeighbor=r1;
                      end
                      X1=NormalCell(i-1).CpGs(1:SizeOfLeftNeighbor,1);
                      A=NormalCell(i-1).CpGs(SizeOfLeftNeighbor+1:end,1);
                      XL1=NormalCell(i-1).Location(1:SizeOfLeftNeighbor,1);
                      AL=NormalCell(i-1).Location(SizeOfLeftNeighbor+1:end,1);

                      NormalCell(i-1).CpGs=[];
                      NormalCell(i-1).CpGs=X1;

                      NormalCell(i-1).Location=[];
                      NormalCell(i-1).Location=XL1;
                      %-------- New Core ---------
                      NormalCell(i).CpGs=[A;NormalCell(i).CpGs];
                      NormalCell(i).Location=[AL;NormalCell(i).Location];
                  end
              end
          else %NormalCell(i).Alpha<0
              [r1,~]=size(NormalCellOld(i).CpGs);
              Alpha=NormalCell(i).Alpha*-1;
              SizeOfLeftNeighbor=ceil(r1*Alpha);
              if SizeOfLeftNeighbor>0
                  
                  X1=NormalCell(i).CpGs(1:SizeOfLeftNeighbor,1);
                  A=NormalCell(i).CpGs(SizeOfLeftNeighbor+1:end,1);

                  XL1=NormalCell(i).Location(1:SizeOfLeftNeighbor,1);
                  AL=NormalCell(i).Location(SizeOfLeftNeighbor+1:end,1);

                  NormalCell(i-1).CpGs=[NormalCell(i-1).CpGs;X1];
                  NormalCell(i-1).Location=[NormalCell(i-1).Location;XL1];
                  %--------- New Core --------------
                  NormalCell(i).CpGs=[];
                  NormalCell(i).CpGs=A;

                  NormalCell(i).Location=[];
                  NormalCell(i).Location=AL;
              end
          end
          
      %end
      else
  %------------------Right Side-------------------
      probability=rand(1,1);
      y=probability*10;
      z=fix(y);
      probability=z/10;
      
      if abs(NormalCell(i).SelectRightNeighborProb>=probability)
          NormalCell(i).SelectRightNeighbor=1;
          if NormalCell(i).Beta>0
              if i~=SizeOfCoreMatrix
                  %--------Use CpG------------------
                  
                  [r2,~]=size(NormalCellOld(i+1).CpGs);
                  Right=NormalCell(i).Beta*(1-NormalCell(i+1).Similarity(1,1));
                  SizeOfRightNeighbor=ceil(Right*r2);
                  if SizeOfRightNeighbor>r2
                      SizeOfRightNeighbor=r2;
                  end
                 
                  if SizeOfRightNeighbor>0
                      C=NormalCell(i+1).CpGs(1:SizeOfRightNeighbor,1);
                      Y1=NormalCell(i+1).CpGs(SizeOfRightNeighbor+1:end,1);

                      CL=NormalCell(i+1).Location(1:SizeOfRightNeighbor,1);
                      YL1=NormalCell(i+1).Location(SizeOfRightNeighbor+1:end,1);

                      NormalCell(i+1).CpGs=[];
                      NormalCell(i+1).CpGs=Y1;

                      NormalCell(i+1).Location=[];
                      NormalCell(i+1).Location=YL1;
                      %---------- New Core -------------

                      NormalCell(i).CpGs=[NormalCell(i).CpGs;C];
                      NormalCell(i).Location=[NormalCell(i).Location;CL];
                  end
              end
          else % Beta<0
             
              [r2,~]=size(NormalCellOld(i).CpGs);
              Beta=NormalCell(i).Beta*-1;
              SizeOfRightNeighbor=ceil(r2*Beta);
              
              [r3,~]=size(NormalCell(i).CpGs);
              
              SizeOfRightNeighbor=r3-SizeOfRightNeighbor;
              if SizeOfRightNeighbor>0
                  A=NormalCell(i).CpGs(1:SizeOfRightNeighbor,1);
                  Y1=NormalCell(i).CpGs(SizeOfRightNeighbor+1:r3,1);

                  AL=NormalCell(i).Location(1:SizeOfRightNeighbor,1);
                  YL1=NormalCell(i).Location(SizeOfRightNeighbor+1:r3,1);

                  NormalCell(i+1).CpGs=[Y1;NormalCell(i+1).CpGs];
                  NormalCell(i+1).Location=[YL1;NormalCell(i+1).Location];
                  %------------ New Core ------------
                  NormalCell(i).CpGs=[];
                  NormalCell(i).CpGs=A;

                  NormalCell(i).Location=[];
                  NormalCell(i).Location=AL;
              end

          end

      end
      end
    end
end
