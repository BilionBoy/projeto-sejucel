namespace :import do
  desc "Importar participantes da planilha Excel"
  task participantes: :environment do
    require "roo"
    require "set"

    path = Rails.root.join("lib", "planilhas", "PlanilhaSejus.xlsx").to_s
    xlsx = Roo::Spreadsheet.open(path)

    puts "📂 Importando participantes da planilha..."

    sheet = xlsx.sheet(0)
    participantes = []
    cpfs_vistos = Set.new

    sheet.each_with_index(nome: "Nome", cpf: "CPF", modalidade: "Modalidade", municipio: "Município") do |row, index|
      next if index.zero? # pula cabeçalho

      nome       = row[:nome].to_s.strip.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      cpf        = row[:cpf].to_s.strip.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      modalidade = row[:modalidade].to_s.strip.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
      municipio  = row[:municipio].to_s.strip.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")

      if nome.blank? || cpf.blank?
        puts "⚠️ Ignorado: linha #{index + 1} sem nome ou CPF"
        next
      end

      if cpfs_vistos.include?(cpf)
        puts "⚠️ Ignorado: CPF duplicado na planilha (#{cpf})"
        next
      end
      cpfs_vistos.add(cpf)

      participantes << { nome: nome, cpf: cpf, modalidade: modalidade, municipio: municipio }
    end

    participantes.sort_by! { |p| p[:nome].downcase }

    importados = 0
    ignorados  = 0

    participantes.each do |row|
      if Participante.exists?(cpf: row[:cpf])
        puts "⚠️ Ignorado: CPF já existe no banco (#{row[:cpf]})"
        ignorados += 1
        next
      end

      participante = Participante.new(nome: row[:nome], cpf: row[:cpf])
      participante.modalidade = Modalidade.find_or_create_by(descricao: row[:modalidade])
      participante.municipio  = Municipio.find_or_create_by(descricao: row[:municipio])
      participante.save!

      # Gera a URL completa e segura pro QR Code (usa o host configurado no environment)
      participante.update!(
        codigo_qr: "#{Rails.application.routes.url_helpers.root_url}acoes/new?participante_id=#{participante.id}"
      )

      importados += 1
      puts "✅ Importado: #{participante.nome} (#{participante.cpf}) | QR → #{participante.codigo_qr}"
    end

    puts "🎉 Importação concluída. Importados: #{importados}, Ignorados: #{ignorados}"
  end
end
