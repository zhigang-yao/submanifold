% Generate data points on a cylinder surface with some noise
rng default; % Set random number generator to default state
t = -2*pi:0.001*pi:2*pi;
t(end) = [];
N = length(t);
sig = 0.1; % Noise standard deviation 
x = cos(t); 
y = sin(t);
z = t/8; 
sample_ = [x;y;z]; % Noise-free data
sample = sample_; 

% Add gaussian noise to points
Err = zeros(1,N);  
for ii = 1:N
    err = sig*randn(1); % Sample noise
    Err(ii) = err;
    vec_ii = sample_(:,ii);
    vec_normal = [ vec_ii(1)  vec_ii(2) 0]; % Surface normal
    sint = sin(t(ii)); cost = cos(t(ii));
    vec_tan = [-sint; cost; 1/4]; % Tangent vector
    dir = null([vec_ii vec_tan]'); % Orthogonal direction
    dir = dir/norm(dir); 
    sample(:,ii) = vec_ii + err*dir; % Add noise
    sample(:,ii) = sample(:,ii)/norm(sample(1:end-1,ii)); % Normalize
end

% Remove outliers
sample(:, abs(Err)>sig) = [];  
sample_(:, abs(Err)>sig) = [];

% Plot cylinder surface 
[X,Y,Z] = cylinder; h = 2; Z = Z*h - 1;
surf(X,Y,Z);  

% Run estimation algorithm
N = size(sample,2);
max_iter = 4;
h = 1/(log10(N)); 
Xs = Sub_Cylinder(sample,N,h,max_iter);

% Plot results
[Xc,Yc,Zc] = cylinder; Zc = Zc*2 - 1;
surf(Xc,Yc,Zc); colormap summer;
axis equal; shading flat; alpha(0.6); box off; axis off;
hold on;
X = Xs{max_iter + 1,1};
plot3(sample(1,:),sample(2,:),sample(3,:),'r.',MarkerSize=5); % Noisy points
plot3(X(1,:),X(2,:),X(3,:),'b.',MarkerSize=5); % Estimated points