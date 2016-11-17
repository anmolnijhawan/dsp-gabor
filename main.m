%% External driver script
DEBUG = 1;
% limits of search space
%       mu_x, mu_y, sigma_x, sigma_y, fx, fy, theta, phase
sMin = [  -1,   -1,     0.5,     0.5,  1,  1,     0,    0]';
sMax = [   1,    1,      50,      50, 10, 10,    pi,   pi]';
population_size = 3;
radius=1;
nRRI=1;
nRLC=1;
maxItr=1;
files = {'D51.gif', 'D96.gif'};
num_gabor = 1;

if DEBUG
    disp('main: Calling stochasticSearch with params:')
    sMin,sMax,population_size,radius,nRRI,nRLC,maxItr,files    
end

mkdir('best');

joint_best_pop = stochasticSearch( sMin,sMax,population_size,radius,nRRI,nRLC,maxItr,files );
filename = sprintf('population_variation_%s.mat',datestr(clock,'dd_HH_MM_SS'));
save(filename);
