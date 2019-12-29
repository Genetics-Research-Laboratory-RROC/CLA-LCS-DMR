% dividing normal cells and cancer cells into three  equal part.
function [CoreMatix]=DividCore(NumberOfCore,ModelCell,Index)
j=1;

for i=1:NumberOfCore
   [SizeOfCore,~]=size(ModelCell(Index(i)).Location);
   tmp=ModelCell(Index(i));
   x=SizeOfCore/3;
   
   tmp1=tmp;
   tmp1.CpGs=tmp.CpGs(1:ceil(x));
   tmp1.Location=tmp.Location(1:ceil(x));
   tmp1.Core=1;
   
   tmp2=tmp;
   tmp2.CpGs=tmp.CpGs(ceil(x)+1:2*ceil(x));
   tmp2.Location=tmp.Location(ceil(x)+1:2*ceil(x));
   tmp2.Core=2;
   
   y=SizeOfCore-ceil(x)*2;
   tmp3=tmp;
   tmp3.CpGs=tmp.CpGs(2*ceil(x)+1:2*ceil(x)+y);
   tmp3.Location=tmp.Location(2*ceil(x)+1:2*ceil(x)+y);
   tmp3.Core=1;
   
   CoreMatix(j)=tmp1;
   j=j+1;
   CoreMatix(j)=tmp2;
   j=j+1;
   CoreMatix(j)=tmp3;
   j=j+1;
    
end