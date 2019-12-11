Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C811BD90
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLKUBa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 15:01:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKUBa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Dec 2019 15:01:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBJsNKQ183282;
        Wed, 11 Dec 2019 20:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=B2O1+4/xn4Lox+AAjrbMTqjk6sd44wmCe5hApMUqUYU=;
 b=ZZHWJ2H6qVRFyAg9kAkTpauyCQIqiHvAatZyopIaXxKFH3Y/pdXCrI7ZjkvvGDvvVr1c
 zc/Mo/44mtkMCPg8HM4Ai0/FEEMMz8wDJF60R8GwC8Y2iWafv2C6G+57d2/mwp/ej/PU
 OjrLi1SDdJub3TZmaEJTNBWuSzTg1AWYkPLT0sl9g4R+VR3TJ5Vkkg/DUdD2TErkaRmF
 xw9A2MGD3pZNlub+mmeQ9bDcJ+qd96h9JfYHzdn6OWgR3X5r37W9gCTcZAwVqjmG9Kml
 sEe9hLB+xgF8oW9S5zUH/s9ijxgYO7piJ2QivcJ1r4xd25oT+qGsImtPW8tcQ7nQ6XS8 Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wrw4nbrtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 20:01:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBJx9tj089547;
        Wed, 11 Dec 2019 20:01:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wu2fuwwyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 20:01:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBBK1HWF018304;
        Wed, 11 Dec 2019 20:01:19 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 12:01:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: CPU lockup in or near new filecache code
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
Date:   Wed, 11 Dec 2019 15:01:16 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7C348BD-2543-492A-B768-7E3666734A57@oracle.com>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
 <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
 <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 11, 2019, at 1:14 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>=20
