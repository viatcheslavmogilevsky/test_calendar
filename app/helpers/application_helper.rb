module ApplicationHelper

 def scatter(args)
   current_year,current_month,current_day = nil,nil,nil
   event_count = 1
   global_res = ''
   args.reverse_each do |arg|
     if current_year != arg.year or current_month != arg.month
       global_res << finish_month(current_year,current_month,current_day,event_count)
       global_res << start_month(arg)
       current_year,current_month,current_day = arg.year, arg.month, arg.day
       event_count = 1
     elsif current_day != arg.day
       global_res << finish_month_to(arg.day, current_year, current_month, current_day, event_count)
       current_day = arg.day
       event_count = 1
     else
       event_count += 1
     end
   end
   global_res << finish_month(current_year,current_month,current_day,event_count)
 end

 def inspect_date(date,repeat)
   case repeat
   when 0
     date.inspect
   when 1
     date.strftime("%B, %d")
   when 2
     date.strftime("every %d day of the month")
   when 3
     date.strftime("%A")+'s'
   else
     "every day"
   end
 end

 private

 def class_def
   {
     :table_class => "ui-datepicker-calendar",
     :week_end => "ui-datepicker-week-end",
     :om_day => "ui-datepicker-other-month",
     :simple_day => "ui-state-default",
     :selected_day => 'ui-state-active',
     :div_class => "ui-datepicker"
   }
 end

 def finish_month_to(day, year, month,start_day,count)
   date = Date.new(year,month,start_day)
   res = show_current_day(date,count)
   date= date.next_day
   while date.day != day
     res << %(<tr>) if date.monday?
     res << %(<td class ="#{class_def[:simple_day]}">#{date.day}</td>)
     res << %(</tr>) if date.sunday?
     date = date.next_day
   end
   res
 end

 def show_prev_month(date)
   date = date.prev_month.end_of_month
   return "" if date.sunday?
   day = date.monday.day
   res = %(<tr>)
   date.cwday.times do |i|
     res << %(<td class="#{class_def[:om_day]}">#{day+i}</td>)
   end
   res
 end

 def show_current_month_to(date)
   res = ''
   day = date.day
   date = date.beginning_of_month
   until day == date.day
     res << %(<tr>) if date.monday?
     res << %(<td class="#{class_def[:simple_day]}">#{date.day}</td>)
     res << %(</tr>) if date.sunday?
     date = date.next_day
   end
   res
 end

 def start_month(date)
   res = show_month_head("#{Date::MONTHNAMES[date.month]}-#{date.year}")
   res << show_prev_month(date)
   res << show_current_month_to(date)
 end

 def finish_month(year, month, day, count)
   return "" unless year
   date = Date.new(year,month,day)
   res = show_current_day(date,count)
   res << show_current_month(date)
   res << show_next_month(date)
   res << %(</tbody></table></div>)
 end

 def show_current_day(day,count)
   res = ''
   res << %(<tr>) if day.monday?
   res <<  %(<td class ="#{class_def[:selected_day]}" id="#{day.day}_#{day.month}_#{day.year}">)
   res << link_to(%[#{day.day}],events_for_user_path(@user, day.year,day.month,day.day), :title => pluralize(count,"event"), :remote => true)
   res << %(</td>)
   res << %(</tr>) if day.sunday?
   res
 end

 def show_current_month(date)
   res = ''
   month = date.month
   date = date.next_day
   while month == date.month
     res << %(<tr>) if date.monday?
     res << %(<td class="#{class_def[:simple_day]}">#{date.day}</td>)
     res << %(</td>) if date.sunday?
     date = date.next_day
   end
   res
 end

 def show_next_month(date)
   date = date.next_month.beginning_of_month
   return "" if date.monday?
   res = ''
   (8-date.cwday).times do |i|
     res << %(<td class ="#{class_def[:om_day]}">#{i+1}</td>)
   end
   res << %(</tr>)
 end

 def show_month_head(name)
   res = %(<h3><a class="month_link">#{name}</a></h3>)
   res << %(<div id="#{name}" class="#{class_def[:div_class]}"><table class="#{class_def[:table_class]}"><thead><tr><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th><th>Sun</th></tr></thead><tbody>)
 end
end
