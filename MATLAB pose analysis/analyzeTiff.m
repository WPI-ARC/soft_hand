%Analyze image frames in tiff
img = importTIF('images/Series2_6.tif');

for i = 1:size(img,3)
    figure
    poses{i}=imageanalyze(img(:,:,i));
end
