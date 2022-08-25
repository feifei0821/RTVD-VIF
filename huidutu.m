clear all;
close all;
clc;

[imagename1 imagepath1]=uigetfile('C:\Users\li\Desktop\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    
%[imagename2 imagepath2]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
%image_input2=imread(strcat(imagepath2,imagename2));

I = rgb2gray(image_input1);
imwrite(I,'C:\Users\li\Desktop\data\huidutu\27.png','png');
