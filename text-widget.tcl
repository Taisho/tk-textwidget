package require Tk 8

proc set_tags { } {
   global .textwidget

   .textwidget insert 0.0 "Here is some text text text"
   .textwidget tag add main 1.0 1.28
   .textwidget tag configure main -background red

   .textwidget tag add foo 1.5 1.10
   .textwidget tag configure foo -font {Times 16 {bold italic}}
}

## ------------------------------------------------
## This procedure parses text and creates tags
## according to the Lang specified for use by a text
## widget
## ------------------------------------------------
proc parseText { Text Lang } {
}

## ----------------------------------------------
## Program execution starts here
## ----------------------------------------------
menu .menubar -type menubar
.menubar add cascade -label File -menu .menubar.file -underline 0

#file menu
menu .menubar.file -tearoff 0
.menubar.file add command -label "New" -underline 0 \
    -command { new } 
.menubar.file add command -label "Open..." -underline 0 \
    -command {
        set fileid [open $filename r]
         # filename is set in file_save_as
        set data [read $fileid $filesize]
        close $fileid
        .text.t insert end $data
        wm title . $filename
    }

text .textwidget
set_tags
pack .menubar -expand 1 -fill both
pack .textwidget

proc save { } {
    set data [.text.t get 1.0 {end -1c}]
    set fileid [open $filename w]
    puts -nonewline $fileid $data
    close $fileid
}

proc file_save_as { } {
    global filename
    set data [.text.t get 1.0 {end -1c}]
    set file_types {
     {"Tcl Files" { .tcl .TCL .tk .TK} }
     {"Text Files" { .txt .TXT} }
     {"All Files" * }
    }

    set filename [tk_getSaveFile -filetypes $file_types\
        -initialdir pwd -initialfile $filename\
        -defaultextension .tcl]
    wm title . $filename
    set fileid [open $filename w]
    puts -nonewline $fileid $data
    close $fileid
}

tk appname "Edit"
