function [O] = normalize(M)
%NORMALIZE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
ymax=1;ymin=0;
xmax=max(max(M));
xmin=min(min(M));
O=(ymax-ymin)*(M-xmin)/(xmax-xmin)+ymin;
end

