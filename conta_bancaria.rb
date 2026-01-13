require 'date'
require 'json'

class ContaBancaria
  attr_accessor :nome, :sobrenome, :senha, :saldo, :historico

  def initialize(nome, sobrenome, senha, saldo = 0.0, historico = [])
    @nome = nome
    @sobrenome = sobrenome
    @senha = senha
    @saldo = saldo
    # CORREÇÃO: Agora ele aceita o histórico que vem do JSON ou inicia vazio
    @historico = historico
  end

  def self.carregar_todas
     caminho = "dados_bancarios.json"
     return [] unless File.exist?(caminho)

     arquivo = File.read(caminho)
     return [] if arquivo.strip.empty?

     dados_brutos = JSON.parse(arquivo)

     dados_brutos.map do |dados|
      new(
        dados['nome'],
        dados['sobrenome'],
        dados['senha'],
        dados['saldo'].to_f,
        dados['historico']
      )
     end
  end

  def self.salvar_todas(lista_de_contas)
    dados = lista_de_contas.map do |conta|
      {
        nome: conta.nome,
        sobrenome: conta.sobrenome,
        senha: conta.senha,
        saldo: conta.saldo,
        historico: conta.historico
      }
    end

    File.open("dados_bancarios.json", "w") do |arquivo|
      arquivo.write(JSON.pretty_generate(dados))
    end
  end

  def exibir_resumo
    puts "Titular: #{@nome} #{@sobrenome} | Saldo Atual: R$ #{format('%.2f', @saldo)}"
  end

  def depositar(valor)
    if valor > 0
      @saldo += valor
      # PADRONIZAÇÃO: Usando o método de registro com a cor VERDE
      registrar_no_historico("Depósito", "+", valor, "\e[32m")
      puts "Depósito de R$ #{format('%.2f', valor)} realizado!"
    else
      puts "Valor inválido!"
    end
  end

  def sacar(valor)
    if valor <= 0 || valor > @saldo
      puts "Erro: Valor inválido ou saldo insuficiente."
      return
    end

    print "Digite sua senha: "
    return puts "Senha Incorreta!" if gets.chomp != @senha

    @saldo -= valor
    # PADRONIZAÇÃO: Usando o método de registro com a cor VERMELHA
    registrar_no_historico("Saque", "-", valor, "\e[31m")
    puts "Saque realizado!"
  end

  private

  def registrar_no_historico(tipo, sinal, valor, cor)
    # Certifique-se de que Time ou DateTime está disponível
    data_hora = Time.now.strftime('%d/%m/%Y %H:%M')
    tipo_formatado = tipo.ljust(10)
    simbolo = "#{sinal} R$".ljust(5)
    valor_f = format('%.2f', valor).rjust(10)
    
    @historico << "#{cor}#{data_hora} - #{tipo_formatado} #{simbolo}#{valor_f}\e[0m"
  end
end