close all; clear all; clc;

%% Trainging Target
result = [];
load('ECG_RR_Data');
for i = 1:53
    for j = 1:(length(ECG_data(i).t))
        temp = [];
        rrEst = ECG_data(i).v(j);
        
%         if rrEst < 25
%             temp = [1 0];
%         else
%             temp = [0 1];
%         end
        
        if rrEst < 20
            temp = [1 0 0 0 0 0];
        elseif rrEst > 20 && rrEst < 25
            temp = [0 1 0 0 0 0];
        elseif rrEst > 25 && rrEst < 30
            temp = [0 0 1 0 0 0];
        elseif rrEst > 30 && rrEst < 35
            temp = [0 0 0 1 0 0];
        elseif rrEst > 35 && rrEst < 40
            temp = [0 0 0 0 1 0];
        else
            temp = [0 0 0 0 0 1];
        end
        
%         if rrEst < 10
%             temp = [1 0 0 0 0];
%         elseif rrEst > 10 && rrEst < 15
%             temp = [0 1 0 0 0];
%         elseif rrEst > 15 && rrEst < 20
%             temp = [0 0 1 0 0];
%         elseif rrEst > 20 && rrEst < 25
%             temp = [0 0 0 1 0];
%         else
%             temp = [0 0 0 0 1];
%         end

%         if rrEst < 5
%             temp = [1 0 0 0 0 0 0 0];
%         elseif rrEst > 5 && rrEst < 10
%             temp = [0 1 0 0 0 0 0 0];
%         elseif rrEst > 10 && rrEst < 15
%             temp = [0 0 1 0 0 0 0 0];
%         elseif rrEst > 15 && rrEst < 20
%             temp = [0 0 0 1 0 0 0 0];
%         elseif rrEst > 20 && rrEst < 25
%             temp = [0 0 0 0 1 0 0 0];
%         elseif rrEst > 25 && rrEst < 30
%             temp = [0 0 0 0 0 1 0 0];
%         elseif rrEst > 30 && rrEst < 35
%             temp = [0 0 0 0 0 0 1 0];
%         else
%             temp = [0 0 0 0 0 0 0 1];
%         end
        result = [result; temp];
    end
end

result = result';
save('Training_Target.mat','result');

%% Original Data
% ecgSignalData = [];
% for i = 1:53
%     idx = num2str(i);
%     fileName = "_wins";
%     fileName = strcat(idx, fileName);
%     load(fileName);
%     
%     fileName = "_respSigs";
%     fileName = strcat(idx, fileName);
%     load(fileName, 'ekg_ELF_RSlinB_FMeam_FPt_RDtGC_EHF');
%     
%     win_start = wins.t_start(1);
%     countTemp1 = 0;
%     for k = 1:35
%         countTemp2 = abs(win_start - ekg_ELF_RSlinB_FMeam_FPt_RDtGC_EHF.t(k));
%         if countTemp2 < countTemp1
%             idx = k;
%         end
%         countTemp1 = countTemp2;
%     end
%     
%     for j = 1:(length(wins.t_start))
%         temp = [];
%         temp = ekg_ELF_RSlinB_FMeam_FPt_RDtGC_EHF.v(round(idx):round(idx+31*5-1));
%         temp = temp';
% %         if length(temp) < 4001
% %             temp(4001) = temp(4000);
% %         elseif length(temp) > 4001
% %             temp(end) = [];
% %         end
%         ecgSignalData = [ecgSignalData;temp];
%         idx = round(idx+31*5);
%     end
% end
% 
% ecgSignalData = ecgSignalData';
% save('ECG_Signal_Data.mat', 'ecgSignalData');

%% RR estimate
% fileName = "_rrEsts";
% for i = 1:53
%     idx = num2str(i);
%     fileName = "_rrEsts";
%     fileName = strcat(idx, fileName);
%     load(fileName, 'ekg_ELF_RSlinB_FMe__FPt_RDtGC_EHF_ARM_SFu_TFu', 'ppg_ELF_RSlinB_FMe__FPt_PDtIMS_EHF_PZX_SFu_TFu');
%     fprintf('Loop\n');
%     ECG_data(i).t = ekg_ELF_RSlinB_FMe__FPt_RDtGC_EHF_ARM_SFu_TFu.t;
%     ECG_data(i).v = ekg_ELF_RSlinB_FMe__FPt_RDtGC_EHF_ARM_SFu_TFu.v;
%     PPG_data(i).t = ppg_ELF_RSlinB_FMe__FPt_PDtIMS_EHF_PZX_SFu_TFu.t;
%     PPG_data(i).v = ppg_ELF_RSlinB_FMe__FPt_PDtIMS_EHF_PZX_SFu_TFu.v;
% end
% 
% save('ECG_RR_Data.mat', 'ECG_data');
% save('PPG_RR_Data.mat', 'PPG_data');