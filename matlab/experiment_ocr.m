%% run the exper
clc;
clear;
close all; 

% set up the parameters of the experiment
model.type = 'CART'; 
params.n_classifiers = 15;
params.bootstraps = 50;
params.fraction = 1;
params.rf = .5;


s_mms_single_class = zeros(10,1);
s_sms_single_class = zeros(10,1);
s_mms_multi_class = zeros(10,1);
s_sms_multi_class = zeros(10,1);
s_mms_null = zeros(10,1);
s_sms_null = zeros(10,1);

m_mms_single_class = zeros(10,1);
m_sms_single_class = zeros(10,1);
m_mms_multi_class = zeros(10,1);
m_sms_multi_class = zeros(10,1);
m_mms_null = zeros(10,1);
m_sms_null = zeros(10,1);

load data/ocr.mat

for c = 1:10  % for each class 

  i = find(labels == c);
  data_tr = data(labels ~= c, :);
  data_te = data(labels == c, :);
  data_te = [data_te ;  data(i(1), :)];

  labels_tr = labels(labels ~= c, :);
  labels_te = labels(labels == c, :);
  labels_te = [labels_te; labels(i(1), :)];

  [m_scores1, s_scores1, m_scores_null1, s_scores_null1, err1] ...
    = b2agging(data_tr, data_te, labels_tr, labels_te, params);


  data_tr = data(1:5000, :);
  data_te = data(5001:end, :);

  labels_tr = labels(1:5000, :);
  labels_te = labels(5001:end, :);
  [m_scores2, s_scores2, m_scores_null2, s_scores_null2, err2] ...
    = b2agging(data_tr, data_te, labels_tr, labels_te, params);

  disp('Variances')
  disp(['Biased: ', num2str(mean(mean(s_scores1))),'  ', num2str(std(mean(s_scores1,2)))])
  disp(['Null 1: ', num2str(mean(mean(s_scores_null1))), '  ', num2str(std(mean(s_scores_null1,2)))])
  disp(['Regular: ', num2str(mean(mean(s_scores2))), '  ', num2str(std(mean(s_scores2,2)))])
  disp(['Null 2: ', num2str(mean(mean(s_scores_null2))), '  ', num2str(std(mean(s_scores_null2,2)))])
  disp(' ')
  
  s_mms_single_class(c) = mean(mean(s_scores1));
  s_sms_single_class(c) = std(mean(s_scores1,2));
  s_mms_multi_class(c) = mean(mean(s_scores2));
  s_sms_multi_class(c) = std(mean(s_scores2));
  s_mms_null(c) = mean(mean(s_scores_null1));
  s_sms_null(c) = std(mean(s_scores_null1,2));
  
  m_mms_single_class(c) = mean(mean(m_scores1));
  m_sms_single_class(c) = std(mean(m_scores1,2));
  m_mms_multi_class(c) = mean(mean(m_scores2));
  m_sms_multi_class(c) = std(mean(m_scores2));
  m_mms_null(c) = mean(mean(m_scores_null2));
  m_sms_null(c) = std(mean(m_scores_null2,2));
end 

s_mms = [s_mms_single_class s_mms_multi_class s_mms_null];
s_sms = [s_sms_single_class s_sms_multi_class s_sms_null];
m_mms = [m_mms_single_class m_mms_multi_class m_mms_null];
m_sms = [m_sms_single_class m_sms_multi_class m_sms_null];
fname = ['results/ocr_n', num2str(params.n_classifiers),'_b', ...
  num2str(params.bootstraps), '.mat'];
save(fname);
disp(['Saving to ', fname]);
%% plot
