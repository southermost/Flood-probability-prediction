clc;
clear;
close all;

% 读取数据
data = xlsread("test.csv");
data = data(:, 2:21);  % 选择第二到第二十一列

% 对每一列进行 mapminmax 标准化
[mappedData, settings] = mapminmax(data', 0, 1);

% 转置回来，确保数据列的维度一致
Data = mappedData';

% 选择指定的列
cols = [1, 2, 3, 4, 7, 8, 11, 14, 16, 17];
Data = Data(:, cols);

% 权重向量
w = [0.0606 0.0704 0.0650 0.0553 0.0653 0.0554 0.0545 0.0577 0.0683 0.0561];

% 将权重归一化，使其总和为 1
w_normalized = w / sum(w);

% 加载 Y1_dsdg 数据
p = load("Y1_dsdg.mat");
p = p.Y1_dsdg;

% 检查 p 的长度是否匹配 Data 的行数
if length(p) ~= size(Data, 1)
    error('p 的长度与 Data 的行数不匹配。');
end

% 对 Data 每一列与权重相乘并与 p 相加
result = Data * w_normalized' + p;

% 使用高斯混合模型（GMM）拟合数据
k = 5;  % 假设有 5 个高斯成分，对应于 5 个等级
GMModel = fitgmdist(result, k);  % 拟合高斯混合模型

% 使用 GMM 模型计算每个样本属于每个成分的后验概率
posterior_probs = posterior(GMModel, result);

% 根据后验概率选择最大概率的成分作为等级
[~, levels] = max(posterior_probs, [], 2);

% 设置新的配色方案
colors = [1, 0.7, 0;    % 橙色
            0.1, 0.6, 1;   % 蓝色
            1, 0, 0;      % 红色
             0.6, 0, 1;   % 紫色
            0.1, 0.8, 0.1];% 绿色
          
         
          

% 显示等级划分结果，使用新的颜色
figure;
gscatter(1:length(result), result, levels, colors, '*', 8);
xlabel('Index');
ylabel('Risk score');
legend('low risk', ' medium low risk', 'medium risk', 'medium high risk', 'high risk');
ylim([0.45 1.5])    % 设置 y 轴范围
tick_interval = 100000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:750000;  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签


% 统计每个等级的数量
level_counts = histcounts(levels, 1:6);  % 1 到 5 代表等级
disp('各个等级的样本数量：');
disp(['等级 1: ' num2str(level_counts(1))]);
disp(['等级 2: ' num2str(level_counts(2))]);
disp(['等级 3: ' num2str(level_counts(3))]);
disp(['等级 4: ' num2str(level_counts(4))]);
disp(['等级 5: ' num2str(level_counts(5))]);

% 统计等级信息
level_stats = tabulate(levels);  % 获取等级的统计信息
disp('等级统计信息：');
disp(level_stats);
