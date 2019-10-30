Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A022E9666
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2019 07:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3GbB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Oct 2019 02:31:01 -0400
Received: from mails2n0-route0.email.arizona.edu ([128.196.130.122]:42748 "EHLO
        mails2n0-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbfJ3GbB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Oct 2019 02:31:01 -0400
IronPort-SDR: Z+uIwnerkMEpFHSwT24ySS6dB23Rdyt+YWdJnks/obMyaulZmusQdC/N6X5fSacO2fNekVquCD
 OC73xb9rtENA==
IronPort-PHdr: =?us-ascii?q?9a23=3AYv0sPRM+9uia5CItX98l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0Lfr6rarrMEGX3/hxlliBBdydt6sfzbOO6euxByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oRnPusUZhYZvK7s6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyoBKjU38nzYitZogaxGrhKvuRxxzY3abo6aNvVxYqzTcMgGRW?=
 =?us-ascii?q?dDRMtdSzBNDp++YoYJEuEPPfxYr474p1YWsxa+BROjBOXyxT9MmHD2x7Ax3u?=
 =?us-ascii?q?M7Hg7b2QwgHtQOvW/brNrrMqcSVuW1w7fSwTrZdfNW2Db86I/Och87u/2DQ6?=
 =?us-ascii?q?9/cdfIxEQpCgjLjU2QpJT4Mz+JzOgBrmaW4ul6We+uj2MrsQB8rzypy8wxkI?=
 =?us-ascii?q?fGnJgVxUrB9ShhxYY1IsC3R1BjbN6/FZtQqzmaN4xrQsM+W21ouDg1yrkBuZ?=
 =?us-ascii?q?OjeCcG1YgrywTCZ/GJcIWE+BPuWeKLLTp5gH9qfqqzhxe08Ue+1u3xTtS43E?=
 =?us-ascii?q?pQoiZYnNTBtWoB2h3X58SdS/Zw+l+t2TOV2ADS7uFEL1o0la3eK5M52LE/i5?=
 =?us-ascii?q?8TsUXFHiLtl0X5kqmWdkIh+ue28ejoeK/mpp6dNo9zjAHxKL4ildKiDuQlKg?=
 =?us-ascii?q?QORXSU+fyg1L3/+k30WLFKjvwwkqnEv5HWPMIbpqCiAwJOzIYj5AiwDy283N?=
 =?us-ascii?q?Qbg3YHNlRFdwyDj4TzPFHOOv/4Xr+DhAHmlDZt2uCDOLP6KovCI2KFk7r7e7?=
 =?us-ascii?q?t5rUlGx0B7mdRe4Y9ET7cPO9rtVULr8t/VFBk0N0qz2emxW/tn0YZLcmKGBK?=
 =?us-ascii?q?OdPbma5VaE4+MpC+aBYogQtXD0Mfk34Pjny3I1hAlOLuGSwZILZSXgTbxdKE?=
 =?us-ascii?q?KDbC+0jw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BHEQDrLLld/0VFigoNVxsBAQEBOAE?=
 =?us-ascii?q?BAwMBAQECAQEFAQEBgVUCAYhiqjaBewEIAQEBDi8BAYRAAoQCNQgOAgMJAQE?=
 =?us-ascii?q?BBAEBAQEBBQICAYVXTU0BEAGBZyKCdQIBAyMEEVELGgImAgJXBjGDBIJTsk9?=
 =?us-ascii?q?1fzOFToMEHwmBVYEOKAGMKHiBB4E4gms+h1WCXgSBOYhijB9Elm4fgg+BGAV?=
 =?us-ascii?q?fky0GG4I8ggOKBYsajj+ZdYFUA4IMTSUTgVmBT08kkWyKHIUkAQE?=
X-IPAS-Result: =?us-ascii?q?A2BHEQDrLLld/0VFigoNVxsBAQEBOAEBAwMBAQECAQEFA?=
 =?us-ascii?q?QEBgVUCAYhiqjaBewEIAQEBDi8BAYRAAoQCNQgOAgMJAQEBBAEBAQEBBQICA?=
 =?us-ascii?q?YVXTU0BEAGBZyKCdQIBAyMEEVELGgImAgJXBjGDBIJTsk91fzOFToMEHwmBV?=
 =?us-ascii?q?YEOKAGMKHiBB4E4gms+h1WCXgSBOYhijB9Elm4fgg+BGAVfky0GG4I8ggOKB?=
 =?us-ascii?q?Ysajj+ZdYFUA4IMTSUTgVmBT08kkWyKHIUkAQE?=
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="429313011"
Received: from on-campus-10-138-69-69.vpn.arizona.edu (HELO [10.138.69.69]) ([10.138.69.69])
  by mails2n0out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 23:30:59 -0700
Subject: Re: NFS hangs on one interface
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org>
 <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
 <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Chandler <admin@genome.arizona.edu>
Message-ID: <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu>
Date:   Tue, 29 Oct 2019 23:30:59 -0700
MIME-Version: 1.0
In-Reply-To: <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Does this tcpdump help at all?  I ran:
tcpdump -i eth2 -s 0 -w out.pcap host x.4 and x.2

Then I tried "mount -v x.2:/data /data" in another term, waited until after the timeout then ^C then killed the tcpdump


   1   0.000000 x.4 -> x.2 TCP 66 739 > nfs [ACK] Seq=1 Ack=1 Win=140 Len=0 TSval=2837501537 TSecr=1577364421
   2   0.000034 x.4 -> x.2 NFS 206 [TCP Previous segment not captured] V3 READ Call, FH:0x48bf584a Offset:0 Len:131072
   3   0.000127 x.2 -> x.4 TCP 60 nfs > 739 [RST] Seq=1 Win=0 Len=0
   4   0.000148 x.2 -> x.4 TCP 60 nfs > 739 [RST] Seq=1 Win=0 Len=0
   5   3.000003 x.4 -> x.2 TCP 74 [TCP Port numbers reused] 739 > nfs [SYN] Seq=0 Win=17920 Len=0 MSS=8960 SACK_PERM=1 TSval=2837504537 TSecr=0 WS=128
   6   3.000182 x.2 -> x.4 TCP 74 nfs > 739 [SYN, ACK] Seq=0 Ack=1 Win=17896 Len=0 MSS=8960 SACK_PERM=1 TSval=1578327421 TSecr=2837504537 WS=128
   7   3.000205 x.4 -> x.2 TCP 66 739 > nfs [ACK] Seq=1 Ack=1 Win=17920 Len=0 TSval=2837504537 TSecr=1578327421
   8   3.000228 x.4 -> x.2 NFS 206 V3 READ Call, FH:0x48bf584a Offset:0 Len:131072
   9   3.000261 x.2 -> x.4 TCP 66 nfs > 739 [ACK] Seq=1 Ack=141 Win=19072 Len=0 TSval=1578327421 TSecr=2837504537
  10   4.100351 x.4 -> x.2 NFS 194 V4 Call PUTROOTFH | GETATTR
  11   4.139630 x.2 -> x.4 TCP 66 nfs > 798 [ACK] Seq=4113 Ack=129 Win=157 Len=0 TSval=1578328561 TSecr=2837505637
  12  44.294611 x.2 -> x.4 TCP 66 netconfsoaphttp > nfs [ACK] Seq=1 Ack=1 Win=140 Len=0 TSval=1578368716 TSecr=2837365831
  13  44.294628 x.4 -> x.2 TCP 66 [TCP ACKed unseen segment] nfs > netconfsoaphttp [ACK] Seq=3969 Ack=2 Win=149 Len=0 TSval=2837545831 TSecr=1578188716
  14  44.294634 x.2 -> x.4 TCP 66 [TCP Previous segment not captured] netconfsoaphttp > nfs [FIN, ACK] Seq=2 Ack=1 Win=140 Len=0 TSval=1578368716 TSecr=2837365831
  15  44.294688 x.4 -> x.2 TCP 66 [TCP ACKed unseen segment] nfs > netconfsoaphttp [FIN, ACK] Seq=3969 Ack=3 Win=149 Len=0 TSval=2837545831 TSecr=1578368716
  16  44.294734 x.2 -> x.4 TCP 60 netconfsoaphttp > nfs [RST] Seq=3 Win=0 Len=0
  17  47.294699 x.2 -> x.4 TCP 74 [TCP Port numbers reused] netconfsoaphttp > nfs [SYN] Seq=0 Win=17920 Len=0 MSS=8960 SACK_PERM=1 TSval=1578371716 TSecr=0 WS=128
  18  47.294723 x.4 -> x.2 TCP 74 nfs > netconfsoaphttp [SYN, ACK] Seq=0 Ack=1 Win=17896 Len=0 MSS=8960 SACK_PERM=1 TSval=2837548831 TSecr=1578371716 WS=128
  19  47.294770 x.2 -> x.4 TCP 66 netconfsoaphttp > nfs [ACK] Seq=1 Ack=1 Win=17920 Len=0 TSval=1578371716 TSecr=2837548831
  20  47.294794 x.2 -> x.4 NFS 270 V4 Call READDIR FH:0xcb5e6e28
  21  47.294802 x.4 -> x.2 TCP 66 nfs > netconfsoaphttp [ACK] Seq=1 Ack=205 Win=19072 Len=0 TSval=2837548831 TSecr=1578371716
  22  47.294975 x.4 -> x.2 NFS 4034 V4 Reply (Call In 20) READDIR
  23  47.495918 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  24  47.897918 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  25  48.701955 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  26  50.309927 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  27  53.525953 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  28  59.957895 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  29  62.999962 x.4 -> x.2 TCP 66 [TCP Keep-Alive] 739 > nfs [ACK] Seq=140 Ack=1 Win=17920 Len=0 TSval=2837564537 TSecr=1578327421
  30  63.000082 x.2 -> x.4 TCP 66 [TCP Previous segment not captured] nfs > 739 [ACK] Seq=17897 Ack=141 Win=19072 Len=0 TSval=1578387421 TSecr=2837504537
  31  64.099972 x.4 -> x.2 TCP 66 798 > nfs [FIN, ACK] Seq=129 Ack=1 Win=140 Len=0 TSval=2837565637 TSecr=1578304804
  32  64.100147 x.2 -> x.4 NFS 326 V4 Reply (Call In 10) PUTROOTFH | GETATTR
  33  64.100174 x.4 -> x.2 TCP 54 798 > nfs [RST] Seq=130 Win=0 Len=0
  34  67.099990 x.4 -> x.2 TCP 74 [TCP Port numbers reused] 798 > nfs [SYN] Seq=0 Win=17920 Len=0 MSS=8960 SACK_PERM=1 TSval=2837568637 TSecr=0 WS=128
  35  67.100135 x.2 -> x.4 TCP 74 nfs > 798 [SYN, ACK] Seq=0 Ack=1 Win=17896 Len=0 MSS=8960 SACK_PERM=1 TSval=1578391521 TSecr=2837568637 WS=128
  36  67.100158 x.4 -> x.2 TCP 66 798 > nfs [ACK] Seq=1 Ack=1 Win=17920 Len=0 TSval=2837568637 TSecr=1578391521
  37  67.100181 x.4 -> x.2 NFS 238 V4 Call READDIR FH:0x0366982c
  38  67.100222 x.2 -> x.4 TCP 66 nfs > 798 [ACK] Seq=1 Ack=173 Win=19072 Len=0 TSval=1578391521 TSecr=2837568637
  39  67.100241 x.4 -> x.2 NFS 194 V4 Call PUTROOTFH | GETATTR
  40  67.100285 x.2 -> x.4 TCP 66 nfs > 798 [ACK] Seq=1 Ack=301 Win=20096 Len=0 TSval=1578391521 TSecr=2837568637
  41  67.100332 x.2 -> x.4 NFS 326 V4 Reply (Call In 39) PUTROOTFH | GETATTR
  42  67.100339 x.4 -> x.2 TCP 66 798 > nfs [ACK] Seq=301 Ack=261 Win=19072 Len=0 TSval=2837568637 TSecr=1578391521
  43  67.111864 x.4 -> x.2 NFS 198 V4 Call GETATTR FH:0x62d40c52
  44  67.111991 x.2 -> x.4 NFS 158 [TCP Previous segment not captured] V4 Reply (Call In 43) GETATTR
  45  67.112010 x.4 -> x.2 TCP 78 [TCP Dup ACK 43#1] 798 > nfs [ACK] Seq=433 Ack=261 Win=19072 Len=0 TSval=2837568649 TSecr=1578391521 SLE=4373 SRE=4465
  46  72.821950 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  47  98.549965 x.4 -> x.2 NFS 4034 [RPC duplicate of #22][TCP Retransmission] V4 Reply (Call In 20) READDIR
  48 107.294623 x.2 -> x.4 TCP 66 [TCP Keep-Alive] netconfsoaphttp > nfs [ACK] Seq=204 Ack=1 Win=17920 Len=0 TSval=1578431716 TSecr=2837548831
  49 107.294642 x.4 -> x.2 TCP 66 [TCP Keep-Alive ACK] nfs > netconfsoaphttp [ACK] Seq=3969 Ack=205 Win=19072 Len=0 TSval=2837608831 TSecr=1578371716
  50 122.999956 x.4 -> x.2 TCP 66 [TCP Keep-Alive] 739 > nfs [ACK] Seq=140 Ack=1 Win=17920 Len=0 TSval=2837624537 TSecr=1578327421
  51 123.000088 x.2 -> x.4 TCP 66 [TCP Keep-Alive ACK] nfs > 739 [ACK] Seq=17897 Ack=141 Win=19072 Len=0 TSval=1578447421 TSecr=2837504537
  52 123.354599 Solarfla_y -> Solarfla_z ARP 60 Who has x.4?  Tell x.2
  53 123.354613 Solarfla_z -> Solarfla_y ARP 42 x.4 is at 00:0f:53:z
  54 127.110922 x.4 -> x.2 TCP 78 798 > nfs [FIN, ACK] Seq=433 Ack=261 Win=19072 Len=0 TSval=2837628648 TSecr=1578391521 SLE=4373 SRE=4465
  55 127.111041 x.2 -> x.4 TCP 66 nfs > 798 [FIN, ACK] Seq=4465 Ack=434 Win=21120 Len=0 TSval=1578451532 TSecr=2837628648
  56 127.111068 x.4 -> x.2 TCP 54 798 > nfs [RST] Seq=434 Win=0 Len=0
  57 130.110999 x.4 -> x.2 TCP 74 [TCP Port numbers reused] 798 > nfs [SYN] Seq=0 Win=17920 Len=0 MSS=8960 SACK_PERM=1 TSval=2837631648 TSecr=0 WS=128
  58 130.111106 x.2 -> x.4 TCP 74 nfs > 798 [SYN, ACK] Seq=0 Ack=1 Win=17896 Len=0 MSS=8960 SACK_PERM=1 TSval=1578454532 TSecr=2837631648 WS=128
  59 130.111133 x.4 -> x.2 TCP 66 798 > nfs [ACK] Seq=1 Ack=1 Win=17920 Len=0 TSval=2837631648 TSecr=1578454532
  60 130.111146 x.4 -> x.2 NFS 238 V4 Call READDIR FH:0x0366982c
  61 130.111162 x.4 -> x.2 NFS 198 V4 Call GETATTR FH:0x62d40c52
  62 130.111198 x.2 -> x.4 TCP 66 nfs > 798 [ACK] Seq=1 Ack=173 Win=19072 Len=0 TSval=1578454532 TSecr=2837631648
  63 130.111208 x.2 -> x.4 TCP 66 nfs > 798 [ACK] Seq=1 Ack=305 Win=20096 Len=0 TSval=1578454532 TSecr=2837631648
  64 130.111290 x.2 -> x.4 NFS 158 V4 Reply (Call In 61) GETATTR
  65 130.111296 x.4 -> x.2 TCP 66 798 > nfs [ACK] Seq=305 Ack=93 Win=17920 Len=0 TSval=2837631648 TSecr=1578454532
  66 130.111367 x.4 -> x.2 NFS 202 V4 Call GETATTR FH:0x62d40c52
  67 130.111430 x.2 -> x.4 NFS 178 V4 Reply (Call In 66) GETATTR
  68 130.111463 x.4 -> x.2 NFS 198 V4 Call GETATTR FH:0x62d40c52
  69 130.111513 x.2 -> x.4 NFS 158 [TCP Previous segment not captured] V4 Reply (Call In 68) GETATTR
  70 130.111521 x.4 -> x.2 TCP 78 [TCP Dup ACK 68#1] 798 > nfs [ACK] Seq=573 Ack=205 Win=17920 Len=0 TSval=2837631648 TSecr=1578454532 SLE=4317 SRE=4409
