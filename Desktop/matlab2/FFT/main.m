%clc 
%clear all

% A = [100,100,150,100;
%      100,150,120,120;
%      120,150,120,150;
%      100,150,150,150]
% B = [1, 1, 1, 1;
%      1,-1i,-1,1i;
%      1,-1, 1,-1;
%      1,1i,-1,-1i]
% C = randi(15,3,5);
% D = randi(25,3,5);
%  
% x=[10]
% for i = 1:5
%     x = i^2
% end
% 
% 
% A = [ 1 2; 3 4];
% B = [ 5 6; 7 8];
% C = cat(3,A,B)

im = rgb2gray(imread('lena.jpg'));
impad = padarray(im,[40 40], 'symmetric', 'post');

imshow(impad);
A = impad(y:y+3,x:x+3);






