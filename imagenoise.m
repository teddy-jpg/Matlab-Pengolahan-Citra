function img_out=imagenoise(I,d);
img_out = imnoise(I,'salt & pepper',d);
imwrite(img_out,'noise.png')
figure(1),imshow(img_out)
