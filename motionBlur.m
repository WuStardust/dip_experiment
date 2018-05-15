clear all
%% read image and transform to gray
img = imread('./src/motionBlur.bmp');
img = sum(img, 3) / 3;
subplot(151)
imshow(img, [])
title('ԭͼ��')

%% 
resultImg = zeros(size(img));
ImgD = zeros(size(img));
for i=2:279
    ImgD(:, i) = img(:, i) - img(:, i-1);
end

ImgD(:,2) = 0;
subplot(152)
imshow(ImgD, [])
title('���ͼ')

for i=1:279
    if(i<=18)
        resultImg(:,i) = ImgD(:, i);
    else
        resultImg(:,i) = ImgD(:,i) + resultImg(:,i-16);
    end
end

subplot(153)
imshow(resultImg, [])
title('��ԭͼ(d=16)')

for i=1:279
    if(i<=18)
        resultImg(:,i) = ImgD(:, i);
    else
        resultImg(:,i) = ImgD(:,i) + resultImg(:,i-18);
    end
end

subplot(154)
imshow(resultImg, [])
title('��ԭͼ(d=18)')

subplot(155)
imshow(ImgD, [0,10])
title('���ͼ�Ҷȱ任��')