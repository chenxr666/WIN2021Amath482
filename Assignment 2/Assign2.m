% Clean workspace
clear all; close all; clc

figure(1)
[y, Fs] = audioread('GNR.m4a');
tr_gnr = length(y)/Fs; % record time in seconds
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Sweet Child O Mine');
p8 = audioplayer(y,Fs); playblocking(p8);

k = (1/tr_gnr)*[0:length(y)/2-1 -length(y)/2:-1];
ks = fftshift(k);
t2 = linspace(0,tr_gnr,length(y)+1); t = t2(1:length(y));

% Creating a spectrogram
a = 1000;
tau = 0:0.5:10;
Notes = zeros(length(tau),1);
for j = 1:length(tau)
    g = exp(-a*(t - tau(j)).^2);
    yg = g.*(y.');
    ygt = fft(yg);
    ygt_spec(:,j) = fftshift(abs(ygt));
    [m,i] = max(fftshift(abs(ygt)));
    Notes(j,1) = abs(ks(i));
end
figure(2)
pcolor(tau, ks, ygt_spec);
shading interp
set(gca, 'ylim', [0 1000], 'Fontsize', 16)
colormap(hot)
colorbar
xlabel('time(t)'), ylabel('frequency(k)')
yyaxis right
scatter(tau, Notes, 'y', 'filled')
ylim([0 1000])
yticks([293 349 440 587 783])
yticklabels({'D4' 'F4' 'A4' 'D5' 'G5'})
title('Spectrogram of the guitar notes in the GNR clip')

figure(3)
[y2, Fs2] = audioread('Floyd.m4a');
y2(end)=[];
tr_flo = length(y2)/Fs2; % record time in seconds
plot((1:length(y2))/Fs2,y2);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Comfortably Numb');
p8 = audioplayer(y2,Fs2); playblocking(p8);

k2 = (1/tr_flo)*[0:length(y2)/2-1 -length(y2)/2:-1];
ks2 = fftshift(k2);
t22 = linspace(0,tr_flo,length(y2)+1); t1 = t22(1:length(y2));

%% Filter for Bass in Floyd clip
y2t = fft(y2);
y2_filter = ifft(y2t.*fftshift(50<abs(y2t)<250));

% Creating a spectrum
a = 500;
tau = 0:0.5:10;
Notes2 = zeros(length(tau),1);
for j = 1:length(tau)
    g = exp(-a*(t1 - tau(j)).^2);
    y2g = g.*(y2_filter.');
    y2gt = fft(y2g);
    y2gt_spec(:,j) = fftshift(abs(y2gt));
    [m,i] = max(fftshift(abs(y2gt)));
    Notes2(j,1) = abs(ks2(i));
end
figure(4)
pcolor(tau, ks2, y2gt_spec);
shading interp
set(gca, 'ylim', [50 250], 'Fontsize', 16)
colormap(hot)
colorbar
xlabel('time(t)'), ylabel('frequency(k)')
yyaxis right
scatter(tau, Notes2, 'y', 'filled')
ylim([50 250])
yticks([82 98 110 123 130])
yticklabels({'E2' 'G2' 'A2' 'B2' 'C3'})
title('Spectrogram of the Bass notes in the Floyd clip')

%% Filter for Guitar in Floyd clip
y2t = fft(y2);
y2_filter = ifft(y2t.*fftshift(250<abs(y2t)<500));

% Creating a spectrum
a = 500;
tau = 0:0.5:10;
Notes2 = zeros(length(tau),1);
for j = 1:length(tau)
    g = exp(-a*(t1 - tau(j)).^2);
    y2g = g.*(y2_filter.');
    y2gt = fft(y2g);
    y2gt_spec(:,j) = fftshift(abs(y2gt));
    [m,i] = max(fftshift(abs(y2gt)));
    Notes2(j,1) = abs(ks2(i));
end
figure(5)
pcolor(tau, ks2, y2gt_spec);
shading interp
set(gca, 'ylim', [250 500], 'Fontsize', 16)
colormap(hot)
colorbar
xlabel('time(t)'), ylabel('frequency(k)')
yyaxis right
scatter(tau, Notes2, 'y', 'filled')
ylim([250 500])
yticks([329 369 392])
yticklabels({'E4' 'F4' 'G4'})
title('Spectrogram of the Guitar notes in the Floyd clip')
