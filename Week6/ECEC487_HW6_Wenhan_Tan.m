close all; clear all; clc;
rand('seed', 0);
randn('seed', 0);

%% Computer Experiment 5.1
n1 = normrnd(0, 1, [1, 100]);
n2 = normrnd(2, 1, [1, 100]);
h1 = ttest2(n1, n2);
subplot(1,2,1);
histogram([n1]);
hold on
histogram([n2]);
title("Mean: 0, 2")

n2 = normrnd(0.2, 1, [1, 100]);
h2 = ttest2(n1, n2);
subplot(1,2,2);
histogram([n1]);
hold on
histogram([n2]);
title("Mean: 0, 0.2")

n1 = normrnd(0, 1, [1, 150]);
n2 = normrnd(2, 1, [1, 200]);
h3 = ttest2(n1, n2);

n2 = normrnd(0.2, 1, [1, 200]);
h4 = ttest2(n1, n2);