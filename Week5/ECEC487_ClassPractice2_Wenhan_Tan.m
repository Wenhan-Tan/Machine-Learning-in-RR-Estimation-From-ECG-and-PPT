close all; clc; clear all;
rand('seed', 0);
randn('seed', 0);

%% Part 1 
m1 = [0 0];
m2 = [10 0];
sigma = [2 0; 0 2];

x1 = mvnrnd(m1, sigma, 50);
x2 = mvnrnd(m2, sigma, 50);
y = [ones(1, 50) ones(1, 50) * -1];
x = [x1; x2];

clf
plot(x1(:,1), x1(:,2), '.r');
hold on;
plot(x2(:,1), x2(:,2), '.k');
hold on;

x1mid = [mean(x1(:,1)) mean(x1(:,2))];
x2mid = [mean(x2(:,1)) mean(x2(:,2))];
w = (x2mid(2) - x1mid(2)) / (x2mid(1) + x1mid(1));
w0 = x1mid(2) - x1mid(1) * w;

xline = linspace(-20, 20, 100);
yline = w*xline + w0;
plot(xline, yline);
hold on;

count = 0;
for i = 1:50
    if (x(i,1) * -w + x(i,2) - w0) < 0
        plot(x(i,1), x(i,2),'og');
        hold on;
        count = count + 1;
    end
    
    if(x(i+50, 1) * -w + x(i+50, 2) - w0) > 0
        plot(x(i+50, 1), x(i+50, 2), 'og');
        count = count + 1;
    end
end

accuracy = 100 - count;

% xlim([-5 5]);
% ylim([-10 110]);
title('Part 1');
xlabel('x_1');
ylabel('x_2');
grid on;
legend('Class 1', 'Class 2', 'Decision Line', ['Misclassification Points (Accuracy is ' num2str(accuracy) '%)']);