def depositar(saldo_atual, historico_atual)
  print "\nQuanto você deseja depositar? R$ "
  valor = gets.chomp.to_f # .to_f converte para Float (número com centavos)

  if valor > 0
    novo_saldo = saldo_atual + valor # Criamos a variável aqui
    historico_atual << "Depósito + R$ #{format('%.2f', valor)}"

    puts "Depósito de R$ #{format('%.2f', valor)} realizado com sucesso!"
    return novo_saldo
  else
    puts "Valor inválido para depósito."
    return saldo_atual
  end
end

def sacar(saldo_atual, historico_atual, senha_correta)
  print = "Digite sua senha para autorizar o saque: "
  senha_digitada = gets.chomp
  if senha_digitada != senha_correta
    puts "Senha incirreta! Operação cancelada."
    return saldo_atual
  end
  
  print "\nQuanto você deseja sacar? R$ "
  valor = gets.chomp.to_f

  if valor > 0 && valor <= saldo_atual
    novo_saldo = saldo_atual - valor
    historico_atual << "Saque - R$ #{format('%.2f', valor)}"

    puts " Saque de R$ #{format('%2.f', valor)} realizado com sucesso!"
    return novo_saldo
  elsif valor > saldo_atual
    puts "Saldo insuficiente para realizar esse saque."
    return saldo_atual
  else
    puts "Valro inválido para saque."
    return saldo_atual
  end
end