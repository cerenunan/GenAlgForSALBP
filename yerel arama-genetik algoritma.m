clc;
clear;
task=1:21;
global pt
global numberofpredecessors
tt=[4,3,9,5,9,4,8,7,5,1,3,1,5,3,5,3,13,5,2,3,7];%Ýþlerin süreleri
pt=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %1. iþin öncülleri
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %2. iþin öncülleri
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %3. iþin öncülleri
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %4. iþin öncülleri
    0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %5. iþin öncülleri
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %6. iþin öncülleri
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %7. iþin öncülleri
    0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %8. iþin öncülleri
    0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0;  %9. iþin öncülleri
    0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0;  %10. iþin öncülleri
    0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0;  %11. iþin öncülleri
    0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0;  %12. iþin öncülleri
    0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0;  %13. iþin öncülleri
    0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0;  %14. iþin öncülleri
    0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0;  %15. iþin öncülleri
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0;  %16. iþin öncülleri
    0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0;  %17. iþin öncülleri
    0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0;  %18. iþin öncülleri
    0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0;  %19. iþin öncülleri
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0;  %20. iþin öncülleri
    0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;];%21. iþin öncülleri
c=39;                                           %cycle time deðeri
maxite=1000;
ite=1;
pop=100;
c_rate=0.7;
%öncelik saysý miktarý
numberofpredecessors=zeros(1,21);
for m=1:21
    for n=1:21
        if pt(m,n)==1
            numberofpredecessors(m)=numberofpredecessors(m)+1;
        end
    end
end
%Ýþlem süresine göre öncelik sýrasýna sokma
depo=sort(tt,'descend');
pm=[]; 
d=task;
for i=1:21
        for j=1:length(d)
            if depo(i)==tt(d(j))
                pm(i)=d(j);
                d(j)=[];
                break
            end
        end
end
%Baþlangýç için istasyon odaklý atama yapm
k=tt(1);% toplam iþlem süresi
sk=[1];%Seçili Kromozon 
for i=1:21 % sadece 1. iþlemi öncülü yok yani sistem her zaman birinci iþle baþlar bu yüzden onu öncelik listesinden çýkarýyoruz
    if pm(i)==1
        pm(i)=[];
        break
    end
end
counter1=0;
x=length(pm);
while length(sk)<21
    for q=1:x
        for w=1:length(sk)
            if pt(pm(q),sk(w))==1
                counter1=counter1+1;
            end               
        end
        if counter1==numberofpredecessors(pm(q))
            sk=[sk pm(q)];
            k=k+tt(pm(q));
            counter1=0;
            pm(q)=[];
            break;
        else
           counter1=0;
        end
    end
    x=length(pm);
end
PMU(sk)
%Ýstasyon atamalarý ve toplam istasyon sayýsý
is=1;%Ýstasyon sayýsý
ct=c-tt(1);% ilk baþta 1 iþle baþladýðýmýz için onun süresini çýkarýp döngüye baþlýyoruz
isno=[1];%Atanan Ýþlerin Ýstasyon Sýrasý
ks=[];
for i=2:length(sk) 
    if ct-tt(sk(i))<0
        is=is+1;
        isno=[isno is];
        ks=[ks ct];
        ct=c-tt(sk(i));
    else
        isno=[isno is];
        ct=ct-tt(sk(i));    
    end
end
ks=[ks ct];
g=[sk;isno];
x=1;
depo3=g;
while x==1
    for k=1:is-1
            for i=2:21
                for j=1:21
                   if g(2,i)==k && g(2,j)==k+1
                       counter=0;
                       for w=1:i-1
                           if pt(g(1,j),g(1,w))==1
                               counter=counter+1;
                           end               
                       end
                       if counter==numberofpredecessors(g(1,j))
                          n=nonesential(g(1,:),i,j);
                        if ks(k)-tt(g(1,j))>=0
                            ks(k)=ks(k)-tt(g(1,j));
                           g(2,j)=k;
                        elseif ks(k)-tt(g(1,j))+tt(g(1,i))<ks(k) && ks(k)-tt(g(1,j))+tt(g(1,i))>=0 && n==1
                           ks(k)=ks(k)-tt(g(1,j))+tt(g(1,i));
                            g(2,j)=k;
                           g(2,i)=k+1;
                        end
                       end
                   end
                end
            end
    end
    for i=1:20
        for j=i:21
            if g(2,i)>g(2,j)
                depo1=g(1,i);
                g(1,i)=g(1,j);
                g(1,j)=depo1;
                depo2=g(2,i);
                g(2,i)=g(2,j);
                g(2,j)=depo2;
            end
        end
    end
    if depo3==g
        x=0;
    else
        depo3=g;
    end
