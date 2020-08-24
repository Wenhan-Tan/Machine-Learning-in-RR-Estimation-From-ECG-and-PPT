% clear all; close all; clc;

%% Computer Experiments 3.1
% Part A
randn('seed', 0);
m1 = [-5 0];
m2 = [5 0];
sigma = [1 0; 0 1];
x1 = mvnrnd(m1, sigma, 200);
x2 = mvnrnd(m2, sigma, 200);
x1 = [x1 reshape(ones(1, 200), 200, 1)];
x2 = [x2 reshape(ones(1, 200), 200, 1)];
x12 = [x1; x2]';
y = [reshape(ones(1, 200), 200, 1); reshape(ones(1, 200) * -1, 200, 1)];

% Part B
w1 = perce(x12, y, [1; 1; -0.5]); % Perceptron Algorithm
w2 = SSErr(x12, y); % Sum of Error Squares Classifier
w3 = LMSalg(x12, y, [1; 1; -0.5]); % LMS Algorithm

% Part C D
figure,
plot(x12(1, 1:200), x12(2, 1:200), 'bo');
hold on;
plot(x12(1, 201:400), x12(2, 201:400), 'r+');
hold on;
fplot(@(x) (-w1(3)+-w1(1)*x)/w1(2));
hold on;
fplot(@(x) (-w2(3)+-w2(1)*x)/w2(2));
hold on;
fplot(@(x) (-w3(3)+-w3(1)*x)/w3(2));
hold off;
legend('Class 1', 'Class 2', 'w-Perceptron Algorithm', 'w-SSErr', 'w-LMS Algorithm');
ylim([-6 6]);
grid on;
title('Computer Experiment 3.1')
xlabel('x1');
ylabel('x2');

%% Computer Experiments 3.2
m1 = [-2 0];
m2 = [2 0];
sigma = [1 0; 0 1];

x1 = mvnrnd(m1, sigma, 200);
x2 = mvnrnd(m2, sigma, 200);
x1 = [x1 reshape(ones(1, 200), 200, 1)];
x2 = [x2 reshape(ones(1, 200), 200, 1)];
x12 = [x1; x2]';
y = [reshape(ones(1, 200), 200, 1); reshape(ones(1, 200) * -1, 200, 1)];

% Part B
w1 = perce(x12, y, [1; 1; -0.5]); % Perceptron Algorithm
w2 = SSErr(x12, y); % Sum of Error Squares Classifier
w3 = LMSalg(x12, y, [1; 1; -0.5]); % LMS Algorithm

% Part C D
figure,
plot(x12(1, 1:200), x12(2, 1:200), 'bo');
hold on;
plot(x12(1, 201:400), x12(2, 201:400), 'r+');
hold on;
fplot(@(x) (-w1(3)+-w1(1)*x)/w1(2));
hold on;
fplot(@(x) (-w2(3)+-w2(1)*x)/w2(2));
hold on;
fplot(@(x) (-w3(3)+-w3(1)*x)/w3(2));
hold off;
legend('Class 1', 'Class 2', 'w-Perceptron Algorithm', 'w-SSErr', 'w-LMS Algorithm');
ylim([-6 6]);
grid on;
title('Computer Experiment 3.2')
xlabel('x1');
ylabel('x2');

%% Functions
% Perceptron Algorithm
function w=perce(X,y,w_ini)
    [l,N]=size(X);
    max_iter=10000; % Maximum allowable number of iterations
    rho=0.05; % Learning rate
    w=w_ini; % Initialization of the parameter vector
    iter=0; % Iteration counter
    mis_clas=N; % Number of misclassified vectors
    while (mis_clas>0) && (iter<max_iter)
        iter=iter+1;
        mis_clas=0;
        gradi=zeros(l,1);% Computation of the "gradient"
        % term
        for i=1:N
            if((X(:,i)' *w)*y(i)<0)
                mis_clas=mis_clas+1;
                gradi=gradi+rho*(-y(i)*X(:,i));
            end
        end
        w=w-rho*gradi; % Updating the parameter vector
    end
end

% Sum of Error Squares Classifier
function w=SSErr(X,y)
    w=inv(X*X')*(X*y);
end

% LMS Algorithm
function w=LMSalg(X,y,w_ini)
    [l,N]=size(X);
    rho=0.2; % Learning rate initialization
    w=w_ini; % Initialization of the parameter vector
    for i=1:N
        w=w+(rho/i)*(y(i)-X(:,i)' *w)*X(:,i);
    end
end