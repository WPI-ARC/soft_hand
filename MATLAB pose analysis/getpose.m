function pose = getpose(fullangle,N)

pose = ones(1,N)*pi/180*fullangle/N;
%angles in radians relative to previous segment
%leftmost segment relative to x-axis
%clockwise (down) positive