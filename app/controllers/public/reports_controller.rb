class Public::ReportsController < ApplicationController
def new
    @report = Report.new
    @customer = Customer.find(params[:customer_id])
end
    
def create 
    @customer = Customer.find(params[:customer_id]) #どのユーザーに対する通報なのかparamsで取得する
    @report = Report.new(report_params)  #ストロングパラメータを通す
    @report.reporter_id = current_customer.id  #通報者(reporter_id)にcurrent_user.idを代入
    @report.reported_id = @customer.id #通報される人(reported_id)に上で取得した@user.idを代入
    if @report.save 
      flash[:success] = "ご報告ありがとうございます"
      redirect_to customer_path(@customer)
    else
      render "new"
    end
end

private

  def report_params
    params.require(:report).permit(:reason, :url, :image)
  end
end
