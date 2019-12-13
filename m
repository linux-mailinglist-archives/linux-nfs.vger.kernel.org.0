Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9311EBD5
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfLMU0k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 15:26:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMU0k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 15:26:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDKJRHu065373;
        Fri, 13 Dec 2019 20:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=4QxWWhfzkeeg/sj/lRZm77rHhBFZZB7dyoW1bA8QM34=;
 b=k5TC2QgdEH/G1ODuvCAQO2/KjcINSU6NjwZApWC1Nn+NhnCbYxGAIW88Ekvtc6U0clwH
 /WuaOgKNoYujEiaVrmieeMuSx0joMTT1LqiSCSc8mWpZT7t1JEcojOm1aM49ziHvz5cT
 WO9bXB6eWGrdjEW/tNsQPqfBgK2/gbe5m3ekv8C58BT9HCkv2e+du7NZCWx09zqdUpaW
 E/uq59n7uF1l+zNOFkf3831UwRu5qZfyn8+bpjgdjxebO5s7M0Tuk49hKKcf7QSdcpfW
 PBru3brkBCRxNNAS8tQYNnqTtRAlc06pK9qZfbqcccqjKbjWlZ7ZHyZNWkKaaezZ/63u QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qu6m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 20:26:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDKIaFo029237;
        Fri, 13 Dec 2019 20:26:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wvdwqqskf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 20:26:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDKQUBQ014080;
        Fri, 13 Dec 2019 20:26:30 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 12:26:30 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: CPU lockup in or near new filecache code
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aa7857e4a9ac535e78353db53448efb1b58a57f9.camel@hammerspace.com>
Date:   Fri, 13 Dec 2019 15:26:28 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74C1EB52-06D7-4FB5-BA1C-BB1EC2F325CA@oracle.com>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
 <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
 <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
 <A7C348BD-2543-492A-B768-7E3666734A57@oracle.com>
 <aa7857e4a9ac535e78353db53448efb1b58a57f9.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130149
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 13, 2019, at 3:12 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Wed, 2019-12-11 at 15:01 -0500, Chuck Lever wrote:
>> OK, I finally got a hit. It took a long time. I've seen this
>> particular
>> stack trace before, several times.
>>=20
>> Dec 11 14:58:34 klimt kernel: watchdog: BUG: soft lockup - CPU#0
>> stuck for 22s! [nfsd:2005]
>> Dec 11 14:58:34 klimt kernel: Modules linked in: rpcsec_gss_krb5
>> ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager
>> ocfs2_stackglue ib_umad ib_ipoib mlx4_ib sb_edac x86_pkg_temp_thermal
>> kvm_intel coretemp kvm irqbypass crct10dif_pclmul crc32_pclmul
>> ghash_clmulni_intel iTCO_wdt ext4 iTCO_vendor_support aesni_intel
>> mbcache jbd2 glue_helper rpcrdma crypto_simd cryptd rdma_ucm ib_iser
>> rdma_cm pcspkr iw_cm ib_cm mei_me raid0 libiscsi lpc_ich mei sg
>> scsi_transport_iscsi i2c_i801 mfd_core wmi ipmi_si ipmi_devintf
>> ipmi_msghandler ioatdma acpi_power_meter nfsd nfs_acl lockd
>> auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en sr_mod
>> sd_mod cdrom qedr ast drm_vram_helper drm_ttm_helper ttm crc32c_intel
>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm igb
>> dca i2c_algo_bit i2c_core mlx4_core ahci libahci libata nvme
>> nvme_core qede qed dm_mirror dm_region_hash dm_log dm_mod crc8
>> ib_uverbs dax ib_core
>> Dec 11 14:58:34 klimt kernel: CPU: 0 PID: 2005 Comm: nfsd Tainted:
>> G        W         5.5.0-rc1-00003-g170e7adc2317 #1401
>> Dec 11 14:58:34 klimt kernel: Hardware name: Supermicro Super
>> Server/X10SRL-F, BIOS 1.0c 09/09/2015
>> Dec 11 14:58:34 klimt kernel: RIP: 0010:__srcu_read_lock+0x23/0x24
>> Dec 11 14:58:34 klimt kernel: Code: 07 00 0f 1f 40 00 c3 0f 1f 44 00
>> 00 8b 87 c8 c3 00 00 48 8b 97 f0 c3 00 00 83 e0 01 48 63 c8 65 48 ff
>> 04 ca f0 83 44 24 fc 00 <c3> 0f 1f 44 00 00 f0 83 44 24 fc 00 48 63
>> f6 48 8b 87 f0 c3 00 00
>> Dec 11 14:58:34 klimt kernel: RSP: 0018:ffffc90001d97bd0 EFLAGS:
>> 00000246 ORIG_RAX: ffffffffffffff13
>> Dec 11 14:58:34 klimt kernel: RAX: 0000000000000001 RBX:
>> ffff888830d0eb78 RCX: 0000000000000001
>> Dec 11 14:58:34 klimt kernel: RDX: 0000000000030f00 RSI:
>> ffff888853f4da00 RDI: ffffffff82815a40
>> Dec 11 14:58:34 klimt kernel: RBP: ffff88883112d828 R08:
>> ffff888843540000 R09: ffffffff8121d707
>> Dec 11 14:58:34 klimt kernel: R10: ffffc90001d97bf0 R11:
>> 0000000000001b84 R12: ffff888853f4da00
>> Dec 11 14:58:34 klimt kernel: R13: ffff8888132a1410 R14:
>> ffff88883112d7e0 R15: 00000000ffffffef
>> Dec 11 14:58:34 klimt kernel: FS:  0000000000000000(0000)
>> GS:ffff88885fc00000(0000) knlGS:0000000000000000
>> Dec 11 14:58:34 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Dec 11 14:58:34 klimt kernel: CR2: 00007f2d6a2d8000 CR3:
>> 0000000859b38004 CR4: 00000000001606f0
>> Dec 11 14:58:34 klimt kernel: Call Trace:
>> Dec 11 14:58:34 klimt kernel: fsnotify_grab_connector+0x16/0x4f
>> Dec 11 14:58:34 klimt kernel: fsnotify_find_mark+0x11/0x6a
>> Dec 11 14:58:34 klimt kernel: nfsd_file_acquire+0x3a9/0x5b2 [nfsd]
>> Dec 11 14:58:34 klimt kernel: nfs4_get_vfs_file+0x14c/0x20f [nfsd]
>> Dec 11 14:58:34 klimt kernel: nfsd4_process_open2+0xcd6/0xd98 [nfsd]
>> Dec 11 14:58:34 klimt kernel: ? fh_verify+0x42e/0x4ef [nfsd]
>> Dec 11 14:58:34 klimt kernel: ? nfsd4_process_open1+0x233/0x29d
>> [nfsd]
>> Dec 11 14:58:34 klimt kernel: nfsd4_open+0x500/0x5cb [nfsd]
>> Dec 11 14:58:34 klimt kernel: nfsd4_proc_compound+0x32a/0x5c7 [nfsd]
>> Dec 11 14:58:34 klimt kernel: nfsd_dispatch+0x102/0x1e2 [nfsd]
>> Dec 11 14:58:34 klimt kernel: svc_process_common+0x3b3/0x65d [sunrpc]
>> Dec 11 14:58:34 klimt kernel: ? svc_xprt_put+0x12/0x21 [sunrpc]
>> Dec 11 14:58:34 klimt kernel: ? nfsd_svc+0x2be/0x2be [nfsd]
>> Dec 11 14:58:34 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
>> Dec 11 14:58:34 klimt kernel: svc_process+0xf6/0x115 [sunrpc]
>> Dec 11 14:58:34 klimt kernel: nfsd+0xf2/0x149 [nfsd]
>> Dec 11 14:58:34 klimt kernel: kthread+0xf6/0xfb
>> Dec 11 14:58:34 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
>> Dec 11 14:58:34 klimt kernel: ret_from_fork+0x3a/0x50
>>=20
>=20
> Does something like the following help?
>=20
> 8<---------------------------------------------------
> =46rom caf515c82ed572e4f92ac8293e5da4818da0c6ce Mon Sep 17 00:00:00 =
2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Fri, 13 Dec 2019 15:07:33 -0500
> Subject: [PATCH] nfsd: Fix a soft lockup race in
> nfsd_file_mark_find_or_create()
>=20
> If nfsd_file_mark_find_or_create() keeps winning the race for the
> nfsd_file_fsnotify_group->mark_mutex against nfsd_file_mark_put()
> then it can soft lock up, since fsnotify_add_inode_mark() ends
> up always finding an existing entry.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfsd/filecache.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9c2b29e07975..f275c11c4e28 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -132,9 +132,13 @@ nfsd_file_mark_find_or_create(struct nfsd_file =
*nf)
> 						 struct nfsd_file_mark,
> 						 nfm_mark));
> 			=
mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
> -			fsnotify_put_mark(mark);
> -			if (likely(nfm))
> +			if (nfm) {
> +				fsnotify_put_mark(mark);
> 				break;
> +			}
> +			/* Avoid soft lockup race with =
nfsd_file_mark_put() */
> +			fsnotify_destroy_mark(mark, =
nfsd_file_fsnotify_group);
> +			fsnotify_put_mark(mark);
> 		} else
> 			=
mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
>=20

Received. I'll have some time over the weekend or on Monday to test it.


--
Chuck Lever



