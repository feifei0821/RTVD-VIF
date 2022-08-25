function [pftmap] = pft(rgb) % [row,col,page] =size(rgb); 
rgb = cat(3,rgb,rgb,rgb);
gimg = rgb2gray(rgb);%将彩色图像转为灰度图像 
F = fft2(gimg);%对灰度图像进行二维离散傅里叶变换 
amp = abs(F);%得到幅值图像 
ph = angle(F);%得到相位图 
s = ifft2(1 * exp(1i*ph));%不加入幅值图像部分，只对相位谱进行二维离散傅里叶反变换 
filt = fspecial('gaussian', [3 3]);%标准差为sigma的二维高斯滤波算子 
Pftmap = mat2gray(imfilter(abs(s).*abs(s), filt, 'circular')); 
pftmap = mat2gray(Pftmap);%归一化 
end