>> On Dec 10, 2019, at 3:45 PM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>>=20
>> On Tue, 2019-12-10 at 11:27 -0500, Chuck Lever wrote:
>>> Under stress, I'm seeing BUGs similar to this quite a bit on my =
v5.5-
>>> rc1 NFS server.
>>> As near as I can tell, the nfsd thread is looping under
>>> nfsd_file_acquire somewhere.
>>>=20
>>> Dec  9 13:22:52 klimt kernel: watchdog: BUG: soft lockup - CPU#0
>>> stuck for 22s! [nfsd:2002]
>>> Dec  9 13:22:52 klimt kernel: Modules linked in: rpcsec_gss_krb5
>>> ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager
>>> ocfs2_stackglue ib_umad ib_ipoib mlx4_ib sb_edac =
x86_pkg_temp_thermal
>>> coretemp kvm_intel kvm irqbypass ext4 crct10dif_pclmul crc32_pclmul
>>> ghash_clmulni_intel mbcache jbd2 iTCO_wdt iTCO_vendor_support
>>> aesni_intel glue_helper crypto_simd cryptd pcspkr rpcrdma i2c_i801
>>> lpc_ich rdma_ucm mfd_core ib_iser rdma_cm mei_me mei iw_cm raid0
>>> ib_cm libiscsi sg scsi_transport_iscsi ioatdma wmi ipmi_si
>>> ipmi_devintf ipmi_msghandler acpi_power_meter nfsd nfs_acl lockd
>>> auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en sr_mod =
cdrom
>>> sd_mod qedr ast drm_vram_helper drm_ttm_helper ttm drm_kms_helper
>>> crc32c_intel syscopyarea sysfillrect sysimgblt fb_sys_fops drm ahci
>>> libahci libata igb mlx4_core dca i2c_algo_bit i2c_core nvme =
nvme_core
>>> qede qed dm_mirror dm_region_hash dm_log dm_mod crc8 ib_uverbs dax
>>> ib_core
>>> Dec  9 13:22:52 klimt kernel: CPU: 0 PID: 2002 Comm: nfsd Tainted:
>>> G             L    5.5.0-rc1-00002-gc56d8b96a170 #1400
>>> Dec  9 13:22:52 klimt kernel: Hardware name: Supermicro Super
>>> Server/X10SRL-F, BIOS 1.0c 09/09/2015
>>> Dec  9 13:22:52 klimt kernel: RIP: 0010:put_task_struct+0xc/0x28
>>> Dec  9 13:22:52 klimt kernel: Code: 05 11 01 00 75 17 48 c7 c7 b1 b4
>>> eb 81 31 c0 c6 05 4f 05 11 01 01 e8 a7 ad fd ff 0f 0b c3 48 8d 57 20
>>> 83 c8 ff f0 0f c1 47 20 <83> f8 01 75 05 e9 cf 7e fd ff 85 c0 7f 0d
>>> be 03 00 00 00 48 89 d7
>>> Dec  9 13:22:52 klimt kernel: RSP: 0018:ffffc90000f7bb88 EFLAGS:
>>> 00000213 ORIG_RAX: ffffffffffffff13
>>> Dec  9 13:22:52 klimt kernel: RAX: 0000000000000002 RBX:
>>> ffff888844120000 RCX: 0000000000000000
>>> Dec  9 13:22:52 klimt kernel: RDX: ffff888844120020 RSI:
>>> 0000000000000000 RDI: ffff888844120000
>>> Dec  9 13:22:52 klimt kernel: RBP: 0000000000000001 R08:
>>> ffff888817527b00 R09: ffffffff8121d707
>>> Dec  9 13:22:52 klimt kernel: R10: ffffc90000f7bbc8 R11:
>>> 000000008e6571d9 R12: ffff888855055750
>>> Dec  9 13:22:52 klimt kernel: R13: 0000000000000000 R14:
>>> ffff88882dcd9320 R15: ffff88881741a8c0
>>> Dec  9 13:22:52 klimt kernel: FS:  0000000000000000(0000)
>>> GS:ffff88885fc00000(0000) knlGS:0000000000000000
>>> Dec  9 13:22:52 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>> 0000000080050033
>>> Dec  9 13:22:52 klimt kernel: CR2: 00007f816a386000 CR3:
>>> 0000000855686003 CR4: 00000000001606f0
>>> Dec  9 13:22:52 klimt kernel: Call Trace:
>>> Dec  9 13:22:52 klimt kernel: wake_up_q+0x34/0x40
>>> Dec  9 13:22:52 klimt kernel:
>>> __mutex_unlock_slowpath.isra.14+0x9d/0xeb
>>> Dec  9 13:22:52 klimt kernel: fsnotify_add_mark+0x53/0x5d
>>> Dec  9 13:22:52 klimt kernel: nfsd_file_acquire+0x423/0x576 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: nfs4_get_vfs_file+0x14c/0x20f [nfsd]
>>> Dec  9 13:22:52 klimt kernel: nfsd4_process_open2+0xcd6/0xd98 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: ? fh_verify+0x42e/0x4ef [nfsd]
>>> Dec  9 13:22:52 klimt kernel: ? nfsd4_process_open1+0x233/0x29d
>>> [nfsd]
>>> Dec  9 13:22:52 klimt kernel: nfsd4_open+0x500/0x5cb [nfsd]
>>> Dec  9 13:22:52 klimt kernel: nfsd4_proc_compound+0x32a/0x5c7 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: nfsd_dispatch+0x102/0x1e2 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: svc_process_common+0x3b3/0x65d =
[sunrpc]
>>> Dec  9 13:22:52 klimt kernel: ? svc_xprt_put+0x12/0x21 [sunrpc]
>>> Dec  9 13:22:52 klimt kernel: ? nfsd_svc+0x2be/0x2be [nfsd]
>>> Dec  9 13:22:52 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: svc_process+0xf6/0x115 [sunrpc]
>>> Dec  9 13:22:52 klimt kernel: nfsd+0xf2/0x149 [nfsd]
>>> Dec  9 13:22:52 klimt kernel: kthread+0xf6/0xfb
>>> Dec  9 13:22:52 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
>>> Dec  9 13:22:52 klimt kernel: ret_from_fork+0x3a/0x50
>>>=20
>>=20
>> Does the very first patch in the series I just sent out help?
>=20
> The test is to run (cd git; make -j12 test) on a 12-core client
> over NFSv4.1 on RDMA with disconnect injection enabled.
>=20
> I run the test with sys, krb5, krb5i, and krb5p.
>=20
> The server used to crash 0-2 times per security flavor.
>=20
> With your patch applied the server was stable enough to complete
> all four security flavors without a kworker lockup. A definite
> improvement. For the first patch:
>=20
> Tested-by: Chuck Lever <chuck.lever@oracle.com>

OK, I finally got a hit. It took a long time. I've seen this particular
stack trace before, several times.

Dec 11 14:58:34 klimt kernel: watchdog: BUG: soft lockup - CPU#0 stuck =
for 22s! [nfsd:2005]
Dec 11 14:58:34 klimt kernel: Modules linked in: rpcsec_gss_krb5 =
ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue =
ib_umad ib_ipoib mlx4_ib sb_edac x86_pkg_temp_thermal kvm_intel coretemp =
kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel iTCO_wdt =
ext4 iTCO_vendor_support aesni_intel mbcache jbd2 glue_helper rpcrdma =
crypto_simd cryptd rdma_ucm ib_iser rdma_cm pcspkr iw_cm ib_cm mei_me =
raid0 libiscsi lpc_ich mei sg scsi_transport_iscsi i2c_i801 mfd_core wmi =
ipmi_si ipmi_devintf ipmi_msghandler ioatdma acpi_power_meter nfsd =
nfs_acl lockd auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en =
sr_mod sd_mod cdrom qedr ast drm_vram_helper drm_ttm_helper ttm =
crc32c_intel drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops drm igb dca i2c_algo_bit i2c_core mlx4_core ahci libahci =
libata nvme nvme_core qede qed dm_mirror dm_region_hash dm_log dm_mod =
crc8 ib_uverbs dax ib_core
Dec 11 14:58:34 klimt kernel: CPU: 0 PID: 2005 Comm: nfsd Tainted: G     =
   W         5.5.0-rc1-00003-g170e7adc2317 #1401
