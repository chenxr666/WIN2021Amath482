% Clean workspace
clear all; close all; clc

load subdata.mat % Imports the data as the 262144x49 (space by time) matrix called subdata

L = 10; % spatial domain
n = 64; % Fourier modes
x2 = linspace(-L,L,n+1); x = x2(1:n); y =x; z = x;
k = (2*pi/(2*L))*[0:(n/2 - 1) -n/2:-1]; ks = fftshift(k);

[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);

ave = zeros(1,n); 
for j=1:49
Un(:,:,:)=reshape(subdata(:,j),n,n,n);
Unt = fftn(Un);
ave = ave+Unt;
% M = max(abs(Un),[],'all');
% subplot(2,1,1)
% close all, isosurface(X,Y,Z,abs(Un)/M,0.7)
% axis([-20 20 -20 20 -20 20]), grid on, drawnow
end
ave = abs(fftshift(ave))/49; % Averaging over realizations
M = max(abs(ave),[],'all');
[Mx,My,Mz] = ind2sub(size(ave),find(abs(ave)==M)); % Find the cooridinates of the max 
cx = Kx(Mx,My,Mz); % Find the center frequency
cy = Ky(Mx,My,Mz);
cz = Kz(Mx,My,Mz);

tau = 0.2;
filterX = exp(-tau*(Kx-cx).^2); % Define the filter
filterY = exp(-tau*(Ky-cy).^2);
filterZ = exp(-tau*(Kz-cz).^2);
XX = zeros(49,1);
YY = zeros(49,1);
ZZ = zeros(49,1);
for j=1:49
Un(:,:,:)=reshape(subdata(:,j),n,n,n);
Unt = fftshift(fftn(Un));
unft = filterX.*filterY.*filterZ.*Unt; % Apply the filter to the signal in frequency space
unf = ifftn(fftshift(unft)); % Shift it back to spatial space
M = max(abs(unf),[],'all');
[Mx,My,Mz] = ind2sub(size(unf),find(abs(unf)==M)); 
XX(j,1) = X(Mx,My,Mz);
YY(j,1) = Y(Mx,My,Mz);
ZZ(j,1) = Z(Mx,My,Mz);
end
plot3(XX,YY,ZZ) % Plot the trajectory of the submarine
axis([-10 10 -10 10 -10 10])
title('The trajectory of the submarine');
xlabel('x axis')
ylabel('y axis')
zlabel('depth')



