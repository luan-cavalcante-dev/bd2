import mysql.connector

# =======================================
# realizar conexão com o banco de dados
# =======================================

try:
    conexao = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root123",
        database="universidade"
    )

    cursor = conexao.cursor()
    print("Conexão com o banco de dados estabelecida")

except Exception as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
    exit()

# ===================================
# 1. Transação com commit
# ===================================
print("\nIniciando transação com commit...")
try:
    conexao.start_transaction()

    cursor.execute(
        "INSERT INTO matriculas (id_aluno, id_curso) VALUES (1, 1)"
    )

    conexao.commit()
    print("Transação com commit realizada com sucesso")

except Exception as e:
    conexao.rollback()
    print(f"Erro na transação com commit: {e}")

# ===========================================
# 2. Transação com rollback
# ===========================================
print("\nIniciando transação com rollback...")
try:
    conexao.start_transaction()

    cursor.execute(
        "INSERT INTO matriculas (id_aluno, id_curso) VALUES (999, 1)"
    )

    cursor.execute(
        "UPDATE matriculas SET id_curso = 999 WHERE id_aluno = 999"
    )

    conexao.commit()
    print("Transação com rollback realizada com sucesso (não deveria)")

except Exception as e:
    conexao.rollback()
    print(f"Erro na transação com rollback: {e}")

# ===========================================
# 3. Lista de alunos
# ===========================================
print("\nLista de alunos")

cursor.execute("SELECT * FROM alunos")
for aluno in cursor.fetchall():
    print(aluno)

# ===========================================
# 4. Lista disciplinas
# ===========================================
print("\nListar disciplinas")

cursor.execute("SELECT * FROM disciplinas")
for disciplina in cursor.fetchall():
    print(disciplina)

# ===========================================
# 5. Matrículas por semestre
# ===========================================
print("\nListar matrículas por semestre")

semestre = input("Digite o semestre (ex: 2026.1): ")

cursor.execute(
    "SELECT * FROM matricula WHERE semestre = %s", (semestre,)
)

resultados = cursor.fetchall()

if resultados:
    for matricula in resultados:
        print(matricula)
else:
    print("Nenhuma matrícula encontrada.")

# ===========================================
# 6. Aluno + disciplina
# ===========================================
print("\nListar alunos matriculados")

matricula_id = input("Digite o ID da matrícula: ")

cursor.execute("""
    SELECT a.nome, d.nome
    FROM alunos a
    JOIN matricula m ON a.id = m.aluno_id
    JOIN matricula_disciplina md ON m.id = md.matricula_id
    JOIN disciplinas d ON md.disciplina_id = d.id
    WHERE m.id = %s
""", (matricula_id,))

resultados = cursor.fetchall()


if resultados:
    print(f"Aluno: {resultado[0]}, Disciplina: {resultado[1]}")
else:
    print("Nenhum aluno encontrado.")

# ===========================================
# 7. Cancelar matrícula
# ===========================================
print("\nCancelar matrícula")

matricula_id = input("Digite o ID da matrícula: ")

try:
    conexao.start_transaction()

    cursor.execute(
        "DELETE FROM matricula WHERE id = %s", (matricula_id,)
    )

    conexao.commit()
    print("Matrícula cancelada com sucesso")

except Exception as e:
    conexao.rollback()
    print(f"Erro ao cancelar matrícula: {e}")

# ===========================================
# Fechar conexão
# ===========================================
cursor.close()
conexao.close()

print("\nConexão encerrada")