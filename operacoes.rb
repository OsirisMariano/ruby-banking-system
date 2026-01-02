def depositar(saldo, historico, valor)
  saldo += valor
  historico << "Depósito + R$ #{format('%.2f', valor)}"
  puts "✅ Depósito de R$ #{format('%.2f', valor)} realizado com sucesso!"
  
  return saldo # Retornamos o novo saldo para o main.rb
end

def sacar(saldo, historico, senha_correta, valor)
  print "Digite sua senha para autorizar o saque: "
  tentativa_senha = gets.chomp

  if tentativa_senha == senha_correta
    if valor <= saldo
      saldo -= valor
      historico << "Saque    - R$ #{format('%.2f', valor)}"
      puts "✅ Saque realizado!"
    else
      puts "❌ Saldo insuficiente."
    end
  else
    puts "❌ Senha incorreta! Operação cancelada."
  end
  return saldo
end