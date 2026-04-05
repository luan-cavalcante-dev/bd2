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

# =======================================
# 1. Inicinado controle de concorrência
# =======================================
print("\nIniciando controle de concorrência...")

try:
    conexao.start_transaction()
    
    aluno_id = 1
    curso_id = 1

    # trava o aluno para evitar que outras transações modifiquem o mesmo registro
    cursor.execute(
        "SELECT * FROM alunos WHERE id = %s FOR UPDATE",(aluno_id,)
    )
    
    aluno = cursor.fetchone()

    if not aluno:
        raise Exception("Aluno não encontrado")
    
    # trava o cruso
    
    cursor.execute(
        "SELECT * FROM cursos WHERE id = %s FOR UPDATE",(curso_id,)
    )
    curso = cursor.fetchone()

    if not curso:
        raise Exception("Curso não encontrado")
    
    # simular concorrência
    import time
    print("Simulando concorrência... (aguarde 10 segundos)")
    time.sleep(10)

    # realizar a matrícula

    cursor.execute(
        "INSERT INTO matricula (aluno_id, curso_id) VALUES (%s, %s)",(aluno_id, curso_id)
    )
    conexao.commit()
    print("Matrícula realizada com sucesso")

except Exception as e:
    conexao.rollback()
    print(f"Erro no controle de concorrência: {e}")
        
    

