%% BCT

%
%

%im = imread('lena.jpg');


function out = btc(im,bs) 
    
    [height,width] = size(im);
    %impad = im;
    impad = padarray(im,[bs-1 bs-1], 'symmetric','post');%�Ϥ��X�i��bs������
    out = zeros(height,width,'uint8');
    %im2uint8(out);
    m = bs*bs;
        
%     a = mean(im) - std(im)*sqrt( q/(m-q) );
%     b = mean(im) + std(im)*sqrt( (m-q)/q );
%     
%     g = im>mean(im);
%     ind = zeros[height,weight];

    for j=1:4:height
        for i=1:4:width
            
            lag = impad(j:j+3,i:i+3);
            u = mean(lag(:));
            % lag = double(lag(:));
            s = std(double(lag(:)),1);% 0 = /n-1, 1 = /n
           
            temp = lag>=u; %�p�G��>���ܷ|����l�ܦ��¦� �]��temp matrix�ܥ����s
            q = sum(temp(:));
            a = round( u - s*sqrt( q/(m-q) ));
            b = round( u + s*sqrt( (m-q)/q ));
            out(j:j+3,i:i+3) = temp.*b + ~temp .* a;
        end
    end
        
            


