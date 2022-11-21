% win_width = ceil(length(y1));  %Sliding window width
clear;
[filename,pathname] =uigetfile("MultiSelect","off",'*.wav');
%for k=1:length(filename)
[y,fs] = audioread([pathname, filename]);
y = y./max(abs(y));
noise=0.1*wgn(length(y),1,4);
y1 = y + noise;
%y1 = awgn(y1,40);
win_width = 60;
slide_incr = 1;  %Slide for each iteration
numstps = (length(y1)-win_width)/slide_incr; %Number of windows
% order = 7;
% framelen = 9;
%for i = 1:numstps
 for i=1:numstps
    tempp = mean(y1(i:i+win_width));%Calculation for each window
    tempp1 = mean(y(i:i+win_width));
 % [b,a] = cheby1(4,2,0.3,'low')
% temp1 = zeros(length(temp));
 L=win_width-1;
 delay=2; 
 delta = max(corrcoef(tempp,tempp1));
 M = length(tempp);
  zd=[zeros(1,delay-1) y1(delay:M)'];
[~,y2,e] = lms1(zd,tempp',delta,L );
% for i=1:r
% subplot(r,1,i)
% plot(imf(i,:));
% xlabel('time');
% ylabel('Amplitude');
% title(strcat('IMF',num2str(i)));
% end
%temp2 = sum(tempp1,2);
% mean1(k) = mean((temp2));
% stdev(k) = std((temp2));
% kur(k,i) =  kurtosis(temp2);
% sk(k,i) = skewness(temp2);
 yfilt(i:i+win_width) =  tempp;%sgolayfilt(temp,order,framelen);
 end
 %yy (i) = mean(yfilt(i:i+win_width));
 figure
 subplot(411)
 
 plot(y);xlabel('Time');
 ylabel('Amplitude');
 title('Original PCG');
subplot(412)

plot(noise);xlabel('Time');
 ylabel('Amplitude');
 title('Noise (+4 dB)');
 subplot(413)
 
 plot(y1);xlabel('Time');
 ylabel('Amplitude');
 title('Noisy PCG');
 subplot(414)
 
 plot(yfilt);xlabel('Time');
 ylabel('Amplitude');
 title('Filtered PCG');
 snrval = snr(y,y-yfilt');
 