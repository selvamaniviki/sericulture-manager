%%%%%%%%%%%SERICULTURE%%%%%%%%%%%%%%

clc;

clear;

close all;

warning off



%%%%% TRAIN THE DATASET IMAGES %%%%%
  
matlabroot='D:\notes\project\2nd\code';

data1 = fullfile(matlabroot,'TRAINING IMAGES');
Data=imageDatastore(data1,'IncludeSubfolders',true,'LabelSource','foldernames');

validationPath = fullfile(matlabroot,'TESTING IMAGES');
imdsValidation = imageDatastore(validationPath, ...    
'IncludeSubfolders',true,'LabelSource','foldernames');

%% CREATE CONVOLUTIONAL NEURAL NETWORK LAYERS %%%TRAINING%%%


 layers=[imageInputLayer([250 250 3])  
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,64,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,128,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)    
%     
%     convolution2dLayer(3,256,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options=trainingOptions('sgdm','MaxEpochs',50,'InitialLearnRate',0.0001,'Shuffle','every-epoch', ...    
    'ValidationData',imdsValidation, ...        
    'ValidationFrequency',30,...        
    'Verbose',false, ...        
    'Plots','training-progress');

 convnet=trainNetwork(Data,layers,options);

 save convnet.mat convnet



%%% CLASSIFY VALIDATION IMAGES AND COMPUTE ACCURACY % % % % %

YPred = classify(convnet,imdsValidation);

YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation);

% % TRAINING% % % 
% % % % 
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%