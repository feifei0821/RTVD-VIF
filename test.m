clear all;
close all;
clc;
addpath(genpath('nsct_toolbox'));

[imagename1 imagepath1]=uigetfile('E:\images and code\lunwenziliao\code\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    
[imagename2 imagepath2]=uigetfile('E:\images and code\lunwenziliao\code\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));

%image_input1= imread('11.png'); image_input2 = imread('12.png');

figure;imshow(image_input1);
figure;imshow(image_input2);

%if size(image_input1)~=size(image_input2)
%    error('two images are not the same size.');
%end

%M1=xianzhu(image_input1);
%M2=xianzhu(image_input2);
tic
M1=srmap(image_input1,0.8);
M2=srmap(image_input2,0.8);

%M1=pftmap(image_input1);
%M2=pftmap(image_input2);

%M1=qpftmap(image_input1,0.8);
%M2=qpftmap(image_input2,0.8);


O1 = normalize(M1);
O2 = normalize(M2);
%figure, imshow(O1), figure, imshow(O2);

%相对总变差分解
S1 = tsmooth(image_input1,0.001,1);
S2 = tsmooth(image_input2,0.001,1);

%高斯滤波分解
% gausFilter = fspecial('gaussian',[5 5],10);
% S1 = imfilter(image_input1,gausFilter,'replicate');
% S2 = imfilter(image_input2,gausFilter,'replicate');
% S1=double(S1)./255;
% S2=double(S2)./255;

%双边滤波分解
% S1 = bilateralFilter(image_input1);
% S2 = bilateralFilter(image_input2);
% figure, imshow(S1), figure, imshow(S2);

% [S1 S2]=nsct_fuse(image_input1,image_input2,2);
% S1 = nsct_fuse(image_input1,4);
% S2 = nsct_fuse(image_input2,4);
% S1=S1{1}./255;
% S2=S2{1}./255;

A=double(image_input1)./255;
B=double(image_input2)./255;

T1=A-S1;
T2=B-S2;
%X1=A-O1;
%X2=B-O2;
%figure, imshow(T1), figure, imshow(T2);

%F1=T1+S1;
%F2=T2+S2;
%figure, imshow(F1), figure, imshow(F2);

%q = guidedfilter(I, p, r, eps);

%F_m=max(X1,X2);
%F_m=max(T1,T2);
w1=O1./(O1+O2);
w2=O2./(O1+O2);
%figure, imshow(w1);figure, imshow(w2);
F_m=T1.*w1+T2.*w2;

%weight1 = Visual_Weight_Map(image_input1);
%weight2 = Visual_Weight_Map(image_input2);
%F_m = (0.5+0.5*(weight1-weight2)).*T1 + (0.5+0.5*(weight2-weight1)).*T2;

% Lis method 
  %	um = 3;
    % first step
  %	b1 = ordfilt2(abs(es2(X1, floor(um/2))), um*um, ones(um));
  %	b2 = ordfilt2(abs(es2(X2, floor(um/2))), um*um, ones(um));
    % second step
  %	mm = (conv2(double((b1 > b2)), ones(um), 'valid')) > floor(um*um/2);
  %	F_m  = (mm.*X1) + ((~mm).*X2);
%figure, imshow(F_m);

%F_s=S1.*(O1./(O1+O2))+S2.*(O2./(O1+O2));
%F_s=S1.*O1+S2.*(1-O1);

%m1 = abs(S1);
%m2 = abs(S2);
%F_s=max(m1,m2);

%F_s=max(S1,S2);
%F_s=0.8*S1+0.2*S2;
       
  	% Lis method 
  	%um = 3;
    % first step
  	%a1 = ordfilt2(abs(es2(A, floor(um/2))), um*um, ones(um));
  	%a2 = ordfilt2(abs(es2(B, floor(um/2))), um*um, ones(um));
    % second step
  	%mm = (conv2(double((a1 > a2)), ones(um), 'valid')) > floor(um*um/2);
  	%F_s  = (mm.*S1) + ((~mm).*S2);
    
   % Burts method 
  	um = 3; th = .7;
  	% compute salience 计算显著性
  	a1 = conv2(es2(S1.*S1, floor(um/2)), ones(um), 'valid'); 
  	a2 = conv2(es2(S2.*S2, floor(um/2)), ones(um), 'valid'); 
  	% compute match 
  	MA = conv2(es2(S1.*S2, floor(um/2)), ones(um), 'valid');
  	MA = 2 * MA ./ (a1 + a2 + eps);
    figure
    imshow(MA);
  	% selection 
    m1 = MA > th; m2 = a1 > a2; 
    w1 = (0.5 - 0.5*(1-MA) / (1-th));
    w2 = 1-w1;
%     w1 = 0.5;
%     w2 = 1-w1;
%     figure, imshow([w1 w2]);
    F_s  = (~m1) .* ((m2.*S1) + ((~m2).*S2));
    F_s  = F_s + (m1 .* ((m2.*S1.*(1-w1))+((m2).*S2.*w1) + ((~m2).*S2.*(1-w1))+((~m2).*S1.*w1))); 
    
% F_s=0.5*S1+0.5*S2;
% figure, imshow(F_s);

% m1 = abs(A);
%    m2 = abs(B);
%    if(m1>m2)
%   R=m1;
%    else
%    R=m2;
%    end
%    Emax = max(R(:));
%   P = R/Emax;
% 
%    C = atan(30*P)/atan(30);
%   	F_s = (C.*S1) + ((1-C).*S2);
  
  
%weight1 = Visual_Weight_Map(image_input1);
%weight2 = Visual_Weight_Map(image_input1);
%F_s = (0.5+0.5*(weight1-weight2)).*S1 + (0.5+0.5*(weight2-weight1)).*S2;
%F_s = weight1.*S1 + weight2.*S2;
   %figure, imshow(F_s);

figure
imshow([S1 S2 F_s]);

figure
imshow([T1*10 T2*10 F_m*10]);
    
    
F=F_m+F_s;
toc
figure, imshow(F);
%imwrite(F,'C:\Users\li\Desktop\data\jieguo\max.png','png');

imwrite(S1,'imgs\nalta_0.0015_ir.png');
imwrite(S2,'imgs\nalta_0.0015_vs.png');
imwrite(F_s,'imgs\nalta_0.0015_f.png');
imwrite(F,'imgs\nalta_0.0015.png');

