function [ fvector ] = scanningwindows( A,m,n,s )
% SCANNINGWINDOWS
% A is matrix; m and n represent the window size; 
% s represents the stride by which the widows move;
DEBUG =0;
an=size(A);
imax = length(1:s:(an(1)-m+1));
jmax = length(1:s:(an(2)-n+1));
fvector = zeros(2,imax*jmax);
x_c = 0;
y_c = 0;
for i = 1:s:(an(1)-m+1)
    y_c = y_c + 1;
    x_c = 0;
    for j = 1:s:(an(2)-n+1)
        x_c = x_c + 1;   
        tmp = A(i:i+m-1,j:j+n-1);
        %mean= mean(mean(tmp));
        %variance = var(var(A,1),1);
        fvector1 = [mean(tmp(:)); var(tmp(:),1)];
        fvector(:,(y_c-1)*jmax+x_c) = fvector1;
           
    end
end
if DEBUG
       disp('scanningwindows:')
        fvector
end
end