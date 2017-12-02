%%
%?�C�@?���x??��?�@?n?�C�V�q�A?�Ҧ�?��??���C�V�q?���@??���Ҧ�?��?�����x?
Img_Mat = [ ];
for i = 1:num_img     %num_img??����??����?�q
    str = strcat(tran_path,'\face',int2str(i),'.bmp');
    temp_mat = imread(str);
    [r c] = size(temp_mat);
    temp_mat = reshape(temp_mat,r*c,1);   %??��?��?�@?�C�V�q
    Img_Mat = [Img_Mat temp_mat];
end
%%

%�o��x?A�Z�A�D���x?A���C�@�檺�����ȡA�}�ϯx?A�C�@�泣?�h??�檺�����ȡA�]?�x?�����O?�_?���ǫת��H���A�ҥH�i�H���ΰ��H?��tImg_Mat = double(Img_Mat);
differ_mat = bsxfun(@minus, Img_Mat, mean(Img_Mat,2));

%%
L_Mat = (differ_mat' * differ_mat);
[eiv eic] = eig(L_Mat);   %�D���S���V�qeiv�H�ίS����eic

L_eig_vec = [ ];
for i = 1:size(eiv)
    if (eic(i,i) > 1)
        L_eig_vec = [L_eig_vec eiv(:,i)];    %?���S���Ȥj�_1���S���V�q
    end
end

Ei_Face = differ_mat * L_eig_vec;     %�o��?��t�x?���S���V�q?������v�l��?

%%
%�إߧ��S��?���Z�A�H???�N?�o??���ԫܦh�F�A?��?��?��?����?���Ҧ�?�����x?A��g��S��?��?U���A�C�@?�H??����?�o��??�S��?�[??�A�i�H�z��?�S��?��?����?�ȡC��v����?�GU^{T}A�C��?�{�Ǧp�U�G

project_sample = [ ];
project_sample = Ei_Face' * differ_mat;

%Image_Mat��� project_sample������ �t�F152��


%%
%?�n??��?���A��v��S��?��?���o��??���[?�C�V�q�A�M�Z�A?��@�@??���Ӥ��x?��v���[?�x?�C�V�q�D��?���Z�áA�Z�ó̵u���K�i�H??�O�P�@?�H��

%************��v�Q???��***************************
project_test = [ ];
str = strcat(test_path,'\test1.bmp');
temp_mat = imread(str);
figure,imshow(temp_mat);
title('Test Image');
temp_mat = reshape(temp_mat,r*c,1);
temp_mat = double(temp_mat) - img_mean;
project_test = Ei_Face' * temp_mat;

%*********************���?���Z��**************************
com_dist = [ ];
for i = 1:size(project_sample,2)
    vec_dist = norm(project_test - project_sample(:,i));
    com_dist = [com_dist vec_dist];
end

%***********************??�X�Z�ó̤p��?��?��*************
[match_min,match_index] = min(com_dist);
str = strcat(tran_path,'\face',int2str(match_index),'.bmp');
recognize_img = imread(str);
figure,imshow(recognize_img);
title('Recognized Image');