# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe ArticlesController, type: :controller do
  let!(:article1) { create(:article, title: Faker::Lorem.sentence) }
  let!(:article2) { create(:article, title: Faker::Lorem.sentence) }

  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('index') }

    it 'returns articles' do
      subject
      expect(assigns(:articles)).to match_array [article1, article2]
    end
  end

  describe 'GET #show' do
    let(:params) { { id: article1.id } }
    subject { get :show, params: params }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('show') }

    it 'returns article' do
      subject
      expect(assigns(:article)).to eq article1
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to render_template('new') }

    it 'creates new instance' do
      subject
      expect(assigns(:article).title).to eq nil
      expect(assigns(:article).body).to eq nil
    end
  end
end
