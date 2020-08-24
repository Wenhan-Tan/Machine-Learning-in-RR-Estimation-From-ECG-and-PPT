close all; clc; clear all; 

rand('seed', 0);
randn('seed', 0);
%% Problem 4.1
% Data
X1 = [ 0.1, -0.2; 0.2, 0.1; -0.15, 0.2; 1.1, 0.8; 1.2, 1.1 ];
X2 = [ 1.1, -0.1; 1.25, 0.15; 0.9, 0.1; 0.1, 1.2; 0.2, 0.9 ];

figure,
plot( X1(:,1), X1(:,2), 'ob' ); 
hold on;

plot( X2(:,1), X2(:,2), '+r' );
hold on; 

% Decision Regions
x1 = linspace( -1, +2, 50 ); 
x2 = -x1 + 1.65; % the top line g_1 
plot( x1, x2, 'r-' ); 
text( 1.5, 0.2, 'g_1' );
hold on;

x2 = -x1 + .65; % the bottom line g_2
plot( x1, x2, 'r-' ); 
text( -.5, 1., 'g_2'); 
hold off;

title('First Layer');
xlabel('x_1'); ylabel('x_2');
axis( [-1,+2,-1,+2] ); 
grid on;
legend('Class 1', 'Class 2', 'g_1 = x_1 + x_2 - 1.65', 'g_2 = x_1 + x_2 - 0.65');

% Linear Hyperplane
X11 = [0, 0; 1, 1];
X22 = [1, 0]; 

figure,
plot( X11(:,1), X11(:,2), 'ob' );
hold on;

plot( X22(:,1), X22(:,2), '+r' );
hold on;

x11 = linspace( -1, +2, 50 ); 
x22 = x1 - 0.5; % the top line g_1

plot( x11, x22, 'r-' );
hold off;
grid on;
axis( [0,1.5,-1,1.5] ); 
title('Second Layer');
xlabel('y_1');
ylabel('y_2');
legend('Class 1', 'Class 2', 'g(y) = y_1 - y_2 - 0.5');

%% Problem 4.2
% Data
m1 = [0 0];
m2 = [1 1];
m3 = [0 1];
m4 = [1 0];
sigma = [0.01 0; 0 0.01];

x1 = mvnrnd(m1, sigma, 150);
x2 = mvnrnd(m2, sigma, 150);
x3 = mvnrnd(m3, sigma, 150);
x4 = mvnrnd(m4, sigma, 150);
x = [x1; x2; x3; x4]';
y = [ones(1, 300) ones(1, 300) * -1];

figure,
plot(x(1,1:300), x(2,1:300), '.r');
hold on;
plot(x(1, 301:600), x(2, 301:600), '.b');
hold on;

% Decision Regions
x1 = linspace( -1, +2, 50 ); 
x2 = -x1 + 1.55; % the top line g_1 
plot( x1, x2, 'r-' ); 
text( 1.4, 0.4, 'g_1' );
hold on;

x2 = -x1 + .55; % the bottom line g_2
plot( x1, x2, 'r-' ); 
text( -.25, 0.7, 'g_2'); 
hold off;

title('Data Set');
xlabel('x_1'); ylabel('x_2');
axis( [-0.5,1.5,-0.5,1.5] ); 
grid on;
legend('Class 1', 'Class 2', 'g_1 = x_1 + x_2 - 1.55', 'g_2 = x_1 + x_2 - 0.55');

% Train
net = NN_training(x, y, 2, 1, 8, 0.1);
% x = 1:10;
% y = [0.01167
% 0.007448
% 0.005321
% 0.005987
% 0.005887
% 0.005687
% 0.005887
% 0.005587
% 0.005487
% 0.005387];
% 
% figure,
% plot(x,y,'.-r');
% title('Error Curve');
% xlabel('Number of Iterations');
% ylabel('Error Percentage');
% grid on;
%% Functions
function net = NN_training(x,y,k,code,iter,par_vec)
    rand('seed',0) % Initialization of the random number
    % generators
    randn('seed',0) % for reproducibility of net initial
    % conditions
    % List of training methods
    methods_list = {'traingd'; 'traingdm'; 'traingda'};
    % Limits of the region where data lie
    limit = [min(x(:,1)) max(x(:,1)); min(x(:,2)) max(x(:,2))];
    % Neural network definition
    net = feedforwardnet([k 1], methods_list{code, 1});
    % Neural network initialization
    net = init(net);
    % Setting parameters
    net.trainParam.epochs = iter;
    net.trainParam.lr=par_vec(1);
    if(code == 2)
    net.trainParam.mc=par_vec(2);
    elseif(code == 3)
    net.trainParam.lr_inc = par_vec(3);
    net.trainParam.lr_dec = par_vec(4);
    net.trainParam.max_perf_inc = par_vec(5);
    end
    % Neural network training
    net = train(net,x,y);
    %NOTE: During training, the MATLAB shows a plot of the
    % MSE vs the number of iterations.
end