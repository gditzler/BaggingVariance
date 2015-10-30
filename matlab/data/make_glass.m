
clc
clear
close all

load glass.data.txt

data = glass_data(:, 1:end-1);
labels = glass_data(:, end);

i = randperm(numel(labels));
labels = labels(i);
data = data(i,:);

u = unique(labels);
p = [];
for i = 1:length(u)
  p(i) = sum(labels == u(i));
end


for i=[3 6 7]
  data(labels==i, :) = [];
  labels(labels==i) = [];
end

u = unique(labels);
p = [];
labels2 = labels;
for i = 1:length(u)
  labels2(labels == u(i)) = i;
end
labels = labels2;


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
save('glass.mat');
