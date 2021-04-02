function img_out=imageavgblur(img_in,size);
J = fspecial('average', size);
K = imfilter(img_in,J,'replicate');
img_out = K;
%figure(1),imshow(K)