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

    if (dataInput && horaInput) {
        dataInput.addEventListener('input', () => {
            if (!dataInput.value) return;

            const date = new Date(dataInput.value);
            const dia = date.getUTCDay();

            horaInput.value = "";

            if (dia === 0) {
                horaInput.disabled = true;
                setFormMessage('A oficina está fechada aos Domingos.', 'error');
            } else if (dia === 6) {
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "12:00";
                setFormMessage('Sábados: Atendimento das 08:00 às 12:00.', 'ok');
            } else {
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "18:00";
                setFormMessage('Segunda a Sexta: 08:00 às 18:00.', 'ok');
            }
        });
    }

    if (agendamentoForm) {
        agendamentoForm.addEventListener('submit', (event) => {
            if (horaInput && horaInput.disabled) {
                event.preventDefault();
                alert("Por favor, escolha uma data válida.");
            }
        });
    }

    const socket = io();

    socket.on('connect', () => {
        console.log('Conectado ao servidor Websocket!');
    });

    socket.on('update_table', () => {
        console.log('Atualização recebida!');
        window.location.reload();
    });

}); 