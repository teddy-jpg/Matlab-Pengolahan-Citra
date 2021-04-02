function img_out=imageresize(img_in, rowScale, colScale);
F=[rowScale 0 0;0 colScale 0;0 0 1]
K=maketform('affine',F);
L = imtransform(img_in,K)
img_out = L;
%figure(1),imshow(L)