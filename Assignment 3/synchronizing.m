function syn_vidFr = synchronizing(vidFr)
    [B, A] = min(vidFr(1:25,2));
    syn_vidFr = vidFr(A:end,:);
end