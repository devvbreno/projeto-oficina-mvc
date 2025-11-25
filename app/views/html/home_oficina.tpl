<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TopCar - Agendamentos</title>
    <link rel="stylesheet" href="/static/css/oficina.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>

    <header>
        <div class="container">
            <div class="logo">
                <img src="/static/img/logo-topcar.png" alt="Logo TopCar Centro Automotivo">
            </div>
            <nav>
                <ul>
                    <li><a href="#" class="nav-link active" data-target="agendamento">Agendamento</a></li>
                    <li><a href="#" class="nav-link" data-target="produtos">Produtos</a></li>
                    <li><a href="#" class="nav-link" data-target="sobre">Nossa História</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container">
        
        <section id="agendamento" class="content-section active">
            <h2>Faça seu Agendamento</h2>
            % if defined('error_message') and error_message:
                <div class="alert-error" style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 20px; border-radius: 4px;">
                <strong>Erro:</strong> {{error_message}}
                </div>
            % end
            <p>Preencha o formulário e verifique os horários disponíveis na tabela abaixo.</p>
            
            <form id="agendamento-form" action="/create_order" method="POST">
                <div class="form-group">
                    <label for="nome">Nome Completo:</label>
                    <input type="text" id="nome" name="nome" required placeholder="Seu nome">
                </div>
                
                <div class="form-group">
                    <label for="telefone">Telefone / WhatsApp:</label>
                    <input type="tel" id="telefone" name="telefone" required placeholder="(XX) XXXXX-XXXX">
                </div>
                
                <div class="form-group">
                    <label for="veiculo">Modelo do Veículo:</label>
                    <input type="text" id="veiculo" name="veiculo" placeholder="Ex: Honda Civic 2019" required>
                </div>

                <div class="form-group">
                    <label for="servico">Serviço Desejado:</label>
                    <select id="servico" name="servico" required>
                        <option value="">Selecione um serviço...</option>
                        <option value="troca_oleo">Troca de Óleo e Filtros</option>
                        <option value="freios">Revisão e Troca de Freios</option>
                        <option value="alinhamento">Alinhamento e Balanceamento</option>
                        <option value="motor">Revisão Completa do Motor</option>
                        <option value="outros">Outros (Descrever abaixo)</option>
                    </select>
                </div>

                <div class="form-group half-width">
                    <label for="data">Data Preferencial:</label>
                    <input type="date" id="data" name="data" required>
                </div>

                <div class="form-group half-width">
                    <label for="hora">Horário Preferencial:</label>
                    <input type="time" id="hora" name="hora" min="08:00" max="17:00" required>
                </div>

                <div id="form-message-wrapper" class="full-width">
                    <span id="form-message">Selecione uma data para ver os horários.</span>
                </div>

                <div class="form-group full-width">
                    <label for="observacoes">Observações Adicionais:</label>
                    <textarea id="observacoes" name="observacoes" rows="3" placeholder="Detalhes do problema ou serviço..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary full-width">Confirmar Agendamento</button>
            </form>

            <hr class="section-divider">

            <h2>Horários Marcados da Semana</h2>
            <p>Confira a disponibilidade. (Esta é uma visualização de exemplo).</p>
            
            <div class="schedule-table">
                <table>
                    <thead>
                        <tr>
                            <th>Horário</th>
                            <th>Segunda-feira</th>
                            <th>Terça-feira</th>
                            <th>Quarta-feira</th>
                            <th>Quinta-feira</th>
                            <th>Sexta-feira</th>
                            <th>Sábado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>08:00</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                        </tr>
                        <tr>
                            <td>08:30</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                        </tr>
                        <tr>
                            <td>09:00</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                        </tr>
                        <tr>
                            <td>09:30</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                        </tr>
                        <tr>
                            <td>10:00</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                        </tr>
                        <tr>
                            <td>10:30</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                        </tr>
                        <tr>
                            <td>11:00</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                        </tr>
                        <tr>
                            <td>11:30</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                        </tr>
                        <tr>
                            <td>12:00</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>12:30</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="lunch">Almoço</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>13:00</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>13:30</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>14:00</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>14:30</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>15:00</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>15:30</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="available">Disponível</td>
                            <td class="booked">Ocupado</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>16:00</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>16:30</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                        <tr>
                            <td>17:00</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="available">Disponível</td>
                            <td class="closed">Fechado</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section id="produtos" class="content-section">
            <h2>Nossos Produtos de Alta Qualidade</h2>
            <p>Trabalhamos apenas com as melhores marcas para o seu veículo.</p>
            
            <div class="product-grid">
                <div class="product-item">
                    <div class="img-placeholder">[IMAGEM ÓLEO]</div>
                    <h3>Óleos Lubrificantes</h3>
                    <p>Óleos sintéticos e semi-sintéticos para máxima performance.</p>
                </div>
                <div class="product-item">
                    <div class="img-placeholder">[IMAGEM PNEUS]</div>
                    <h3>Pneus Premium</h3>
                    <p>Variedade de marcas e modelos, com instalação inclusa.</p>
                </div>
                <div class="product-item">
                    <div class="img-placeholder">[IMAGEM BATERIAS]</div>
                    <h3>Baterias de Longa Vida</h3>
                    <p>Com garantia estendida para sua tranquilidade.</p>
                </div>
                <div class="product-item">
                    <div class="img-placeholder">[IMAGEM FREIOS]</div>
                    <h3>Componentes de Freio</h3>
                    <p>Pastilhas, discos e fluidos de alto desempenho.</p>
                </div>
            </div>
        </section>

        <section id="sobre" class="content-section">
            <h2>A História da TopCar: Confiança e Inovação</h2>
            
            <div class="img-placeholder" style="height: 250px; margin-bottom: 20px;">[IMAGEM OFICINA INTERIOR]</div>

            <p>Desde 2005, a TopCar é sinônimo de excelência em serviços automotivos. Nascemos da paixão por carros e da busca incessante pela satisfação dos nossos clientes.</p>
            <p>Nossa equipe é formada por profissionais altamente qualificados e em constante atualização, prontos para lidar com as tecnologias mais recentes.</p>
            <p>Na TopCar, você encontra transparência, agilidade e o cuidado que seu veículo merece. Venha fazer parte da nossa história de sucesso!</p>
        </section>

    </main>
    <section class="content-section" style="margin-top: 40px;">
        <h2>Ordens Registradas no Sistema</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Veículo</th>
                    <th>Serviço</th>
                    <th>Data</th>
                    <th>Ação</th>
                </tr>
            </thead>
            <tbody>
                % for ordem in orders:
                <tr>
                    <td>{{ordem.id}}</td>
                    <td>{{ordem.client_name}}</td>
                    <td>{{ordem.vehicle_model}}</td>
                    <td>{{ordem.service_description}}</td>
                    <td>{{ordem.date}}</td>
                    <td>
                        <form action="/delete_order" method="POST">
                            <input type="hidden" name="id" value="{{ordem.id}}">
                            <button type="submit" style="color: red;">Excluir</button>
                        </form>
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </section>
    <footer>
        <div class="container">
            <p>&copy; 2025 TopCar Centro Automotivo. Todos os direitos reservados.</p>
            <p>Rua das Peças, 123 - Bairro dos Motores - Sua Cidade/UF | Telefone: (XX) XXXX-XXXX</p>
        </div>
    </footer>
        

</body>
</html>