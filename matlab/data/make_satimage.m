clc
clear
close all


load satimage.txt
data = satimage(:,1:end-1);
labels = satimage(:,end);

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

save('satimage.mat')
