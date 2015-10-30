clc
clear
close all

fileID = fopen('car.data');

f1 = {};
f2 = {};
f3 = {};
f4 = {};
f5 = {};
f6 = {};
cc = {};

tline = fgets(fileID);
while ischar(tline)
    tline = fgets(fileID);
    if ischar(tline)
      C = strsplit(tline, ',');
      f1{end+1} = C{1};
      f2{end+1} = C{2};
      f3{end+1} = C{3};
      f4{end+1} = C{4};
      f5{end+1} = C{5};
      f6{end+1} = C{6};
      cc{end+1} = C{7};
    end
    
end
fclose(fileID);

[~,~,labels] = unique(cc);

[~,~,feature1] = unique(f1);
f1 = zeros(length(feature1), numel(unique(feature1)));
for i = 1:length(feature1)
  f1(i, feature1(i)) = 1;
end

[~,~,feature2] = unique(f2);
f2 = zeros(length(feature2), numel(unique(feature2)));
for i = 1:length(feature2)
  f2(i, feature2(i)) = 1;
end


[a,b,feature3] = unique(f3);
f3 = zeros(length(feature3), 1);
for i = 1:length(feature3)
  if feature3(i)==1
    f3(i) = 2;
  end
  if feature3(i)==2
    f3(i) = 3;
  end
  if feature3(i)==3
    f3(i) = 4;
  end
  if feature3(i)==4
    f3(i) = 5;
  end
end

[a,b,feature4] = unique(f4);

f4 = zeros(length(feature4), 1);
for i = 1:length(feature4)
  if feature4(i)==1
    f4(i) = 2;
  end
  if feature4(i)==2
    f4(i) = 4;
  end
  if feature4(i)==3
    f4(i) = 6;
  end
end

[~,~,feature5] = unique(f5);
f5 = zeros(length(feature5), numel(unique(feature5)));
for i = 1:length(feature5)
  f5(i, feature5(i)) = 1;
end

[~,~,feature6] = unique(f6);
f6 = zeros(length(feature6), numel(unique(feature6)));
for i = 1:length(feature6)
  f6(i, feature6(i)) = 1;
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

data = [f1 f2 f3 f4 f5 f6];
clearvars -except data labels
save('cars.mat')



