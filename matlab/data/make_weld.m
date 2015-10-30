clc
clear
close all

load Weld' Inspection'/allclass.mat
load Weld' Inspection'/alldata.mat


data = alldata;
labels = sum(repmat(1:4,1800,1).*allclass, 2);


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
save('weld.mat')