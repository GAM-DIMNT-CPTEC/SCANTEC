V26 m_mpout
11 m_mpout.F90 S582 0
10/01/2013  17:36:06
use m_stdio private
use m_stdio private
enduse
D 56 18 19
D 58 18 13
D 60 18 32
S 582 24 0 0 0 6 1 0 4658 10015 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 m_mpout
S 584 23 0 0 0 8 590 582 4674 14 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 stdout
S 585 23 0 0 0 6 592 582 4681 14 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 len_filename
S 586 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 590 16 2 m_stdio stdout
R 592 16 4 m_stdio len_filename
S 593 6 4 0 0 6 1 582 4707 80002c 0 A 0 0 0 0 0 0 0 0 0 0 0 0 629 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 mpout
S 594 19 0 0 0 6 1 582 4713 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 1 0 0 0 0 0 582 0 0 0 0 mpout_open
O 594 1 602
S 595 19 0 0 0 6 1 582 4724 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6 1 0 0 0 0 0 582 0 0 0 0 mpout_close
O 595 1 603
S 596 19 0 0 0 6 1 582 4736 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 1 0 0 0 0 0 582 0 0 0 0 mpout_sync
O 596 1 604
S 597 19 0 0 0 6 1 582 4747 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 1 0 0 0 0 0 582 0 0 0 0 mpout_flush
O 597 1 605
S 598 19 0 0 0 6 1 582 4759 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12 1 0 0 0 0 0 582 0 0 0 0 mpout_ison
O 598 1 606
S 599 19 0 0 0 6 1 582 4770 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 4 0 0 0 0 0 582 0 0 0 0 mpout_log
O 599 4 610 609 608 607
S 600 16 0 0 0 6 1 582 4780 4 400000 A 0 0 0 0 0 0 0 0 2147483647 34 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 mpout_mask
S 601 19 0 0 0 6 1 582 4791 4000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 22 1 0 0 0 0 0 582 0 0 0 0 mpout_setflush
O 601 1 611
S 602 27 0 0 0 8 632 582 4806 10010 400000 A 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 open_
Q 602 594 0
S 603 27 0 0 0 8 637 582 4812 10010 400000 A 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 close_
Q 603 595 0
S 604 27 0 0 0 8 639 582 4819 10010 400000 A 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 sync_
Q 604 596 0
S 605 27 0 0 0 8 642 582 4825 10010 400000 A 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 flush_
Q 605 597 0
S 606 27 0 0 0 6 644 582 4832 10010 400000 A 0 0 0 0 0 0 27 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 ison_
Q 606 598 0
S 607 27 0 0 0 6 653 582 4838 10010 400000 A 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 logi_
Q 607 599 0
S 608 27 0 0 0 6 667 582 4844 10010 400000 A 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 logr_
Q 608 599 0
S 609 27 0 0 0 6 660 582 4850 10010 400000 A 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 logd_
Q 609 599 0
S 610 27 0 0 0 6 647 582 4856 10010 400000 A 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 log_
Q 610 599 0
S 611 27 0 0 0 8 676 582 4861 10010 400000 A 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 setflush_
Q 611 601 0
S 612 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 613 3 0 0 0 56 0 1 0 0 0 A 0 0 0 0 0 0 0 0 4871 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 6d 5f 6d 70 6f 75 74
S 614 16 0 0 0 56 1 582 4879 14 440000 A 0 0 0 0 0 0 0 0 613 20 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 myname
S 615 3 0 0 0 58 0 1 0 0 0 A 0 0 0 0 0 0 0 0 4886 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 5 6d 70 6f 75 74
S 616 16 1 0 0 58 1 582 4892 14 440000 A 0 0 0 0 0 0 0 0 615 22 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 def_pfix
S 617 6 4 0 0 6 619 582 4901 80003c 0 A 0 0 0 0 0 0 0 0 0 0 0 0 630 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 isync
S 619 6 4 0 0 16 621 582 4907 80003c 0 A 0 0 0 0 0 4 0 0 0 0 0 0 630 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 mpout_on
S 621 6 4 0 0 16 622 582 4916 80003c 0 A 0 0 0 0 0 8 0 0 0 0 0 0 630 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 mpout_initialized
S 622 6 4 0 0 16 627 582 4934 80003c 0 A 0 0 0 0 0 12 0 0 0 0 0 0 630 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 mpout_opened
S 624 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 0 0 0 0 0 124 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 625 6 4 0 0 60 1 582 4947 80003c 0 A 0 0 0 0 0 0 0 0 0 0 0 0 631 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 upfix
S 626 3 0 0 0 6 0 1 0 0 0 A 0 0 0 0 0 0 0 0 0 2147483647 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 627 6 4 0 0 16 1 582 4953 80003c 0 A 0 0 0 0 0 16 0 0 0 0 0 0 630 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 default_flush
S 629 11 0 0 0 8 1 582 5092 40800000 801000 A 0 0 0 0 0 4 0 0 593 593 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _m_mpout$8
S 630 11 0 0 0 8 629 582 5103 40800010 801000 A 0 0 0 0 0 20 0 0 617 627 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _m_mpout$12
S 631 11 0 0 0 8 630 582 5115 40800010 801000 A 0 0 0 0 0 124 0 0 625 625 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _m_mpout$13
S 632 23 5 0 0 0 636 582 4806 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 open_
S 633 1 3 1 0 6 1 632 3934 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 mask
S 634 1 3 1 0 28 1 632 5127 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pfix
S 635 1 3 1 0 16 1 632 5132 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 append
S 636 14 5 0 0 0 1 632 4806 10 400000 A 0 0 0 0 0 0 0 2 3 0 0 0 0 0 0 0 0 0 0 0 0 127 0 582 0 0 0 0 open_
F 636 3 633 634 635
S 637 23 5 0 0 0 638 582 4812 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 close_
S 638 14 5 0 0 0 1 637 4812 10 400000 A 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 283 0 582 0 0 0 0 close_
F 638 0
S 639 23 5 0 0 0 641 582 4819 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 sync_
S 640 1 3 1 0 28 1 639 5139 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 tag
S 641 14 5 0 0 0 1 639 4819 10 400000 A 0 0 0 0 0 0 0 7 1 0 0 0 0 0 0 0 0 0 0 0 0 332 0 582 0 0 0 0 sync_
F 641 1 640
S 642 23 5 0 0 0 643 582 4825 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush_
S 643 14 5 0 0 0 1 642 4825 10 400000 A 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 374 0 582 0 0 0 0 flush_
F 643 0
S 644 23 5 0 0 6 645 582 4832 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ison_
S 645 14 5 0 0 16 1 644 4832 14 400000 A 0 0 0 0 0 0 0 10 0 0 0 646 0 0 0 0 0 0 0 0 0 401 0 582 0 0 0 0 ison_
F 645 0
S 646 1 3 0 0 16 1 644 4832 14 1003000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ison_
S 647 23 5 0 0 0 652 582 4856 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 log_
S 648 1 3 1 0 28 1 647 5143 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 where
S 649 1 3 1 0 28 1 647 5149 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 message
S 650 1 3 1 0 16 1 647 5157 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 showrank
S 651 1 3 1 0 16 1 647 5166 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 652 14 5 0 0 0 1 647 4856 10 400000 A 0 0 0 0 0 0 0 11 4 0 0 0 0 0 0 0 0 0 0 0 0 427 0 582 0 0 0 0 log_
F 652 4 648 649 650 651
S 653 23 5 0 0 0 659 582 4838 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logi_
S 654 1 3 1 0 28 1 653 5143 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 where
S 655 1 3 1 0 28 1 653 5149 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 message
S 656 1 3 1 0 6 1 653 5172 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 num
S 657 1 3 1 0 16 1 653 5157 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 showrank
S 658 1 3 1 0 16 1 653 5166 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 659 14 5 0 0 0 1 653 4838 10 400000 A 0 0 0 0 0 0 0 16 5 0 0 0 0 0 0 0 0 0 0 0 0 486 0 582 0 0 0 0 logi_
F 659 5 654 655 656 657 658
S 660 23 5 0 0 0 666 582 4850 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logd_
S 661 1 3 1 0 28 1 660 5143 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 where
S 662 1 3 1 0 28 1 660 5149 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 message
S 663 1 3 1 0 9 1 660 5176 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 val
S 664 1 3 1 0 16 1 660 5157 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 showrank
S 665 1 3 1 0 16 1 660 5166 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 666 14 5 0 0 0 1 660 4850 10 400000 A 0 0 0 0 0 0 0 22 5 0 0 0 0 0 0 0 0 0 0 0 0 551 0 582 0 0 0 0 logd_
F 666 5 661 662 663 664 665
S 667 23 5 0 0 0 673 582 4844 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logr_
S 668 1 3 1 0 28 1 667 5143 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 where
S 669 1 3 1 0 28 1 667 5149 14 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 message
S 670 1 3 1 0 8 1 667 5176 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 val
S 671 1 3 1 0 16 1 667 5157 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 showrank
S 672 1 3 1 0 16 1 667 5166 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 673 14 5 0 0 0 1 667 4844 10 400000 A 0 0 0 0 0 0 0 28 5 0 0 0 0 0 0 0 0 0 0 0 0 612 0 582 0 0 0 0 logr_
F 673 5 668 669 670 671 672
S 674 23 5 0 0 0 675 582 5180 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 initialize_
S 675 14 5 0 0 0 1 674 5180 10 400000 A 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 673 0 582 0 0 0 0 initialize_
F 675 0
S 676 23 5 0 0 0 678 582 4861 10 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 setflush_
S 677 1 3 1 0 16 1 676 5166 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 678 14 5 0 0 0 1 676 4861 10 400000 A 0 0 0 0 0 0 0 35 1 0 0 0 0 0 0 0 0 0 0 0 0 711 0 582 0 0 0 0 setflush_
F 678 1 677
A 13 2 0 0 0 6 586 0 0 0 13 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 612 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 56 613 0 0 0 20 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 58 615 0 0 0 22 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 624 0 0 0 32 0 0 0 0 0 0 0 0 0
A 34 2 0 0 0 6 626 0 0 0 34 0 0 0 0 0 0 0 0 0
Z
Z