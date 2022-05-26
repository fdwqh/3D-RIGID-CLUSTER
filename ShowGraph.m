function ShowGraph(N,Edge,RigidClusters,RigidSet,IsHinge)
global R;
block_edgenum=max(round(nthroot(R,3)),2);
block_index=0;
block_num=block_edgenum^3;
startpos=zeros(block_num,3);
for i=1:block_edgenum
    for j=1:block_edgenum
        for k=1:block_edgenum
            block_index=block_index+1;
            startpos(block_index,1)=(i-1)*10;
            startpos(block_index,2)=(j-1)*10;
            startpos(block_index,3)=(k-1)*10;
        end
    end
end
Keys=1:N;
Values=zeros(1,N);
has_pos=containers.Map(Keys,Values);
Points=cell(1,N);
for i=1:R
    rset=RigidSet{i};
    for j=1:length(rset)
        current_point=rset(j);
        if has_pos(current_point)==0
            x=startpos(i,1)+rand()*10;
            y=startpos(i,2)+rand()*10;
            z=startpos(i,3)+rand()*10;
            Points{current_point}=[x y z];
            has_pos(current_point)=1;
        end
    end
end
%color=['r' 'g' 'b' 'c' 'm' 'y' 'k' 'w'];
line_color=cell(1,R);
for i=1:R
    line_color{i}=[rand() rand() rand()];
end
%disp(line_color);
for i=1:R
    for j=RigidSet{i}
        plot3(Points{j}(1),Points{j}(2),Points{j}(3),'o','Color',line_color{i},'MarkerSize',8,'MarkerFaceColor',line_color{i});
        hold on;
    end
end
M=size(Edge,1);
for i=1:M
    u=Edge(i,1)+1;
    v=Edge(i,2)+1;
    %length(RigidClusters{u})
    for j=1:size(RigidClusters{u},2)
        for k=1:size(RigidClusters{v},2)
            rigid_j=RigidClusters{u}(j);
            rigid_k=RigidClusters{v}(k);
            if rigid_j==rigid_k
                plot3([Points{u}(1),Points{v}(1)],[Points{u}(2),Points{v}(2)],[Points{u}(3),Points{v}(3)],'color',line_color{rigid_j},'LineWidth',1.5);
                hold on;
            end
        end
    end
end
for i=1:M
    if IsHinge(i)==1
        u=Edge(i,1)+1;
        v=Edge(i,2)+1;
        plot3([Points{u}(1),Points{v}(1)],[Points{u}(2),Points{v}(2)],[Points{u}(3),Points{v}(3)],'color','k','LineStyle','--','LineWidth',2);
    end
end
end