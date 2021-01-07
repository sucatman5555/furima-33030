require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end
  describe '新規登録/ユーザー情報' do
    it '全て正しく入力されている場合' do
      expect(@user).to be_valid
    end
    it 'ニックネームが必須であること' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'tarako.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '1234a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は6文字以上、英字と数字の両方を含めてください')
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password_confirmation = '12345ab'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'ユーザー本名は、名字が必須であること' do
      @user.last_name_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
    end
    it 'ユーザー本名は、名前が必須であること' do
      @user.first_name_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kanji can't be blank")
    end
    it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name_kanji = 'ﾀﾗｺ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kanji に全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end
    it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name_kanji = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kanji に全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end
    it 'ユーザー本名のフリガナは、名字が必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'ユーザー本名のフリガナは、名前が必須であること' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'ユーザー本名のフリガナの名字は、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'ﾀﾗｺ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana に全角文字（カタカナ）を使用してください')
    end
    it 'ユーザー本名のフリガナの名前は、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana に全角文字（カタカナ）を使用してください')
    end
    it '生年月日が必須であること' do
      @user.user_birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("User birth date can't be blank")
    end
  end
end
