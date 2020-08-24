clear all; close all; clc;

%% Data
load('Training_Target');
load('ECG_Signal_Data');

combDataClass = [ecgSignalData; result];
cols = size(combDataClass,2);
P = randperm(cols);
randCombDataClass = combDataClass(:,P);
ecgSignalData = randCombDataClass(1:155,:);
result = randCombDataClass(156:length(combDataClass(:,1)),:);

%% Feed Forward NN_Train & NN_Evaluation
% result = result(1,:);
% for i = 1:length(result)
%     if result(i) == 0
%         result(i) = -1;
%     end
% end
% net = NN_training(ecgSignalData, result, 155, 1, 10, 0.1);
% pe = NN_evaluation(net, ecgSignalData, result);

%% SVM
% result = result(1,:);
% x1 = ecgSignalData(:, 1:592);
% y1 = result(1:592);
% x2 = ecgSignalData(:, 593:740);
% y2 = result(593:740);
% [pe_tr, pe_te, svmModel]=SVM_Class(x1, y1, x2, y2);

%% DT
% result = result(1,:);
% x1 = ecgSignalData(:, 1:592);
% y1 = result(1:592);
% x2 = ecgSignalData(:, 593:740);
% y2 = result(593:740);
% [pe_tr, pe_te]=DT_Class(x1, y1, x2, y2)

%% Neural Network
% [x,t] = simpleclass_dataset;
% plot(x(1,:),x(2,:),'+')

net = patternnet(10);
net = train(net,ecgSignalData,result);
view(net);
y = net(ecgSignalData);
plotconfusion(result,y);

%% Functions
function [pe_tr, pe_te, svmModel]=SVM_Class(x1, y1, x2, y2)
    svmModel = fitcsvm(x1', y1', 'KernelFunction', 'polynomial', 'KernelScale','auto', 'PolynomialOrder',4);
    
    train_res = predict(svmModel, x1');
    pe_tr = sum(y1'~=train_res) / length(y1);
    
    test_res = predict(svmModel, x2');
    pe_te = sum(y2'~=test_res) / length(y2);
end

function [pe_tr, pe_te]=DT_Class(x1, y1, x2, y2)
    dtModel = fitctree(x1', y1');
    
    train_res = predict(dtModel, x1');
    pe_tr = sum(y1'~=train_res) / length(y1);
    
    test_res=predict(dtModel, x2');
    pe_te=sum(y2'~=test_res) / length(y2);
    view(dtModel, 'Mode', 'Graph')
end

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

function pe = NN_evaluation(net, x, y)
    y1 = sim(net, x);
    pe = sum(y.*y1<0) / length(y);
end