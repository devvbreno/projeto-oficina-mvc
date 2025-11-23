from app.controllers.datarecord import DataRecord
db = DataRecord()
id_alvo = 2

if db.delete_order(id_alvo):
    print(f"✅ Sucesso! A ordem {id_alvo} foi apagada.")
else:
    print(f"❌ Erro: Não encontrei nenhuma ordem com ID {id_alvo}.")

print("Lista atual:", db.get_all_orders())