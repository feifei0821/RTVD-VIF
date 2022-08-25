function y=nsct_fuse(I1,nlevels)
%    NSCT
%    Input:
%    I1 - input image A
%    I2 - input image B
%    nlevels - number of directions in each decomposition level ÿ���ֽ⼶��ķ�����
%    Output:
%    y  - fused image   
%
%    The code is edited by Yu Liu, 01-09-2014.


%nlevels = [2,3,3,4] ;       
pfilter = 'pyrexc' ;              
dfilter = 'vk' ; 
 
I1=double(I1);
coeffs_1 = nsctdec( I1, nlevels, dfilter, pfilter ); %���²����������任�ֽ�


    
y= coeffs_1;


