function checkres=Check(N,cutoff,MutuallyPairs,RigidSets)
checkres=-1;
for i=1:size(RigidSets,1)
    ok=CheckEachSet(RigidSets{i},N,cutoff,MutuallyPairs);
    if ok==0
        checkres=i;
        return;
    end
end
end

function ok=CheckEachSet(rset,N,cutoff,MutuallyPairs)
ok=1;
%rigid check
for i=1:length(rset)
    x=rset(i);
    for j=i+1:length(rset)
        y=rset(j);
        if MutuallyPairs((x-1)*N+y)>cutoff %not mutually rigid
            ok=0;
            return;
        end
    end
end
%maximum check
Keys=1:N;
Values=zeros(1,N);
IsContain=containers.Map(Keys,Values);
for i=1:length(rset)
    IsContain(rset(i))=1;
end
for i=1:N
    if IsContain(i)==1
        continue;
    end
    for a=1:length(rset)
        for b=a+1:length(rset)
            for c=b+1:length(rset)
                x=rset(a);
                y=rset(b);
                z=rset(c);
                if MutuallyPairs((x-1)*N+i)<cutoff && MutuallyPairs((y-1)*N+i)<cutoff && MutuallyPairs((z-1)*N+i)<cutoff
                    %not maximum
                    ok=0;
                    return;
                end
            end
        end
    end
end
end