Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DE92968A0
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Oct 2020 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374824AbgJWDFO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Oct 2020 23:05:14 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:42391 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374823AbgJWDFO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Oct 2020 23:05:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 4CHTcT0l2mz8tNV
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 03:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1603422313;
        bh=1D+npy0FU7gWe2U6hn1uhTeAlkZwYmtAtU3rIJn3TDY=;
        h=From:To:Subject:Date:From;
        b=f8ohzoS9qktlvo5yu5lA/xlpQZSZGB+HNy+ceOpvTFZm7nl/4hK6aq/YjrxQ9FsEB
         rHZ4hwZJ7HZpjVQlkUKdw3ipWeRxeVikYC/bNchuKPfRFM+2o83OwK3uGxKqweEnJZ
         6oRD5szJUB/AGYEOdNiFsh8yVc5YbAVZbZ38LFv52PB7ixzmM6deiO0Pnq0Qh0SRHv
         eCm3IJ61QnL1z+m54DgGrPYJeWmiBt6lDhhCmrdYtBLba9Ki2tv1DBELxfOfxbYhsW
         qpJlr8m5wfJwaVJ47kfuvDo8AIeVZKVTDs8vaccNFunKbgcHzJhDzKXd4AXP8fM1MI
         HDPkWCeIEupiA==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5ctCee646nl8 for <linux-nfs@vger.kernel.org>;
        Fri, 23 Oct 2020 03:05:13 +0000 (UTC)
