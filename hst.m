n_points = 1;

o = csvread('hstcoord.csv');
o( ~any(o,2), : ) = [];
t = delaunay(o(:, 1), o(:, 2));
TR = TriRep(t, o(:, 1), o(:, 2));
[CC, R] = circumcenters(TR);
[~, sortidx] = sort(R, 'descend');

boundarydata = csvread('swissboundary.csv');
boundary = [boundarydata(1:840, :); boundarydata(26935:28690, :); boundarydata(841:26094, :)];
[boundarychx, boundarychy] = deg2ch1903plus(boundary(:, 2), boundary(:, 1));


figure; hold on;
triplot(t, o(:, 1), o(:, 2));
plot(boundarychx, boundarychy, 'g');
n = 1;
for i = 1:size(CC, 1)
    in = sortidx(i);
    if inpolygon(CC(in, 1), CC(in, 2), boundarychx, boundarychy)
        plot(CC(in, 1), CC(in, 2), 'r*');
        disp(['x = ' num2str(CC(in, 1)) ', y = ' num2str(CC(in, 2))]);
        n = n + 1;
        if n > n_points
            break;
        end
    end
end

