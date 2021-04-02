img_in = imread('onion.png');
%rotasi
degree = 60
%imagerotation(img_in,degree);

%scala
rowScale = 2
colScale = 2
%imageresize(img_in, rowScale, colScale)

%translation
tx=100
ty=10
%imagetranslation(img_in, tx, ty)

%shearing dalam persen
verScale = 0
horScale = .5
%imageshearing(img_in, verScale, horScale);

radius = 0.01

%imagesharpen(img_in, size);

imagenoise(img_in, radius);
