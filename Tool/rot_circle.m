function [points_rot, points] = rot_circle(v,r)
%   Detailed explanation goes here

theta = asin(r/1); % angel between v and vector connecting points on the cicle 


phi = 0:0.01:(2*pi); % sample equal distant phi on the circle

 
points = zeros(3,length(phi));


for i=1:length(phi)

   % get cart coordinates
   [points(1,i), points(2,i), points(3,i)] = sph2cart(phi(i),(pi/2-theta),1);
      
end


b=[0 0 1]' ;
rot_M = rotMat(b,v);

points_rot = rot_M*points; % rotate points on the circle

end

