clc
clear
close all
load("dnn.mat");
load("svr.mat");
load("gbr.mat");

load("val_data.mat");

dnn_pred_test=predict(dnn,val_data);
svr_pred_test=predict(svr,val_data);
gbr_pred_test=predict(gbr,val_data);


save("dnn_pred_test.mat","dnn_pred_test");
save("svr_pred_test.mat","svr_pred_test");
save("gbr_pred_test.mat","gbr_pred_test");