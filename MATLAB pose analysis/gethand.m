function fingers = gethand()

fingers(1).origin = [0 10 0]; fingers(1).angle = 20; fingers(1).up = 0;
fingers(2).origin = [0 10 4]; fingers(2).angle = 20; fingers(2).up = 0;
fingers(3).origin = [0 10 8]; fingers(3).angle = 20; fingers(3).up = 0;
fingers(4).origin = [0 0 2]; fingers(4).angle = 0; fingers(4).up = 1;
fingers(5).origin = [0 0 6]; fingers(5).angle = 0; fingers(5).up = 1;

N = 100;

for i=1:3
    fingers(i).posefun = @(in) getpose(in(1),N);
    fingers(i).len = 15;
    fingers(i).height = 2;
    fingers(i).width = 2;
end
for i=4:5
    fingers(i).posefun = @(in) getpose(in(2),N);
    fingers(i).len = 9;
    fingers(i).height = 2;
    fingers(i).width = 2;
end




