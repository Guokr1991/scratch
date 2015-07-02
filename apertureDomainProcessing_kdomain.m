%%

clear all;
close all;
clc
rootpth = '..';
addpath([rootpth '/data_files/beamforming/ece582_final_project/'])
addpath([rootpth '/data_files/beamforming/DR_testdata/'])
addpath ../beamforming/accessory/
addpath ../beamforming/core/    
% load point_target
load point_target

[~, rf_steer, x, z] = linearScanDR(rf,acq_params,bf_params);

f0=7e6;
fs=100e6;

filt_rf = zeros(size(rf_steer));
figure
for ii = 1:size(rf_steer,3)
clf
tmp = squeeze(rf_steer(:,:,ii));
tmp(isnan(tmp)) = 0;

tmpfft = fftshift(fft2(tmp));

tmpfft(:,~floor((size(tmpfft,2)/2))) = 0;

filt_rf(:,:,ii) = abs(ifft2(ifftshift(tmpfft)));
end

for ii = 1:size(filt_rf,3)
    imagesc(filt_rf(:,:,ii)); caxis([min(filt_rf(:)) max(filt_rf(:))])
    drawnow
    pause(0.1)
end

filt_rf(isnan(filt_rf)) = 0;
rf_steer(isnan(rf_steer)) = 0;
filt_sum = squeeze(sum(filt_rf,2));
cont_sum = squeeze(sum(rf_steer,2));

figure
subplot(211)
rf2bmode(cont_sum, 80, x, z); colormap jet

subplot(212)
rf2bmode(filt_sum, 80, x, z); colormap jet

% tmp = fftshift(fft2(squeeze(filt_rf(:,:,ii))));
% tmp(1:198,:) = 0;
% tmp(311:end,:) = 0;
% tmp(:,1:50) = 0;
% tmp(:,90:end) = 0;
% tmp2 = ifft2(ifftshift(tmp));
% subplot(122)
% imagesc(abs(tmp2))