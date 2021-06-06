clear all; close all;
% create the computational grid
Nx = 128;Ny = 128;Nz = 128;
dx = 1e-7;        % grid point spacing in the x direction [m]
dy = 1e-7;        % grid point spacing in the y direction [m]
dz = 1e-7;        % grid point spacing in the y direction [m]
kgrid = kWaveGrid(Nx, dx, Ny, dy, Nz, dz);

%This calculates the concentration relative to ambient.
cf = 0; % ambient concentration value [ng/L]
ci = 2.828E6-(2.828E6)/330; % initial concentration value [ng/L]
medium.diffusion_coeff = 2.5E-9; %m2/s;
medium.perfusion_coeff = 0;
medium.blood_ambient_temperature=0;

G2=cf*ones([Nx Ny Nz]);
for th=0:2*pi/200:2*pi
    for phi=0:2*pi/200:2*pi
        for r=0:10
            i=r*sin(phi)*cos(th)+64;
            j=r*sin(phi)*sin(th)+64;
            k=r*cos(phi)+64;
            G2(round(i),round(j),round(k))=ci;
        end
    end
end
source.T0=G2;
figure
h = pcolor(G2(:,:,64));
set(h, 'EdgeColor', 'none');
hc=colorbar; 
title(hc,'ng/L');
caxis([cf ci]);
saveas(gcf,'kwave_diffusion_slice_initial.png')

input_args = {'PlotScale', [cf, ci]};

Nt = 1;
dt = [1E-6 1E-5 1E-4 1E-3 1E-2];
D=medium.diffusion_coeff;
DE=zeros([Nx Ny Nz length(dt)]);
tall(source.T0);tall(DE);
for w=1:length(dt)
    DE(:,:,:,w) = bioheatExact(source.T0, 0, [D, 0, 0], kgrid.dx, Nt * dt(w));
end
gather(source.T0);gather(DE);


figure;
h = pcolor(DE(:,:,64,1));
set(h, 'EdgeColor', 'none');
hc=colorbar; 
title(hc,'ng/L');
caxis([cf max(DE,[],'all')]);
saveas(gcf,'kwave_diffusion_slice_1us.png')

figure 
for w=1:length(dt)
    rr=DE(64:end,64,64,w);
    plot(1:65,rr,'DisplayName',[num2str(dt(w))+" s"])
    hold on
end
grid on
xlabel('Distance, 1/10 um')
ylabel('[O2], ng/L')
legend()
saveas(gcf,'kwave_diffusion_radial.png')
