function [srmap] = sr(rgb, sigma) %计算利用最基本普残差得到显著图，即不包含颜色亮度分量等特征 
rgb = cat(3,rgb,rgb,rgb);
F = fft2(rgb2gray(rgb));%将彩色图像转为灰度图像（即亮度）后进行二维离散傅立叶变换 
Af = abs(F);%对傅立叶变换结果取绝对值（即求变换后图像的幅度图像） 
Pf = angle(F);%求变换后图像的相位谱图像 
Lf = log(Af);%得到幅度值的Log谱 
filt = fspecial('average', 3);%创建局部平均滤波算子[3，3]为默认尺寸 %circular'图像大小通过将图像看成是一个二维周期函数的一个周期来扩展 
Rf = Lf - imfilter(Lf, filt, 'circular');% 幅度值的Log谱-局部平均滤波器进行平滑处理后的Log谱得到普残差 
srmap = ifft2((exp(Rf+i*Pf)));%将相位谱和谱残差进行二维傅立叶反变换得到显著图 
srmap = abs(srmap);%取上面计算图像的幅值部分即位显著图（saliency map) 
srmap = srmap .^ 2;%将显著图矩阵中各个元素平方，即为进行二维卷积运算，利用了“复数和它的共轭复数的乘积是复数模的平方”这一结论 
srmap = mat2gray(imfilter(srmap, fspecial('gaussian',[3 3], sigma)));%对处理后的显著图进行滤波（高斯低通滤波尺寸为[3，3]，Sigma为滤波器的标准差），然后归一化 
end