end
is=g(2,21);
populasyon_istasyon=g(2,:);
populasyon_is=g(1,:);
for i=2:pop
    populasyon_is=[populasyon_is;g(1,:)];
    populasyon_istasyon=[populasyon_istasyon;g(2,:)];
end
while ite<=maxite
    for i=1:pop
        p1=randi(pop);
        p2=p1;
        while p1==p2
            p2=randi(pop);
        end
        q=rand();
        if q<=c_rate
            parent1=populasyon_is(p1,:);
            parent2=populasyon_is(p2,:);
            point1=randi(21-1);
            point2=point1;
            while abs(point1-point2)<4
                point2=randi(21-1);
            end
            if point2<point1
                deepo=point2;
                point2=point1;
                point1=deepo;
            end
            child1=parent1;
            child2=parent2;

            counter=point1;
            for p=1:21
                for o=point1+1:point2
                    if parent2(p)==parent1(o)
                        counter=counter+1;
                        child1(counter)=parent2(p);
                    end
                end
            end
            counter=point1;
            for p=1:21
                for o=point1+1:point2
                    if parent1(p)==parent2(o)
                        counter=counter+1;
                        child2(counter)=parent1(p);
                    end
                end
            end
        end
        r1=randi(20)+1;
        r2=r1;
        while r1==r2
            r2=randi(20)+1;
        end
        if r1<r2
            counter=0;
            for b=1:r1
                if pt(populasyon_is(i,r2),populasyon_is(i,b))
                    counter=counter+1;
                end
            end
            n=nonesential( populasyon_is(i,:),r1,r2);
            if n==1 && counter==numberofpredecessors(populasyon_is(i,r2))
                depo1=populasyon_is(i,r1);
                populasyon_is(i,r1)=populasyon_is(i,r2);
                populasyon_is(i,r2)=depo1;
            end
        else
            counter=0;
            for b=1:r2
                if pt(populasyon_is(i,r1),populasyon_is(i,b))
                    counter=counter+1;
                end
            end
            n=nonesential( populasyon_is(i,:),r2,r1);
            if n==1 && counter==numberofpredecessors(populasyon_is(i,r1))
                depo1=populasyon_is(i,r1);
                populasyon_is(i,r1)=populasyon_is(i,r2);
                populasyon_is(i,r2)=depo1;
            end
        end
    end
    %fitness
    for i=1:pop
        isno=1;
        ct=c;
        for j=1:21
            if ct-tt(populasyon_is(i,j))<0
                ct=c-tt(populasyon_is(i,j));
                isno=isno+1;
                populasyon_istasyon(i,j)=isno;
            else
                ct=ct-tt(populasyon_is(i,j));
                populasyon_istasyon(i,j)=isno;
            end
        end
    end
    best_sol=[];
    best_fitness=100;
    for i=1:pop
    counter=0;
    for x=1:21
    for y=1:x
        if pt(populasyon_is(i,x),populasyon_is(i,y))==1
            counter=counter+1;
        end
    end
        if counter~=numberofpredecessors(populasyon_is(i,x))
            fitness=100000000;
            break
        else
            fitness=populasyon_is(i,21);
        end
        counter=0;
    end
        if fitness<best_fitness
            best_fitness=populasyon_istasyon(i,21);
            best_sol=populasyon_is(i,:);
        end
end
ite=ite+1;    
end
fprintf('En Ýyi dizilim \n');
disp(best_sol);
fprintf('Ýstasyon Sayýsý\n');
disp(best_fitness);