Received: from EXMBNJE5.ad.twosigma.com (exmbnje5.ad.twosigma.com [172.20.45.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 4CHTcT0CQ9z8sw9
        for <linux-nfs@vger.kernel.org>; Fri, 23 Oct 2020 03:05:13 +0000 (UTC)
Received: from EXMBNJE6.ad.twosigma.com (172.20.45.169) by
 EXMBNJE5.ad.twosigma.com (172.20.45.205) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 03:05:12 +0000
Received: from EXMBNJE6.ad.twosigma.com ([fe80::91c9:357f:d44f:ceaf]) by
 EXMBNJE6.ad.twosigma.com ([fe80::91c9:357f:d44f:ceaf%16]) with mapi id
 15.00.1497.000; Fri, 23 Oct 2020 03:05:12 +0000
From:   Chris Zimman <cwz@twosigma.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: NFS 4.0 bad RIP
Thread-Topic: NFS 4.0 bad RIP
Thread-Index: Adao6GpRsx7haGNUTCuxLYX0RU6ujw==
Date:   Fri, 23 Oct 2020 03:05:12 +0000
Message-ID: <7edefe848b44431abd43861e1a2345a2@EXMBNJE6.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.23.150.182]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi
=A0
We are seeing an issue that I haven't seen reported anywhere else yet.=A0 W=
e have some machines running 4.19.104 (w/ one additional patch, more on tha=
t in a moment) that after some period of time always seem to die with an NF=
S client related kernel RIP.=A0 The machines are mounting Kerberized NFS 4.=
0:
=A0
	e.g.

	(rw,noatime,vers=3D4.0,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregm=
ax=3D120,acdirmax=3D120,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dkrb5=
p,clientaddr=3D172.20.21.7,local_lock=3Dnone,addr=3D172.20.21.4)
=A0
For the avoidance of doubt (and although this would very much seem to be a =
client-side issue), the server side details are:

Running the same kernel release, the server is exporting a ZFS (0.8.4) volu=
me w/ sharenfs disabled (e.g. using knfsd).=A0 It's running the release of =
NFS utils included w/ Debian 9 and we run rpc.svcgssd (e.g. vs gssproxy) be=
cause we ran into issues w/ gssproxy and some users (see patch + notes belo=
w).
The NFS server itself never seems at all bothered, as it just keeps chuggin=
g along, irrespective of client hangs.  When the clients hang, they get reb=
ooted, and after they come back up, go happily on their way until the bug m=
anifests again.
=A0
The client machines seem to eventually (15-40 days avg) die with a trace th=
at typically looks like this:
=A0
[978587.033741] INFO: task ApplicationImpl:1123136 blocked for more than 12=
0 seconds.
[978587.033743]=A0=A0=A0=A0=A0=A0 Not tainted 4.19.104-mars #31
[978587.033743] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[978587.033744] ApplicationImpl D=A0=A0=A0 0 1123136 1122989 0x00000000
[978587.033746] Call Trace:
[978587.033752]=A0 __schedule+0x3f9/0x880
[978587.033755]=A0 ? __switch_to_asm+0x35/0x70
[978587.033756]=A0 ? __switch_to_asm+0x41/0x70
[978587.033758]=A0 ? bit_wait+0x60/0x60
[978587.033759]=A0 schedule+0x36/0x80
[978587.033760]=A0 io_schedule+0x16/0x40
[978587.033761]=A0 bit_wait_io+0x11/0x60
[978587.033763]=A0 __wait_on_bit+0x64/0x90
[978587.033765]=A0 out_of_line_wait_on_bit+0x8e/0xb0
[978587.033767]=A0 ? init_wait_var_entry+0x50/0x50
[978587.033781]=A0 nfs_wait_on_request+0x46/0x50 [nfs]
[978587.033788]=A0 nfs_lock_and_join_requests+0x121/0x510 [nfs]
[978587.033790]=A0 ? radix_tree_lookup_slot+0x22/0x50
[978587.033796]=A0 nfs_updatepage+0x168/0x970 [nfs]
[978587.033802]=A0 nfs_write_end+0xe1/0x3a0 [nfs]
[978587.033805]=A0 generic_perform_write+0xff/0x1b0
[978587.033810]=A0 nfs_file_write+0xd7/0x250 [nfs]
[978587.033811]=A0 __vfs_write+0x10f/0x1a0
[978587.033812]=A0 vfs_write+0xb5/0x1a0
[978587.033813]=A0 ksys_write+0x5c/0xe0
[978587.033815]=A0 __x64_sys_write+0x1a/0x20
[978587.033817]=A0 do_syscall_64+0x5a/0x100
[978587.033818]=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
[978587.033820] RIP: 0033:0x7f62feb121cd
[978587.033824] Code: Bad RIP value.
[978587.033825] RSP: 002b:00007f61ac5adb50 EFLAGS: 00000293 ORIG_RAX: 00000=
00000000001
[978587.033826] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007f62fe=
b121cd
[978587.033827] RDX: 0000000000002000 RSI: 00007f61ac5adbb0 RDI: 0000000000=
000222
[978587.033827] RBP: 00007f61ac5adb80 R08: 0000000000000010 R09: 0000000709=
50c5a0
[978587.033828] R10: 0000000000000f80 R11: 0000000000000293 R12: 0000000000=
002000
[978587.033828] R13: 00007f61ac5adbb0 R14: 0000000000000222 R15: 00007f62e3=
33a500
[978587.033857] INFO: task ApplicationImpl:1124088 blocked for more than 12=
0 seconds.

The one patch that we have on the machines is in net/sunrpc/cache.c:
=A0
diff -ruBb net/sunrpc/cache.c ../../linux-4.19.104/net/sunrpc/cache.c
--- net/sunrpc/cache.c=A0 2020-02-14 21:33:28.000000000 +0000
+++ ../../linux-4.19.104/net/sunrpc/cache.c=A0=A0=A0=A0 2020-03-03 21:35:41=
.330763655 +0000
@@ -37,6 +37,7 @@
#include "netns.h" #define=A0=A0=A0=A0=A0=A0=A0=A0 RPCDBG_FACILITY RPCDBG_C=
ACHE
+#define=A0 BIG_PAGE_SIZE (PAGE_SIZE << 2) static bool cache_defer_req(stru=
ct cache_req *req, struct cache_head *item);
static void cache_revisit_request(struct cache_head *item);
@@ -539,7 +540,7 @@
=A0 * it to be revisited when cache info is available
=A0 */
-#define=A0=A0=A0=A0=A0=A0=A0 DFR_HASHSIZE=A0=A0=A0 (PAGE_SIZE/sizeof(struc=
t list_head))
+#define=A0=A0=A0=A0=A0=A0=A0 DFR_HASHSIZE=A0=A0=A0 (BIG_PAGE_SIZE/sizeof(s=
truct list_head))
#define=A0=A0=A0=A0=A0=A0=A0 DFR_HASH(item)=A0 ((((long)item)>>4 ^ (((long)=
item)>>13)) % DFR_HASHSIZE)=20
=A0#define=A0=A0=A0=A0=A0=A0=A0 DFR_MAX 300=A0=A0=A0=A0 /* ??? */
@@ -769,12 +770,12 @@
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 struct cache_request *crq)
{
=A0=A0=A0=A0=A0=A0=A0 char *bp =3D crq->buf;
-=A0=A0=A0=A0=A0=A0 int len =3D PAGE_SIZE;
+=A0=A0=A0=A0=A0=A0 int len =3D BIG_PAGE_SIZE;=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 detail->cache_request(detail, crq->item, &bp, &len);
=A0 =A0=A0=A0=A0=A0=A0if (len < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EAGAIN;
-=A0=A0=A0=A0=A0=A0 return PAGE_SIZE - len;
+=A0=A0=A0=A0=A0=A0 return BIG_PAGE_SIZE - len;
} static ssize_t cache_read(struct file *filp, char __user *buf, size_t cou=
nt,
@@ -1188,7 +1189,8 @@
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Too late to make an upcall=
 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EAGAIN;-=A0=A0=A0=A0=
=A0=A0 buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
=A0
+=A0=A0=A0=A0=A0=A0 buf =3D kmalloc(BIG_PAGE_SIZE, GFP_KERNEL);
=A0=A0=A0=A0=A0=A0=A0 if (!buf)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EAGAIN;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
We added this patch because there was a problem where some users seemed to =
belong to too many groups, and the up/down calls to Kerberos were failing, =
leaving them unable to access their home directories.
I mention this because I'd like to rule out the likelihood that this patch =
may be causing issues somewhere down the line and perhaps related to the is=
sue we're seeing.
=A0
Has anyone seen anything similar to this, or perhaps has any thoughts on wh=
at might be going on here?
=A0
Thanks
=A0
--Chris
