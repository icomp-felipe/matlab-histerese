%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				    UNIVERSIDADE FEDERAL DO AMAZONAS                      %
%					    FACULDADE DE TECNOLOGIA                           %
%                                                                         %
% Disciplina: Conversão de Energia I (FTE032)                             %
% Professor : Dr. Alessandro Bezerra Trindade                             %
% Algoritmo : Curva de Histerese de um Indutor                            %
% Objetivos : Construir o gráfico de curva de histerese magnética de um   %
%             indutor utilizando as funções disponíveis no Matlab, para   %
%             fins didáticos.                                             %
%                                                                         %
% Autor : Felipe André Souza da Silva                                     %
% Data  : 30/10/2020                                                      %
% e-mail: ft.ufam.felipe@gmail.com                                        %                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Criando a figura (plot)
histereseIndutor = figure('Name', 'Curva de Histerese de um Indutor');
figure(histereseIndutor);

%%%%%%%%%%%%%% Realizando Simulação %%%%%%%%%%%%%%

% Invocando a simulação do Simulink
sim('ee_inductor_hysteresis');

% Recuperando os resultados da simulação
time = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.B.series.time;
Bval = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.B.series.values;
Hval = simlog_ee_inductor_hysteresis.Nonlinear_Inductor.inductor.H.series.values;

% Plota a curva considerando o regime transitório
indices_tran = find(simlog_t >= 0);

% Plota a curva após o regime transitório
indices_perm = find(simlog_t >= 2/60);

% Desenha a curva de histerese desde o regime transitório (em vermelho)
plot(Hval(indices_tran),Bval(indices_tran),'LineWidth',1,'Color','r');
hold on;

% Desenha a curva de histerese apenas após o regime transitório (em azul)
plot(Hval(indices_perm),Bval(indices_perm),'LineWidth',1,'Color','b');

%%%%%%%%%%%%%% Formatando o gráfico %%%%%%%%%%%%%%
grid on;

% Definindo pontos de interesse na curva (obtidos experimentalmente)
xpoints = [624.6     0 -158 -624.6     0 158];
ypoints = [1.254 0.785    0 -1.254 -0.78   0];
labels  = {'+B_{máx}','+B_r','-H_c','-B_{máx}','-B_r','+H_c'};

% Desenhando os pontos (usando * como marcador e azul de cor de fundo)
plot(xpoints,ypoints,'b*')

% Ajustando alinhamentos horizontal e vertical dos pontos
for i = 1:6,

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
legend('Regime transitório','Regime permanente','Location','NorthWest');