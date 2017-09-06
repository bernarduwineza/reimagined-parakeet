%% DCT feature extraction for Segmentation.


%% Main Code 

tic 

clc; close all; clear all;

L=1024;     %Image dimensions
n=8;        %Stride 

currentDir = '/home/buwienza/vcFiler/dresden_spliced/';      %Define the current directory being used
rgbFiles = dir(fullfile(currentDir, '*_rgb.png')); % List of rgb images in the directory
% maskFiles = dir(fullfile(currentDir, '*_mask.png')); % List of masks 


%mkdir('dresden_ftrs');      %Directory in which to save features
N = length(rgbFiles);
F=zeros(L,L,4); 

feat = zeros(100, 1024, 1024, 4); 
mask = zeros(100, 1024, 1024);
 
 

 for k = 1: N %length(pngFiles)    
     disp(sprintf('Extracting dct features for image number %d',k))
     %I_rgb = imread(strcat(currentDir,'/',rgbFiles(k).name));
     %I_mask =imread(strcat(currentDir,'/',maskFiles(k).name));

     s=rgbFiles(k).name;
     image_Id=strrep(s,'_rgb.png','');
     t1=strcat(image_Id,'_rgb.png');
     t2=strcat(image_Id,'_mask.png');
     I_rgb=imread(strcat(currentDir,t1));
     I_mask=imread(strcat(currentDir,t2));
     
     I_rgb=imresize(I_rgb, [L L]);       %Resize the image
     I1=I_rgb;
     I_gray=rgb2gray(I_rgb);

%     F=zeros(L,L,4);     

     D=zeros(size(I_gray));
    
     M=size(I_gray,1)/n; 
     for i=1:M 
         for j=1:M
             D(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)) = dct2(I_gray(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)));
         end
     end
    
     F(:,:,1:3)=(I1);       % Make first three channels RGB values of the image
     F(:,:,4)=D;            % Make the fourth channel DCT features 
         
%    feat = zeros(10, 1024, 1024, 4);
%    mask = zeros(10, 1024, 1024);
     if k<100                % Proper indexing loop
         indices = k;
     elseif mod(k,100)==0
         indices = 100;
     else
         indices = mod(k, 100);
     
     end 
%          
     feat(indices,:,:,:) = F;
     mask(indices,:,:) = I_mask; 
     
%% Indexing and saving the file...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The index in the saved file indicates that the file contains 100
    % images (both RGB and Groung Truth masks) preceding that index. 
    % For example: dct_features_300 will contain images from 00201_rgb.png
    % to 00300_rgb.png 
    % NOTE: The absolute indices are not preserved within the saved file.
    % 00201_rgb.png will have 1 as an index. 00273_rgb.png will have 73 as an index. 00300_rgb.png
    % will have 100 as an index. 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    if mod(k, 100)==0
         index = int2str(k);
         
         
         name = strcat ('dct_features_', index , '.mat');       
         
         disp(sprintf('Saving feature file...'))
         save(name,'feat','mask', '-v7.3');  
         
     end
%%  

 end 

  
disp ('Feature extraction complete!'); 
toc