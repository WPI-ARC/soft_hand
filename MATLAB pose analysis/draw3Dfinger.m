
function draw3Dfinger(f)
   
    t = hgtransform('Parent',gca);
    for i=1:4
        e=f.edges{i};
        h(i) = line(e(:,1),e(:,2),e(:,3),'Color','b');        
    end
    h(i+1) = line([f.edges{1}(1,1),f.edges{2}(1,1),f.edges{3}(1,1),f.edges{4}(1,1),f.edges{1}(1,1)],...
                    [f.edges{1}(1,2),f.edges{2}(1,2),f.edges{3}(1,2),f.edges{4}(1,2),f.edges{1}(1,2)],...
                    [f.edges{1}(1,3),f.edges{2}(1,3),f.edges{3}(1,3),f.edges{4}(1,3),f.edges{1}(1,3)]);
    h(i+2) = line([f.edges{1}(end,1),f.edges{2}(end,1),f.edges{3}(end,1),f.edges{4}(end,1),f.edges{1}(end,1)],...
                    [f.edges{1}(end,2),f.edges{2}(end,2),f.edges{3}(end,2),f.edges{4}(end,2),f.edges{1}(end,2)],...
                    [f.edges{1}(end,3),f.edges{2}(end,3),f.edges{3}(end,3),f.edges{4}(end,3),f.edges{1}(end,3)]);
    set(h,'Parent',t);
    
    M = makehgtform('zrotate',pi/180*f.angle);
    if (f.up)
        M = M*makehgtform('xrotate',pi); %flip
    end
    M = makehgtform('translate',f.origin)*M;
    set(t,'Matrix',M)
    
    
    %set(gcf,'Renderer','opengl')
    %view(3); grid on; axis equal
    %drawnow
end
    