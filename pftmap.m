function [pftmap] = pft(rgb) % [row,col,page] =size(rgb); 
rgb = cat(3,rgb,rgb,rgb);
gimg = rgb2gray(rgb);%����ɫͼ��תΪ�Ҷ�ͼ�� 
F = fft2(gimg);%�ԻҶ�ͼ����ж�ά��ɢ����Ҷ�任 
amp = abs(F);%�õ���ֵͼ�� 
ph = angle(F);%�õ���λͼ 
s = ifft2(1 * exp(1i*ph));%�������ֵͼ�񲿷֣�ֻ����λ�׽��ж�ά��ɢ����Ҷ���任 
filt = fspecial('gaussian', [3 3]);%��׼��Ϊsigma�Ķ�ά��˹�˲����� 
Pftmap = mat2gray(imfilter(abs(s).*abs(s), filt, 'circular')); 
pftmap = mat2gray(Pftmap);%��һ�� 
end

