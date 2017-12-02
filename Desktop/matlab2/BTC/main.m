%clc
%clear all

%%
%----------BTC----------------
im = rgb2gray(imread('lena.jpg'));
bs = 7;%block size 

Imout = btc(im,bs);
imshow(Imout);

% if bs <= 4 會出現雜訊 why?





