function coolDibujarTrayectorias(matrices_dh)
    % Create a new figure with specific settings
    figure('Name', 'Robot Arm Visualization', ...
           'Color', 'white', ...
           'Position', [100 100 1200 800]);

    % Create 3D axes with proper settings
    ax = axes('Parent', gcf, ...
              'DataAspectRatio', [1 1 1], ...
              'NextPlot', 'add', ...
              'XGrid', 'on', ...
              'YGrid', 'on', ...
              'ZGrid', 'on', ...
              'FontSize', 12);

    view(ax, 3); % 3D view
    xlabel(ax, 'X-axis (mm)');
    ylabel(ax, 'Y-axis (mm)');
    zlabel(ax, 'Z-axis (mm)');
    title(ax, 'Robotic Arm Trajectory Visualization');

    % Set consistent axis limits based on robot dimensions
    max_reach = 15 + 7 + 3; % d1 + a2 + a3
    axis(ax, [-max_reach max_reach -max_reach max_reach 0 max_reach*1.5]);

    % Colors for different parts
    colors = lines(4);
    base_color = [0.3 0.3 0.3];
    link_colors = [0 0.4470 0.7410;  % Blue
                   0.8500 0.3250 0.0980;  % Orange
                   0.9290 0.6940 0.1250]; % Yellow

    % Draw base
    [X,Y,Z] = cylinder(5, 50);
    Z = Z * 5;
    surf(ax, X, Y, Z, 'FaceColor', base_color, 'EdgeColor', 'none');

    % Draw all positions
    for i = 1:length(matrices_dh)
        if isempty(matrices_dh{i})
            continue;
        end

        TT = matrices_dh{i};

        % Extract all joint positions
        p0 = TT(:,:,1) * [0;0;0;1];  % Base
        p1 = TT(:,:,2) * [0;0;0;1];  % Joint 1
        p2 = TT(:,:,3) * [0;0;0;1];  % Joint 2
        p3 = TT(:,:,4) * [0;0;0;1];  % End effector

        % Plot links
        plot3(ax, [p0(1) p1(1)], [p0(2) p1(2)], [p0(3) p1(3)], ...
              'Color', link_colors(1,:), 'LineWidth', 3);
        plot3(ax, [p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)], ...
              'Color', link_colors(2,:), 'LineWidth', 3);
        plot3(ax, [p2(1) p3(1)], [p2(2) p3(2)], [p2(3) p3(3)], ...
              'Color', link_colors(3,:), 'LineWidth', 3);

        % Plot joints
        scatter3(ax, p1(1), p1(2), p1(3), 100, 'filled', ...
                'MarkerFaceColor', link_colors(1,:), ...
                'MarkerEdgeColor', 'k');
        scatter3(ax, p2(1), p2(2), p2(3), 80, 'filled', ...
                'MarkerFaceColor', link_colors(2,:), ...
                'MarkerEdgeColor', 'k');
        scatter3(ax, p3(1), p3(2), p3(3), 60, 'filled', ...
                'MarkerFaceColor', link_colors(3,:), ...
                'MarkerEdgeColor', 'k');

        % Add small pause for animation effect if many points
        if length(matrices_dh) > 20 && i < length(matrices_dh)
            pause(0.05);
            drawnow;
        end
    end

    % Add legend and lighting
    legend(ax, {'Base', 'Link 1', 'Link 2', 'Link 3', 'Joint 1', 'Joint 2', 'End Effector'}, ...
           'Location', 'northeastoutside');
    light('Position', [1 1 1], 'Style', 'infinite');
    lighting gouraud;
    material dull;

    % Add colorbar to show progression
    colormap(jet);
    c = colorbar;
    c.Label.String = 'Trajectory Progression';
    c.Ticks = linspace(0,1,5);
    c.TickLabels = {'0%', '25%', '50%', '75%', '100%'};
end
