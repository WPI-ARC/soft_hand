function edges = placefinger(f)

edges = f.edges;

for i=1:4
    if f.up %flip y-axis
        edges{i} = bsxfun(@times,edges{i},[1 -1 1]);
    end
    M = makehgtform('zrotate',pi/180*f.angle);
    edges{i} = (M(1:3,1:3)*edges{i}')'; %rotate
    
    edges{i} = bsxfun(@plus,edges{i},f.origin);
end
    
    