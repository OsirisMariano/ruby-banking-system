def limpar_tela
  # O comando para limpar a tela depende do sistema operacional
  Gem.win_platform? ? system('cls') : system('clear')
end

def cadastrar_usuario
  puts "--- Formulário de Cadastro ---"
  print "Digite seu nome: "
  nome = gets.chomp
  print "Digite seu sobrenome: "
  sobrenome = gets.chomp
  print "Digite seu email: "
  email = gets.chomp
  print "Digite sua telefone: "
  telefone = gets.chomp
  print "Digite seu data de nascimento: "
  data = gets.chomp

  puts "\nBem-vindo(a), #{nome} #{sobrenome}!"
  puts "Dados confirmados: #{email} | #{telefone}"

  # Retornamos o nome para usar no menu principal depois
  return nome
end

def exibir_menu_principal
  puts "\n--- Menu Principal ---"
  puts "1. Ver Saldo"
  puts "2. Depositar Dinheiro"
  puts "3. Sacar Dinheiro"
  puts "4. Ver Extrato"
  puts "5. Sair"
  print "\nEscolha uma opção: "

  # Ele devolve (return) o número escolhido para o resto do programa
  return gets.chomp.to_i

end

def salvar_dados(nome, sobrenome, email, telefone, saldo, historico)
  File.open("banco_dados.txt", "w") do |arquivo|
    arquivo.puts nome
    arquivo.puts sobrenome
    arquivo.puts email
    arquivo.puts telefone
    arquivo.puts saldo
    historico.each {|item| arquivo.puts item}
  end
end

def carregar_dados
  caminho_arquivo = "banco_dados.txt"
  # Se o arquivo não existir (primeira vez usando o banco), retornamos valores iniciais padrão
  return nil, nil, nil, nil, 0.0, [] unless File.exist?(caminho_arquivo)
  linhas = File.readlines(caminho_arquivo, chomp: true)
  return nil, nil, nil, nil, 0.0, [] if linhas.empty?

  nome = linhas[0]
  sobrenome = linhas[1]
  email = linhas[2]
  telefone = linhas[3]
  saldo = linhas[4].to_f
  
  # O histórico começa na linha 5 e vai até o fim
  historico = linhas[5..-1] || []

  # RETORNO COMPLETO: Precisamos devolver as 6 coisas na ordem correta
  return nome, sobrenome, email, telefone, saldo, historico
end