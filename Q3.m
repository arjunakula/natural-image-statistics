% generate 128 uniform points for x
x_random = 1+rand(1,128)*(1024-1);

% generate 128 uniform points for y
y_random = 1+rand(1,128)*(1024-1);

% for each x_random, generate 3 poisson values with mean 100 
all_x = [];
for i=1:length(x_random)
    sur_val = poissrnd(150,1,10);
    all_x = [all_x,(x_random(i)+sur_val)];
end

% for each y_random, generate 3 poisson values with mean 100
all_y = [];
for i=1:length(y_random)
    sur_val = poissrnd(150,1,10);
    all_y = [all_y,(y_random(i)+sur_val)];
end

% generate 384 uniform theta values
theta = rand(1,1280)*(2*pi);

% generate 384 r values using cdf
r = rand(1,1280);
r_sample = sqrt(-1./(2*r));

% construct ends of line segments

x_start = [];
y_start = [];
x_end = [];
y_end= [];

for i = 1:length(all_x)
    
    x_start(end+1) = all_x(i);
    x_end(end+1) = all_x(i)+abs(r_sample(i))*cos(theta(i));
    
    if(x_start(i) >= 1024 || x_end(i) >= 1024)
        x_start(i) = 200+(1+rand(1,1)*(760-1));
        x_end(i) = 230+(1+rand(1,1)*(660-1));
    end
end


for i = 1:length(all_y)
    
    y_start(end+1) = all_y(i);
    y_end(end+1) = all_y(i)+abs(r_sample(i))*sin(theta(i));
    
    if(y_start(i) >= 1024 || y_end(i) >= 1024)
        y_start(i) = 200+(1+rand(1,1)*(760-1));
        y_end(i) = 230+(1+rand(1,1)*(660-1));
    end
end

%3.1 using x ends and y ends plot the line segments
plot([x_start;x_end],[y_start;y_end], 'LineWidth',5)
xlim([1, 1024]);
ylim([1, 1024]);

%3.2 downsampling above image to get I2 and I3

r = r./2;
x_start = [];
y_start = [];
x_end = [];
y_end= [];

for i = 1:length(all_x)
    
    x_start(end+1) = all_x(i);
    x_end(end+1) = all_x(i)+abs(r_sample(i))*cos(theta(i));
    
    if(x_start(i) >= 1024 || x_end(i) >= 1024)
        x_start(i) = 200+(1+rand(1,1)*(760-1));
        x_end(i) = 230+(1+rand(1,1)*(660-1));
    end
end


for i = 1:length(all_y)
    
    y_start(end+1) = all_y(i);
    y_end(end+1) = all_y(i)+abs(r_sample(i))*sin(theta(i));
    
    if(y_start(i) >= 1024 || y_end(i) >= 1024)
        y_start(i) = 200+(1+rand(1,1)*(760-1));
        y_end(i) = 230+(1+rand(1,1)*(660-1));
    end
end

%3.1 using x ends and y ends plot the line segments
plot([x_start;x_end],[y_start;y_end], 'LineWidth',5)
xlim([1, 1024]);
ylim([1, 1024]);

img = imread('3_2_2.png');
I2 = imcrop(img,[500 300 428 428]);
imshow(I2)
I2 = imcrop(img,[600 400 428 428]);
imshow(I2)