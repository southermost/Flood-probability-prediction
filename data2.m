clc
clear
close all

load("dg_sg.mat");
load("dnn_gbr_test.mat");
load("svr_gbr_test.mat");

mix=[dnn_gbr_test, svr_gbr_test];

dg_sg_test=predict(rf,mix);


save("dg_sg_test.mat","dg_sg_test");