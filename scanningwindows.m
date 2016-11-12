% A is matrix; m and n represent the window size; 
% s represents the stride by which the widows move;

function [ fvector ] = scanningwindows( A,m,n,s )
an=size(A);
fvector = [];
for i = 1:s:(an(1)-m+1)
     for j = 1:s:(an(2)-n+1)
           tmp = A(i:i+m-1,j:j+n-1);
           %mean= mean(mean(tmp));
           %variance = var(var(A,1),1);
           fvector1 = [mean(tmp(:)); var(tmp(:),1)];
           fvector = [fvector fvector1];
               
     end
end    
end