clc
clear
close all

% 1) S1 "Suit of card #1" 
%   Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs} 
% 2) C1 "Rank of card #1" 
%   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King) 
% 3) S2 "Suit of card #2" 
%   Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs} 
% 4) C2 "Rank of card #2" 
%   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King) 
% 5) S3 "Suit of card #3" 
%   Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs} 
% 6) C3 "Rank of card #3" 
%   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King) 
% 7) S4 "Suit of card #4" 
%   Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs} 
% 8) C4 "Rank of card #4" 
%   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King) 
% 9) S5 "Suit of card #5" 
%   Ordinal (1-4) representing {Hearts, Spades, Diamonds, Clubs} 
% 10) C5 "Rank of card 5" 
%   Numerical (1-13) representing (Ace, 2, 3, ... , Queen, King) 
% 11) CLASS "Poker Hand" 
%   Ordinal (0-9) 

poker = load('poker-hand-training-true.data.txt');

labels = poker(:, end)+1;

[~,~,feature] = unique(poker(:, 1));
f1 = zeros(length(feature), numel(unique(feature)));
for i = 1:length(feature)
  f1(i, feature(i)) = 1;
end

f2 = poker(:, 1);

[~,~,feature] = unique(poker(:, 3));
f3 = zeros(length(feature), numel(unique(feature)));
for i = 1:length(feature)
  f3(i, feature(i)) = 1;
end

f4 = poker(:, 4);

[~,~,feature] = unique(poker(:, 5));
f5 = zeros(length(feature), numel(unique(feature)));
for i = 1:length(feature)
  f5(i, feature(i)) = 1;
end

f6 = poker(:, 6);

[~,~,feature] = unique(poker(:, 7));
f7 = zeros(length(feature), numel(unique(feature)));
for i = 1:length(feature)
  f7(i, feature(i)) = 1;
end

f8 = poker(:, 8);

[~,~,feature] = unique(poker(:, 9));
f9 = zeros(length(feature), numel(unique(feature)));
for i = 1:length(feature)
  f9(i, feature(i)) = 1;
end

f10 = poker(:, 10);

data = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10];

clearvars -except data labels

labels(labels == 4) = 3;
labels(labels == 5) = 3;
labels(labels == 6) = 3;
labels(labels == 7) = 3;
labels(labels == 8) = 3;
labels(labels == 9) = 3;
labels(labels == 10) = 3;

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
save('poker.mat');
