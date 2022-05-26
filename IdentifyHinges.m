function IsHinge=IdentifyHinges(N,Edges,MutuallyRigid,cutoff)
M=size(Edges,1);
Keys=1:M;
Values=zeros(1,M);
IsHinge=containers.Map(Keys,Values);
for i=1:M
    A=Edges(i,1)+1;
    B=Edges(i,2)+1;
    ok=CheckHinge(A,B,N,MutuallyRigid,cutoff);
    if ok
        IsHinge(i)=1;
    end
end
end

function res=CheckHinge(A,B,N,MutuallyRigid,cutoff)
if A==B || MutuallyRigid(r(A,B,N))>cutoff
   res=0;
   return;
end
List=[];
%找到同时和A,B相互刚性的点
for i=1:N
    if i==A || i==B || MutuallyRigid(r(A,i,N))>cutoff || MutuallyRigid(r(B,i,N))>cutoff
        continue;
    end
    List=[List i];
end
%如果存在两个点不相互刚性，AB就是一个hinge
for i=1:length(List)
    for j=i+1:length(List)
        C=List(i);
        D=List(j);
        if C==D
            continue;
        end
        if MutuallyRigid(r(C,D,N))>cutoff
            res=1;
            return;
        end
    end
end
res=0;
end

function rij=r(i,j,N)
rij=(i-1)*N+j;
end