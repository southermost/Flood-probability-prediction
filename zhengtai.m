clc
clear
close all

% 生成或读取数据，假设数据存储在变量 data_column 中
;
figure;
plot(Y1_dsdg, 'r-', 'DisplayName', 'Test');  % 实际值
hold on;
% plot(y_mix, 'Color', [.8, .3, 0], 'DisplayName', 'SVR-GBR');  % 堆叠模型的预测值
legend('show');
legend('box','off');
xlabel('Index');
ylabel('Probability');
% title('实际值 vs 堆叠模型预测值');

% 设置横坐标刻度
tick_interval = 100000;  % 设定刻度间隔，例如每100个样本显示一个刻度
x_ticks = 0:tick_interval:length(Y1_dsdg);  % 生成刻度位置
xticks(x_ticks);  % 应用刻度位置
xticklabels(arrayfun(@num2str, x_ticks, 'UniformOutput', false));  % 显示刻度标签
xlim([1 length(Y1_dsdg)]);  % 设置x轴范围
% xlabel('样本索引');
% ylabel('输出值');
% 1. 绘制数据的直方图
data=Y1_dsdg;
figure;
histogram(data, 'Normalization', 'pdf'); % 使用pdf标准化直方图
hold on;

% 2. 拟合正态分布
mu = mean(data); % 计算数据的均值
sigma = std(data); % 计算数据的标准差

% 生成正态分布的x轴范围
x_values = linspace(min(data), max(data), 100);

% 计算对应正态分布的概率密度函数值
y_values = normpdf(x_values, mu, sigma);

% 3. 绘制正态分布曲线
plot(x_values, y_values, 'r-', 'LineWidth', 2);

% 设置图形标题和标签
% title('数据的直方图与正态分布对比');
xlabel('Flood probability');
ylabel('Probability density');
legend('box','off');
legend('Data histogram', 'Positive distribution curve');
hold off;

% [h1,p1] = shapirotest(data);

[h2,p2] = kstest(data);
