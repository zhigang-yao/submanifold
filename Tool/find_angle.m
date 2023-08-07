function theta=find_angle(x,y)

normx = norm(x);
normy = norm(y);
normxy = sum(x.*y);

xy = normxy/(normx * normy);
if (abs(xy) > 1)
    xy = round(xy);
end

theta= acos(xy);

end