clc
clear
close all

d = importdata('letter.txt');

data = d.data;
[~,~,labels] = unique(d.textdata);
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
save('letter.mat');