clc;
clear;
close all;

co = [0 0 1; 0 0.5 0; 1 0 0; 0 0.75 0.75; 0.75 0 0.75; 0.75 0.75 0; 0.25 0.25 0.25];

load results/ocr_n15_b50.mat;
s_mms_n15 = s_mms;
s_sms_n15 = s_sms;
m_mms_n15 = m_mms;
m_sms_n15 = m_sms;
clearvars -except s_mms_n15 s_sms_n15 m_mms_n15 m_sms_n15

load results/ocr_n50_b50.mat;
s_mms_n50 = s_mms;
s_sms_n50 = s_sms;
m_mms_n50 = m_mms;
m_sms_n50 = m_sms;
clearvars -except s_mms_n15 s_sms_n15 m_mms_n15 m_sms_n15 s_mms_n50 s_sms_n50 m_mms_n50 m_sms_n50

load results/ocr_n50_b50.mat;
s_mms_n100 = s_mms;
s_sms_n100 = s_sms;
m_mms_n100 = m_mms;
m_sms_n100 = m_sms;
clearvars -except s_mms_n15 s_sms_n15 m_mms_n15 m_sms_n15 s_mms_n50 s_sms_n50 m_mms_n50 m_sms_n50 s_mms_n100 s_sms_n100 m_mms_n100 m_sms_n100

figure; 
bar(s_mms_n15)
legend('NC', 'Normal', 'Null')
set(gca, 'fontsize', 20)

figure; 
bar(s_mms_n50)
legend('NC', 'Normal', 'Null')
set(gca, 'fontsize', 20)

figure; 
bar(s_mms_n100)
legend('NC', 'Normal', 'Null')
set(gca, 'fontsize', 20)
