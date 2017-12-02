% VQ lbg

%%
%----------training codebook-----------
%clc
%clear all
% 
% I = rgb2gray( imread('czech10.jpg') );
% I = double(I);
% cb_size = 32;
% block_size = 4;
% %cb = zeros(block_size^2 , cb_size); % 第一次設定cb
% pool = im2col(I,[block_size , block_size] , 'sliding');
% [m,n] = size(pool);
% order = randperm(n);
% cb(:) = pool (: , order(1:cb_size));
% 
% index = zeros(1,n);
% for i = 1:9
%     for i = 1 : n
%         temp = repmat(pool(:,i) ,1,  cb_size);% same size with the code book
%         [val,ind] = min ( sum((temp-cb).^2) );
%         index(i) =  ind; 
%     end
%     order = 1:n;
%     for i = 1:cb_size
%         cb(:,i) = round( mean(pool(:,order(index==i))')' );%第二次轉置是因為要符合cb的格式
%     end
% end
% 
% save cb cb

%%
%input test image and decode
load cb
% 
cb_size = 32;
block_size = 4;
I = rgb2gray( imread('cat2.jpg') );
I = double(I);

pool_en = im2col(I,[block_size block_size], 'distinct');

[m,n] = size(I);

index = zeros(floor(m/block_size),floor(n/block_size)); 
for i= 1:numel(index)
    temp = repmat(pool_en(:,i),1,cb_size);
    [val,ind] = min( sum((temp-cb).^2));
    index(i) = ind;
end

pool_de = cb(:,index(:));%index大小的用cb做出來的矩陣
I2 = uint8(col2im(pool_de,[block_size block_size],[m,n],'distinct'));%把矩陣轉成圖片格式
imshow(I2)
I = uint8(I);
psnr(I,I2) %PSNR值越大，就代表失真越少











