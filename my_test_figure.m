clc
clear
close all
load("test_labels.mat");
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


size=104858;
figure
subplot(1,2,1)
plot(1:size, test_labels, 'b-', 1:size, Y_dnn, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'DNN');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(i)', 'HorizontalAlignment', 'center'); % 添加标号

subplot(1,2,2)
plot(1:size, test_labels, 'b-', 1:size, y_svr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'SVR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(j)', 'HorizontalAlignment', 'center'); % 添加标号


figure
subplot(1,2,1)
plot(1:size, test_labels, 'b-', 1:size, y_gbr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'GBR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(i)', 'HorizontalAlignment', 'center'); % 添加标号

subplot(1,2,2)
plot(1:size, test_labels, 'b-', 1:size, y_dnn_svr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'DNN-SVR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(j)', 'HorizontalAlignment', 'center'); % 添加标号



figure
subplot(1,2,1)
plot(1:size, test_labels, 'b-', 1:size, y_dnn_gbr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'DNN-GBR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(i)', 'HorizontalAlignment', 'center'); % 添加标号

subplot(1,2,2)
plot(1:size, test_labels, 'b-', 1:size, y_svr_gbr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'SVR-GBR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(j)', 'HorizontalAlignment', 'center'); % 添加标号




figure
subplot(1,2,1)
plot(1:size, test_labels, 'b-', 1:size, y_dnn_svr_gbr, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', 'DNN-SVR-GBR');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(i)', 'HorizontalAlignment', 'center'); % 添加标号

subplot(1,2,2)
plot(1:size, test_labels, 'b-', 1:size, y_ds_dg, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', '(DNN-SVR)-(DNN-GBR)');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(j)', 'HorizontalAlignment', 'center'); % 添加标号


figure
subplot(1,2,1)
plot(1:size, test_labels, 'b-', 1:size, y_ds_sg, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', '(DNN-SVR)-(SVR-GBR)');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(i)', 'HorizontalAlignment', 'center'); % 添加标号

subplot(1,2,2)
plot(1:size, test_labels, 'b-', 1:size, y_dg_sg, 'r-', 'LineWidth', 1.5); % 真实值和预测值
legend('Test', '(DNN-GBR)-(SVR-GBR)');
legend('box','off');
xlabel('Index'); 
ylabel('Probability');
% 设置横坐标刻度
ylim([0.25 0.9])    % 设置 y 轴范围
tick_interval = 15000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
% text(size/2, label_y_position, '(j)', 'HorizontalAlignment', 'center'); % 添加标号

