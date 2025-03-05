clc;
clear;
close all;

load("test_labels.mat"); 
y_mean = mean(test_labels);
%预测值
load("y_dnn.mat");
load("y_svr.mat");
load("y_gbr.mat");
load("y_dnn_svr.mat");
load("y_dnn_gbr.mat");
load("y_svr_gbr.mat");
load("y_dnn_svr_gbr.mat");

load("y_ds_dg.mat");
load("y_ds_sg.mat");
load("y_dg_sg.mat");

% y_three=load("y_pred_three.mat");
% 计算RMSE
rmse_DNN = sqrt(mean((test_labels - y_dnn).^2));
rmse_SVR = sqrt(mean((test_labels - y_svr).^2));
rmse_GBR = sqrt(mean((test_labels - y_gbr).^2));
rmse_DNN_SVR = sqrt(mean((test_labels - y_dnn_svr).^2));
rmse_DNN_GBR = sqrt(mean((test_labels - y_dnn_gbr).^2));
rmse_SVR_GBR = sqrt(mean((test_labels - y_svr_gbr).^2));
rmse_DNN_SVR_GBR = sqrt(mean((test_labels - y_dnn_svr_gbr).^2));
rmse8=sqrt(mean((test_labels - y_ds_dg).^2));
rmse9=sqrt(mean((test_labels - y_ds_sg).^2));
rmse10=sqrt(mean((test_labels - y_dg_sg).^2));
% rmse_three = sqrt(mean((y_true - y_three.y_pred_meta).^2));
% 显示结果
disp(['RMSE = ', num2str(rmse_DNN)]);
disp(['RMSE = ', num2str(rmse_SVR)]);
disp(['RMSE = ', num2str(rmse_GBR)]);
disp(['RMSE = ', num2str(rmse_DNN_SVR)]);
disp(['RMSE = ', num2str(rmse_DNN_GBR)]);
disp(['RMSE = ', num2str(rmse_SVR_GBR)]);
disp(['RMSE = ', num2str(rmse_DNN_SVR_GBR)]);
disp(['RMSE = ', num2str(rmse8)]);
disp(['RMSE = ', num2str(rmse9)]);
disp(['RMSE = ', num2str(rmse10)]);
% disp(['RMSE = ', num2str(rmse_three)]);

R_squared1=computeR2(test_labels,y_dnn);
R_squared2=computeR2(test_labels,y_svr);
R_squared3=computeR2(test_labels,y_gbr);
R_squared4=computeR2(test_labels,y_dnn_svr);
R_squared5=computeR2(test_labels,y_dnn_gbr);
R_squared6=computeR2(test_labels,y_svr_gbr);
R_squared7=computeR2(test_labels,y_dnn_svr_gbr);
R8=computeR2(test_labels,y_ds_dg);
R9=computeR2(test_labels,y_ds_sg);
R10=computeR2(test_labels,y_dg_sg);
% R_squared8=computeR2(y_true,y_three.y_pred_meta);
R_2=[R_squared1 R_squared2 R_squared3 R_squared4 R_squared5 R_squared6 R_squared7 R8 R9 R10]

RMSE_value=[rmse_DNN rmse_SVR rmse_GBR rmse_DNN_SVR rmse_DNN_GBR rmse_SVR_GBR rmse_DNN_SVR_GBR rmse8 rmse9 rmse10];
x=1:1:10;
subplot(1,2,1)
plot(RMSE_value, '^-', 'Color', [.8, .3, 0]);
xlabel('Model');
ylabel('RMSE');
subplot(1,2,2)
plot(R_2, 'o-', 'Color', [0, 0.39, 0]);
xlabel('Model');
ylabel('R^2');


function R_squared = computeR2(y_true, y_pred)
    % computeR2 计算实际值和预测值之间的R方（R-squared）值
    %
    % 用法:
    %   R_squared = computeR2(y_true, y_pred)
    %
    % 输入:
    %   y_true - 实际值的向量
    %   y_pred - 预测值的向量
    %
    % 输出:
    %   R_squared - R方值

    % 计算均值
    y_mean = mean(y_true);

    % 计算总平方和（Total Sum of Squares）
    SST = sum((y_true - y_mean).^2);

    % 计算残差平方和（Residual Sum of Squares）
    SSR = sum((y_true - y_pred).^2);

    % 计算R方值
    R_squared = 1 - (SSR / SST);
end