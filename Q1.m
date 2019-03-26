%read image
img = imread('natural_scene_1.jpg');
img_gray = rgb2gray(img);
img_scaled = img_gray*(31/255);

% 1.6 
% min = 0;
% max = 31;
% r = (max-min).*rand(10000,1) + min;
% img_scaled = reshape(r,[1,100*100]);

% convolve the image
img_conv = zeros(size(img_scaled,1),size(img_scaled,2));
rows = size(img_scaled,1);
cols = size(img_scaled,2);
for i = 1:rows
    for j = 1:cols
        
        if j==cols
            img_conv(i,j) = int16(img_scaled(i,j));
        else
            b1 = img_scaled(i,j);
            b2 = img_scaled(i,j+1);
            b = int16(b1)-int16(b2);
            if(b==0)
            img_conv(i,j) = 0.01;
            else
                img_conv(i,j) = b;
            end
        end
    end
end

% 
% %1.1 plot H(z) and logH(z)
% h1 = histfit(reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]));
% xlim([-31,31])
%  xlabel('z')
% ylabel('H(z)')
% hold on;
% 
%  [h1,bins] = hist(reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]));
% plot(bins,log(h1))
%  %xlim([-31,31])
%  xlabel('z')
%  ylabel('logH(z)')


% % 1.2 compute mean, variance and kurtosis
[h1,bins] = hist(reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]));
mean_hist = (h1*bins')/sum(h1);
var_hist = (((bins-mean_hist).^2)*(h1'))/sum(h1);
standDev = sqrt(var_hist);
kurtosis = ((((bins-mean_hist)/standDev).^4)*(h1'))/sum(h1);
% 
% % 1.3 fitting generalized gaussian
% gamma_val = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5];
% %data_val = reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]);
% 
% ypoints = h1/sum(h1);
% xpoints = bins;
% min_gamma = 0.5;
% stat_val = abs(xpoints/standDev);
% norm_const = 1/(sqrt(2*pi)*standDev);
% min_error = (exp(-1*(stat_val.^(0.5))) - ypoints) * (exp(-1*(stat_val.^(0.5))) - ypoints)';
% for i = 2:9
%     error =  (exp(-1*(stat_val.^(gamma_val(i)))) - ypoints) * (exp(-1*(stat_val.^(gamma_val(i)))) - ypoints)' ;
%     if(min_error>=error)
%         min_error = error;
%         min_gamma = gamma_val(i);
%     end
% end
%  bar(bins,h1./sum(h1))
%  hold on;
%  plot(xpoints,exp(-1*(stat_val.^(1.5))))
 %plot(bins,(2.6/standDev)*exp(-1*(stat_val.^(2))),'r')
 
%ggd = exp(((data_val-mean_hist)/standDev).^(4));
%plot(data_val,ggd);

%1.4 
% plot(xpoints, normpdf(xpoints,mean_hist,standDev),'r');
% hold on;
% bar(bins,(h1./sum(h1)));
% hold on;
% plot(bins,log(h1)./sum(log(h1)),'g')
% legend('gaussian','histogram','log plot')

%1.5
img_downsample = zeros(floor(size(img_scaled,1)/2),floor(size(img_scaled,2)/2));
rows = size(img_scaled,1);
cols = size(img_scaled,2);
new_i = 0;
new_j = 0;
for i = 1:2:rows
    if(i+1 > rows)
        continue;
    end
    new_i = new_i + 1;
    for j = 1:2:cols
        
        if (j+1) > cols
            continue;
        end
        
        new_j = new_j + 1;
        
        new_val = (img_scaled(i,j)+img_scaled(i,j+1)+img_scaled(i+1,j)+img_scaled(i+1,j+1))/4;
        img_downsample(new_i,new_j) = new_val;
     end
end

img_scaled2 = img_scaled;
img_scaled = img_downsample;
img_conv = zeros(size(img_scaled,1),size(img_scaled,2));
rows = size(img_scaled,1);
cols = size(img_scaled,2);
for i = 1:rows
    for j = 1:cols
        
        if j==cols
            img_conv(i,j) = int16(img_scaled(i,j));
        else
            b1 = img_scaled(i,j);
            b2 = img_scaled(i,j+1);
            b = int16(b1)-int16(b2);
            if(b==0)
            img_conv(i,j) = 0.01;
            else
                img_conv(i,j) = b;
            end
        end
    end
end


%1.1 plot H(z) and logH(z)
% [h1,bins] = hist(reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]));
% plot(bins,h1)
% xlim([-31,31])
%  xlabel('z')
% ylabel('H(z)')
% hold on;
% 
%  [h1,bins] = hist(reshape(img_conv,[1,size(img_scaled,1)*size(img_scaled,2)]));
% plot(bins,log(h1))
%  %xlim([-31,31])
%  xlabel('z')
%  ylabel('logH(z)')





