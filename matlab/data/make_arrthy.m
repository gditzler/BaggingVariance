clc
clear
close all

load arrhythmia

data = X;
labels = Y;

nc = [];
uc = unique(labels);
for c = 1:length(uc)
  nc(c) = sum(labels==uc(c));
end
j = find(nc < 50);

for c = 1:j
  disp(j(c))
  data(labels==c,:) = [];
  labels(labels==c) = [];
end

nc= [];
uc = unique(labels);
for c = 1:length(uc)
  nc(c) = sum(labels==uc(c));
end


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
save('arrhy.mat')
