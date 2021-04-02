function img_out=imageshearing(img_in, verScale, horScale);
F=[1 horScale 0;verScale 1 0;0 0 1]
K=maketform('affine',F);
L = imtransform(img_in,K)
img_out = L;
%figure(2),imshow(L)