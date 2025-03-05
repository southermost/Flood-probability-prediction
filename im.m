clc
clear
close all

% 生成或加载数据集
% 这里假设你已经有一个名为data的矩阵，最后一列是目标变量
% 如果是从文件加载数据，例如CSV文件，可以使用以下方式
% data = readmatrix('your_data.csv');
load("kmeans_data.mat");

% 分离特征和目标变量
X = data(:, 1:end - 2); % 特征矩阵
Y = data(:, end-1); % 目标变量向量

% 使用随机森林进行特征重要性分析
% 需要安装Statistics and Machine Learning Toolbox
% 设置'OOBPredictorImportance'为'on'，以保存袋外置换相关数据用于计算特征重要性
tree = TreeBagger(1000, X, Y, 'Method', 'regression', 'OOBPredictorImportance', 'on'); 

% 获取特征重要性
importance = tree.OOBPermutedVarDeltaError;

% 对特征重要性进行排序
[sorted_importance, index] = sort(importance, 'descend');

% 显示特征重要性
fprintf('特征重要性排名:\n');
for i = 1:length(index)
    fprintf('特征 %d: 重要性 = %f\n', index(i), sorted_importance(i));
end
all=sum(sorted_importance)
b=sorted_importance./all;
% 可视化特征重要性
bar(sorted_importance);
xlabel('特征索引（按重要性排序）');
ylabel('重要性');
title('特征重要性分析');
