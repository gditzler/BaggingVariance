clc;
clear;
close all;

addpath('data/')
datas = {'abalone.csv'
'annealing_train.csv'
'arrhythmia.csv'
'audiology-std_train.csv'
'balance-scale.csv'
'breast-tissue.csv'
'car.csv'
'cardiotocography-10clases.csv'
'cardiotocography-3clases.csv'
'chess-krvk.csv'
'conn-bench-vowel-deterding_train.csv'
'contrac.csv'
'dermatology.csv'
'ecoli.csv'
'energy-y1.csv'
'energy-y2.csv'
'flags.csv'
'glass.csv'
'hayes-roth_train.csv'
'heart-cleveland.csv'
'heart-switzerland.csv'
'heart-va.csv'
'image-segmentation_train.csv'
'iris.csv'
'led-display.csv'
'lenses.csv'
'letter.csv'
'libras.csv'
'low-res-spect.csv'
'lung-cancer.csv'
'lymphography.csv'
'molec-biol-splice.csv'
'nursery.csv'
'oocytes_merluccius_states_2f.csv'
'oocytes_trisopterus_states_5b.csv'
'optical_train.csv'
'page-blocks.csv'
'pendigits_train.csv'
'pittsburg-bridges-MATERIAL.csv'
'pittsburg-bridges-REL-L.csv'
'pittsburg-bridges-SPAN.csv'
'pittsburg-bridges-TYPE.csv'
'plant-margin.csv'
'plant-shape.csv'
'plant-texture.csv'
'post-operative.csv'
'primary-tumor.csv'
'seeds.csv'
'semeion.csv'
'soybean_train.csv'
'statlog-image.csv'
'statlog-landsat_train.csv'
'statlog-shuttle_train.csv'
'statlog-vehicle.csv'
'steel-plates.csv'
'synthetic-control.csv'
'teaching.csv'
'thyroid_train.csv'
'vertebral-column-3clases.csv'
'wall-following.csv'
'waveform-noise.csv'
'waveform.csv'
'wine-quality-red.csv'
'wine-quality-white.csv'
'wine.csv'
'yeast.csv'
'zoo.csv'
         };

% set up the parameters of the experiment
model.type = 'CART'; 
params.n_classifiers = 100 ;
params.bootstraps = 50;
params.fraction = 1;
params.rf = .5;

delete(gcp('nocreate'))
parpool(5);

for d = 1:length(datas)
  disp(['Running ', datas{d}]);
  fname = ['results/',strrep(datas{d},'.csv',''),'_n', num2str(params.n_classifiers),'_b', ...
    num2str(params.bootstraps),'_rf', num2str(100*params.rf), '_f', ...
    num2str(100*params.fraction), '.mat'];
  load(datas{d});
  try
   basic_experiment(data, labels, params, fname)
  catch 
   disp(['Error on ', datas{d}]);
  end
end