function [ cost ] = evalCost( population, in_img, save, savename )
%EVALCOST Takes population and returns cost per initialisation

if nargin == 2
    save = 0;
    savename = [];
end    


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
%            size(in_img(:,:,i))
       end
       gr = conv2(double(in_img(:,:,i)),Gr,'same');    % Remove 'valid' for zero padding
       gi = conv2(double(in_img(:,:,i)),Gi,'same');
       if DEBUG
           disp('evalCost: Magnitude')
       end
       m = magnitude(gr, gi);
       if DEBUG
           disp('evalCost: Smoothing')
       end
       s = smoothing(m, 7, 7);
       
%        if DEBUG
%            figure(1);
%            imshow( (Gr-min(min(Gr)))/(max(max(Gr))-min(min(Gr))) );
%            title('Real part of Gabor Filter (normalised)');
%            figure(2);
%            imshow( (gr-min(min(gr)))/(max(max(gr))-min(min(gr))) );
%            title('Filter output (normalised)');           
%            figure(3);
%            imshow( (m-min(min(m)))/(max(max(m))-min(min(m))) );
%            title('Magnitude output (normalised)');
%        end

       if DEBUG
            disp('evalCost: Scanning')
       end

       f_s = size(Gr);
       if i == 1
            X1 = scanningwindows(s, f_s(1), f_s(2), 5);    % Stride (argument no. 4) is changeable
            [tmpY,tmpC] = C_Y_of_X(X1);
       else if i == 2
            X2 = scanningwindows(s, f_s(1), f_s(2), 5);
            [tmpY,tmpC] = C_Y_of_X(X2);
           end
       end
       Y = [Y tmpY];
       C = [C tmpC];
   end

   if save == 1
       if DEBUG
        disp('evalCost: Scattering')
       end

       figure(4)
       scatter(X1(1,:),X1(2,:),'b','o');
       hold on
       scatter(X2(1,:),X2(2,:),'r','x');
       title('Scatter plot of mean vs variance');
       hold off
       if DEBUG
           disp('evalCost: Saving scatter plot')
       end
       saveas(4,savename);
   end
   
   if DEBUG
       Y
       C
   end
   
   d = (Y(1)-Y(2))'*(Y(1)-Y(2));
   s = max(C);
   cost(pop) = d/s;
   
end   

end

