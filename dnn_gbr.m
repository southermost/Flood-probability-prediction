clc
clear
close all
%加载数据集
load("train.mat");
load("val_data.mat");
load("test_data.mat");

load("train_labels.mat");
load("val_labels.mat");
load("test_labels.mat");

%加载模型
load("dnn.mat");
%gbr训练
gbr = fitrensemble(train_data, train_labels, 'Method', 'LSBoost', 'NumLearningCycles', 2000, 'LearnRate', 0.999);
save("gbr.mat","gbr");
dnn_pred_valid = predict(dnn, val_data);
gbr_pred_valid = predict(gbr,val_data);

meta_X = [dnn_pred_valid, gbr_pred_valid];
% 使用随机森林作为元学器，创建随机森林模型
num_trees = 2000;  % 树的数量
rf = TreeBagger(num_trees, meta_X, val_labels, ...
                       'Method', 'regression', ...
                       'MinLeafSize', 1, ...
                       'NumVariablesToSample', 'all'); % 尝试考虑所有特征
save("dnn-gbr.mat","rf");

y_dnn = predict(dnn, test_data);
y_gbr = predict(gbr,test_data);

test_mix=[y_dnn,y_gbr];
y_mix=predict(rf, test_mix);


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








