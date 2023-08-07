% Load the PIE.mat data file
load('PIE.mat'); 

% Determine the number of unique classes in the ground truth (gnd)
n_class = length(unique(gnd));

% Normalize the feature matrix (fea) to have unit norm (spherical normalization)
fea_sphere = fea./sqrt(sum(fea.^2,2));

% Get the number of rows (samples) in the normalized feature matrix
N = size(fea_sphere,1);  

% Set the maximum number of iterations for the Sub_sphere_PIE function
max_iter = 10;

% Apply the Sub_sphere_PIE function to the normalized feature matrix
Xs = Sub_sphere_PIE(fea_sphere',N,0.1,max_iter);

% Extract the submanifold features from the last iteration
fea_submanifold = Xs{max_iter,1}; 

% Transpose the submanifold features to match the original feature matrix orientation
fea_submanifold = fea_submanifold';

% Calculate the silhouette scores for the original, spherical, and submanifold features
s_1 = silhouette(fea,gnd);
s_2 = silhouette(fea_sphere,gnd);
s_3 = silhouette(fea_submanifold,gnd);

% Plot the silhouette scores in a box chart
subplot(1,3,1);
boxchart([s_1,s_2,s_3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('silhouette score');
title('Class separability');

% Perform k-means clustering on the original, spherical, and submanifold features
grp_1 = kmeans(fea,n_class,'Replicates',10);
grp_2 = kmeans(fea_sphere,n_class,'Replicates',10);
grp_3 = kmeans(fea_submanifold,n_class,'Replicates',10);

% Calculate the clustering accuracy (ACC), mutual information (MI), and adjusted Rand index (ARI) for each clustering result
acs = [calAC(grp_1,gnd) calAC(grp_2,gnd) calAC(grp_3,gnd)];
nmis = [calMI(grp_1,gnd) calMI(grp_2,gnd) calMI(grp_3,gnd)];
aris = [calARI(grp_1,gnd) calARI(grp_2,gnd) calARI(grp_3,gnd)];

% Plot the clustering accuracy for each feature set
subplot(1,3,2);
bar(acs); xlim([0.5,3.5]);
xticks([1,2,3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('ACC');
title('Clustering of high dimension data');

% Set the random number generator to its default state for reproducibility
rng default; 

% Reduce the dimensionality of each feature set to 2D using t-SNE
fea_2d = tsne(fea,'NumDimensions',5);
fea_sphere_2d = tsne(fea_sphere,'NumDimensions',5);
fea_submanifold_2d = tsne(fea_submanifold,'NumDimensions',5);

% Perform k-means clustering on the 2D features
grp_4 = kmeans(fea_2d,n_class,'Replicates',10);
grp_5 = kmeans(fea_sphere_2d,n_class,'Replicates',10);
grp_6 = kmeans(fea_submanifold_2d,n_class,'Replicates',10);

% Calculate the clustering accuracy (ACC), mutual information (MI), and adjusted Rand index (ARI) for each 2D clustering result
acs_2d = [calAC(grp_4,gnd) calAC(grp_5,gnd) calAC(grp_6,gnd)];
nmis_2d = [calMI(grp_4,gnd) calMI(grp_5,gnd) calMI(grp_6,gnd)];
aris_2d = [calARI(grp_4,gnd) calARI(grp_5,gnd) calARI(grp_6,gnd)];

% Plot the clustering accuracy for each 2D feature set
subplot(1,3,3);
bar(acs_2d); ylim([0,1.02]); xlim([0.5,3.5]);
xticks([1,2,3]);
xticklabels({'Original', 'Sphere','Submanifold'});
ylabel('ACC');
title('Clustering of 2-dimension data');
