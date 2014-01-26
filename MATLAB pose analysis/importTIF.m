%Input: string filename
%Output: 3d matrix where third index is frame identifier

function img = importTIF(fname)
    info = imfinfo(fname);
    numImgs = numel(info);
    height=info.Height;
    width=info.Width;
    img = zeros(height,width,numImgs,'uint8');
    for i=1:numImgs
        img(:,:,i) = imread(fname,i,'Info',info);

    end
end
