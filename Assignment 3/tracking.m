function disp = tracking(vidFr, ymin, ymax, xmin, xmax, wp)   
    snapshots = size(vidFr, 4);
    disp = [];
    filter = zeros(480, 640);
    filter(ymin:1:ymax, xmin:1:xmax) = 1;
    for i = 1:snapshots
        A = double(rgb2gray(vidFr(:,:,:,i))).*filter;
        [Y, X] = find(A>wp);
        disp = [disp; mean(X), mean(Y)];
    end
end