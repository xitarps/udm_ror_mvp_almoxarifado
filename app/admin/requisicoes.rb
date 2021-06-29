ActiveAdmin.register Requisicao do

  menu priority: 5, label: "Requisições"

  actions :all, :except => [:edit]

  permit_params :tipo, :data, :numero, :setor, :quantidade, :custo_medio, :custo_total, :observacoes, :estoque_id

  config.batch_actions = false

  config.per_page = 10

  filter :id
  filter :data, label: 'DATA'
  filter :tipo, as: :select, collection: Requisicao.tipos, label: 'TIPO'
  filter :estoque, as: :select, label: 'ITEM'
  filter :setor, as: :select, collection: Requisicao.setores, label: 'SETOR'
  filter :numero, label: 'NÚMERO'

  config.sort_order = 'data_desc'

  index do

    selectable_column

    column "ID", :id
    column "DATA" do |requisicao|
        requisicao.data.strftime("%d/%m/%y")
    end
    column "TIPO", :tipo
    column "ITEM", :estoque
    column "SETOR", :setor
    column "NÚMERO", :numero
    column "QUANTIDADE" do |requisicao|
        number_with_precision requisicao.quantidade, precision: 4
    end
    column "CUSTO MÉDIO" do |requisicao|
        number_to_currency requisicao.custo_medio, precision: 2
    end
    column "CUSTO TOTAL" do |requisicao|
        number_to_currency requisicao.custo_total, precision: 2
    end

    actions

  end

  show title: :estoque do

    panel "Requisição" do

       attributes_table_for requisicao do 

          row("ID") { requisicao.id }
          row("DATA") { requisicao.data.strftime("%d/%m/%y") }
          row("TIPO") { requisicao.tipo }
          row("ITEM") { requisicao.estoque }
          row("SETOR") { requisicao.setor }
          row("NÚMERO") { requisicao.numero }
          row("QUANTIDADE") { number_with_precision requisicao.quantidade, precision: 4 }
          row("PREÇO UNITÁRIO") { number_to_currency requisicao.custo_medio, precision: 2 }
          row("PREÇO TOTAL") { number_to_currency requisicao.custo_total, precision: 2 }
          row("OBSERVAÇÕES") { requisicao.observacoes }

       end

    end

  end

  form title: "Requisição" do |f|
    f.inputs do
      f.input :data, label: "DATA"
      f.input :tipo, label: "TIPO"
      f.input :estoque, label: "ITEM"
      f.input :setor, label: "SETOR"
      f.input :numero, label: "NÚMERO"
      f.input :quantidade, label: "QUANTIDADE", precision: 4
      f.input :observacoes, label: "OBSERVAÇÕES"

    end
    f.actions
  end

end
