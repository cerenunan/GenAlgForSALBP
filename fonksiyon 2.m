function PMU(sol)
global pt
global numberofpredecessors
counter=0;
for i=1:21
    for j=1:i
        if pt(sol(i),sol(j))==1
            counter=counter+1;
        end
    end
   if counter~=numberofpredecessors(sol(i))
       fprintf('HATA %d',i)
   end
   counter=0;
end
end