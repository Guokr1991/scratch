clear all; close all; clc
load wavelet_tmp.mat

rcv = double(frame(:,1));
rcv = interp(rcv,10);

figure; 
plot(rcv); title('pre-decomp'); axis tight

wvtype = 'sym4';

[cA, cD] = dwt(rcv,wvtype);

figure; hist(cA,100);

figure; hist(cD,100);

cD(find(cD~=0)) = 0;
