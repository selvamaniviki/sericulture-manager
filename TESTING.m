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