Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A327321A7D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBVOlS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 09:41:18 -0500
Received: from mail-m2835.qiye.163.com ([103.74.28.35]:51612 "EHLO
        mail-m2835.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBVOlR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Feb 2021 09:41:17 -0500
Received: from SurfaceGo (unknown [223.104.213.44])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id 94AF17800EF
        for <linux-nfs@vger.kernel.org>; Mon, 22 Feb 2021 22:40:00 +0800 (CST)
From:   "david.li" <david.li@ucloud.cn>
To:     <linux-nfs@vger.kernel.org>
Subject: SUNRPC BUG: discarded reply data wrongly
Date:   Mon, 22 Feb 2021 22:40:00 +0800
Message-ID: <014d01d70928$99a61820$ccf24860$@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdcJKJi7H4KCeLvaQO6YBaGjsGm7lg==
Content-Language: en-us
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZQxgaSB0dTkJOHk9NVkpNSk9LS09DS0tDT05VGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6HAw*HT0*NT8DNxQKEjNP
        DzIaChFVSlVKTUpPS0tPQ0tLQkNNVTMWGhIXVR8aDRIfVRcSOw4YFxQOH1UYFUVZV1kSC1lBWUlJ
        SFVKS09VSUpIVU9PWVdZCAFZQU1MSUI3Bg++
X-HM-Tid: 0a77ca2ecc9e841dkuqw94af17800ef
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'm having an issue where the nfsv4 client discarded wrong reply data. Below
are rpcdebug messages.

Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_data_ready...
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv started
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       reading TCP record fragment
of length 33076
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       reading XID (4 bytes)
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       reading reply for XID
a647852d
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       reading CALL/REPLY flag (4
bytes)
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       read reply XID a647852d
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       XID a647852d read 13988 bytes
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xprt = 000000004e3a630c,
tcp_copied = 13996, tcp_offset = 13996, tcp_reclen = 33076
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv done
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_data_ready...
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_data_ready...
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv started
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       read reply XID a647852d
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       XID a647852d truncated
request
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xprt = 000000004e3a630c,
tcp_copied = 13996, tcp_offset = 13996, tcp_reclen = 33076 Feb 22 18:00:38
10-13-143-1 kernel: RPC: 28500 xid a647852d complete (13996 bytes received)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 __rpc_wake_up_task (now
5529697130)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 disabling timer Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28500 removed from queue 000000002db00ddc
"xprt_pending"
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       __rpc_wake_up_task done
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 sync task resuming
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       discarded 152 bytes
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 call_status (status 13996)
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv done
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 call_decode (status 13996)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 validating UNIX cred
000000008f67d2bf Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 using
AUTH_UNIX cred 000000008f67d2bf to unwrap rpc data Feb 22 18:00:38
10-13-143-1 kernel: RPC: 28500 call_decode result 13936 Feb 22 18:00:38
10-13-143-1 kernel: RPC:
wake_up_first(000000008fc2e8d6 "NFSv4.0 transport Slot table") Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28500 return 0, status 13936 Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28500 release task
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       freeing buffer of size 2880
at 000000008c1be110
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 release request
0000000072cd9863
Feb 22 18:00:38 10-13-143-1 kernel: RPC:
wake_up_first(0000000089f3219a "xprt_backlog") Feb 22 18:00:38 10-13-143-1
kernel: RPC:
rpc_release_client(00000000530ceeb2)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28500 freeing task
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       new task initialized, procpid
3552
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       allocated task
000000002fddcc21
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 __rpc_execute flags=0x4080
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 call_start nfs4 proc READDIR
(sync)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 call_reserve (status 0) Feb
22 18:00:38 10-13-143-1 kernel: RPC:
wake_up_first(00000000e5d6f8f3 "xprt_sending") Feb 22 18:00:38 10-13-143-1
kernel: RPC: 28501 reserved req 0000000072cd9863 xid a747852d Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28501 call_reserveresult (status 0) Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28501 call_refresh (status 0) Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28501 refreshing UNIX cred
000000008f67d2bf Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
call_refreshresult (status 0) Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
call_allocate (status 0) Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
allocated buffer of size 2880 at 000000008c1be110 Feb 22 18:00:38
10-13-143-1 kernel: RPC: 28501 call_bind (status 0) Feb 22 18:00:38
10-13-143-1 kernel: RPC: 28501 call_connect xprt 000000004e3a630c is
connected Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 call_transmit
(status 0) Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
xprt_prepare_transmit Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
rpc_xdr_encode (status 0) Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501
marshaling UNIX cred 000000008f67d2bf Feb 22 18:00:38 10-13-143-1 kernel:
RPC: 28501 using AUTH_UNIX cred 000000008f67d2bf to wrap rpc data Feb 22
18:00:38 10-13-143-1 kernel: RPC: 28501 xprt_transmit(268)
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_send_request(268) = 0
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 xmit complete Feb 22 18:00:38
10-13-143-1 kernel: RPC: 28501 sleep_on(queue "xprt_pending"
time 5529697178)
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 added to queue
000000002db00ddc "xprt_pending"
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 setting alarm for 60000 ms
Feb 22 18:00:38 10-13-143-1 kernel: RPC:
wake_up_first(00000000e5d6f8f3 "xprt_sending")
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_data_ready...
Feb 22 18:00:38 10-13-143-1 kernel: RPC: 28501 sync task going to sleep
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_data_ready...
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv started
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       discarded 16384 bytes
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv done
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       xs_tcp_data_recv started
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       discarded 2544 bytes
Feb 22 18:00:38 10-13-143-1 kernel: RPC:       invalid TCP record fragment
length

Why nfsv4 client still discarded reply data for second response?

The kernel is 4.19.x

