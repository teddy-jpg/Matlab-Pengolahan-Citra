function img_out=imagetranslation(img_in, tx, ty)
F=[1 0 0;0 1 0;tx ty 1]
K=maketform('affine',F);
L=imtransform(img_in,K,'XData',[1 (size(img_in,2)+F(3,1))],'YData',[1 (size(img_in,1)+F(3,2))],'FillValues',[0;0;100]);
img_out = L;
%figure(1),imshow(L)