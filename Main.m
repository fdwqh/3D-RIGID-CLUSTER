function Main
clc
BaseData=load("s0.txt");
N=BaseData(1,1); %points number
M=BaseData(1,2); %edge number
Edges=BaseData(2:M+1,:);
MutuallyPairs=IdentifyMutuallyPairs(N,Edges);
%scatter(1:N*N,MutuallyPairs,2);
global R;
R=0;
IsHinge=IdentifyHinges(N,Edges,MutuallyPairs,-4);
RigidClusters=IdentifyRigidClusters(N,-4,MutuallyPairs);
%for i=1:length(RigidClusters)
%    disp(RigidClusters{i});
%end
disp(R);
RigidSet=GetRigidSet(N,R,RigidClusters);
for i=1:R
    disp(RigidSet{i});
end
checkres=Check(N,-4,MutuallyPairs,RigidSet);
disp(checkres);
ShowGraph(N,Edges,RigidClusters,RigidSet,IsHinge);
end

function RigidSet=GetRigidSet(N,R,RigidClusters)
RigidSet=cell(R,1); %RigidSet{i} represents points in rigid cluster i
for i=1:N
    for j=1:size(RigidClusters{i},2)
        k=RigidClusters{i}(j);
        RigidSet{k}=[RigidSet{k} i];
    end
end
end