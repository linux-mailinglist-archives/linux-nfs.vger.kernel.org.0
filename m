Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1799917FEA
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfEHSc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 14:32:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbfEHSc4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 May 2019 14:32:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48INhfM048370
        for <linux-nfs@vger.kernel.org>; Wed, 8 May 2019 18:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2018-07-02; bh=2nRFeXdYwXlbWQsQTTHje5zp3cxsqh6Yd0dqFbrnPQk=;
 b=qt5bX1BdKUSd0F92d6+6M1U2J4h4OYUrmMTnPrv1fgOkr0oteXbZuBBhZFlCdNJ83Hgu
 7exKOjHxbDEiBkkT8j8pE88jzSF3K317P9cS0AZ0dcUvvA9GFpYjc0mcaK4BTIUY2PVF
 clSUMzHal2x4BbUCm66FNshxo7Cws1LvjmJdqFu9r8fmpHCO8LrsXU2onBPYQhWkpi56
 quqpmpU3tThrCBQhFx6IEbEzuEHs0lxwuQaczKFmcIYspoQAHopkZ2We1jY9r+h3uPpl
 umB5GFLezIykpNN6zTQjgYF8wBhiStKQJksAdDZaKBg+9r7DDHUIPtp4Kdkai/hb4/jm sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s94b0x20a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2019 18:32:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x48IT636191072
        for <linux-nfs@vger.kernel.org>; Wed, 8 May 2019 18:30:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2s9ayfpsga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 May 2019 18:30:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x48IUr0e014777
        for <linux-nfs@vger.kernel.org>; Wed, 8 May 2019 18:30:53 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 11:30:53 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Anna's linux-next (pulled 5/8) seems unstable
Message-Id: <ACF23F78-1162-420D-92F9-3856EA44A323@oracle.com>
Date:   Wed, 8 May 2019 14:30:52 -0400
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905080112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080112
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hit a few oddities, so I enabled memory debugging.

This happens over and over during xfstests:

May  8 11:19:42 manet kernel: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
May  8 11:19:42 manet kernel: BUG kmalloc-128 (Tainted: G    B           =
 ): Poison overwritten
May  8 11:19:42 manet kernel: =
--------------------------------------------------------------------------=
---
May  8 11:19:42 manet kernel: INFO: =
0x000000004ca7d9fd-0x000000003fa83627. First byte 0x6a instead of 0x6b
May  8 11:19:42 manet kernel: INFO: Allocated in gss_create+0x8b/0x32f =
[auth_rpcgss] age=3D9633 cpu=3D11 pid=3D21120

This is the first field in struct gss_auth, which is a kref object.

I also see this:

May  8 14:21:16 manet kernel: WARNING: CPU: 10 PID: 45 at =
/home/cel/src/linux/anna/mm/page_alloc.c:4584 =
__alloc_pages_nodemask+0x3f/0x2c2
May  8 14:21:16 manet kernel: Modules linked in: cts rpcsec_gss_krb5 =
ib_umad ib_ipoib mlx4_ib dm_mirror dm_region_hash dm_log dm_mod dax =
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
iTCO_wdt iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul =
ghash_clmulni_intel rpcrdma aesni_intel rdma_ucm crypto_simd cryptd =
ib_iser glue_helper rdma_cm iw_cm pcspkr ib_cm libiscsi =
scsi_transport_iscsi lpc_ich i2c_i801 mfd_core mei_me sg mei ioatdma wmi =
ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad =
pcc_cpufreq auth_rpcgss ip_tables xfs libcrc32c mlx4_en sr_mod cdrom =
qedr sd_mod ast drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops ttm drm mlx4_core crc32c_intel qede igb ahci libahci qed =
libata dca i2c_algo_bit i2c_core crc8 ib_uverbs ib_core nfsv4 =
dns_resolver nfsv3 nfs_acl nfs lockd grace sunrpc fscache
May  8 14:21:16 manet kernel: CPU: 10 PID: 45 Comm: kworker/u26:0 Not =
tainted 5.1.0-rc6-00066-g3be130e #286
May  8 14:21:16 manet kernel: Hardware name: Supermicro =
SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
May  8 14:21:16 manet kernel: Workqueue: rpciod rpc_async_schedule =
[sunrpc]
May  8 14:21:16 manet kernel: RIP: =
0010:__alloc_pages_nodemask+0x3f/0x2c2
May  8 14:21:16 manet kernel: Code: f4 55 53 89 fb 48 83 ec 30 65 48 8b =
04 25 28 00 00 00 48 89 44 24 28 31 c0 48 89 e7 83 fe 0a f3 ab 76 10 80 =
e7 20 74 02 eb 02 <0f> 0b 31 c0 e9 38 02 00 00 23 1d e5 9b 0d 01 b8 22 =
01 32 01 48 63
May  8 14:21:16 manet kernel: RSP: 0018:ffffc9000332fc98 EFLAGS: =
00010246
May  8 14:21:16 manet kernel: RAX: 0000000000000000 RBX: =
0000000000040040 RCX: 0000000000000000
May  8 14:21:16 manet kernel: RDX: 0000000000000001 RSI: =
0000000000000017 RDI: ffffc9000332fcc0
May  8 14:21:16 manet kernel: RBP: 0000000000000c40 R08: =
0000000000000001 R09: 0000000000000000
May  8 14:21:16 manet kernel: R10: 8080808080808080 R11: =
fefefefefefefeff R12: 0000000000000017
May  8 14:21:16 manet kernel: R13: 000000050909093c R14: =
0000000000000000 R15: 0000000000004291
May  8 14:21:16 manet kernel: FS:  0000000000000000(0000) =
GS:ffff88886fb00000(0000) knlGS:0000000000000000
May  8 14:21:16 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
May  8 14:21:16 manet kernel: CR2: 00007fe2167d1e94 CR3: =
0000000002013001 CR4: 00000000001606e0
May  8 14:21:16 manet kernel: Call Trace:
May  8 14:21:16 manet kernel: kmalloc_order+0x1d/0x62
May  8 14:21:16 manet kernel: kmalloc_order_trace+0x21/0x10d
May  8 14:21:16 manet kernel: __kmalloc+0x42/0x14a
May  8 14:21:16 manet kernel: ? xprt_do_reserve+0x6f/0x173 [sunrpc]
May  8 14:21:16 manet kernel: rpc_malloc+0x61/0xba [sunrpc]
May  8 14:21:16 manet kernel: call_allocate+0xdd/0x1af [sunrpc]
May  8 14:21:16 manet kernel: ? rpc_clnt_add_xprt+0x153/0x153 [sunrpc]
May  8 14:21:16 manet kernel: __rpc_execute+0x135/0x42c [sunrpc]
May  8 14:21:16 manet kernel: rpc_async_schedule+0x29/0x39 [sunrpc]
May  8 14:21:16 manet kernel: process_one_work+0x285/0x4be
May  8 14:21:16 manet kernel: worker_thread+0x1b0/0x26f
May  8 14:21:16 manet kernel: ? cancel_delayed_work_sync+0xf/0xf
May  8 14:21:16 manet kernel: kthread+0xf6/0xfb
May  8 14:21:16 manet kernel: ? kthread_flush_work+0xc6/0xc6
May  8 14:21:16 manet kernel: ret_from_fork+0x24/0x30

