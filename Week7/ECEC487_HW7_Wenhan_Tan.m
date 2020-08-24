close all; clear all; clc;
rand('seed', 0); randn('seed', 0);
%% Computer Experiment 6.1
w = [1 1];
w0 = 0;
a = 10;
e = 1;
sed = 0;
N = 1000;

x = generate_hyper(w,w0,a,e,N,sed);

[pc, variances] = pcacov(cov(x'));

hold on
plot([0 pc(1,1)],[0 pc(1,2)], 'r-', 'Linewidth', 2);
hold on
plot([0 pc(2,1)], [0 pc(2,2)], 'k-', 'Linewidth', 1);
ylim([-5 5]);
title('Hyper');
xlabel('x_1');
ylabel('x_2');
legend({'Data Points', 'a_0', 'a_1'}, 'FontSize', 12);

function X=generate_hyper(w,w0,a,e,N,sed)
    l=length(w);
    t=(rand(l-1,N)-.5)*2*a;
    t_last=-(w(1:l-1)/w(l))'*t + 2*e*(rand(1,N)-.5)-(w0/w(l));
    X=[t; t_last];
    %Plots for the 2d and 3d case
    if(l==2)
        figure(1), plot(X(1,:),X(2,:),'.b')
    elseif(l==3)
        figure(1), plot3(X(1,:),X(2,:),X(3,:),'.b')
    end
    figure(1)
end