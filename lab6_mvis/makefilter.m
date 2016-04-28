% filter generation

fs = 48000;

lb = [10 100 500 1000 5000 10000];
ub = [100 500 1000 5000 10000 20000];

  
  fprintf('reg signed [15:0] y;\n');
  fprintf('reg signed [15:0] x;\n');
for i= 1:length(lb)
  if i != length(lb)
    fprintf('reg signed [15:0] z%i;\n',i );
  end
  fprintf('reg signed [15:0] a%i;\n',i );
  fprintf('reg signed [15:0] b%i;\n',i );
  fprintf('reg signed [15:0] mul_a%i_y;\n',i);
  fprintf('reg signed [15:0] mul_b%i_x;\n\n',i);
  fprintf('fixed_comb_mult5760 mula%i (y,a%i,mul_a%i_y);\n',i,i);
  fprintf('fixed_comb_mult5760 mulb%i (x,b%i,mul_b%i_x);\n',i,i);
end  

fprintf('case(filterID)\n');
for i = 1:length(lb)
  fprintf('%i: begin\n',i-1);
  [b,a] = butter(4,[lb(i)/fs, ub(i)/fs])
  for n = 1:length(b)
    fprintf('b%i <= ', i-1);
    decTo2_16fix(b(n));
  end
  for n = 1:length(a)
    fprintf('a%i <= ', i-1);
    decTo2_16fix(a(n));
  end
  fprintf('end\n\n');
end
fprintf('endcase\n')

fprintf('always @ (posedge clk) begin\n');
fprintf('x <= audIn;\n')
fprintf('y <= mul_b1_x+z1;\n');
for i = 1:length(lb)-2
  fprintf('z%i <= mul_b%i_x+z%i-mul_a%i_y;\n',i,i+1,i+1,i+1);
end
fprintf('z%i <= mul_b%i_x-mul_a%i_y;\n',i,i+1,i+1);

