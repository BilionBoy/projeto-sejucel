namespace :import do
  desc "Importar participantes da planilha Excel"
  task participantes: :environment do
    require "roo"

    path = Rails.root.join("lib", "planilhas", "PlanilhaSejus.xlsx").to_s
    xlsx = Roo::Spreadsheet.open(path)

    puts "📂 Importando participantes da planilha..."

    # Pegamos a primeira aba
    sheet = xlsx.sheet(0)

    participantes = []

   sheet.each_with_index(nome: "Nome", cpf: "CPF", modalidade: "Modalidade", municipio: "Município") do |row, index|
      next if index == 0 # pula o cabeçalho

      nome = row[:nome].to_s.strip
      cpf = row[:cpf].to_s.strip

      # Ignora se não tiver CPF ou nome vazio
      next if nome.blank? || cpf.blank?

      participantes << {
        nome: nome,
        cpf: cpf,
        modalidade: row[:modalidade].to_s.strip,
        municipio: row[:municipio].to_s.strip
      }
    end

    # Ordena alfabeticamente por nome
    participantes.sort_by! { |p| p[:nome].downcase }

    participantes.each do |row|
      participante = Participante.find_or_initialize_by(cpf: row[:cpf])
      participante.nome = row[:nome]
      participante.codigo_qr ||= SecureRandom.uuid

      # busca modalidade e municipio existentes
      participante.modalidade = Modalidade.find_or_create_by(descricao: row[:modalidade])
      participante.municipio  = Municipio.find_or_create_by(descricao: row[:municipio])

      participante.save!
      puts "✅ Importado: #{participante.nome} (#{participante.cpf})"
    end

    puts "🎉 Importação concluída. Total de participantes importados: #{participantes.size}"
  end
end
