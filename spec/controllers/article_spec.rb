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

  describe 'POST #create' do
    subject { post :create, params: params }
    let(:params) { { article: { title: 'test title', body: '12345678910' } } }

    context 'creates a new article successfully' do
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to article_path(assigns(:article)) }

      it 'creates a new article' do
        subject

        expect(Article.last.title).to eq 'test title'
        expect(Article.last.body).to eq '12345678910'
      end

      it 'change count of article' do
        expect { subject }.to change { Article.count }.by(1)
      end
    end

    context 'connot create a new article' do
      before do
        params[:article].except!(:title)
      end

      it { is_expected.to render_template('new') }
    end
  end
end
