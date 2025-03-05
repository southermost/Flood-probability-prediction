clc
clear
close all

load("val_data.mat");
load("val_labels.mat");

load("dnn.mat");
load("svr.mat");
load("gbr.mat");


dnn_pred_test = predict(dnn, val_data);
svr_pred_test = predict(svr,val_data);
gbr_pred_test = predict(gbr,val_data);


mix1=[dnn_pred_test svr_pred_test];
mix2=[dnn_pred_test gbr_pred_test];
mix3=[svr_pred_test gbr_pred_test];
mix4=[dnn_pred_test svr_pred_test gbr_pred_test];
% dsg=load("dnn-svr-gbr.mat");
sg=load("svr-gbr.mat");
% dsg=load('dnn-svr-gbr.mat');

svr_gbr_test=predict(sg.rf,mix3);
save("svr_gbr_test.mat","svr_gbr_test");
