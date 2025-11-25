document.addEventListener('DOMContentLoaded', () => {

    const navLinks = document.querySelectorAll('.nav-link');
    const contentSections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const targetId = link.getAttribute('data-target');
            
            contentSections.forEach(s => s.classList.remove('active'));
            navLinks.forEach(n => n.classList.remove('active'));

            document.getElementById(targetId).classList.add('active');
            link.classList.add('active');
        });
    });

    const form = document.getElementById('agendamento-form');
    const dataInput = document.getElementById('data');
    const horaInput = document.getElementById('hora');
    const msgBox = document.getElementById('form-message');

    if (dataInput && horaInput) {
        dataInput.addEventListener('input', () => {
            if (!dataInput.value) return;

            const date = new Date(dataInput.value);
            const dia = date.getUTCDay();

            horaInput.value = "";
            msgBox.classList.remove('hidden', 'status-ok', 'status-error');

            if (dia === 0) {
                horaInput.disabled = true;
                msgBox.textContent = "A oficina está fechada aos Domingos.";
                msgBox.classList.add('status-error');
                msgBox.classList.remove('hidden');
            } else if (dia === 6) {
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "12:00";
                msgBox.textContent = "Sábados: Atendimento das 08:00 às 12:00.";
                msgBox.classList.add('status-ok');
                msgBox.classList.remove('hidden');
            } else {
                horaInput.disabled = false;
                horaInput.min = "08:00";
                horaInput.max = "18:00";
                msgBox.textContent = "Segunda a Sexta: 08:00 às 18:00.";
                msgBox.classList.add('status-ok');
                msgBox.classList.remove('hidden');
            }
        });
    }

    if (form) {
        form.addEventListener('submit', (e) => {
            if (horaInput.disabled) {
                e.preventDefault();
                alert("Por favor, escolha uma data válida.");
            }
        });
    }
});