clc
clear
close all


load wine_dataset


data = wineInputs';
labels = sum(repmat([1;2;3], 1, 178).*wineTargets)';
i = randperm(length(labels));
data = data(i,:);
labels = labels(i);

u = unique(labels);
p = [];
for i = 1:length(u)
  p(i) = sum(labels == u(i));
end
u = unique(labels);
p = [];
labels2 = labels;
for i = 1:length(u)
  labels2(labels == u(i)) = i;
end
labels = labels2;

clearvars -except data labels
save('wine.mat')