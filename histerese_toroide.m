%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   UNIVERSIDADE FEDERAL DO AMAZONAS                      %
%                       FACULDADE DE TECNOLOGIA                           %
%                                                                         %
% Disciplina: Conversão de Energia I (FTE032)                             %
% Professor : Dr. Alessandro Bezerra Trindade                             %
% Algoritmo : Curva de Histerese de um Toróide                            %
% Objetivos : Construir o gráfico de curva de histerese magnética de um   %
%             toróide utilizando as funções disponíveis no Matlab, para   %
%             fins didáticos.                                             %
%                                                                         %
% Autor : Felipe André Souza da Silva                                     %
% Data  : 30/10/2020                                                      %
% e-mail: ft.ufam.felipe@gmail.com                                        %                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Criando a figura (plot)
histereseToroide = figure('Name', 'Curva de Histerese de um Toróide');
figure(histereseToroide);

%%%%%%%%%%%%%% Realizando Simulação %%%%%%%%%%%%%%

% Invocando a simulação do Simulink
sim('ee_inductor_hysteresis');

% Recuperando os resultados da simulação
time = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.B.series.time;
Bval = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.B.series.values;
Hval = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.H.series.values;

% Plota a curva após o regime transitório
indices = find(simlog_t >= 2/60);

% Desenha a curva de histerese apenas após o regime transitório
plot(Hval(indices),Bval(indices),'LineWidth',1);

%%%%%%%%%%%%%% Formatando o gráfico %%%%%%%%%%%%%%
grid on; hold on;

% Definindo pontos de interesse na curva (obtidos experimentalmente)
xpoints = [123.9 123.9];
ypoints = [1.089 -0.18];
labels  = {'b','a'};

% Desenhando os pontos (usando * como marcador e azul de cor de fundo)
plot(xpoints,ypoints,'b*')

% Ajustando alinhamentos horizontal e vertical dos pontos
for i = 1:2,

    text(xpoints(i),ypoints(i),labels(i),'VerticalAlignment','top','HorizontalAlignment','left');

end

% Desenhando o eixo cartesiano
line([0,0],  ylim, 'Color', 'k', 'LineWidth', 2); % Desenha o eixo X
line(xlim , [0,0], 'Color', 'k', 'LineWidth', 2); % Desenha o eixo Y

% Nomeando os eixos
xlabel('H (Ae/m)');
ylabel('B (T)'   );

% Nomeando o gráfico
title ('Fenômeno de Histerese Magnética');
legend('Regime Permanente','Location','NorthWest');