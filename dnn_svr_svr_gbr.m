clc
clear
close all

load("dnn_svr_test.mat");
load("svr_gbr_test.mat");
load("val_labels.mat");
load("test_data.mat");
load("test_labels.mat");
mix=[dnn_svr_test,svr_gbr_test];



num_trees = 2000;  % 树的数量
rf = TreeBagger(num_trees, mix, val_labels, ...
                       'Method', 'regression', ...
                       'MinLeafSize', 1, ...
                       'NumVariablesToSample', 'all'); % 尝试考虑所有特征
save("ds_sg.mat","rf");
