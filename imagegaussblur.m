function img_out=imagegaussblur(img_in,size,sigma);
J = fspecial('gaussian', [size size], sigma);
K = imfilter(img_in,J,'replicate');
img_out = K;
%figure(1),imshow(K)