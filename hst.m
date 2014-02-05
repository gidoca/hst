o = csvread('hstcoord.csv');
o( ~any(o,2), : ) = [];
t = delaunay(o(:, 1), o(:, 2));
TR = TriRep(t, o(:, 1), o(:, 2));
[CC, R] = circumcenters(TR);
[~, sortidx] = sort(R, 'descend');
figure; hold on;
triplot(t, o(:, 1), o(:, 2));
for i = 1:1000
    in = sortidx(i);
    plot(CC(in, 1), CC(in, 2), 'o');
end