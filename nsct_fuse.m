function y=nsct_fuse(I1,nlevels)
%    NSCT
%    Input:
%    I1 - input image A
%    I2 - input image B
%    nlevels - number of directions in each decomposition level 每个分解级别的方向数
%    Output:
%    y  - fused image   
%
%    The code is edited by Yu Liu, 01-09-2014.


%nlevels = [2,3,3,4] ;       
pfilter = 'pyrexc' ;              
dfilter = 'vk' ; 
 
I1=double(I1);
coeffs_1 = nsctdec( I1, nlevels, dfilter, pfilter ); %非下采样轮廓波变换分解


    
y= coeffs_1;


