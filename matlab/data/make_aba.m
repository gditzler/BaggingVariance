clc
clear
close all

load abalone_dataset
data = abaloneInputs';
labels = abaloneTargets';

nc = [];
uc = unique(labels);
for c = 1:length(uc)
  nc(c) = sum(labels==uc(c));
end
bad = find(nc < 150);


for c = 1:length(bad)
  q = [];
  for n = 1:length(labels)
    if labels(n) == bad(c)
      q(end+1) = n;
    end
  end
  data(q, :) = [];
  labels(q) = [];
end

u = unique(labels);
p = [];
labels2 = labels;
for i = 1:length(u)
  labels2(labels == u(i)) = i;
end
labels = labels2;


% for c = 1:numel(j)
% %   disp(j(c))
%   data(labels==j(c),:) = [];
%   labels(labels==j(c)) = [];
% end
% 
% nc= [];
% uc = unique(labels);
% for c = 1:length(uc)
%   nc(c) = sum(labels==uc(c));
% end
% 
% 
% u = unique(labels);
% p = [];
% for i = 1:length(u)
%   p(i) = sum(labels == u(i));
% end
data(find(labels == 9), :) = [];
labels(find(labels == 9), :) = [];
% labels(find(labels == 11), :) = [];

% 
% u = unique(labels);
% p = [];
% labels2 = labels;
% for i = 1:length(u)
%   labels2(labels == u(i)) = i;
% end
% labels = labels2;


clearvars -except data labels

save('abalone.mat')
