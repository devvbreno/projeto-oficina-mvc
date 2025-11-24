document.addEventListener('DOMContentLoaded', () => {

    // --- LÓGICA DE NAVEGAÇÃO POR ABAS ---
    const navLinks = document.querySelectorAll('.nav-link');
    const contentSections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault(); // Previne o comportamento padrão do link

            const targetId = link.getAttribute('data-target');
            const targetSection = document.getElementById(targetId);

            // 1. Remove 'active' de todas as seções e links
            contentSections.forEach(section => {
                section.classList.remove('active');
            });
            navLinks.forEach(navLink => {
                navLink.classList.remove('active');
            });

            // 2. Adiciona 'active' ao link clicado e à seção alvo
            if (targetSection) {
                targetSection.classList.add('active');
            }
            link.classList.add('active');
        });
    });

    // --- LÓGICA DO FORMULÁRIO DE AGENDAMENTO ---
    const agendamentoForm = document.getElementById('agendamento-form');
    const dataInput = document.getElementById('data');
    const horaInput = document.getElementById('hora');
    const formMessage = document.getElementById('form-message');

    // Função para atualizar o status do formulário
    const setFormMessage = (message, status) => {
        formMessage.textContent = message;
        formMessage.className = `status-${status}`; // status-ok, status-error, status-info
    };

    // Define a mensagem inicial
    setFormMessage('Selecione uma data para ver os horários.', 'info');
    
    // --- LÓGICA DE VALIDAÇÃO DE DATA/HORA ---
    dataInput.addEventListener('input', () => {
        const dataSelecionada = new Date(dataInput.value);
        // getUTCDay() é mais confiável pois não depende do fuso horário local
        // 0 = Domingo, 1 = Segunda, ..., 5 = Sexta, 6 = Sábado
        const diaDaSemana = dataSelecionada.getUTCDay();

        // Reseta o valor da hora
        horaInput.value = "";

        if (diaDaSemana === 0) { // Domingo
            horaInput.disabled = true;
            setFormMessage('Desculpe, a oficina não abre aos Domingos.', 'error');
        } else if (diaDaSemana === 6) { // Sábado
            horaInput.disabled = false;
            horaInput.min = '08:00';
            horaInput.max = '12:00'; // Horário limite de Sábado
            setFormMessage('Horário de Sábado: 08:00 às 12:00.', 'ok');
        } else { // Dias de Semana (Seg-Sex)
            horaInput.disabled = false;
            horaInput.min = '08:00';
            // MUDANÇA AQUI: O último horário de agendamento é 17:00
            horaInput.max = '17:00'; 
            setFormMessage('Horário de Semana: 08:00 às 17:00.', 'ok');
        }
    });

    // --- LÓGICA DE ENVIO DO FORMULÁRIO ---
    agendamentoForm.addEventListener('submit', (event) => {

        // Verifica se a hora está desabilitada (Domingo)
        if (horaInput.disabled) {
            event.preventDefault();
            
            setFormMessage('Por favor, selecione uma data válida (Segunda a Sábado).', 'error');
            return;
        }

        const nome = document.getElementById('nome').value;
        const data = dataInput.value;
        
        // Simulação de envio

        // Limpa o formulário e reseta a mensagem
        horaInput.disabled = false;
        setFormMessage('Selecione uma data para ver os horários.', 'info');
    });

});