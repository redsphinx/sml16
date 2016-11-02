clc
data = load('data.txt', '-ascii');

n = length(data);

mu_seq = data(1,:);

for i=1:n
   mu_seq =  mu_seq + 1/i * (data(i,:) - mu_seq);
end

