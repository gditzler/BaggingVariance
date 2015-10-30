% convert the 4 ocr files into a single file that has the data and labels,
% where the labels are stored as an integer vector rather than a 1-hot
% code.
clc;
clear;
close all;

load opt_class
load opt_train
load opt_test
load opttest_class

data = [opt_train;opt_test];
labels = [sum((repmat(0:9, size(opt_class,1), 1)+1).*opt_class, 2); ...
    sum((repmat(0:9, size(opttest_class,1), 1)+1).*opttest_class, 2)];
  
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
save('ocr.mat')