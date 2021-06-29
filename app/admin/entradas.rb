ActiveAdmin.register Entrada do

  menu priority: 4, label: "Entradas"

  actions :all, :except => [:edit]

  permit_params :data, :documento, :numero, :quantidade, :preco_unitario, :preco_total, :observacoes, :estoque_id

  config.batch_actions = false

  config.per_page = 10

  filter :id
  filter :data, label: 'DATA'
  filter :estoque, as: :select, label: 'ITEM'
  filter :numero, label: 'DOCTO NÚMERO'

  config.sort_order = 'data_desc'

  index do
    selectable_column
    column "ID", :id
    column "DATA" do |entrada|
        entrada.data.strftime("%d/%m/%y")
    end
    column "ITEM", :estoque
    column "DOCTO NÚMERO", :numero
    column "QUANTIDADE" do |entrada|
        number_with_precision entrada.quantidade, precision: 4
    end
    column "PREÇO UNITÁRIO" do |entrada|
        number_to_currency entrada.preco_unitario, precision: 2
    end
    column "PREÇO TOTAL" do |entrada|
        number_to_currency entrada.preco_total, precision: 2
    end
    actions

  end

  show title: :estoque do

    panel "Entrada" do

      attributes_table_for entrada do 

        row("ID") { entrada.id }
        row("DATA") { entrada.data.strftime("%d/%m/%y") }
        row("ITEM") { entrada.estoque }
        row("DOCUMENTO") { entrada.documento }
        row("NÚMERO") { entrada.numero }
        row("QUANTIDADE") { number_with_precision entrada.quantidade, precision: 4 }
        row("PREÇO UNITÁRIO") { number_to_currency entrada.preco_unitario, precision: 2 }
        row("PREÇO TOTAL") { number_to_currency entrada.preco_total, precision: 2 }
        row("OBSERVAÇÕES") { entrada.observacoes }

      end

    end

  end

  form title: "Entrada" do |f|

    f.inputs do

      f.input :data, label: "DATA"
      f.input :estoque, label: "ITEM"
      f.input :documento, label: "DOCUMENTO"
      f.input :numero, label: "NÚMERO"
      f.input :quantidade, label: "QUANTIDADE", precision: 4
      f.input :preco_unitario, label: "PREÇO UNITÁRIO", precision: 4
      f.input :observacoes, label: "OBSERVAÇÕES"

    end

    f.actions
  end
end
