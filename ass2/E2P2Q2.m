E2P2Q1 % get alpha and beta
n = 200;
data = zeros(n,1);

for i = 1:n
  theta = rand*pi - pi/2;
  data(i) = b*tan(theta) + a;
end
