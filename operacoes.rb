require 'date'

def depositar(saldo, historico, valor)
  return saldo if valor <= 0

  data_hora = DateTime.now.strftime('%d/%m/%Y %H:%M')
  saldo += valor

  # --- ALINHAMENTO PROFISSIONAL ---
  tipo = "Depósito".ljust(10)
  
  # 1. Criamos o símbolo fixo (5 espaços)
  simbolo = "+ R$".ljust(5)
  
  # 2. Criamos o valor numérico alinhado à direita (10 espaços)
  valor_f = format('%.2f', valor).rjust(10)

  # Montamos a linha usando as peças separadas
  historico << "\e[32m#{data_hora} - #{tipo} #{simbolo}#{valor_f}\e[0m"
  
  puts "✅ Depósito realizado!"
  return saldo
end

def sacar(saldo, historico, senha_correta, valor)
  # ... (suas validações de segurança aqui) ...
  return saldo if valor <= 0
  print "Digite sua senha: "
  return saldo if gets.chomp != senha_correta
  if valor > saldo
    puts "❌ Saldo insuficiente."
    return saldo
  end

  saldo -= valor
  data_hora = DateTime.now.strftime('%d/%m/%Y %H:%M')

  # --- ALINHAMENTO PROFISSIONAL ---
  tipo = "Saque".ljust(10)
  
  # Usamos o mesmo tamanho de coluna (5 para símbolo, 10 para valor)
  simbolo = "- R$".ljust(5)
  valor_f = format('%.2f', valor).rjust(10)

  historico << "\e[31m#{data_hora} - #{tipo} #{simbolo}#{valor_f}\e[0m"
  
  puts "✅ Saque realizado!"
  return saldo
end