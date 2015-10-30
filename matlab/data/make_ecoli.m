clc
clear
close all

% cat ecoli.data.txt | tr -s " " | tr ' ' '\t' | awk -F '\t' '{print $2,$3,$4,$5,$6,$8}' | tr ' ' ',' > ecoli-fix.data 
% cat ecoli.data.txt | tr -s " " | tr ' ' '\t' | awk -F '\t' '{print $9}'  > ecoli-fix.labels

data = importdata('ecoli-fix.data');
[~,~,labels] = unique(importdata('ecoli-fix.labels'));
i = randperm(length(labels));
data = data(i,:);
labels = labels(i);

nc = [];
uc = unique(labels);
for c = 1:length(uc)
  nc(c) = sum(labels==uc(c));
end
bad = find(nc < 50);

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


clearvars -except data labels

save('ecoli.mat');