Dec 11 14:58:34 klimt kernel: Hardware name: Supermicro Super =
Server/X10SRL-F, BIOS 1.0c 09/09/2015
Dec 11 14:58:34 klimt kernel: RIP: 0010:__srcu_read_lock+0x23/0x24
Dec 11 14:58:34 klimt kernel: Code: 07 00 0f 1f 40 00 c3 0f 1f 44 00 00 =
8b 87 c8 c3 00 00 48 8b 97 f0 c3 00 00 83 e0 01 48 63 c8 65 48 ff 04 ca =
f0 83 44 24 fc 00 <c3> 0f 1f 44 00 00 f0 83 44 24 fc 00 48 63 f6 48 8b =
87 f0 c3 00 00
Dec 11 14:58:34 klimt kernel: RSP: 0018:ffffc90001d97bd0 EFLAGS: =
00000246 ORIG_RAX: ffffffffffffff13
Dec 11 14:58:34 klimt kernel: RAX: 0000000000000001 RBX: =
ffff888830d0eb78 RCX: 0000000000000001
Dec 11 14:58:34 klimt kernel: RDX: 0000000000030f00 RSI: =
ffff888853f4da00 RDI: ffffffff82815a40
Dec 11 14:58:34 klimt kernel: RBP: ffff88883112d828 R08: =
ffff888843540000 R09: ffffffff8121d707
Dec 11 14:58:34 klimt kernel: R10: ffffc90001d97bf0 R11: =
0000000000001b84 R12: ffff888853f4da00
Dec 11 14:58:34 klimt kernel: R13: ffff8888132a1410 R14: =
ffff88883112d7e0 R15: 00000000ffffffef
Dec 11 14:58:34 klimt kernel: FS:  0000000000000000(0000) =
GS:ffff88885fc00000(0000) knlGS:0000000000000000
Dec 11 14:58:34 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
Dec 11 14:58:34 klimt kernel: CR2: 00007f2d6a2d8000 CR3: =
0000000859b38004 CR4: 00000000001606f0
Dec 11 14:58:34 klimt kernel: Call Trace:
Dec 11 14:58:34 klimt kernel: fsnotify_grab_connector+0x16/0x4f
Dec 11 14:58:34 klimt kernel: fsnotify_find_mark+0x11/0x6a
Dec 11 14:58:34 klimt kernel: nfsd_file_acquire+0x3a9/0x5b2 [nfsd]
Dec 11 14:58:34 klimt kernel: nfs4_get_vfs_file+0x14c/0x20f [nfsd]
Dec 11 14:58:34 klimt kernel: nfsd4_process_open2+0xcd6/0xd98 [nfsd]
Dec 11 14:58:34 klimt kernel: ? fh_verify+0x42e/0x4ef [nfsd]
Dec 11 14:58:34 klimt kernel: ? nfsd4_process_open1+0x233/0x29d [nfsd]
Dec 11 14:58:34 klimt kernel: nfsd4_open+0x500/0x5cb [nfsd]
Dec 11 14:58:34 klimt kernel: nfsd4_proc_compound+0x32a/0x5c7 [nfsd]
Dec 11 14:58:34 klimt kernel: nfsd_dispatch+0x102/0x1e2 [nfsd]
Dec 11 14:58:34 klimt kernel: svc_process_common+0x3b3/0x65d [sunrpc]
Dec 11 14:58:34 klimt kernel: ? svc_xprt_put+0x12/0x21 [sunrpc]
Dec 11 14:58:34 klimt kernel: ? nfsd_svc+0x2be/0x2be [nfsd]
Dec 11 14:58:34 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
Dec 11 14:58:34 klimt kernel: svc_process+0xf6/0x115 [sunrpc]
Dec 11 14:58:34 klimt kernel: nfsd+0xf2/0x149 [nfsd]
Dec 11 14:58:34 klimt kernel: kthread+0xf6/0xfb
Dec 11 14:58:34 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
Dec 11 14:58:34 klimt kernel: ret_from_fork+0x3a/0x50


--
Chuck Lever



