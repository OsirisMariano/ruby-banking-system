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
  print "Crie uma Senha de 4 digitos: "
  senha = gets.chomp
  # Validar se tem 4 dígitos
  while senha.length != 4
    print "Erro! A senha deve ter 4 digitos. Tente novamente: "
    senha = gets.chomp
  end


  puts "\nBem-vindo(a), #{nome} #{sobrenome}!"
  puts "Dados confirmados: #{email} | #{telefone}"

  # Retornamos o nome para usar no menu principal depois
  return nome, sobrenome, email, telefone, senha
end

def exibir_menu_principal
  puts "\n--- Menu Principal ---"
  puts '1. Ver Saldo'
  puts "2. Depositar Dinheiro"
  puts "3. Sacar Dinheiro"
  puts "4. Ver Extrato"
  puts "5. Sair"
  print "\nEscolha uma opção: "

  # Ele devolve (return) o número escolhido para o resto do programa
  return gets.chomp.to_i

end

def salvar_dados(nome, sobrenome, email, telefone, senha, saldo, historico)
  File.open("banco_dados.txt", "w") do |arquivo|
    arquivo.puts "Nome: #{nome}"
    arquivo.puts "sobrenome: #{sobrenome}"
    arquivo.puts "email: #{email}"
    arquivo.puts "telefone: #{telefone}"
    arquivo.puts "senha: #{senha}"
    arquivo.puts "saldo: #{saldo}"
    historico.each { |item| arquivo.puts item }
  end
end

def carregar_dados
  caminho_arquivo = "banco_dados.txt"
  # Se o arquivo não existir (primeira vez usando o banco), retornamos valores iniciais padrão
  return nil, nil, nil, nil, 0.0, [] unless File.exist?(caminho_arquivo)
  linhas = File.readlines(caminho_arquivo, chomp: true)
  return nil, nil, nil, nil, 0.0, [] if linhas.empty?

  nome      = linhas[0].split(": ").last
  sobrenome = linhas[1].split(": ").last
  email     = linhas[2].split(": ").last
  telefone  = linhas[3].split(": ").last
  senha     = linhas[4].split(": ").last
  saldo     = linhas[5].split(": ").last.to_f
  
  historico = linhas[7..-1] || []
  # RETORNO COMPLETO: Precisamos devolver as 6 coisas na ordem correta
  return nome, sobrenome, email, telefone, senha, saldo, historico
end