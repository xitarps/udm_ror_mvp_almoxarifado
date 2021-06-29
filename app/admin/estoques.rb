ActiveAdmin.register Estoque do

  menu priority: 3, label: "Estoques"

  permit_params :tipo, :descricao, :codigo, :unidade, :perecivel, :estoque_minimo, :estoque_maximo, :estoque_reposicao,
                :conta_contabil, :localizacao, :status, :grupo_id

  config.batch_actions = false

  config.per_page = 10

  filter :id
  filter :descricao, label: 'DESCRIÇÂO'
  filter :codigo, label: 'REFERÊNCIA'
  filter :grupo, as: :select, label: 'GRUPO'
  filter :tipo, as: :select, collection: Estoque.tipos, label: 'TIPO'
  filter :perecivel, as: :check_boxes, label: 'PERECÍVEL'
  filter :status, as: :select, collection: Estoque.status, label: 'STATUS'

  config.sort_order = 'descricao_asc'

  index do
    selectable_column
    column "ID", :id
    column "DESCRIÇÂO", :descricao
    column "REFERÊNCIA", :codigo
    column "UNIDADE", :unidade
    column "GRUPO", :grupo
    column "TIPO", :tipo
    column "PERECÍVEL", :perecivel
    column "STATUS", :status
    actions
  end

  sidebar "Item", only: :show do

    attributes_table_for estoque do 
      row("ID") { estoque.id }
      row("GRUPO") { estoque.grupo.nome }
      row("TIPO") { estoque.tipo }
      row("DESCRIÇÃO") { estoque.descricao }
      row("REFERÊNCIA") { estoque.codigo }
      row("UNIDADE") { estoque.unidade }
      row("PRERECÍVEL") { estoque.perecivel }
      row("MÍNIMO") { number_with_precision estoque.estoque_minimo, precision: 4 }
      row("MÁXIMO") { number_with_precision estoque.estoque_maximo, precision: 4 }
      row("REPOSIÇÃO") { number_with_precision estoque.estoque_reposicao, precision: 4 }
      row("SALDO") { number_with_precision estoque.estoque_saldo, precision: 4 }
      row("CUSTO MÉDIO") { number_to_currency estoque.custo_medio }
      row("CUSTO TOTAL") { number_to_currency estoque.custo_total }
      row("CONTA CONTÁBIL") { estoque.conta_contabil }
      row("LOCALIZAÇÃO") { estoque.localizacao }
      row("STATUS") { estoque.status }
    end
  end

  show title: :descricao do

    panel "Entradas" do

      table_for (estoque.entradas.order("data desc, documento, numero")) do

        column("ID") { |entrada| link_to(entrada.id, admin_entrada_path(entrada)) }
        column("DATA") { |entrada| entrada.data.strftime("%d/%m/%y")}
        column("DOCUMENTO") { |entrada| entrada.documento }
        column("NÚMERO") { |entrada| entrada.numero }
        column("QUANTIDADE")   { |entrada| number_with_precision entrada.quantidade, precision: 4 }
        column("PREÇO UNITÁRIO") { |entrada| number_to_currency entrada.preco_unitario }
        column("VALOR TOTAL") { |entrada| number_to_currency entrada.preco_total }
      end
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
      br
      tr :class => "odd" do
        td "ITENS:", :style => "text-align: right;"
        td estoque.entradas.count()
      end
      br            
      tr :class => "odd" do
        td "QUANTIDADE:", :style => "text-align: right;"
        td number_with_precision (estoque.entradas).sum(:quantidade), precision: 4
      end
      br            
      tr :class => "odd" do
        td "VALOR:", :style => "text-align: right;"
        td number_to_currency (estoque.entradas).sum(:preco_total)
      end
      br
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
    end

    panel "Saídas" do

      table_for (estoque.requisicoes.where("tipo = 0").order("data desc, setor, numero")) do

        column("ID") { |requisicao| link_to(requisicao.id, admin_requisicao_path(requisicao)) }
        column("DATA") { |requisicao| requisicao.data.strftime("%d/%m/%y")}
        column("SETOR") { |requisicao| requisicao.setor }
        column("NÚMERO") { |requisicao| requisicao.numero }
        column("QUANTIDADE") { |requisicao| number_with_precision requisicao.quantidade, precision: 4 }
        column("CUSTO MÉDIO") { |requisicao| number_to_currency requisicao.custo_medio }
        column("CUSTO TOTAL") { |requisicao| number_to_currency (requisicao.custo_total) }

      end
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
      br
      tr :class => "odd" do
        td "ITENS:", :style => "text-align: right;"
        td estoque.requisicoes.where("tipo = 0").count()
      end
      br            
      tr :class => "odd" do
        td "QUANTIDADE:", :style => "text-align: right;"
        td number_with_precision (estoque.requisicoes).where("tipo = 0").sum(:quantidade), precision: 4
      end
      br            
      tr :class => "odd" do
        td "VALOR:", :style => "text-align: right;"
        td number_to_currency (estoque.requisicoes).where("tipo = 0").sum(:custo_total)
      end
      br
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
    end

    panel "Devoluções" do

      table_for (estoque.requisicoes.where("tipo = 1").order("data desc, setor, numero")) do

        column("ID") { |requisicao| link_to(requisicao.id, admin_requisicao_path(requisicao)) }
        column("DATA") { |requisicao| requisicao.data.strftime("%d/%m/%y")}
        column("SETOR") { |requisicao| requisicao.setor }
        column("NÚMERO") { |requisicao| requisicao.numero }
        column("QUANTIDADE") { |requisicao| number_with_precision requisicao.quantidade, precision: 4 }
        column("CUSTO MÉDIO") { |requisicao| number_to_currency requisicao.custo_medio }
        column("CUSTO TOTAL") { |requisicao| number_to_currency (requisicao.custo_total) }

      end
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
      br
      tr :class => "odd" do
        td "ITENS:", :style => "text-align: right;"
        td estoque.requisicoes.where("tipo = 1").count()
      end
      br            
      tr :class => "odd" do
        td "QUANTIDADE:", :style => "text-align: right;"
        td number_with_precision (estoque.requisicoes).where("tipo = 1").sum(:quantidade), precision: 4
      end
      br            
      tr :class => "odd" do
        td "TOTAL:", :style => "text-align: right;"
        td number_to_currency (estoque.requisicoes).where("tipo = 1").sum(:custo_total)
      end
      br
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
    end
  end

  form title: "Estoque" do |f|
    f.inputs do
      f.input :grupo, label: "GRUPO"
      f.input :tipo, label: "TIPO"
      f.input :descricao, label: "DESCRIÇÂO"
      f.input :codigo, label: "REFERÊNCIA"
      f.input :unidade, label: "UNIDADE"
      f.input :perecivel, label: "PERECÍVEL"
      f.input :estoque_minimo, label: "MÍNIMO", precision: 4
      f.input :estoque_maximo, label: "MÁXIMO", precision: 4
      f.input :estoque_reposicao, label: "REPOSIÇÃO", precision: 4
      f.input :conta_contabil, label: "CONTA CONTÁBIL"
      f.input :localizacao, label: "LOCALIZAÇÂO"
      f.input :status, label: "STATUS"
    end
    f.actions
  end
end
