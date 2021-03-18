% Clean workspace
% clear all; close all; clc

%% Test 1: Ideal Case
load('cam1_1.mat')
load('cam2_1.mat')
load('cam3_1.mat')
% implay(vidFrames1_1)
disp1_1 = synchronizing(tracking(vidFrames1_1, 200, 380, 325, 345, 250));
disp2_1 = synchronizing(tracking(vidFrames2_1, 100, 300, 250, 320, 250));
disp3_1 = synchronizing(tracking(vidFrames3_1, 200, 345, 235, 500, 247));
l = length(disp1_1);
T1 = [disp1_1'; disp2_1(1:l,:)'; disp3_1(1:l,:)'];
[m,n] = size(T1);
for i = 1:6
    a = mean(T1(i,:));
    for j = 1:n
        T1(i,j) = T1(i,j) - a;
    end
end
[U,S,V] = svd(T1, 'econ');
sig = diag(S);
figure(1)
subplot(2,2,1)
plot(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy')
title('Energy captured by each mode')
subplot(2,2,2)
semilogy(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy (log scale)')
title('Energy(log scale) captured by each mode')
subplot(2,2,3)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')
subplot(2,2,4)
semilogy(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma (log scale)')
title('Singular values (log scale) of each modes')
figure(2)
subplot(1,2,1)
plot(1:l, T1(2,:))
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
ylabel('Displacement in z direction (in pixels)')
xlabel('Snapshots (in time)')
subplot(1,2,2)
plot(1:l, T1(1,:))
ylabel('Displacement in x-y plane direction (in pixels)')
xlabel('Snapshots (in time)')
set(gca, 'XLim', xL);
set(gca, 'YLim', yL);
suptitle('Displacement of the mass')
%% Test 2: Noisy Case
load('cam1_2.mat')
load('cam2_2.mat')
load('cam3_2.mat')
disp1_2 = synchronizing(tracking(vidFrames1_2, 200, 400, 330, 400, 240));
disp2_2 = synchronizing(tracking(vidFrames2_2, 140, 400, 200, 400, 247));
disp3_2 = synchronizing(tracking(vidFrames3_2, 210, 280, 250, 450, 245));
l = length(disp1_2);
T2 = [disp1_2'; disp2_2(1:l,:)'; disp3_2(1:l,:)'];
[m,n] = size(T2);
for i = 1:6
    a = mean(T2(i,:));
    for j = 1:n
        T2(i,j) = T2(i,j) - a;
    end
end
[U,S,V] = svd(T2, 'econ');
sig = diag(S);
figure(3)
subplot(2,2,1)
plot(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy')
title('Energy captured by each mode')
subplot(2,2,2)
semilogy(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy (log scale)')
title('Energy(log scale) captured by each mode')
subplot(2,2,3)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')
subplot(2,2,4)
semilogy(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma (log scale)')
title('Singular values (log scale) of each modes')
figure(4)
subplot(1,2,1)
plot(1:l, T2(2,:))
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
ylabel('Displacement in z direction (in pixels)')
xlabel('Snapshots (in time)')
subplot(1,2,2)
plot(1:l, T2(1,:))
ylabel('Displacement in x-y plane direction (in pixels)')
xlabel('Snapshots (in time)')
set(gca, 'XLim', xL);
set(gca, 'YLim', yL);
suptitle('Displacement of the mass')
%% Test 3: Horizontal Displacement
load('cam1_3.mat')
load('cam2_3.mat')
load('cam3_3.mat')
disp1_3 = synchronizing(tracking(vidFrames1_3, 225, 450, 270, 450, 250));
disp2_3 = synchronizing(tracking(vidFrames2_3, 100, 450, 160, 425, 250));
disp3_3 = synchronizing(tracking(vidFrames3_3, 160, 365, 200, 500, 245));
l = length(disp1_3);
T3 = [disp1_3'; disp2_3(1:l,:)'; disp3_3(1:l,:)'];
[m,n] = size(T3);
for i = 1:6
    a = mean(T3(i,:));
    for j = 1:n
        T3(i,j) = T3(i,j) - a;
    end
end
[U,S,V] = svd(T3, 'econ');
sig = diag(S);
figure(5)
subplot(2,2,1)
plot(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy')
title('Energy captured by each mode')
subplot(2,2,2)
semilogy(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy (log scale)')
title('Energy(log scale) captured by each mode')
subplot(2,2,3)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')
subplot(2,2,4)
semilogy(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma (log scale)')
title('Singular values (log scale) of each modes')
figure(6)
subplot(1,2,1)
plot(1:l, T3(2,:))
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
ylabel('Displacement in z direction (in pixels)')
xlabel('Snapshots (in time)')
subplot(1,2,2)
plot(1:l, T3(1,:))
ylabel('Displacement in x-y plane direction (in pixels)')
xlabel('Snapshots (in time)')
set(gca, 'XLim', xL);
set(gca, 'YLim', yL);
suptitle('Displacement of the mass')
%% Test 4: Horizontal Displacement and Rotation
load('cam1_4.mat')
load('cam2_4.mat')
load('cam3_4.mat')
disp1_4 = synchronizing(tracking(vidFrames1_4, 230, 360, 300, 480, 235));
disp2_4 = synchronizing(tracking(vidFrames2_4, 95, 295, 230, 420, 245));
disp3_4 = synchronizing(tracking(vidFrames3_4, 150, 275, 300, 470, 235));
l = length(disp3_4);
T4 = [disp1_4(1:l,:)'; disp2_4(1:l,:)'; disp3_4'];
[m,n] = size(T4);
for i = 1:6
    a = mean(T4(i,:));
    for j = 1:n
        T4(i,j) = T4(i,j) - a;
    end
end
[U,S,V] = svd(T4, 'econ');
sig = diag(S);
figure(7)
subplot(2,2,1)
plot(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy')
title('Energy captured by each mode')
subplot(2,2,2)
semilogy(sig.^2/sum(sig.^2), 'ko', 'Linewidth', 2)
ylabel('Energy (log scale)')
title('Energy(log scale) captured by each mode')
subplot(2,2,3)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')
subplot(2,2,4)
semilogy(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma (log scale)')
title('Singular values (log scale) of each modes')
figure(8)
subplot(1,2,1)
plot(1:l, T4(2,:))
xL = get(gca, 'XLim');
yL = get(gca, 'YLim');
ylabel('Displacement in z direction (in pixels)')
xlabel('Snapshots (in time)')
subplot(1,2,2)
plot(1:l, T4(1,:))
ylabel('Displacement in x-y plane direction (in pixels)')
xlabel('Snapshots (in time)')
set(gca, 'XLim', xL);
set(gca, 'YLim', yL);
suptitle('Displacement of the mass')