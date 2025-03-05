clc
clear
close all
% ds=load("dnn-svr.mat");
% dg=load("dnn-gbr.mat");
load("ds_dg.mat")
load("Y1_dg.mat");
load("Y1_ds.mat");
% load("Y1_gbr.mat");
mix=[Y1_dg Y1_ds];
% mix2=[Y_dnn Y_gbr];

% Y1_ds=predict(ds.rf,mix1);
Y1_dsdg=predict(rf,mix);

% save("Y1_ds.mat","Y1_ds");
save("Y1_dsdg.mat","Y1_dsdg");