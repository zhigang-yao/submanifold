% ------------------------------
% DEMO: principal submanifold on pie data set and clustering.
% ------------------------------

% --- Load Data ---
% Load the PIE.mat data file
load('PIE5.mat'); 
%load('PIE.mat'); 


% --- Data Preprocessing ---
% Determine the number of unique classes in the ground truth (gnd)
n_class = length(unique(gnd));

% Normalize the feature matrix (fea) to have unit norm (spherical normalization)
fea_sphere = fea./sqrt(sum(fea.^2,2));

% Get the number of rows (samples) in the normalized feature matrix
N = size(fea_sphere,1);  

% --- Feature Extraction ---
% Set the parameters for the Sub_sphere_PIE function
max_iter = 10; 
sig = 0.1; 
h = 0.1;

% Apply the Sub_sphere_PIE function to the normalized feature matrix
X = submanifold_hypersphere(fea_sphere',sig, h, max_iter);

% Extract the submanifold features from the last iteration and transpose
fea_submanifold = X'; 

% --- Data Analysis ---
% Calculate the silhouette scores for different feature representations
s_1 = silhouette(fea,gnd);
s_2 = silhouette(fea_sphere,gnd);
s_3 = silhouette(fea_submanifold,gnd);

% Perform k-means clustering on the original, spherical, and submanifold features
grp_1 = kmeans(fea,n_class,'Replicates',10);
grp_2 = kmeans(fea_sphere,n_class,'Replicates',10);
grp_3 = kmeans(fea_submanifold,n_class,'Replicates',10);

% Calculate clustering metrics for each clustering result
acs = [calAC(grp_1,gnd) calAC(grp_2,gnd) calAC(grp_3,gnd)];

% --- Visualization ---
% Plot the silhouette scores in a box chart
subplot(1,3,1);
boxchart([s_1,s_2,s_3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('silhouette score');
title('Class separability');

% Plot the clustering accuracy for high-dimensional data
subplot(1,3,2);
bar(acs); xlim([0.5,3.5]);
xticks([1,2,3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('ACC');
title('Clustering of high dimension data');

% --- Dimensionality Reduction ---
% Set the random number generator for reproducibility
rng default; 

% Reduce the dimensionality of each feature set to 2D using t-SNE
fea_2d = tsne(fea,'NumDimensions',2);
fea_sphere_2d = tsne(fea_sphere,'NumDimensions',2);
fea_submanifold_2d = tsne(fea_submanifold,'NumDimensions',2);

% Perform k-means clustering on the 2D features
grp_4 = kmeans(fea_2d,n_class,'Replicates',10);
grp_5 = kmeans(fea_sphere_2d,n_class,'Replicates',10);
grp_6 = kmeans(fea_submanifold_2d,n_class,'Replicates',10);

% Calculate clustering metrics for each 2D clustering result
acs_2d = [calAC(grp_4,gnd) calAC(grp_5,gnd) calAC(grp_6,gnd)];

% Plot the clustering accuracy for 2D data
subplot(1,3,3);
bar(acs_2d); ylim([0,1.02]); xlim([0.5,3.5]);
xticks([1,2,3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('ACC');
title('Clustering of 2-dimension data');
