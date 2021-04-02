function img_out=imagerotation(img_in,degree);
F=[cos(degree*pi/180) -sin(degree*pi/180) 0;sin(degree*pi/180) cos(degree*pi/180) 0;0 0 1];
K=maketform('affine',F);
L = imtransform(img_in,K)
img_out = L;
%figure(1),imshow(L)
