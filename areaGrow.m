clear all
%% load image and translate to gray
global img
img = imread('src/twoCircle.bmp');
img = sum(img, 3) / 3;
figure(1)
subplot(1,2,1)
imshow(img,[0, 255])
title('原图像')
%% select seed by click
if( exist('x','var') == 0 && exist('y','var') == 0)  
    [y,x] = getpts;%鼠标取点  回车确定  
    x1 = round(x(1));
    y1 = round(y(1));
    x2 = round(x(2));  
    y2 = round(y(2));
end
%% grow
global resultImg
global stack
% resultImg = zeros(size(img));
resultImg = img;

stack = [[-1; -1], [-1; -1]];
push(x1, y1);
exist = nearestPoint(3);
while(length(stack) ~= 2 || exist)
        exist = nearestPoint(3);
end

stack = [[-1; -1], [-1; -1]];
push(x2, y2);
exist = nearestPoint(2);
while(length(stack) ~= 2 || exist)
        exist = nearestPoint(2);
end

subplot(1,2,2)
imshow(resultImg,[0, 256])
title('结果图')

%% add point by N4
function exist = nearestPoint(threshold)
    global img
    global resultImg
    global stack
    exist = 0;

    temp = stack(:, length(stack));
    x = temp(1); y = temp(2);

    current = img(x, y);
    if(x ~= 1 && resultImg(x-1,y) ~= 256 && abs(img(x-1,y)-current) < threshold)
        push(x-1, y);
        exist = 1;
    end
    if(x ~= 576 && resultImg(x+1,y) ~= 256 && abs(img(x+1,y)-current) < threshold)
       push(x+1,y);
       exist = 1;
    end
    if(y ~= 1 && resultImg(x,y-1) ~= 256 && abs(img(x, y-1)-current) < threshold)
        push(x, y-1);
        exist = 1;
    end
    if (y ~= 593 && resultImg(x,y+1) ~= 256 && abs(img(x, y+1)-current) < threshold)
        push(x, y+1);
        exist = 1;
    end
    if (~exist)
       pop(); 
    end
end

%% stack operation 
function pop()
    global stack
    stack = stack(:, 1:length(stack)-1); 
end

function push(x, y)
    global stack
    global resultImg
    stack = [stack, [x; y]];
    resultImg(x, y) = 256;
end