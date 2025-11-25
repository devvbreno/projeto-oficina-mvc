document.addEventListener('DOMContentLoaded', () => {

    const navLinks = document.querySelectorAll('.nav-link');
    const contentSections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const targetId = link.getAttribute('data-target');
            const targetSection = document.getElementById(targetId);

            contentSections.forEach(section => {
                section.classList.remove('active');
            });
            navLinks.forEach(navLink => {
                navLink.classList.remove('active');
            });

            if (targetSection) {
                targetSection.classList.add('active');
            }
            link.classList.add('active');
        });
    });

    const agendamentoForm = document.getElementById('agendamento-form');
    const dataInput = document.getElementById('data');
    const horaInput = document.getElementById('hora');
    const formMessage = document.getElementById('form-message');

    const setFormMessage = (message, status) => {
        if (formMessage) {
            formMessage.textContent = message;
            formMessage.className = `status-${status}`;
        }
    };

    if (formMessage) {
        setFormMessage('Selecione uma data para ver os horários.', 'info');
    }
    
    if (dataInput && horaInput) {
        dataInput.addEventListener('input', () => {
            if (!dataInput.value) return;
            
            const dataSelecionada = new Date(dataInput.value);
            const diaDaSemana = dataSelecionada.getUTCDay();

            horaInput.value = "";

            if (diaDaSemana === 0) {
                horaInput.disabled = true;
                setFormMessage('Desculpe, a oficina não abre aos Domingos.', 'error');
            } else if (diaDaSemana === 6) {
                horaInput.disabled = false;
                horaInput.min = '08:00';
                horaInput.max = '12:00';
                setFormMessage('Horário de Sábado: 08:00 às 12:00.', 'ok');
            } else {
                horaInput.disabled = false;
                horaInput.min = '08:00';
                horaInput.max = '17:00';
                setFormMessage('Horário de Semana: 08:00 às 17:00.', 'ok');
            }
        });
    }

    if (agendamentoForm && horaInput) {
        agendamentoForm.addEventListener('submit', (event) => {
            if (horaInput.disabled) {
                event.preventDefault();
                setFormMessage('Por favor, selecione uma data válida (Segunda a Sábado).', 'error');
                return;
            }
        });
    }
});