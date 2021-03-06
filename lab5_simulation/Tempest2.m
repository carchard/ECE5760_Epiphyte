%%
clear;
img= imread('BSOD.jpg'); %y,x,rgb
bwimg = rgb2gray(img);
%bwimg = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15; 16 17 18 19 20];
bwimg_serial = reshape(bwimg.',[1 numel(bwimg)]);        %serialize image
bwimg_serial = double(bwimg_serial-127);
%bwimg_serial = double(bwimg_serial);
%bwimg_serial(1280*200+1:1280*201) = 0;
%y=bwimg_serial;
%For now assume fpixel=~78Mhz (true for 1280x1024)
nframes_max=6;

x = repmat(bwimg_serial,1,nframes_max);%concatenate with itself 5 times.

start_idx = randi(numel(bwimg_serial)); %randomize where we started recording
end_idx = numel(x) - randi(numel(bwimg_serial)); %and where we ended recording

x=x(start_idx:end_idx);

%xI = conv(x,x);
%xQ = conv(x,x);



A_lo =exp(-j*(2*pi/8*(0:length(x)-1)));
hd = Filt78();
xrecv = x.*A_lo;
imp = zeros(1,length(x));
imp(1)=1;
A=filter(hd,imp);
y= filter(hd,xrecv);

%y_ADC =  resample(y,100,144);
y_ADC = resample(y,20,78);


xspec = fftshift(fft(x));
xrecvspec = fftshift(fft(xrecv));
lo_spec = fftshift(fft(A_lo));
yspec   = fftshift(fft(y));
yspec_ADC = fftshift(fft(y_ADC));

frame_len_approx=1000*1000;
correlation_window_length = frame_len_approx*1.5; %We can't be sure how long window is, but we can have a good guess
autoc  = xcorr(x);
%autoc = cconv(y,fliplr(y));
%[peaks,locs] = findpeaks(autoc,'MinPeakDistance',.8*frame_len_approx);%, 'MinPeakProminence', 1);

%initial_lag = locs(1);
%distances_between_peaks = diff(locs);
%frame_length = median(distances_between_peaks);
clf;
figure(1);
%numel(bwimg_serial)/autoc_max_idx
subplot(4,2,1);
plot(abs(xspec));
title('Spectrum of transmitted baseband');
%plot(x);
%title('Transmitted signal');
%subplot(3,2,2);
%plot(autoc);
%title('Circular Autocorrelation of received signal');
%subplot(3,2,3);
%plot(abs(xhtspec));
%title('Spectrum of Hilbert Transformed baseband');
subplot(4,2,2);
plot(abs(lo_spec));
title('Spectrum of Local Oscillator');
subplot(4,2,3);
plot(abs(fftshift(fft(A))));
title('Filter xfer');
subplot(4,2,5);
plot(abs(xrecvspec));
%xlim([3e6 5e6]);
title('Mixed Complex Baseband');
subplot(4,2,6);
plot(abs(yspec));
%xlim([3e6 5e6]);
title('LPFd Mixed Complex Baseband');
subplot(4,2,7);
plot(abs(yspec_ADC));
title('Resampled LPFd Mixed Complex Baseband');

%%
W=800;
H=600;
W=1280;
H=1024;
scale_2d = 20/78;
scale_1d = sqrt(scale_2d);
y_ADC_upsampled = resample(y_ADC,78,20);
scaled_W = round(W*scale_2d)+1;
scaled_H = H
img_out1 = abs(xrecv(1:W*H));
img_out1 = uint8(255*img_out1/max(img_out1));
img_out2 = abs(y(1:W*H));
img_out2 = uint8(255*img_out2/max(img_out2));
img_out3 = abs(y_ADC_upsampled(1:W*H));
img_out3 = uint8(255*img_out3/max(img_out3));

%reconstruct image from serial

yimg1 = reshape(img_out1,[W,H]).';
yimg2 = reshape(img_out2,[W,H]).';
yimg3 = reshape(img_out3,[W,H]).';

figure(2);
imshow(yimg1)
title('reconstructed x')
truesize;

figure(3);
imshow(yimg2)
title('reconstructed LPF')
truesize;

figure(4);
imshow(yimg3)
title('reconstructed scaled LPF')
truesize;
%hFig1 = figure('Toolbar','none', 'Menubar','none');
%hIm1 = imshow(yimg1,'InitialMagnification',100);
%hSP1 = imscrollpanel(hFig,hIm);

%hFig2 = figure('Toolbar','none', 'Menubar','none');
%hIm2 = imshow(yimg2,'InitialMagnification',100);
%hSP2 = imscrollpanel(hFig2,hIm2);
%truesize