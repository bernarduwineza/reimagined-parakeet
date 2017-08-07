clc; close all; clear all;

tic 

L=1024;     %Image dimensions
n=8;        %Stride length

currentDir = '/home/buwienza/vcFiler/dresden_spliced';      %Define the current directory being used
filePattern = fullfile(currentDir, '*_rgb.png');       %Define the pattern of files in the directory
pngFiles = dir(filePattern);        % List of images in the directory
mkdir('dresden_features');      %Directory in which to save features


for k = 1:length(pngFiles)
	baseFileName = pngFiles(k).name;        %Obtain the individual names of the image files
	fullFileName = fullfile(currentDir, baseFileName);      %Construct the full file names of the files

    I=imread(fullFileName);
%   should be something like:   I=imread('C:\File Transfer\WorkStation\Joshua Tree\The-Arch-Rock.jpg');

I=imresize(I, [L L]);       %Resize the image
    I1=I;
    I=rgb2gray(I);

    F=zeros(L,L,4);     

    D=zeros(size(I));
    
    M=size(I,1)/n;
    for i=1:M 
        for j=1:M
            D(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)) = dct2(I(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n))); % the most important part 
        end
    end
    
         F(:,:,1:3)=(I1);       %Make first three channels RGB values of the image
         F(:,:,4)=D;            % Make the fourth channel DCT features 
         
         
%         [folderName, name, ~] = fileparts(fullFileName);

        [~,filename,ext] = fileparts(fullFileName);         %Get file names
        newFileName = sprintf ('%s_dct%s',filename,ext);          %Generate new file name 
        destFileName = fullfile('/home/buwienza/vcFiler/dresden_features', newFileName);
        imwrite (D, destFileName);     %Write the extracted feature files to destiantion folder
           
         
        
%     figure; imshow(I)
%     figure; imshow(D)

end 

disp ('Feature extraction complete.'); 

   
toc
