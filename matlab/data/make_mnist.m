clc
clear
close all


load mnist_uint8

train_x = double(train_x) / 255;
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);



data = [train_x;test_x];
labels = [sum((repmat(0:9, size(train_y,1), 1)+1).*train_y, 2); ...
    sum((repmat(0:9, size(test_y,1), 1)+1).*test_y, 2)];
  
  
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

clear train_x train_y test_x test_y
save('mnist.mat')