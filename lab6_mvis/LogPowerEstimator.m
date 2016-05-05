clear;
[x, fs] = audioread('transformers_cut.wav');


lb = [10 100 500 1000 5000 10000];
ub = [100 500 1000 5000 10000 20000];
%lb = lb*2*pi;
%ub = ub*2*pi;
MODE=0;
t = 1:length(x);
out= zeros(length(lb),length(x));
abs_out = zeros(length(lb),length(x));
lpf_abs_out = zeros(length(lb),length(x));
env_out = zeros(length(lb),length(x));
for i = 1:length(lb)
  [b,a] = butter(2,[lb(i)/fs, ub(i)/fs]);
  [lpf_z, lpf_p, lpf_k] = butter(2,10/fs);
  %lpf_k = lpf_k*(2^i);
  [lpf_b,lpf_a] = zp2tf(lpf_z,lpf_p,lpf_k);
  out(i,:) = filter(b,a,x);
  abs_out(i,:) = abs(out(i,:));
  lpf_abs_out(i,:) = filter(lpf_b,lpf_a,abs_out(i,:).^2);
  env_out(i,:) = out(i,:).*cos(2*pi*lb(i)/fs.*t);%exp(j.*2*pi*lb(i).*t);
  if MODE==1
  subplot(length(lb)/2,2,i);
  plot(t,out(i,:),t,abs_out(i,:),t,lpf_abs_out(i,:),t,env_out(i,:));
  title(sprintf('fFilter (%i,%i)',lb(i),ub(i)));
  ylim([-1 1]);
  elseif MODE==0
      clf;
      title(sprintf('fFilter (%i,%i)',lb(i),ub(i)));

      subplot(4,1,1);
      plot(t,out(i,:));
      subplot(4,1,2);
      plot(t,abs_out(i,:));
      subplot(4,1,3);
      plot(t,lpf_abs_out(i,:));
      subplot(4,1,4);
      plot(t,env_out(i,:));
      pause;
      
  end
end

