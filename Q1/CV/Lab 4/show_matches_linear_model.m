function show_matches_linear_model(Ia, Ib, fa, fb, p)
% Written by L. Garrido, 2015
% Obtained from vl_demo_sift_match

M = 5;
N = 5;

divx = size(Ia,2)/M;
divy = size(Ia,1)/N;

offx = divx / 2;
offy = divy / 2;

imshow(cat(2, Ia, Ib),[]);

[nrow ncol] = size(Ia);

hold on

for i = 1:M,
    for j = 1:N,
        xa = offx + (i - 1) * divx;
        ya = offy + (j - 1) * divy;
        
        xb = xa + p(1) + size(Ia,2);
        yb = ya + p(2);
        
        if ((xa < ncol) && (xb > ncol))
          q = line([xa ; xb], [ya ; yb]);
          set(q,'linewidth', 2, 'color', 'r');
        end
    end
end

axis image off ;