close all; clear all; clc

%% Problem 1
x = [randn(100,2)*0.75-ones(100,2); randn(100,2)*0.25+ones(100,2)];
k = 2;
c1 = [-1 -1];
c2 = [1 1];
result = [];
temp1 = 0;
temp2 = 0;
temp3 = 0;
for i = 1:200
    temp1 = sqrt((x(i,1) - c1(1))^2 + (x(i,2) - c1(2))^2);
    temp2 = sqrt((x(i,1) - c2(1))^2 + (x(i,2) - c2(2))^2);
    if temp1 > temp2
        temp3 = 2;
    else
        temp3 = 1;
    end
    result(i) = temp3;
end
result = result';
figure,
plot(x(result==1,1),x(result==1,2),'r.');
hold on;
plot(x(result==2,1),x(result==2,2),'b.');
hold on;
plot(-1,-1, 'ko', 'linewidth', 1);
plot(1,1, 'ko', 'linewidth', 1);

legend('cluster1', 'cluster2', 'cluster centers');

%% Kmeans
x = [randn(100,2)*0.75-ones(100,2); randn(100,2)*0.25+ones(100,2)];
k = 2;
[idx, c] = kmeans(x,k);

figure,
plot(x(idx==1,1),x(idx==1,2),'r.');
hold on;
plot(x(idx==2,1),x(idx==2,2),'b.');
hold on;
plot(c(:,1),c(:,2), 'ko', 'linewidth', 1);
legend('cluster1', 'cluster2', 'cluster centers');