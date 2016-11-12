function [ cost ] = evalCost( population, in_img )
%EVALCOST Takes population and returns cost per initialisation
    
DEBUG = 1;
cost = zeros(size(population,2),1);

for pop = 1:size(population,2)
   if DEBUG
       disp('evalCost: Creating gabor filter')
       pop
   end
   [Gr,Gi] = build_gabor_kernel(population(:,pop));
   
   Y = [];
   C = [];
   
   for i = 1:size(in_img,3)
       if DEBUG
           disp('evalCost: Applying gabor filter')
           i
           size(Gr)
           size(in_img(:,:,i))
       end
       gr = imfilter(double(in_img(:,:,i)),Gr);
       gi = imfilter(double(in_img(:,:,i)),Gi);
       if DEBUG
           disp('evalCost: Magnitude')
       end
       m = magnitude(gr, gi);
       if DEBUG
           disp('evalCost: Smoothing')
       end
       s = smoothing(m, 7, 7);
       
       if DEBUG
%            size(gr)
%            size(m)
%            size(s)
           figure(1);
           imshow( (gr-min(min(gr)))/(max(max(gr))-min(min(gr))) );           
           figure(2);
           imshow( (m-min(min(m)))/(max(max(m))-min(min(m))) );
           figure(3);
           imshow( (s-min(min(s)))/(max(max(s))-min(min(s))) );
%            pause(5);
           
       end
       if DEBUG
            disp('evalCost: Scanning')
       end
       if i == 1
            X1 = scanningwindows(s, 7, 7, 5);
            [tmpY,tmpC] = C_Y_of_X(X1);
       else if i == 2
            X2 = scanningwindows(s, 7, 7, 5);
            [tmpY,tmpC] = C_Y_of_X(X2);
           end
       end
       Y = [Y tmpY];
       C = [C tmpC];
   end
   if DEBUG
       disp('evalCost: Scattering')
   end
   figure(4)
   scatter(X1(1,:),X1(2,:));
   hold on
   scatter(X2(1,:),X2(2,:));
   hold off
   if DEBUG
       Y
       C
   end
   d = (Y(1)-Y(2))'*(Y(1)-Y(2));
   s = max(C);
   cost(pop) = d/s;
   
end   

end

