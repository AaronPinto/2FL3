A1 = [0.4, 0.9, 0.7]; A2 = [0.7, 0.2, 0.4]; P = [6.4, 10.0, 2.8]; % Define initial vectors
fprintf('Dot product of A1 and A2 = %.4f\n', dot(A1, A2)); 
projection = (dot(A1, A2) / dot(A2, A2)) * A2; 
% Print out projection vector with nice formatting
fprintf(['Projection of A1 onto A2 = [', repmat('%.4f, ', 1, numel(projection)-1), '%.4f]\n'], projection);
fprintf('Angle between A1 and A2 = %.4f rad\n', acos(dot(A1, A2) / (norm(A1) * norm(A2))));
c = cross(A1, A2);
% Print out cross product with nice formatting
fprintf(['Cross product of A1 and A2 = [', repmat('%.4f, ', 1, numel(c)-1), '%.4f]\n'], c);
A1O = P - A1;
fprintf('Distance from the orign to the line defined by A1 at P = %.4f\n', norm(cross(A1O, -A1 / norm(A1))));
an = c / norm(c);
fprintf('Distance from the orign to the plane defined by A1 and A2 at P = %.4f\n', dot(A1O, an));
