require 'date'

def depositar(saldo, historico, valor)
  data_hora = DateTime.now.strftime('%d/%m/%Y %H:%M')
  saldo += valor

  # PADRONIZAÇÃO DE ESPAÇOS:
  # 'tipo' ocupa 10 espaços e 'valor_num' ocupa 10 espaços para alinhar os centavos
  tipo = "Depósito".ljust(10)
  valor_num = format('%.2f', valor).rjust(10)

  # Montagem da string usando as variáveis preparadas
  historico << "\e[32m#{data_hora} - #{tipo} + R$ #{valor_num}\e[0m"
  
  puts "✅ Depósito de R$ #{format('%.2f', valor)} realizado com sucesso!"
  return saldo
end

def sacar(saldo, historico, senha_correta, valor)
  data_hora = DateTime.now.strftime('%d/%m/%Y %H:%M')
  
  print "Digite sua senha para autorizar o saque: "
  tentativa_senha = gets.chomp

  if tentativa_senha == senha_correta
    if valor <= saldo
      saldo -= valor
      
      # PADRONIZAÇÃO DE ESPAÇOS (IGUAL AO DEPÓSITO):
      tipo = "Saque".ljust(10)
      valor_num = format('%.2f', valor).rjust(10)

      # Montagem da string usando as variáveis preparadas
      historico << "\e[31m#{data_hora} - #{tipo} - R$ #{valor_num}\e[0m"
      
      puts "✅ Saque realizado!"
    else
      puts "❌ Saldo insuficiente."
    end
  else
    puts "❌ Senha incorreta! Operação cancelada."
  end
  return saldo
end