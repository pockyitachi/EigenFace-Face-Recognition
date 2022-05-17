clc, clear all;
training_set=[];                                         
 % read 40 images from the training set
 % For each image make it 1 x (480 * 640)
 for i=1:40
       a=imread(strcat('Training2/',num2str(i),'.jpg'));          
       b=a(1:480*640);                                 
       b=double(b);                                 
       training_set=[training_set;b];                  
 end
 % Find the mean of the 1D array
 meanFace=mean(training_set);   
 % Reshape the 1D array back to 480 x 640
 figure,imshow(mat2gray(reshape(meanFace,480,640))); %mat2gray=matrix to grayscale image
%%
% For each image, substract the mean face
for i=1:40
    X(i,:)=training_set(i,:)-meanFace;
    
    % Mean is float
end
figure,
subplot(1,2,1),imshow(mat2gray(reshape(training_set(5,:),480,640))); title('Sample Image');   
subplot(1,2,2),imshow(mat2gray(reshape(X(5,:),480,640))); title('Sample Image - meanFace');
%%
k=40;                       % top K

Sigma=X*X';                 % covariance matrix，M×M

[V,D]=eigs(Sigma,k);        
%%
E=X'*V;                     % Each column is a Eigenface，k columns
figure;

for i=1:40

subplot(5,8,i),imshow(mat2gray(reshape(E(:,i),480,640)));     

title(strcat('k=',num2str(i)));



end
%%
Train_E=training_set*E;    
%%
testing_set=[]; 
N = 20;
num = 40;
% pick 20 randomly from 40
p = randperm(num);
c = p(1:N);
for i=1:N
       a=imread(strcat('Testing2/T_imgo',num2str(i),'.jpg'));           
       b=a(1:480*640);                                 
       b=double(b);                                   
       testing_set=[testing_set;b];                          
end
Test_E=testing_set*E;

%%
correct=0;                  
for i=1:20
    for j=1:40
       error(j)=norm(Test_E(i,:)-Train_E(j,:));
    end
   [ERROR,I]=sort(error);
   true_class=ceil(i);   
   for m=1:3                 
        recog_classes(m)=ceil(I(m));  
   end
    recog_class=mode(recog_classes);
    if true_class==recog_class
       correct=correct+1;  
    end
end
accuracy=correct/20;      


