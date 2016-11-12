function [ Y, C ] = C_Y_of_X( X )
%C_Y_of_X Get centroid and determinant of 
%    covariance matrix of X
%    X assumed to be of size (2 x NoOfPatches)

Y = sum(X,2)/size(X,2);
newX = X - repmat(Y,1,size(X,2));

Cmat = newX * newX';
C = det(Cmat);

end

