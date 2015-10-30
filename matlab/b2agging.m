function [m_scores, s_scores, m_scores_null, s_scores_null, err] = b2agging(data_tr, data_te, labels_tr, labels_te, params)
% [m_scores, s_scores, m_scores_null, s_scores_null, err] = b2agging(data_tr, data_te, labels_tr, labels_te, params)
% 
% Inputs 
%   data_tr: matrix of size 
%   data_te: 
%   labels_tr: column array of class labels 
%   labels_te: column array of class labels
%   params: 
% Outputs 
%    m_scores: probabilitiy estimates (test)
%    s_scores: error bar estimates on the probabilities
%    m_scores_null: probabilitiy estimates (train)  
%    s_scores_null: error bar estimates on the probabilities (train)
%    err: classification error


ntr = length(labels_tr);
nft = size(data_tr, 2);
nrf = floor(nft*params.rf);

classifiers = cell(params.n_classifiers, 1);
fsets = cell(params.n_classifiers, 1);

% training phase 
parfor t = 1:params.n_classifiers
  i = randsample(1:ntr, ntr, true);
  j = randperm(nft);
  j = j(1:nrf);
  classifiers{t} = fitctree(data_tr(i, j), labels_tr(i));
  fsets{t} = j;
end

% testing phase 
m_scores = zeros(size(data_te, 1), length(unique(labels_tr)));
s_scores = zeros(size(data_te, 1), length(unique(labels_tr)));

for n = 1:params.bootstraps
  scores_tmp = zeros(size(data_te, 1), length(unique(labels_tr)));
  i = randsample(1:params.n_classifiers, floor(params.n_classifiers*params.fraction), true);
  for j = i
    tr = classifiers{j};
    [~, s] = predict(tr, data_te(:, fsets{j}));
    if size(s,2) ~= size(scores_tmp,2)
      dd=1;
    end
    scores_tmp = scores_tmp + s;
  end
  
  m_scores = m_scores+scores_tmp/length(i);
  s_scores = s_scores+(scores_tmp/length(i)).^2;
end

m_scores = m_scores/params.bootstraps;
s_scores = sqrt(s_scores/params.bootstraps-(m_scores).^2);
[~, yhat] = max(m_scores');
yhat = yhat';
err = sum(labels_te ~= yhat)/numel(yhat);


% null model 
m_scores_null = zeros(size(data_tr, 1), length(unique(labels_tr)));
s_scores_null = zeros(size(data_tr, 1), length(unique(labels_tr)));

for n = 1:params.bootstraps
  scores_tmp = zeros(size(data_tr, 1), length(unique(labels_tr)));
  i = randsample(1:params.n_classifiers, floor(params.n_classifiers*params.fraction), true);
  for j = i
    tr = classifiers{j};
    [~, s] = predict(tr, data_tr(:, fsets{j}));
    scores_tmp = scores_tmp + s;
  end
  
  m_scores_null = m_scores_null+scores_tmp/length(i);
  s_scores_null = s_scores_null+(scores_tmp/length(i)).^2;
end

m_scores_null = m_scores_null/params.bootstraps;
s_scores_null = sqrt(s_scores_null/params.bootstraps-(m_scores_null/params.bootstraps).^2);
