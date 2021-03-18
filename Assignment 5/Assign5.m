ski = VideoReader('ski_drop_low.mp4');
mon = VideoReader('monte_carlo_low.mp4');
ski_frames = read(ski);
mon_frames = read(mon);

%% ski drop
dt = 1/ski.Framerate;
t = 0:dt:ski.Duration;
numFra = get(ski, 'numberOfFrames');

for i = 1:numFra
    I = rgb2gray(ski_frames(:,:,:,i));
    I = im2double(I);
    X(:,i) = reshape(I,[],1);
end

X1 = X(:,1:end-1);
X2 = X(:,2:end);

[U,Sig,V] = svd(X1,'econ');
sig = diag(Sig);

figure(1)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')

% trancate to rank r
r = 2;
ur = U(:, 1:r);
sr = Sig(1:r, 1:r);
vr = V(:, 1:r);
S = ur'*X2*vr/sr;
[eV, D] = eig(S);
mu = diag(D);
omega = log(mu)/dt;
phi = ur*eV;
y0 = phi \ X1(:,1);

u_modes = zeros(length(y0), length(t));
for iter = 1:length(t)
    u_modes(:, iter) = y0.*exp(omega*t(iter));
end
u_dmd = phi*u_modes;

bg = u_dmd;
fg = X - abs(u_dmd);
fg = (fg-min(fg))./(max(fg)-min(fg));

figure(2)
imshow(reshape(X(:,200), 540, 960));
figure(3)
imshow(reshape(bg(:,200), 540, 960));
figure(4)
imshow(reshape(fg(:,200), 540, 960));

%% monte carlo
dt = 1/mon.Framerate;
t = 0:dt:mon.Duration;
numFra = get(mon, 'numberOfFrames');

for i = 1:numFra
    I = rgb2gray(mon_frames(:,:,:,i));
    I = im2double(I);
    X(:,i) = reshape(I,[],1);
end

X1 = X(:,1:end-1);
X2 = X(:,2:end);

[U,Sig,V] = svd(X1,'econ');
sig = diag(Sig);

figure(5)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')

% trancate to rank r
r = 3;
ur = U(:, 1:r);
sr = Sig(1:r, 1:r);
vr = V(:, 1:r);
S = ur'*X2*vr/sr;
[eV, D] = eig(S);
mu = diag(D);
omega = log(mu)/dt;
phi = ur*eV;
y0 = phi \ X1(:,1);

u_modes = zeros(length(y0), length(t));
for iter = 1:length(t)
    u_modes(:, iter) = y0.*exp(omega*t(iter));
end
u_dmd = phi*u_modes;

bg = u_dmd;
fg = X - abs(u_dmd(:,end-1));

figure(6)
imshow(reshape(X(:,200), 540, 960));
figure(7)
imshow(reshape(bg(:,50), 540, 960));
figure(8)
imshow(reshape(fg(:,50), 540, 960));