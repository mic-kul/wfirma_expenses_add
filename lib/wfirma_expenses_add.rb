require 'capybara'
require 'capybara/poltergeist'

module Wfirma
  module Expenses
    class Add
      include Capybara::DSL
      Capybara.default_driver = :poltergeist
      attr_accessor :user_login, :password, :nip, :document_number, :amount_brutto,
                    :purchase_date, :expense_type, :date, :pay_until, :paid
      EXPENSES =
      {
        other: 'Inne wydatki',
        tele_media: 'Koszty mediów',
      }

      def initialize(options)
        @user_login = options[:wfirma_login]
        @password = options[:wfirma_password]
        @nip = options[:nip]
        @document_number = options[:document_number]
        @amount_brutto = options[:amount_brutto]
        @date = options[:date]
        @purchase_date = options[:date_purchase]
        @expense_type = options[:expense_type]
        @pay_until = options[:pay_until]
        @paid = options[:paid]
      end

      def run!
        login
        add_expense
      end

      private

      def login
        visit 'https://wfirma.pl/users/login'
        within '.login-form' do
          fill_in 'UserLogin', with: user_login
          fill_in 'UserPassword', with: password
        end
        click_button 'Zaloguj'
        sleep 1
      end

      def add_expense
        click_link('Dodaj wydatek')
        within 'div.dialogbox-content' do
          fill_autocomplete 'ContractorDetailName', with: nip, select: 'OVH Sp. z o.o.'
          fill_in 'ExpenseFullnumber', with: document_number

          fill_dates
          # inne wydatki
          fill_amount amount_brutto

          sleep 1
          click_button 'Zapisz i kontynuuj'
          sleep 1
        end
      end

      def fill_dates
        page.execute_script %{ $('#ExpenseDate').val('#{date}')}
        page.execute_script %{ $('#ExpenseReceptionDate').val('#{date}')}
        page.execute_script %{ $('#ExpensePaymentDate').val('#{pay_until}')}
        page.execute_script %{ $('.checkbox2').click() } if paid == true
      end

      def fill_autocomplete(field, options = {})
        fill_in field, with: options[:with]

        page.execute_script %{ $('##{field}').trigger("focus") }
        page.execute_script %{ $('##{field}').trigger("keydown") }
        selector = 'ul.ui-autocomplete a:first-child'

        sleep(2)
        page.execute_script "$(\"#{selector}\").mouseenter().click()"
      end

      def fill_amount(amount_brutto)
        within '.ui-accordion-header' do
          page.execute_script %{ $('.ui-accordion-header input[type="text"]').first().click() }
          sleep 1
          page.execute_script %{ $('span:contains("#{expense_label}")').first().click() }
          sleep 1
        end

        page.execute_script %{ $('.input-brutto').first().val('#{amount_brutto}') }
        page.execute_script %{ $('.input-brutto').first().trigger('change') }
      end

      def expense_label
        EXPENSES[expense_type]
      end
    end
  end
end
