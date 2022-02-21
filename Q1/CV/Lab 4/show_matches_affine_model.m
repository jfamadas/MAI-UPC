function show_matches_affine_model(Ia, Ib, fa, fb, p)
% Written by L. Garrido, 2012
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

A = [1 + p(1), p(2); p(3), 1 + p(4)];
t = [p(5); p(6)];

for i = 1:M,
    for j = 1:N,
        xa = offx + (i - 1) * divx;
        ya = offy + (j - 1) * divy;
        
        r = A * [xa; ya] + t;
        
        xb = r(1) + size(Ia,2);
        yb = r(2);
        
        if ((xa < ncol) && (xb > ncol))
          q = line([xa ; xb], [ya ; yb]);
          set(q,'linewidth', 2, 'color', 'r');
        end
    end
end

axis image off ;