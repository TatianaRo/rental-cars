require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do 
    it 'attributes cannot be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include ('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include ('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include ('não pode ficar em branco')
    end

    it 'cnpj must be uniq' do
      Subsidiary.create!(name: 'Filial10', cnpj:'71717095000107', address:'Rua das aves, 89')

      subsidiary = Subsidiary.new(cnpj:'71717095000107')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'cnpjs length must be 14' do
      subsidiary = Subsidiary.new(cnpj: '1234')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não possui o tamanho esperado (14 caracteres)')
   end

   it 'cnpj must be valid' do
     subsidiary = Subsidiary.new(cnpj: '12345678901234')

     subsidiary.valid?

     expect(subsidiary.errors[:cnpj]).to include('inválido')

   end

  end
end
