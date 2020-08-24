%% Computer Experiment 2.7
randn('seed', 0);
% X5
% Data generation
x51 = normrnd(1,2,[333,1]);
x52 = normrnd(4,2,[333,1]);
x53 = normrnd(8,2,[334,1]);
x5 = [x51; x52; x53];

pdf1 = pdf('normal', x5, 1, 2) * 333/1000;
pdf2 = pdf('normal', x5, 4, 2) * 333/1000;
pdf3 = pdf('normal', x5, 8, 2) * 334/1000;
pdf123 = [pdf1, pdf2, pdf3];

% Bayesian classification
bclassification1 = (pdf1 > pdf2) & (pdf1 > pdf3);
bclassification2 = (pdf2 > pdf1) & (pdf2 > pdf3);
bclassification3 = (pdf3 > pdf1) & (pdf3 > pdf2);

% Euclidean classification
eclassification1 = (sqrt((x5 - 1).^2) < sqrt((x5 - 4).^2)) & (sqrt((x5 - 1).^2) < sqrt((x5 - 8).^2));
eclassification2 = (sqrt((x5 - 4).^2) < sqrt((x5 - 1).^2)) & (sqrt((x5 - 4).^2) < sqrt((x5 - 8).^2));
eclassification3 = (sqrt((x5 - 8).^2) < sqrt((x5 - 4).^2)) & (sqrt((x5 - 8).^2) < sqrt((x5 - 1).^2));

% Error of Bayesian classificaion
berror1 = 333 - sum(bclassification1(1:333));
berror2 = 333 - sum(bclassification2(334:666));
berror3 = 334 - sum(bclassification3(667:1000));
berror = (berror1 + berror2 + berror3) / 1000.0;

% Error of Euclidean classification
eerror1 = 333 - sum(eclassification1(1:333));
eerror2 = 333 - sum(eclassification2(334:666));
eerror3 = 334 - sum(eclassification3(667:1000));
eerror = (eerror1 + eerror2 + eerror3) / 1000.0;

% X5'
% Data generation
x51p = normrnd(1,2,[800,1]);
x52p = normrnd(4,2,[100,1]);
x53p = normrnd(1,2,[100,1]);
x5p = [x51p; x52p; x53p];

pdf1p = pdf('normal', x5p, 1, 2) * 800/1000;
pdf2p = pdf('normal', x5p, 4, 2) * 100/1000;
pdf3p = pdf('normal', x5p, 1, 2) * 100/1000;
pdf123p = [pdf1p, pdf2p, pdf3p];

% Bayesian classification
bclassification1p = (pdf1p > pdf2p) & (pdf1p > pdf3p);
bclassification2p = (pdf2p > pdf1p) & (pdf2p > pdf3p);
bclassification3p = (pdf3p > pdf1p) & (pdf3p > pdf2p);

% Euclidean classification
eclassification1p = (sqrt((x5p - 1).^2) <= sqrt((x5p - 4).^2)) & (sqrt((x5p - 1).^2) <= sqrt((x5p - 1).^2));
eclassification2p = (sqrt((x5p - 4).^2) < sqrt((x5p - 1).^2)) & (sqrt((x5p - 4).^2) < sqrt((x5p - 1).^2));
eclassification3p = (sqrt((x5p - 1).^2) <= sqrt((x5p - 4).^2)) & (sqrt((x5p - 1).^2) <= sqrt((x5p - 1).^2));

% Error of Bayesian classification
berror1p = 800 - sum(bclassification1p(1:800));
berror2p = 100 - sum(bclassification2p(801:900));
berror3p = 100 - sum(bclassification3p(901:1000));
berrorp = (berror1p + berror2p + berror3p) / 1000.0;

% Error of Euclidean classification
eerror1p = 800 - sum(eclassification1p(1:800));
eerror2p = 100 - sum(eclassification2p(801:900));
eerror3p = 100 - sum(eclassification3p(901:1000));
eerrorp = (eerror1p + eerror2p + eerror3p) / 1000.0;

figure,
plot(x5,pdf123,'o');
xlabel('x');
ylabel('p(x|w)');
title('Data Set X5');
grid on;

figure,
plot(x5p,pdf123p,'o');
xlabel('x');
ylabel('p(x|w)');
title("Data Set X5'");
grid on;
%% Computer Experiment 2.8
% Data Generation
z1 = [normrnd(1,6,[333,1]) normrnd(1,6,[333,1])];
z2 = [normrnd(8,6,[333,1]) normrnd(6,6,[333,1])];
z3 = [normrnd(13,6,[334,1]) normrnd(1,6,[334,1])];
z = [z1; z2; z3];
x3 = z;

% k = 1
for i = 1:1000
    for j = 1:1000
        d(i,j) = sqrt( (x3(i,1) - z(j,1))^2 + (x3(i,2) - z(j,2))^2 );
    end
end

for i = 1:1000
    temp = d(i,:);
    [u1(i), index1(i)] = min(temp(temp>min(temp)));
end
k1classification1 = index1 <= 333;
k1classification2 = (index1 >= 334) & (index1 <= 666);
k1classification3 = (index1 >= 667) & (index1 <= 1000);

k1classification = [k1classification1(1:333) k1classification1(334:666) k1classification1(667:1000)];

% k = 11
for i = 1:1000
    temp = d(i,:);
    for j = 1:12
        temp2 = sort(temp);
        index2(i,j) = find(temp2(j) == temp);
    end
end
index2(:,1) = [];

for i = 1:1000
   k11classification1(i) = sum(index2(i,:) <= 333);
   k11classification2(i) = sum(index2(i,:) >= 334) & sum(index2(i,:) <= 666);
   k11classification3(i) = sum(index2(i,:) >= 667) & sum(index2(i,:) <= 1000);
end
k11classification1 = (k11classification1 > k11classification2) & (k11classification1 > k11classification3);
k11classification2 = (k11classification2 > k11classification1) & (k11classification2 > k11classification3);
k11classification3 = (k11classification3 > k11classification2) & (k11classification3 > k11classification1);

k11classification = [k11classification1(1:333) k11classification2(334:666) k11classification3(667:1000)];

figure,
plot(z1(:,1), z1(:,2), 'o');
hold on;
plot(z2(:,1), z2(:,2), 'o');
hold on;
plot(z3(:,1), z3(:,2), 'o');
hold off;
xlabel('x1');
ylabel('x2');
title('Data Set Z');