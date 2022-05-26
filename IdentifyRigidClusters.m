function label=IdentifyRigidClusters(N,cutoff,MutuallyPairs)
global R;
label=cell(N,1); %every point may belongs to several rigid clusters
mp=cell(N,1); %mp(u)={v|v and u is mutually rigid}
% get mp(i)
for i=1:N
    mp{i}=[];
    label{i}=[];
    for j=1:N
        if MutuallyPairs((i-1)*N+j)<cutoff && i~=j 
            mp{i}=[mp{i} j];
        end
    end
end
% get label{i}
R=0;
for A=1:N
    mA=mp{A};
    nA=length(mA);
    for i=1:nA
        B=mA(i);
        mAB=intersect(mA,mp{B});
        nAB=length(mAB);
        %disp(mAB);
        for j=1:nAB
            C=mAB(j);
            if C==A || C==B
                continue;
            end
            %disp([A B C]);
            % whether A,B,C has been included in the same rigid cluster:
            Processed=check(label{C},label{A},label{B}); 
            %disp(Processed);
            if Processed==1
                continue;
            end
            R=R+1;
            label{A}=[label{A} R];
            label{B}=[label{B} R];
            label{C}=[label{C} R];
            mABC=intersect(mAB,mp{C});
            %disp(mABC);
            nABC=length(mABC);
            for k=1:nABC
                label{mABC(k)}=[label{mABC(k)} R];
            end
        end
    end
end
end
function ok=check(c,a,b)
ok=0;
for k=1:length(c)
    z=c(k);
    for i=1:length(a)
        x=a(i);
        if z==x
            for j=1:length(b)
                y=b(j);
                %disp([x,y,z]);
                if z==y
                    ok=1;
                    return;
                end
            end
        end
    end
end
end