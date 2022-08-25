function [O] = normalize(M)
%NORMALIZE 此处显示有关此函数的摘要
%   此处显示详细说明
ymax=1;ymin=0;
xmax=max(max(M));
xmin=min(min(M));
O=(ymax-ymin)*(M-xmin)/(xmax-xmin)+ymin;
end

