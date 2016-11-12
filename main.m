%% External driver script

% limits of search space
%       mu_x, mu_y, sigma_x, sigma_y, fx, fy, theta, phase
sMin = [  -1,   -1,       2,       2,  1,  1,     0,    0]';
sMax = [   1,    1,      100,    100, 10, 10,    pi,   pi]';
population_size = 5;
radius=1;
nRRI=1;
nRLC=1;
maxItr=5;
files = {'D51.gif', 'D96.gif'};
num_gabor = 1;

% x = zeros(maxItr);
% y = zeros(maxItr);
[x,y] = stochasticSearch( sMin,sMax,population_size,radius,nRRI,nRLC,maxItr,files )