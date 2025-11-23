from app.controllers.datarecord import DataRecord
from app.models.service_order import ServiceOrder

print("--- TESTE 1: Criando e Salvando ---")

# 1. Iniciamos o Banco
db = DataRecord()

# 2. Criamos uma Ordem de Serviço na memória (Simulando o formulário)
# Preencha com dados de teste
nova_ordem = ServiceOrder(
    id=None, # O banco vai gerar
    client_name="Breno Teste",
    vehicle_model="Fusca Azul",
    date="2023-10-27",
    contact_phone="1199999999",
    service_description="Troca de Oleo",
    time="14:00",
    notes="Cliente vip"
)

# 3. Mandamos o banco salvar
try:
    db.create_order(nova_ordem)
    print("✅ Sucesso! Ordem criada e (teoricamente) salva.")
except Exception as e:
    print(f"❌ Erro ao salvar: {e}")

print("\n--- TESTE 2: Persistência (Fechando e abrindo) ---")

# 4. Criamos UMA NOVA instância do banco (Simulando reiniciar o servidor)
db_novo = DataRecord()

# 5. Pedimos para ler todas as ordens
todas_as_ordens = db_novo.get_all_orders()

# 6. Verificamos se a ordem que criamos antes está lá
if len(todas_as_ordens) > 0:
    ordem_recuperada = todas_as_ordens[-1] # Pega a última
    print(f"✅ Leitura funcionou! Cliente recuperado: {ordem_recuperada.client_name}")
    print(f"   Veículo: {ordem_recuperada.vehicle_model}")
else:
    print("❌ Falha: O banco voltou vazio (o arquivo JSON não foi salvo ou lido corretamente).")