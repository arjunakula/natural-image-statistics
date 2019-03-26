img = imread('natural_scene_1.jpg');
img_gray = rgb2gray(img);
img_scaled = img_gray*(31/255);

fft_img = fft(img_scaled);
amp_img = zeros(size(fft_img,1),size(fft_img,2));

max_amp = 0;
rows = size(fft_img,1);
cols = size(fft_img,2);
for i = 1:rows
    for j = 1:cols
        amp_img(i,j) = abs(fft_img(i,j));
        if(amp_img(i,j) > max_amp)
            max_amp = amp_img(i,j);
        end
    end
end

%discretize f
% f = [];
% for i = 1:31
%     for j = 1:31
%         f(end+1) = sqrt(i*i + j*j);
%     end
% end
f = 1:max_amp;

%f = sort(f);
max_f_index = 0;
total_fourier_power = [];

new_amp_vector = reshape(amp_img,[1,rows*cols]);
new_amp_vector = sort(new_amp_vector);

% for i = 1:length(f)
%     i
%     if(f(i) > max_amp)
%         max_f_index = i;
%         break;
%     end
%     pwr = 0;
pwr = 0;
k = 0.01;
items = 0;
for d1 = 1:length(new_amp_vector)
    %for d1 = 1:10
    d1
    
    if(new_amp_vector(d1) <= k)
        items = items+1;
        pwr = pwr+(new_amp_vector(d1)*new_amp_vector(d1));
        %amp_img(d1,d2) = 0;
    else
        
        if(items == 0)
            total_fourier_power(end+1) = 0;
        else
            total_fourier_power(end+1) = pwr/items;
        end
        
        items = 0;
        pwr = 0;
        k = k+0.01;
    end
    
end

%end
%
% % 2.1 logAf vs logf
% save('214_p.mat','total_fourier_power','-mat','-v7.3');
% % %save('211_p.mat','total_fourier_power','-mat','-v7.3');
% %
% load('211_p.mat');
% plot(log(0.01:0.01:(length(total_fourier_power)/100)),log(sqrt(total_fourier_power)),'r');
% hold on;
% load('212_p.mat');
% plot(log(0.01:0.01:(length(total_fourier_power)/100)),log(sqrt(total_fourier_power)),'g');
% hold on;
% load('213_p.mat');
% plot(log(0.01:0.01:(length(total_fourier_power)/100)),log(sqrt(total_fourier_power)),'b');
% hold on;
% load('214_p.mat');
% plot(log(0.01:0.01:(length(total_fourier_power)/100)),log(sqrt(total_fourier_power)),'c');
% hold on;
% legend('image1','image2','image3','image4');


% %1.2
S = [];
fo = [];
k = 0.001;
pwr = 0;
for d1 = 1:length(new_amp_vector)
    if(k >= (length(total_fourier_power)/100)+1)
        break
    end
    
    if(new_amp_vector(d1) <= k+0.001)
        pwr = pwr+new_amp_vector(d1)*new_amp_vector(d1);
        %amp_img(d1,d2) = 0;
    else
        S(end+1) = pwr;
        fo(end+1) = k;
        pwr = 0;
        k = k+0.001;
    end
end
