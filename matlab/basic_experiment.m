function basic_experiment(data, labels, params, fname)

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

uc = unique(labels);
NC = length(uc);

W = floor(.8*length(labels));

for c = 1:NC  % for each class 

  i = find(labels == uc(c));
  data_tr = data(labels ~= uc(c), :);
  data_te = data(labels == uc(c), :);
  data_te = [data_te ;  data(i(1), :)];

  labels_tr = labels(labels ~= uc(c), :);
  labels_te = labels(labels == uc(c), :);
  labels_te = [labels_te; labels(i(1), :)];

  [m_scores1, s_scores1, m_scores_null1, s_scores_null1, err1] ...
    = b2agging(data_tr, data_te, labels_tr, labels_te, params);


  data_tr = data(1:W, :);
  data_te = data(W+1:end, :);

  labels_tr = labels(1:W, :);
  labels_te = labels(W+1:end, :);
  [m_scores2, s_scores2, m_scores_null2, s_scores_null2, err2] ...
    = b2agging(data_tr, data_te, labels_tr, labels_te, params);

  %disp('Variances')
  %disp(['Biased: ', num2str(mean(mean(s_scores1))),'  ', num2str(std(mean(s_scores1,2)))])
  %disp(['Null 1: ', num2str(mean(mean(s_scores_null1))), '  ', num2str(std(mean(s_scores_null1,2)))])
  %disp(['Regular: ', num2str(mean(mean(s_scores2))), '  ', num2str(std(mean(s_scores2,2)))])
  %disp(['Null 2: ', num2str(mean(mean(s_scores_null2))), '  ', num2str(std(mean(s_scores_null2,2)))])
  %disp(' ')
  
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
save(fname);
disp(['Saving to ', fname]);