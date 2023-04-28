require 'open-uri'
require 'nokogiri'
require 'httparty'
require 'mechanize'

# class ApiMetadadosService
#   def self.busca_metadados(codigo_serie)
#     # url = "https://www3.bcb.gov.br/sgspub/consultarmetadados/consultarMetadadosSeries.do?method=consultarMetadadosSeriesInternet&hdOidSerieSelecionada=#{codigo_serie}"
#     # html = URI.open(url)
#     # doc = Nokogiri::HTML(html)
#     # return doc
#     url = "https://www3.bcb.gov.br/sgspub/consultarmetadados/consultarMetadadosSeries.do?method=consultarMetadadosSeriesInternet&hdOidSerieSelecionada=#{codigo_serie}"
#     html = URI.open(url)
#     doc = Nokogiri::HTML(html)
#     return doc

#   end
# end

# class ApiMetadadosService
#   def self.busca_metadados
#     url = 'https://www3.bcb.gov.br/sgspub/consultarmetadados/consultarMetadadosSeries.do?method=consultarMetadadosSeriesInternet&hdOidSerieSelecionada=12'
#     html = URI.open(url)
#     doc = Nokogiri::HTML(html)
#     puts "----------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
#     puts "-----"
#     puts html
#     # Find the div with the id 'abaDadosBasicos' and extract the first span element's text
#     dados_basicos_div = doc
#     puts "----------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    
#     # texto_span = dados_basicos_div.css('span').first.text.strip
#     puts dados_basicos_div
#     puts "-----$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

#     puts doc.to_html
#     puts "----------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    
#   end
# end

class ApiMetadadosService
  def self.busca_metadados
    response = HTTParty.get("https://www3.bcb.gov.br/sgspub/consultarmetadados/consultarMetadadosSeries.do?method=consultarMetadadosSeriesInternet&hdOidSerieSelecionada=789")
    doc = Nokogiri::HTML(response.body)

    # extrai o título da página
    title = doc.css('.h1').text.strip
    puts "Título: #{title}"
    
    # extrai o nome da série
    serie = doc.css('#documento').text.strip
    puts "Série: #{serie}"
    
    # extrai a descrição da série
    descricao = doc.css('td.mtabi').text.strip
    puts "Descrição: #{descricao}"
    
    # extrai a data do último dado atualizado
    data_atualizacao = doc.css('span.textoPequeno').text.strip
    puts "Data de Atualização: #{data_atualizacao}"
  end
  
  def self.texto
  
    agent = Mechanize.new
    page = agent.get('https://www.bbc.com/news')
    headings = page.search('.gs-c-promo-heading__title')
    headings.map { |heading| heading.text.strip }
    
  end

  # def self.texto
  #   agent = Mechanize.new

  #   # Abre a página dos metadados do Banco Central
  #   page = agent.get('https://www3.bcb.gov.br/sgspub/consultarmetadados/consultarMetadadosSeries.do?method=consultarMetadadosSeriesInternet&hdOidSerieSelecionada=12')

  #   # Encontra o título da série de dados
  #   titulo = page.at('.tituloSerie')

  #   # Encontra a descrição da série de dados
  #   descricao = page.at('.descSerie')

  #   # Encontra a unidade da série de dados
  #   unidade = page.at('.unidadeSerie')

  #   # Retorna um hash com os dados extraídos
  #   {
  #     titulo: titulo,
  #     descricao: descricao,
  #     unidade: unidade
  #   }
  # end

  
end




# ARQUIVO PRIMARIO
#A linha de código @dados = ApiService.busca_dados é responsável 
#por chamar o método busca_dados do serviço ApiService e 
#armazenar o resultado na variável de instância @dados.
#O método busca_dados faz uma chamada HTTP GET à URL 
#especificada no código do serviço, utilizando a biblioteca 
#httparty para realizar a requisição. A resposta da API é então 
#convertida para um objeto JSON através do 
#método parsed_response, também fornecido pela biblioteca 
#httparty.
#Ao armazenar o resultado na variável de instância @dados, 
#essa informação pode ser utilizada posteriormente 
#na view correspondente à action 
#que invocou o método @dados.
