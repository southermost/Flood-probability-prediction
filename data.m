clc
clear
close all

dnn_gbr=load("dnn-gbr.mat");
dnn_svr=load("dnn-svr.mat");
svr_gbr=load("svr-gbr.mat");
load("dnn.mat");
load("svr.mat");
load("gbr.mat");
load("test_data.mat");
load("test_labels.mat");
load("val_data.mat");
load("val_labels.mat");

dnn_pred_valid = predict(dnn, val_data);
svr_pred_valid = predict(svr, val_data);
gbr_pred_valid = predict(gbr, val_data);

save("dnn_pred_valid.mat","dnn_pred_valid");
save("svr_pred_valid.mat","svr_pred_valid");
save("gbr_pred_valid.mat","gbr_pred_valid");
dnn_svr_mix=[dnn_pred_valid,svr_pred_valid];
dnn_gbr_mix=[dnn_pred_valid,gbr_pred_valid];
svr_gbr_mix=[svr_pred_valid,gbr_pred_valid];
dnn_svr_gbr_mix=[dnn_pred_valid,svr_pred_valid,gbr_pred_valid];
save("dnn_svr_mix.mat","dnn_svr_mix");
save("dnn_gbr_mix.mat","dnn_gbr_mix");
save("svr_gbr_mix.mat","svr_gbr_mix");
save("dnn_svr_gbr_mix.mat","dnn_svr_gbr_mix");

dnn_svr_single = predict(dnn_svr.rf, dnn_svr_mix);

dnn_gbr_single = predict(dnn_gbr.rf,dnn_gbr_mix);

svr_gbr_single = predict(svr_gbr.rf,svr_gbr_mix);


save("dnn_svr_single.mat","dnn_svr_single");
save("dnn_gbr_single.mat","dnn_gbr_single");
save("svr_gbr_single.mat","svr_gbr_single");
save("dnn_svr_gbr_mix.mat","dnn_svr_gbr_mix");

