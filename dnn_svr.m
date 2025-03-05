clc;
clear;
close all;
% 加载原始数据
% 假设 data 是特征矩阵，y 是目标变量
load("kmeans_data.mat");
y = data(:,21); % 加载标签数据
% 选择需要的列
cols = [1, 2, 3, 4, 7, 8, 11, 14, 16, 17];
% 假设 y 是目标变量

data = data(:, cols);
% 数据集大小
n = size(data, 1);
% 随机打乱数据的索引
idx = randperm(n);
% 划分训练集、验证集和测试集
train_size = floor(0.8 * n);    % 80% 数据用于训练
val_size = floor(0.1 * n);      % 10% 数据用于验证
test_size = n - train_size - val_size; % 剩余的 10% 用于测试
% 划分数据集
train_data = data(idx(1:train_size), :);
val_data = data(idx(train_size+1:train_size+val_size), :);
test_data = data(idx(train_size+val_size+1:end), :);
save("train.mat","train_data");
save("val_data.mat","val_data");
save("test_data.mat","test_data");

train_labels = y(idx(1:train_size));
val_labels = y(idx(train_size+1:train_size+val_size));
test_labels = y(idx(train_size+val_size+1:end));
save("train_labels.mat","train_labels");
save("val_labels.mat","val_labels");
save("test_labels.mat","test_labels");

% 创建 DNN 模型
layers = [
    featureInputLayer(10)             % 输入层，输入大小为 10（特征数量）
    fullyConnectedLayer(64)           % 第一个全连接层，64 个神经元
    reluLayer                         % 激活函数
    fullyConnectedLayer(32)           % 第二个全连接层，32 个神经元
    reluLayer                         % 激活函数
    fullyConnectedLayer(16)           % 第三个全连接层，16 个神经元
    reluLayer                         % 激活函数
    fullyConnectedLayer(1)            % 输出层，1 个神经元（回归任务）
    regressionLayer                   % 回归层
];

% 训练选项
options = trainingOptions('adam', ...
    'MaxEpochs', 2, ...              % 训练迭代次数
    'MiniBatchSize', 32, ...          % 每个 batch 的大小
    'InitialLearnRate', 0.00001, ...    % 学习率
    'Plots', 'training-progress', ... % 显示训练进程
    'Verbose', false);

% 训练模型
dnn = trainNetwork(train_data, train_labels, layers, options);
save("dnn.mat","dnn");
% 使用径向基函数 (RBF) 作为核函数，并设置相关参数
svr = fitrsvm(train_data, train_labels, ...
                    'KernelFunction', 'gaussian', ...  % 核函数为高斯核
                    'KernelScale', 'auto', ...         % 自动选择核的尺度
                    'BoxConstraint', 2, ...            % 惩罚参数 C
                    'Epsilon', 0.1);                   % Epsilon 不敏感区域

save("svr.mat","svr");
dnn_pred_valid = predict(dnn, val_data);
svr_pred_valid = predict(svr,val_data);

meta_X = [dnn_pred_valid, svr_pred_valid];
% 使用随机森林作为元学器，创建随机森林模型
num_trees = 2000;  % 树的数量
rf = TreeBagger(num_trees, meta_X, val_labels, ...
                       'Method', 'regression', ...
                       'MinLeafSize', 1, ...
                       'NumVariablesToSample', 'all'); % 尝试考虑所有特征
save("dnn-svr.mat","rf");
y_dnn = predict(dnn, test_data);
y_svr = predict(svr,test_data);

test_mix=[y_dnn,y_svr];
y_mix=predict(rf, test_mix);


% % 绘制真实值与预测值的对比图
% figure;
% plot(testLabels, 'b-', 'DisplayName', 'Test');  % 实际值
% hold on;
% plot(y_dnn, 'Color', [.8, .3, 0], 'DisplayName', 'DNN');  % 堆叠模型的预测值
% legend('show');
% xlabel('样本索引');
% ylabel('预测值');
% title('实际值 vs 堆叠模型预测值');
% 
% % 设置横坐标刻度
% tick_interval = 30000;  % 设定刻度间隔，例如每100个样本显示一个刻度
% x_ticks = 0:tick_interval:length(y);  % 生成刻度位置
% xticks(x_ticks);  % 应用刻度位置
% xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
% xlim([1 length(y)]);  % 设置x轴范围
% xlabel('样本索引');
% ylabel('输出值');
% 
% figure;
% plot(testLabels, 'b-', 'DisplayName', 'Test');  % 实际值
% hold on;
% plot(y_svr, 'Color', [.8, .3, 0], 'DisplayName', 'SVR');  % 堆叠模型的预测值
% legend('show');
% xlabel('样本索引');
% ylabel('预测值');
% title('实际值 vs 堆叠模型预测值');
% 
% % 设置横坐标刻度
% tick_interval = 30000;  % 设定刻度间隔，例如每100个样本显示一个刻度
% x_ticks = 0:tick_interval:length(y);  % 生成刻度位置
% xticks(x_ticks);  % 应用刻度位置
% xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
% xlim([1 length(y)]);  % 设置x轴范围
% xlabel('样本索引');
% ylabel('输出值');

figure;
plot(test_labels, 'b-', 'DisplayName', 'Test');  % 实际值
hold on;
plot(y_mix, 'Color', [.8, .3, 0], 'DisplayName', 'DNN-SVR');  % 堆叠模型的预测值
legend('show');
xlabel('样本索引');
ylabel('预测值');
title('实际值 vs 堆叠模型预测值');

% 设置横坐标刻度
tick_interval = 20000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(test_labels);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(test_labels)]);  % 设置x轴范围
xlabel('样本索引');
ylabel('输出值');
 


