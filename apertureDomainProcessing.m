clear all;
close all;
clc
% rootpth = '/getlab/wjl11/scratch';
rootpth = '..';
addpath([rootpth '/data_files/beamforming/'])
addpath([rootpth '/data_files/beamforming/ece582_final_project'])
% addpath([rootpth '/data_files/beamforming/DR_testdata/'])
addpath ../beamforming/accessory/
addpath ../beamforming/core/    
load point_target
% load DR_testdata
% load les

% load sampleData.mat
% rf = double(data.channel_data);
% x = axes.x;
% z = axes.z;
[~, rf_steer, x, z] = linearScanDR(rf,acq_params,bf_params);

f0=7e6;
fs=100e6;
% lags = size(rf_steer,3);
lags = size(rf_steer,2);

% fs = data.fs;
% f0 = data.f0;

% SNR = 6;
% noiseraw = 10^(-SNR/20)*max(rf(:)).*randn(size(rf));
% bw = 0.85*f0;
% 
% [bf,af] = butter(2,[f0-bw/2 f0+bw/2]./(fs/2),'bandpass');
% noisefilt = filtfilt(bf,af,noiseraw);
% rf_steer = rf + noisefilt;

% excitation=sin(2*pi*f0*(0:1/fs:1/(f0*4)));
excitation = [0.5,0,-0.5];
excitation_im = repmat(excitation,[lags 1])';
% excitation_im = [hann(lags)'; zeros(1,lags); -hann(lags)'];


figure
imagesc(excitation_im)

filt_rf = zeros(size(rf_steer));
% figure
for ii = 1:size(rf_steer,3)
% clf
filt_rf(:,:,ii) = imfilter(squeeze(rf_steer(:,:,ii)),excitation_im,0);
% subplot(121)
% imagesc(squeeze(rf_steer(:,:,ii))); caxis([min(rf_steer(:)) max(rf_steer(:))])
% subplot(122)
% imagesc(squeeze(filt_rf(:,:,ii))); caxis([min(rf_steer(:)) max(rf_steer(:))])
% 
% drawnow
% pause
end

% [~,filt_rf] = applyApod(filt_rf,'gauss',50);
% [~,rf_steer] = applyApod(rf_steer,'gauss',50);

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
% subplot(121)
% rf2bmode(cont_sum, 40, x, z); colormap gray
% imagesc(cont_sum); colormap jet
subplot(211)
rf2bmode(cont_sum, 80, x, z); colormap jet
% xlim([-2 2])
% ylim([min(z)*1000 46])
% 
% subplot(122)
% rf2bmode(filt_sum, 40, x, z); colormap gray
% imagesc(filt_sum); colormap jet
subplot(212)
rf2bmode(filt_sum, 80, x, z); colormap jet
% xlim([-2 2])
% ylim([min(z)*1000 46])

