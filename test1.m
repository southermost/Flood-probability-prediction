clc;
clear;
close all;

load("ds_dg.mat");
load("test_labels.mat");
load("test_data.mat");
% load("y_dnn_svr.mat");
load("y_dnn_svr.mat");
load("y_dnn_gbr.mat");
mix=[y_dnn_svr y_dnn_gbr ];
y_ds_dg = predict(rf, mix);

% Rodnnund y_dnn to three decimal places
y_ds_dg = round(y_ds_dg, 3);


save("y_ds_dg.mat","y_ds_dg");