ActiveAdmin.register Grupo do

  menu priority: 2, label: "Grupos"

  permit_params :nome, :status

  config.batch_actions = false

  config.per_page = 10

  filter :id
  filter :nome
  filter :status, as: :select, collection: Grupo.status

  config.sort_order = 'nome_asc'

  index do
    selectable_column
    column "ID", :id
    column "NOME", :nome
    column "STATUS", :status
    actions
  end

  show title: :nome do
    panel "Itens" do
      table_for(grupo.estoques.order("descricao").where("status = 0")) do
        column("Id") { |estoque| estoque.id }
        column("Descrição") { |estoque| link_to(estoque.descricao, admin_estoque_path(estoque)) }
        column("Referência") { |estoque| estoque.codigo }
        column("Unidade") { |estoque| estoque.unidade }
        column("Perecível") { |estoque| estoque.perecivel }
        column("Mínimo") { |estoque| number_with_precision estoque.estoque_saldo, precision: 4 }
        column("Máximo") { |estoque| number_with_precision estoque.estoque_saldo, precision: 4 }
        column("Reposição") { |estoque| number_with_precision estoque.estoque_reposicao, precision: 4 }
        column("Saldo") { |estoque| number_with_precision estoque.estoque_saldo, precision: 4 }
        column("Custo Médio") { |estoque| number_to_currency estoque.custo_medio }
        column("Custo Total") { |estoque| number_to_currency estoque.custo_total }          
      end
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
      br
      tr :class => "odd" do
        td "Itens:", :style => "text-align: right;"
        td grupo.estoques.where("status = 0").count()
      end
      br            
      tr :class => "odd" do
        td "Quantidade:", :style => "text-align: right;"
        td number_with_precision (grupo.estoques).where("status = 0").sum(:estoque_saldo), precision: 4
      end
      br
      tr :class => "odd" do
        td "Total:", :style => "text-align: right;"
        td number_to_currency grupo.estoques.where("status = 0").sum(:custo_total)
      end
      br
      tr :class => "odd" do
        td "========================", :style => "text-align: right;"
      end
    end
  end

  form title: "Grupo" do |f|
    f.inputs do
      f.input :nome, label: "NOME"
      f.input :status, label: "STATUS"
    end
    f.actions
  end
end
