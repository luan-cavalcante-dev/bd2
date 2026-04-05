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

# ====================================================
# 1. estabelecer segurança com usuários e permissões
# ====================================================

# cria usuário aluno

    cursor.execute ( " CREATE USER 'aluno'@'localhost' IDENTIFIED BY '123' " )
    print("Usuário 'aluno' criado com sucesso! ")

    # premissão do aluno para acessar o banco de dados universidade somente para leitura
    cursor.execute ( " GRANT SELECT ON universidade.* TO 'aluno'@'localhost' " )
    print("Permissão de leitura concedida ao usuário 'aluno'! ")

    # cria usuário professor
    cursor.execute ( " CREATE USER 'professor'@'localhost' IDENTIFIED BY '123' " )
    print("Usuário 'professor' criado com sucesso! ")

    # permissão do professor 

    cursor.execute ( " GRANT SELECT, INSERT, UPDATE ON universidade.* TO 'professor'@'localhost' " )
    print("Permissão de leitura e escrita concedida ao usuário 'professor'! ")

    cursor.execute ( " FLUSH PRIVILEGES " )
    print("Privilégios atualizados! ")

    conexao.commit()

except Exception as e:
    print(f"Erro ao estabelecer segurança: {e}")
    
finally:
    cursor.close()
    conexao.close()
    print("Conexão com o banco de dados encerrada")