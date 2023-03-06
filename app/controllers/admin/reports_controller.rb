class Admin::ReportsController < ApplicationController
    before_action :is_admin_access
   # before_action :authenticate_admin!
    
    def index 
      @reports = Report.all.order(created_at: :DESC)
    end
    
    def show 
      @report = Report.find(params[:id])
    end
    
    def update
        @report = Report.find(params[:id])
        if @report.update(report_params) 
          flash[:success] = "対応ステータスを更新しました。"
          redirect_to request.referer #遷移元のURLに戻る
        end
    end
    
    def destroy
    @report = Report.find(params[:id])
    @report.destroy
    flash[:danger] = "通報を削除しました"
    redirect_to admin_reports_path
    end
      

private

  def report_params
    params.require(:report).permit(:status)
  end
        
end
