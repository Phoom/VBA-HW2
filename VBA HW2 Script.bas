Attribute VB_Name = "Module1"
' Steven Pham
' Hw#2 VBA

Sub volumeCalc()

' Declaring variables for ticker name, volume, summary table row
Dim tickerName As String
Dim volume As Double
Dim totalRow As Integer

' Declaring variable for last data row for each worksheet
Dim lastTickerRow As Long

' Declaring variable for worksheet
Dim ws As Excel.Worksheet

' Starting For loop to go through each worksheet
For Each ws In ActiveWorkbook.Worksheets

    ' Hours later, found out that this was needed in the loop or nothing worked
    ws.Activate
    
    ' Find and set the value for last row
    lastTickerRow = Cells(Rows.Count, 1).End(xlUp).Row

    ' Initalize volume
    volume = 0
    
    ' Starting summary table at Column G with row 2
    totalRow = 2
    
    
    ' Starting For Loop for all Tickers
    For I = 2 To lastTickerRow
    
        ' If ticker does not match the next ticker cell
        If Cells(I + 1, 1).Value <> Cells(I, 1).Value Then
            
            ' Grabbing ticker name
            tickerName = Cells(I, 1).Value
            
            ' Grabbing final volume (adding running volume to this final match)
            volume = volume + Cells(I, 7)
            
            ' Tossing the final ticker name and final volume to summary table
            Range("I" & totalRow).Value = tickerName
            Range("J" & totalRow).Value = volume
            
            ' Resetting volume
            volume = 0
    
            ' Pushing summary row to +1 for next entry
            totalRow = totalRow + 1
            
        ' If ticker does match the next ticker cell
        Else
            ' Add on the volume to the next volume
            volume = volume + Cells(I, 7).Value
           
        End If
    
    Next I

' Finished creating summary, now polishing final results
    
    ' Adding header titles
    Range("I1") = "Ticker Name"
    Range("J1") = "Total Volume"
    
    ' Titles set to bold
    Range("I1").Font.Bold = True
    Range("J1").Font.Bold = True
    
    ' Set both header to center
    Range("I1").HorizontalAlignment = xlCenter
    Range("J1").HorizontalAlignment = xlCenter
    
    ' Autofit and adding currency formatting
    Range("J:J").NumberFormat = "_($* #,##0_);_($* (#,##0);_($* ""-""??_);_(@_)"
    Range("I:J").EntireColumn.AutoFit


Next ws

MsgBox ("Done.")

End Sub
