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

% 
%  layers=[imageInputLayer([250 250 3])  
%     
%     convolution2dLayer(3,8,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,16,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,32,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,64,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)
%     
%     convolution2dLayer(3,128,'Padding','same')
%     batchNormalizationLayer
%     reluLayer
%     
%     maxPooling2dLayer(2,'Stride',2)    
% %     
% %     convolution2dLayer(3,256,'Padding','same')
% %     batchNormalizationLayer
% %     reluLayer
% %     
% %     maxPooling2dLayer(2,'Stride',2)
%     
%     fullyConnectedLayer(2)
%     softmaxLayer
%     classificationLayer];
% 
% options=trainingOptions('sgdm','MaxEpochs',50,'InitialLearnRate',0.0001,'Shuffle','every-epoch', ...    
%     'ValidationData',imdsValidation, ...        
%     'ValidationFrequency',30,...        
%     'Verbose',false, ...        
%     'Plots','training-progress');
% 
%  convnet=trainNetwork(Data,layers,options);
% 
%  save convnet.mat convnet
% 
% 
% 
% %%% CLASSIFY VALIDATION IMAGES AND COMPUTE ACCURACY % % % % %
% 
% YPred = classify(convnet,imdsValidation);
% 
% YValidation = imdsValidation.Labels;
% 
% accuracy = sum(YPred == YValidation)/numel(YValidation);

% % TRAINING% % % 
% % % % 
% % % %  %%%%%%%%%%READ THE IMAGE FROM THE DATASET %%%%%%%%%%%
% % % %TESTING % % % % 
 load convnet.mat
[filename,pathname]=uigetfile('*.*'); 

im1=imread([pathname,filename]);

figure,imshow(im1),title('INPUT IMAGE');
% 
% 
% %%%%%%% RESIZE THE IMAGE %%%%%%%%%%
% 
%  
im=imresize(im1,[250 250]);

figure,imshow(im),title('Resized image');

% % % %%%%%%%%%%% CONVERT THE DATA TYPE INTO UNSIGNED INTEGER %%%%%%%%%%%
re=im2uint8(im);
% 

%%%% TO  CLASSIFY THE OUTPUT %%%%%%% 

output=classify(convnet,re);
tf1=[];

for ii=1:2
    st=int2str(ii)
    tf=ismember(output,st);
    tf1=[tf1 tf];
end

output1=find(tf1==1);

if output1==1
     
    msgbox('HEALTHY')
    
elseif output1==2
     
    msgbox('UNHEALTHY')
      

end
% % % %TESTING % % 
% arduino=serial('COM5','BaudRate',9600); % create serial communication object 
% % fopen(arduino); % initiate arduino communication
% % fprintf(arduino, '%s', char(output1)); % send answer variable content to arduino
% % fclose(arduino);
% 
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%