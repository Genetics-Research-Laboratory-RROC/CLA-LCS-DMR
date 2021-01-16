function [DM]=SortLocation(X,DM,c,i)
if i==1
    for i=1:c
        if X(i).DMRs~=0
            [r,~]=size(X(i).Location);
            for j=1:r
                DM(X(i).Location(j),1)=1;
            end
        end
    end
else
for i=1:c
    if X(i).DMRs~=0
        [r,~]=size(X(i).Location);
        for j=1:r
            DM(X(i).Location(j),1)= DM(X(i).Location(j),1)+1;
        end
    end
end

end
