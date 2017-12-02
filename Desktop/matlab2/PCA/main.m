%%
%?每一?片矩??化?一?n?列向量，?所有?片??的列向量?成一??有所有?本?片的矩?
Img_Mat = [ ];
for i = 1:num_img     %num_img??本空??片的?量
    str = strcat(tran_path,'\face',int2str(i),'.bmp');
    temp_mat = imread(str);
    [r c] = size(temp_mat);
    temp_mat = reshape(temp_mat,r*c,1);   %??片?化?一?列向量
    Img_Mat = [Img_Mat temp_mat];
end
%%

%得到矩?A后，求取矩?A中每一行的平均值，并使矩?A每一行都?去??行的平均值，因?矩?中都是?于?像灰度的信息，所以可以不用除以?准差Img_Mat = double(Img_Mat);
differ_mat = bsxfun(@minus, Img_Mat, mean(Img_Mat,2));

%%
L_Mat = (differ_mat' * differ_mat);
[eiv eic] = eig(L_Mat);   %求取特征向量eiv以及特征值eic

L_eig_vec = [ ];
for i = 1:size(eiv)
    if (eic(i,i) > 1)
        L_eig_vec = [L_eig_vec eiv(:,i)];    %?取特征值大于1的特征向量
    end
end

Ei_Face = differ_mat * L_eig_vec;     %得到?方差矩?的特征向量?成的投影子空?

%%
%建立完特征?之后，人???就?得??明朗很多了，?我?把?有?本空?中所有?片的矩?A投射到特征?空?U中，每一?人??片都?得到??特征?加??，可以理解?特征?空?中坐?值。投影公式?：U^{T}A。相?程序如下：

project_sample = [ ];
project_sample = Ei_Face' * differ_mat;

%Image_Mat原圖 project_sample降維後 差了152倍


%%
%?要??的?片再投影到特征?空?中得到??的加?列向量，然后再?其一一??本照片矩?投影的加?矩?列向量求取?式距离，距离最短的便可以??是同一?人物

%************投影被???片***************************
project_test = [ ];
str = strcat(test_path,'\test1.bmp');
temp_mat = imread(str);
figure,imshow(temp_mat);
title('Test Image');
temp_mat = reshape(temp_mat,r*c,1);
temp_mat = double(temp_mat) - img_mean;
project_test = Ei_Face' * temp_mat;

%*********************算取?式距离**************************
com_dist = [ ];
for i = 1:size(project_sample,2)
    vec_dist = norm(project_test - project_sample(:,i));
    com_dist = [com_dist vec_dist];
end

%***********************??出距离最小的?本?片*************
[match_min,match_index] = min(com_dist);
str = strcat(tran_path,'\face',int2str(match_index),'.bmp');
recognize_img = imread(str);
figure,imshow(recognize_img);
title('Recognized Image');