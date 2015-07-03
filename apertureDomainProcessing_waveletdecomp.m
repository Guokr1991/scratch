clear all; close all; clc
load /getlab/wjl11/scratch/data_files/beamforming/wavelet_tmp.mat

rcv = double(frame(:,1));
rcv = interp(rcv,10);

figure
plot(rcv); title('pre-decomp'); axis tight
set(gcf,'position',[ 500 500 2000 500])
wvtype = 'haar';

% F = dbwavf(wvtype);
% figure; 
% plot(F); title('wavelet'); axis tight

size(rcv)
maxL = wmaxlev(length(rcv),wvtype);
[C,L] = wavedec(rcv,3,wvtype);

figure;
plot(C(1:L(1))); title('decomp'); axis tight
