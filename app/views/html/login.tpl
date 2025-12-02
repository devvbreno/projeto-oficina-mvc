<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TopCar Administrativo</title>
    <link rel="stylesheet" href="/static/css/oficina.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        /* Estilos exclusivos para a página de Login */
        body.login-page {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: var(--bg-body);
            background-image: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            margin: 0;
            padding: 20px;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-logo img {
            height: 60px;
            margin-bottom: 20px;
        }

        .login-title {
            color: var(--text-main);
            margin-bottom: 5px;
            font-size: 1.5rem;
        }

        .login-subtitle {
            color: var(--text-muted);
            margin-bottom: 30px;
            font-size: 0.9rem;
        }

        /* Ajuste nos inputs para o login */
        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .btn-login {
            margin-top: 10px;
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
        }
    </style>
</head>
<body class="login-page">

    <div class="login-container">
        <div class="login-logo">
            <img src="/static/img/logo-topcar.png" alt="TopCar Logo">
        </div>

        <h2 class="login-title">Acesso Restrito</h2>
        <p class="login-subtitle">Entre com suas credenciais de administrador.</p>

        % if defined('error_message') and error_message:
            <div class="alert alert-error" style="text-align: left; font-size: 0.9rem;">
                <strong>Erro:</strong> {{error_message}}
            </div>
        % end

        <form action="/login" method="POST">
            <div class="form-group">
                <label for="username">Usuário</label>
                <input type="text" id="username" name="username" placeholder="Ex: admin" required autofocus>
            </div>

            <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" id="password" name="password" placeholder="Sua senha" required>
            </div>

            <button type="submit" class="btn btn-primary btn-login">Entrar no Sistema</button>
        </form>
        
        <p style="margin-top: 20px; font-size: 0.8rem; color: #999;">
            &copy; 2025 Sistema BMVC TopCar
        </p>
    </div>

</body>
</html>