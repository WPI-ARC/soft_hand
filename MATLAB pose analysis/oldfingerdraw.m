
function finger = fingerdraw(pose, len, height, width)
%pose is vector of angles in radians relative to previous segment
%leftmost segment relative to x-axis
%clockwise (down) positive




DRAWTYPE = 4; %2 = 2D, 3 = 3D, 4 = 3D hand
DRAWSTYLE = 0; %0 = none, 1 = ribs, 2 = solid, 3 = outer frame
if (nargin<4)
    width = height;
end

N = length(pose);
seglen = len/N;

x0=0; y0=0; a = 0;
topverts = zeros(N,2); bottomverts = zeros(N,2);

for i = 1:N
    a = a + pose(i);
    x = x0+seglen*cos(a);
    y = y0-seglen*sin(a); 
    
    if (DRAWSTYLE==1)
        line([x0,x],[y0,y]) %centerline
    end
    
    topverts(i,1) = x0+seglen/2*cos(a)+height/2*sin(a);
    topverts(i,2) = y0-seglen/2*sin(a)+height/2*cos(a);
    bottomverts(i,1) = x0+seglen/2*cos(a)-height/2*sin(a);
    bottomverts(i,2) = y0-seglen/2*sin(a)-height/2*cos(a);
    
    if(DRAWSTYLE==1)
        line([bottomverts(i,1),topverts(i,1)], ...
             [bottomverts(i,2),topverts(i,2)]) %crossbar
    end
    
    
    x0 = x;
    y0 = y;
    
end

edges{1} = [topverts,-width/2*ones(N,1)];
edges{2} = [topverts,width/2*ones(N,1)];
edges{3} = [bottomverts,width/2*ones(N,1)];
edges{4} = [bottomverts,-width/2*ones(N,1)];
basef.origin = [0 0 0]; basef.angle = 0; basef.edges = edges;
for i=1:length(finger)
    finger(i).edges = edges;
end


if (DRAWSTYLE==2)
    patch([topverts(:,1);bottomverts(end:-1:1,1)],[topverts(:,2);bottomverts(end:-1:1,2)],'r')
end
if (DRAWSTYLE==3)
    if (DRAWTYPE==2)
        line([topverts(:,1),bottomverts(:,1)],[topverts(:,2),bottomverts(:,2)])
    else
        line(repmat([topverts(:,1),bottomverts(:,1)],1,2),...
             repmat([topverts(:,2),bottomverts(:,2)],1,2),...
             repmat([0 0 width width],N,1),'Color','b') %corner lines
        line([topverts(1,1),topverts(1,1),bottomverts(1,1),bottomverts(1,1),topverts(1,1)],...
             [topverts(1,2),topverts(1,2),bottomverts(1,2),bottomverts(1,2),topverts(1,2)],...
             [0 width width 0 0])
        line([topverts(end,1),topverts(end,1),bottomverts(end,1),bottomverts(end,1),topverts(end,1)],...
             [topverts(end,2),topverts(end,2),bottomverts(end,2),bottomverts(end,2),topverts(end,2)],...
             [0 width width 0 0])
         
    end
end
if (DRAWTYPE==4)
    for i=1:5
        draw3Dfinger(finger(i));
    end
end
end

