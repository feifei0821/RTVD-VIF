function qpftmap = qpftmap(rgb, sigma )%-1 %��Ԫ����Ҷ��λ�������Լ�� 
[row ,col, page] = size(rgb); %������Ԫ�� 
rgb = cat(3,rgb,rgb,rgb);
r = double(rgb(:,:,1)); 
g = double(rgb(:,:,2)); 
b = double(rgb(:,:,3));%r��ͨ��g��ͨ��b��ͨ�� 
R = r - (g + b)/2; %������ĺ�ɫͨ�� 
G = g - (r + b)/2; %���������ɫͨ�� 
B = b - (r + g)/2; %���������ɫͨ�� 
Y = (r + g)/2 - (abs(r - g))/2 - b;%��ɫͨ�� 
u1=1;%I 
u2=1;%RG 
RG = R - G;%��/�̶�����Ԫ 
BY =B - Y;%��/�ƶ�����Ԫ 
I1 = ((r+g+b)./3).*u1;%-0 ������������ 
%I0=rgb2gray(rgb); 
%I1=grayslice(I0,64); 
%I1=double(I1); 
%level = graythresh(I0); %OTSU��ֵȷ��-1 
%I1=im2bw(I0,level); %תΪ��ֵͼ��-1 
M = zeros(row, col); %����һ��ȫ0���飨�˶������� %�����Ȩ��Ԫ����ʾ���� 
f1 = M + RG * 1i; 
f2 = BY + I1* 1i; %���и���Ҷ�任 
F1 = fft2(f1); 
F2 = fft2(f2); 
phaseQ1 = angle(F1);%�õ���λ�� 
phaseQ2 = angle(F2);%�õ���λ�� 
ifftq1 = ifft2(exp(phaseQ1 * 1i));%����λ�׽��и���Ҷ���任 
ifftq2 = ifft2(exp(phaseQ2 * 1i));%����λ�׽��и���Ҷ���任 
absq1 = abs(ifftq1);%�õ���ֵͼ�� 
absq2 = abs(ifftq2);%�õ���ֵͼ�� 
squareq=(absq1+absq2).*(absq1+absq2); 
L = fspecial('gaussian', [5 5], sigma);%��׼��Ϊsigma�Ķ�ά��˹�˲����� 
Squareq = mat2gray(imfilter(squareq, L, 'circular'));%L��ʾ��׼��Ϊsigma�Ķ�ά��˹�˲��� 
qpftmap = mat2gray(Squareq);%��������ͼΪ��һ����Ķ�ά���� 
end


