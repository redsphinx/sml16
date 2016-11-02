clc
data = load('data.txt', '-ascii');

n = length(data);

mu_seq = data(1,:);

mu_ml = [];

for i=1:n
   mu_seq =  mu_seq + 1/i * (data(i,:) - mu_seq);
   mu_ml = [mu_ml; mu_seq];
end


