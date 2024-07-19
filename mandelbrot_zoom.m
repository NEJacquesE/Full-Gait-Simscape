function mandelbrot_zoom
    % Initial parameters for the Mandelbrot set
    x_min = -2.5; x_max = 1.5; y_min = -2; y_max = 2;
    max_iter = 1000;
    
    % Create a figure
    h_fig = figure('Name', 'Mandelbrot Set Zoom', 'NumberTitle', 'off');
    
    % Plot the initial Mandelbrot set
    plot_mandelbrot(x_min, x_max, y_min, y_max, max_iter);
    
    % Set the callback for mouse clicks
    set(h_fig, 'WindowButtonDownFcn', @mouse_click);
    
    % Nested function to handle mouse click
    function mouse_click(~, ~)
        % Get the coordinates of the click
        click_pos = get(gca, 'CurrentPoint');
        x_click = click_pos(1,1);
        y_click = click_pos(1,2);
        
        % Zoom factor
        zoom_factor = 2;
        
        % Update the limits for the next zoom
        x_range = (x_max - x_min) / zoom_factor;
        y_range = (y_max - y_min) / zoom_factor;
        
        x_min = x_click - x_range / 2;
        x_max = x_click + x_range / 2;
        y_min = y_click - y_range / 2;
        y_max = y_click + y_range / 2;
        
        % Plot the new zoomed Mandelbrot set
        plot_mandelbrot(x_min, x_max, y_min, y_max, max_iter);
    end

    % Nested function to plot the Mandelbrot set
    function plot_mandelbrot(x_min, x_max, y_min, y_max, max_iter)
        % Define the grid of complex numbers
        [x, y] = meshgrid(linspace(x_min, x_max, 800), linspace(y_min, y_max, 800));
        c = x + 1i * y;
        
        % Initialize the Mandelbrot set
        z = zeros(size(c));
        mandelbrot_set = zeros(size(c));
        
        % Iteratively compute the Mandelbrot set
        for k = 1:max_iter
            z = z.^2 + c;
            escaped = abs(z) > 2 & mandelbrot_set == 0;
            mandelbrot_set(escaped) = k;
        end
        
        % Plot the Mandelbrot set with colors
        imagesc(linspace(x_min, x_max, 800), linspace(y_min, y_max, 800), mandelbrot_set);
        colormap(parula);
        colorbar;
        axis xy;
        title('Mandelbrot Set');
        xlabel('Real Axis');
        ylabel('Imaginary Axis');
    end
end
