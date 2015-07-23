load arfidata.mat

par.kernelLength = 4;
par.searchRange = 1;
arfidat = computeDisplacementsNXCorr(rfdata,par);

imagesc(x,z,arfidat(:,:,2)); colormap jet; axis image; colorbar
