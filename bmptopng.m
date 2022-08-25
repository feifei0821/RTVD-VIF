clear all;
close all;
clc;

[imagename1 imagepath1]=uigetfile('C:\Users\li\Desktop\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    
[imagename2 imagepath2]=uigetfile('C:\Users\li\Desktop\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));    


imwrite(image_input1,'C:\Users\li\Desktop\data\huidutu\36.png','png');
imwrite(image_input2,'C:\Users\li\Desktop\data\huidutu\37.png','png');