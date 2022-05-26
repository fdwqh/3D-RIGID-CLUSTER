function SumDelta=IdentifyMutuallyPairs(N,Edges)
M=size(Edges,1);
d=3;
SumDelta=zeros(N*N,1);
for T=1:2
    Points=generate(N);
    RigidMatrix=zeros(M,d*N);
    for i=1:M
        x=Edges(i,1)+1;
        y=Edges(i,2)+1;
        for j=1:d
            RigidMatrix(i,d*(x-1)+j)=Points{x}(j)-Points{y}(j);
            RigidMatrix(i,d*(y-1)+j)=Points{y}(j)-Points{x}(j);
        end
    end
    GSolution=null(RigidMatrix);
    Velocity=zeros(d*N,1);
    for i=1:size(GSolution,2)
        k=-100+rand()*200;
        Velocity=Velocity+k*GSolution(:,i);
    end
    for i=1:N
        for j=1:N
            vi=zeros(d,1);
            vj=zeros(d,1);
            for k=1:d
                vi(k)=Velocity(d*(i-1)+k);
                vj(k)=Velocity(d*(j-1)+k);
            end
            deltaij=abs((Points{i}-Points{j})*(vi-vj));
            SumDelta((i-1)*N+j)=SumDelta((i-1)*N+j)+deltaij;
        end
    end
end
SumDelta=log10(SumDelta);
end
function location=generate(n)
L=-100;
R=100;
location=cell(n,1);
for i=1:n
    x=L+rand()*(R-L);
    y=L+rand()*(R-L);
    z=L+rand()*(R-L);
    location{i}=[x y z];
end
end