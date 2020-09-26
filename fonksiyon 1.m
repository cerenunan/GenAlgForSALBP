function nonessential=nonesential(sol,i,j)
global pt
nonessential=1;
for x=i:j
    if pt(sol(x),sol(i))==1
        nonessential=0;
    end
end
end