<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TopCar - Sistema de Agendamento</title>
    <link rel="stylesheet" href="/static/css/oficina.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>

    <header>
        <div class="container header-content">
            <div class="logo">
                <h2 style="color: white; display: flex; align-items: center; gap: 10px;">
                    <img src="/static/img/logo-topcar.png" alt="Logo" style="height: 40px;"> 
                    TopCar
                </h2>
            </div>
            <nav>
                <ul>
                    <li><a href="#" class="nav-link active" data-target="agendamento">Agendamentos</a></li>
                    <li><a href="#" class="nav-link" data-target="produtos">Produtos</a></li>
                    <li><a href="#" class="nav-link" data-target="sobre">Sobre Nós</a></li>
                    
                    <li>
                        <form action="/logout" method="POST" style="display: inline;">
                            <button type="submit" class="btn-logout" title="Sair do Sistema">
                                Sair 🚪
                            </button>
                        </form>
                    </li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="container">
        
        <section id="agendamento" class="content-section active">
            
            <div class="panel">
                <div class="panel-header">
                    <h2>Novo Agendamento</h2>
                    <p>Preencha os dados abaixo para registrar um serviço.</p>
                </div>

                % if defined('error_message') and error_message:
                    <div class="alert alert-error">
                        <strong>⚠️ Atenção:</strong> {{error_message}}
                    </div>
                % end

                <form id="agendamento-form" action="/create_order" method="POST">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="nome">Cliente</label>
                            <input type="text" id="nome" name="nome" required placeholder="Nome completo">
                        </div>
                        <div class="form-group">
                            <label for="telefone">Contato</label>
                            <input type="tel" id="telefone" name="telefone" required placeholder="(XX) 99999-9999">
                        </div>
                        <div class="form-group">
                            <label for="veiculo">Veículo</label>
                            <input type="text" id="veiculo" name="veiculo" required placeholder="Modelo e Ano">
                        </div>
                        <div class="form-group">
                            <label for="servico">Tipo de Serviço</label>
                            <select id="servico" name="servico" required>
                                <option value="">Selecione...</option>
                                <option value="Revisão Básica">Revisão Básica</option>
                                <option value="Troca de Óleo">Troca de Óleo</option>
                                <option value="Freios">Manutenção de Freios</option>
                                <option value="Suspensão">Suspensão e Alinhamento</option>
                                <option value="Motor">Reparo de Motor</option>
                                <option value="Outros">Outros</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="data">Data</label>
                            <input type="date" id="data" name="data" required>
                        </div>
                        <div class="form-group">
                            <label for="hora">Horário</label>
                            <input type="time" id="hora" name="hora" required>
                        </div>
                    </div>

                    <div id="form-message" class="status-box hidden"></div>

                    <div class="form-group full-width">
                        <label for="observacoes">Observações</label>
                        <textarea id="observacoes" name="observacoes" rows="2" placeholder="Detalhes adicionais..."></textarea>
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn btn-primary">Confirmar Agendamento</button>
                    </div>
                </form>
            </div>

            <div class="panel mt-4">
                <div class="panel-header">
                    <h2>Agendamentos Confirmados</h2>
                    <p>Lista atualizada em tempo real do sistema.</p>
                </div>

                <div class="table-responsive">
                    <table class="dynamic-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Cliente</th>
                                <th>Veículo</th>
                                <th>Serviço</th>
                                <th>Data / Hora</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            % if not defined('orders') or not orders:
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        Nenhum agendamento encontrado no banco de dados.
                                    </td>
                                </tr>
                            % else:
                                % for ordem in orders:
                                <tr>
                                    <td>#{{ordem.id}}</td>
                                    <td><strong>{{ordem.client_name}}</strong><br><small>{{ordem.contact_phone}}</small></td>
                                    <td>{{ordem.vehicle_model}}</td>
                                    <td><span class="badge">{{ordem.service_description}}</span></td>
                                    <td>{{ordem.date}} <br> {{ordem.time}}</td>
                                    <td>
                                        <form action="/delete_order" method="POST" onsubmit="return confirm('Tem certeza que deseja excluir este agendamento?');">
                                            <input type="hidden" name="id" value="{{ordem.id}}">
                                            <button type="submit" class="btn-icon delete" title="Excluir">🗑️</button>
                                        </form>
                                    </td>
                                </tr>
                                % end
                            % end
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <section id="produtos" class="content-section">
            <div class="panel">
                <h2>Nossos Produtos</h2>
                <div class="product-grid">
                    <div class="card">
                        <div class="card-img" style="background-color: #ddd;">[IMG Óleo]</div>
                        <h3>Lubrificantes</h3>
                        <p>Alta performance para seu motor.</p>
                    </div>
                    <div class="card">
                        <div class="card-img" style="background-color: #ddd;">[IMG Pneus]</div>
                        <h3>Pneus</h3>
                        <p>Segurança e estabilidade na pista.</p>
                    </div>
                    <div class="card">
                        <div class="card-img" style="background-color: #ddd;">[IMG Freios]</div>
                        <h3>Freios</h3>
                        <p>Pastilhas e discos de alta qualidade.</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="sobre" class="content-section">
            <div class="panel">
                <h2>Sobre a TopCar</h2>
                <div class="about-content">
                    <div class="card-img" style="height: 200px; background-color: #ddd; margin-bottom: 20px;">[IMG Oficina]</div>
                    <p>Desde 2005, a TopCar é sinônimo de excelência em serviços automotivos.</p>
                    <p>Nossos especialistas são treinados para cuidar do seu carro como se fosse nosso.</p>
                </div>
            </div>
        </section>

    </main>

    <footer>
        <p>&copy; 2025 TopCar Centro Automotivo - Sistema BMVC</p>
    </footer>

    <script src="/static/js/oficina.js"></script>
</body>
</html>