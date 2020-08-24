% load('1_respSigs');
% load('../Data_for_Analysis/bidmc_groups_data');
% plot(0:0.008:9, data(1).ekg.v(1:1126));
% hold on;
% plot(0:0.008:9, data(1).ppg.v(1:1126));
% hold on;
% plot(ekg_ELF_RSlinB_FMeam_FPt_RDtGC_EHF.t(1:45), ekg_ELF_RSlinB_FMeam_FPt_RDtGC_EHF.v(1:45));
% 
% legend('ECG', 'PPG', 'RR');
% grid on;
% axis tight;
% xlabel('Time(s)');
% ylabel('Voltage(V)');

% x = [2 3 4 5 6 7 8 9];
% y = [96.6 91.2 85.4 81.1 76.1 74.9 72.7 71.3];
% plot(x,y);
% hold on;
% xlabel('Number of Classes');
% ylabel('Accuracy %');
% title('ECG - Neural Network & Support Vector Machine');
% 
% x = [2 3 4 5 6 7 8 9];
% y = [86.6 80.1 74.4 69.4 65.1 62.9 61.7 61.3];
% plot(x,y);
% legend('NN', 'SVM');
% grid on;

x = [2 3 4 5 6 7 8 9];
y = [93.6 89.2 82.4 79.1 73.1 71.9 69.7 68.3];
plot(x,y);
hold on;
xlabel('Number of Classes');
ylabel('Accuracy %');
title('PPG - Neural Network & Support Vector Machine');

x = [2 3 4 5 6 7 8 9];
y = [84.6 78.1 72.4 67.4 63.1 60.9 59.7 59.3];
plot(x,y);
legend('NN', 'SVM');
grid on;