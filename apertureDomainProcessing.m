clear all;
close all;
clc
rootpth = '/getlab/wjl11/scratch';
addpath([rootpth '/data_files/beamforming/ece582_final_project/'])
addpath([rootpth '/data_files/beamforming/DR_testdata/'])
addpath ../beamforming/accessory/
addpath ../beamforming/core/    
% load point_target
load point_target

[~, rf_steer, x, z] = linearScanDR(rf,acq_params,bf_params);

f0=7e6;
fs=100e6;
lags = 80;

% excitation=sin(2*pi*f0*(0:1/fs:1/(f0*4)));
excitation = [1,0,-1];
excitation_im = repmat(excitation,[lags 1])';
% excitation_im = [hann(lags)'; zeros(1,lags); -hann(lags)'];


figure
imagesc(excitation_im)

filt_rf = zeros(size(rf_steer));
% figure
for ii = 1:size(rf_steer,3)
% clf
filt_rf(:,:,ii) = imfilter(squeeze(rf_steer(:,:,ii)),excitation_im,'replicate');
% subplot(121)
% imagesc(squeeze(rf_steer(:,:,ii))); caxis([min(rf_steer(:)) max(rf_steer(:))])
% subplot(122)
% imagesc(squeeze(filt_rf(:,:,ii))); caxis([min(rf_steer(:)) max(rf_steer(:))])

% drawnow
% pause
end

[~,filt_rf] = applyApod(filt_rf,'gauss',3);
[~,rf_steer] = applyApod(rf_steer,'gauss',3);

filt_rf(isnan(filt_rf)) = 0;
rf_steer(isnan(rf_steer)) = 0;
filt_sum = squeeze(sum(filt_rf,2));
cont_sum = squeeze(sum(rf_steer,2));

fft_cont = abs(fftshift(fft2(cont_sum)));
fft_filt = abs(fftshift(fft2(filt_sum)));
figure
subplot(121)
imagesc(fft_cont./max(fft_cont(:)));
subplot(122)
imagesc(fft_filt./max(fft_filt(:))); 

figure
subplot(211)
rf2bmode(cont_sum, 80, x, z); colormap jet

subplot(212)
rf2bmode(filt_sum, 80, x, z); colormap jet


