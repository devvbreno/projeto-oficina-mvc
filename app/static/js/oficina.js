document.addEventListener('DOMContentLoaded', () => {

    const navLinks = document.querySelectorAll('.nav-link');
    const contentSections = document.querySelectorAll('.content-section');

    // Lógica das Abas
    navLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const targetId = link.getAttribute('data-target');
            
            contentSections.forEach(s => s.classList.remove('active'));
            navLinks.forEach(n => n.classList.remove('active'));

            const targetSection = document.getElementById(targetId);
            if (targetSection) {
                targetSection.classList.add('active');
            }
            link.classList.add('active');
        });
    });

    // Elementos do Formulário
    const agendamentoForm = document.getElementById('agendamento-form');
    const dataInput = document.getElementById('data');
    const horaInput = document.getElementById('hora');
    const msgBox = document.getElementById('form-message');

    const setFormMessage = (message, status) => {
        if (msgBox) {
            msgBox.textContent = message;
            msgBox.className = `status-box status-${status}`;
            msgBox.classList.remove('hidden');
        }
    };

    if (msgBox) {
        setFormMessage('Selecione uma data para ver os horários.', 'info');
    }

    // Validação de Data (Domingo/Sábado)
    if (dataInput && horaInput) {
        dataInput.addEventListener('input', () => {
            if (!dataInput.value) return;

            const date = new Date(dataInput.value);
            const dia = date.getUTCDay();

            horaInput.value = ""; // Limpa a hora ao mudar a data

            if (dia === 0) { // Domingo
                horaInput.disabled = true;
                setFormMessage('A oficina está fechada aos Domingos.', 'error');
            } else if (dia === 6) { // Sábado
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "12:00";
                setFormMessage('Sábados: Atendimento das 08:00 às 12:00.', 'ok');
            } else { // Seg-Sex
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "18:00";
                setFormMessage('Segunda a Sexta: 08:00 às 18:00.', 'ok');
            }
        });
    }

    // Lógica de Envio (AQUI É O SEGREDO)
    if (agendamentoForm) {
        agendamentoForm.addEventListener('submit', (event) => {
            // Se o campo de hora estiver bloqueado (Domingo), nós IMPEDIMOS o envio.
            if (horaInput && horaInput.disabled) {
                event.preventDefault(); // Bloqueia
                alert("Por favor, escolha uma data válida.");
            }
            
            // SE NÃO ESTIVER BLOQUEADO (Data Válida):
            // O código sai da função aqui. O navegador entende que pode continuar
            // e envia os dados para o Python automaticamente.
        });
    }
});