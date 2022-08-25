function qpftmap = qpftmap(rgb, sigma )%-1 %四元傅里叶相位谱显著性检测 
[row ,col, page] = size(rgb); %计算四元数 
rgb = cat(3,rgb,rgb,rgb);
r = double(rgb(:,:,1)); 
g = double(rgb(:,:,2)); 
b = double(rgb(:,:,3));%r红通道g绿通道b蓝通道 
R = r - (g + b)/2; %调整后的红色通道 
G = g - (r + b)/2; %调整后的绿色通道 
B = b - (r + g)/2; %调整后的蓝色通道 
Y = (r + g)/2 - (abs(r - g))/2 - b;%黄色通道 
u1=1;%I 
u2=1;%RG 
RG = R - G;%红/绿对立神经元 
BY =B - Y;%蓝/黄对立神经元 
I1 = ((r+g+b)./3).*u1;%-0 计算亮度特征 
%I0=rgb2gray(rgb); 
%I1=grayslice(I0,64); 
%I1=double(I1); 
%level = graythresh(I0); %OTSU阈值确定-1 
%I1=im2bw(I0,level); %转为二值图像-1 
M = zeros(row, col); %创建一个全0数组（运动特征） %定义加权四元数表示如下 
f1 = M + RG * 1i; 
f2 = BY + I1* 1i; %进行傅里叶变换 
F1 = fft2(f1); 
F2 = fft2(f2); 
phaseQ1 = angle(F1);%得到相位谱 
phaseQ2 = angle(F2);%得到相位谱 
ifftq1 = ifft2(exp(phaseQ1 * 1i));%对相位谱进行傅里叶反变换 
ifftq2 = ifft2(exp(phaseQ2 * 1i));%对相位谱进行傅里叶反变换 
absq1 = abs(ifftq1);%得到幅值图像 
absq2 = abs(ifftq2);%得到幅值图像 
squareq=(absq1+absq2).*(absq1+absq2); 
L = fspecial('gaussian', [5 5], sigma);%标准差为sigma的二维高斯滤波算子 
Squareq = mat2gray(imfilter(squareq, L, 'circular'));%L表示标准差为sigma的二维高斯滤波器 
qpftmap = mat2gray(Squareq);%最终显著图为归一化后的二维矩阵 
end


