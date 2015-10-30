%%
clc
clear
close all 

load covtype.data
labels = covtype(:,end);
data = covtype(:,1:end-1);

c1 = find(labels == 1);
c2 = find(labels == 2);
c3 = find(labels == 3);
c4 = find(labels == 4);
c5 = find(labels == 5);
c6 = find(labels == 6);
c7 = find(labels == 7);
mval = min([numel(c1) numel(c2) numel(c3) numel(c4) numel(c5) numel(c6) numel(c7)]);

c1 = c1(1:mval);
c2 = c2(1:mval);
c3 = c3(1:mval);
c4 = c4(1:mval);
c5 = c5(1:mval);
c6 = c6(1:mval);
c7 = c7(1:mval);

data = [data(c1,:);data(c2,:);data(c3,:);data(c4,:);data(c5,:);data(c6,:);data(c7,:)];
labels = [labels(c1,:);labels(c2,:);labels(c3,:);labels(c4,:);labels(c5,:);labels(c6,:);labels(c7,:)];

i = randperm(length(labels));
data = data(i, :);
labels = labels(i, :);


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
save('covtype.mat')