And just now, the xfstests got stock and this appeared in v/l/m:

May  8 14:22:52 manet kernel: BUG: unable to handle kernel paging =
request at ffffffffc0000000
May  8 14:22:52 manet kernel: #PF error: [INSTR]
May  8 14:22:52 manet kernel: PGD 2016067 P4D 2016067 PUD 2018067 PMD 0=20=

May  8 14:22:52 manet kernel: Oops: 0010 [#1] SMP
May  8 14:22:52 manet kernel: CPU: 4 PID: 14848 Comm: rpc.gssd Tainted: =
G    B   W         5.1.0-rc6-00066-g3be130e #286
May  8 14:22:52 manet kernel: Hardware name: Supermicro =
SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
May  8 14:22:52 manet kernel: RIP: 0010:0xffffffffc0000000
May  8 14:22:52 manet kernel: Code: Bad RIP value.
May  8 14:22:52 manet kernel: RSP: 0018:ffffc9000cc57cd8 EFLAGS: =
00010287
May  8 14:22:52 manet kernel: RAX: ffff8884618641d8 RBX: =
ffffc9000cc57da0 RCX: ffff88886b9f0050
May  8 14:22:52 manet kernel: RDX: 0000000000000020 RSI: =
ffff88846847b550 RDI: ffff8884618641d8
May  8 14:22:52 manet kernel: RBP: ffffffffa04b22a0 R08: =
0000000000000dc0 R09: 0000000000180011
May  8 14:22:52 manet kernel: R10: ffffc9000cc57b30 R11: =
0000000000000002 R12: ffff8884618641d8
May  8 14:22:52 manet kernel: R13: 0000000000000c40 R14: =
0000000000000010 R15: ffffc9000cc57d90
May  8 14:22:52 manet kernel: FS:  00007febec152700(0000) =
GS:ffff88846fb00000(0000) knlGS:0000000000000000
May  8 14:22:52 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
May  8 14:22:52 manet kernel: CR2: ffffffffbfffffd6 CR3: =
0000000469fea003 CR4: 00000000001606e0
May  8 14:22:52 manet kernel: Call Trace:
May  8 14:22:52 manet kernel: ? krb5_derive_key+0x83/0x365 =
[rpcsec_gss_krb5]
May  8 14:22:52 manet kernel: ? crypto_cts_setkey+0x2c/0x3b [cts]
May  8 14:22:52 manet kernel: ? =
gss_import_sec_context_kerberos+0x823/0xa6d [rpcsec_gss_krb5]
May  8 14:22:52 manet kernel: ? kmem_cache_alloc_trace+0xe4/0x10b
May  8 14:22:52 manet kernel: ? gss_import_sec_context+0x6c/0xa9 =
[auth_rpcgss]
May  8 14:22:52 manet kernel: ? gss_pipe_downcall+0x2cc/0x5b4 =
[auth_rpcgss]
May  8 14:22:52 manet kernel: ? rpc_pipe_write+0x56/0x6d [sunrpc]
May  8 14:22:52 manet kernel: ? vfs_write+0xa3/0xfa
May  8 14:22:52 manet kernel: ? ksys_write+0x60/0xb3
May  8 14:22:52 manet kernel: ? do_syscall_64+0x5a/0x68
May  8 14:22:52 manet kernel: ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
May  8 14:22:52 manet kernel: Modules linked in: cts rpcsec_gss_krb5 =
ib_umad ib_ipoib mlx4_ib dm_mirror dm_region_hash dm_log dm_mod dax =
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
iTCO_wdt iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul =
ghash_clmulni_intel rpcrdma aesni_intel rdma_ucm crypto_simd cryptd =
ib_iser glue_helper rdma_cm iw_cm pcspkr ib_cm libiscsi =
scsi_transport_iscsi lpc_ich i2c_i801 mfd_core mei_me sg mei ioatdma wmi =
ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad =
pcc_cpufreq auth_rpcgss ip_tables xfs libcrc32c mlx4_en sr_mod cdrom =
qedr sd_mod ast drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops ttm drm mlx4_core crc32c_intel qede igb ahci libahci qed =
libata dca i2c_algo_bit i2c_core crc8 ib_uverbs ib_core nfsv4 =
dns_resolver nfsv3 nfs_acl nfs lockd grace sunrpc fscache
May  8 14:22:52 manet kernel: CR2: ffffffffc0000000
May  8 14:22:52 manet kernel: ---[ end trace 3c526e4155ae084b ]---
May  8 14:22:52 manet kernel: RIP: 0010:0xffffffffc0000000
May  8 14:22:52 manet kernel: Code: Bad RIP value.
May  8 14:22:52 manet kernel: RSP: 0018:ffffc9000cc57cd8 EFLAGS: =
00010287
May  8 14:22:52 manet kernel: RAX: ffff8884618641d8 RBX: =
ffffc9000cc57da0 RCX: ffff88886b9f0050
May  8 14:22:52 manet kernel: RDX: 0000000000000020 RSI: =
ffff88846847b550 RDI: ffff8884618641d8
May  8 14:22:52 manet kernel: RBP: ffffffffa04b22a0 R08: =
0000000000000dc0 R09: 0000000000180011
May  8 14:22:52 manet kernel: R10: ffffc9000cc57b30 R11: =
0000000000000002 R12: ffff8884618641d8
May  8 14:22:52 manet kernel: R13: 0000000000000c40 R14: =
0000000000000010 R15: ffffc9000cc57d90
May  8 14:22:52 manet kernel: FS:  00007febec152700(0000) =
GS:ffff88846fb00000(0000) knlGS:0000000000000000
May  8 14:22:52 manet kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
May  8 14:22:52 manet kernel: CR2: ffffffffbfffffd6 CR3: =
0000000469fea003 CR4: 00000000001606e0
May  8 14:22:52 manet kernel: BUG: sleeping function called from invalid =
context at /home/cel/src/linux/anna/include/linux/percpu-rwsem.h:34
May  8 14:22:52 manet kernel: in_atomic(): 0, irqs_disabled(): 1, pid: =
14848, name: rpc.gssd
May  8 14:22:52 manet kernel: INFO: lockdep is turned off.
May  8 14:22:52 manet kernel: irq event stamp: 0
May  8 14:22:52 manet kernel: hardirqs last  enabled at (0): =
[<0000000000000000>]           (null)
May  8 14:22:52 manet kernel: hardirqs last disabled at (0): =
[<ffffffff8106e944>] copy_process+0x774/0x1e24
May  8 14:22:52 manet kernel: softirqs last  enabled at (0): =
[<ffffffff8106e944>] copy_process+0x774/0x1e24
May  8 14:22:52 manet kernel: softirqs last disabled at (0): =
[<0000000000000000>]           (null)
May  8 14:22:52 manet kernel: CPU: 4 PID: 14848 Comm: rpc.gssd Tainted: =
G    B D W         5.1.0-rc6-00066-g3be130e #286
May  8 14:22:52 manet kernel: Hardware name: Supermicro =
SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
May  8 14:22:52 manet kernel: Call Trace:
May  8 14:22:52 manet kernel: dump_stack+0x78/0xa9
May  8 14:22:52 manet kernel: ___might_sleep+0x1b8/0x1cd
May  8 14:22:52 manet kernel: exit_signals+0x35/0x195
May  8 14:22:52 manet kernel: do_exit+0x122/0xa61
May  8 14:22:52 manet kernel: ? ksys_write+0x60/0xb3
May  8 14:22:52 manet kernel: rewind_stack_do_exit+0x17/0x20


--
Chuck Lever



