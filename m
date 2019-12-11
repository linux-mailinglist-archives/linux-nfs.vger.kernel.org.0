Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8225511BB75
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfLKSQx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Dec 2019 13:16:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48406 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfLKSQw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Dec 2019 13:16:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBIFGoU084367;
        Wed, 11 Dec 2019 18:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=i4xH7e27QyZ1npVo22sCczCev25jOEy12OEbRMrDjaY=;
 b=eweFvSjhyQa/FhN8VVDZ4DHXz2fbKk9ehZZLXKsSdZph/2J0/J12zw5IrzhcLsAiuctR
 xvJ0dhvC/ZoLzhXSU/6sivCfVklDw5WtDbQCuSvY9fxcgcPfbMvlrqMdEV6wdOnssyOL
 7IvkzDyHoInb6BIZS6ocAtR2uOzC+fMkz+dkPunun+K4Vz9/WmHxBEnH/ycvQLBabr63
 HTkIT9D8pk8DHw3lLDDhK4EYXeeUdDwywNdBTaNrvu7/01D+MJmu+imaYc1bbD5PS5wS
 KFwAiitYZA31Z1kkyGTRZt1xdVCv3XDRZYsIsGMa4BDW5pVkHPliGPak4oeQIIkyI/l7 Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wr4qrpa07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 18:16:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBIGPsX190888;
        Wed, 11 Dec 2019 18:16:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wu3jypbm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 18:16:29 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBBIEY5d021025;
        Wed, 11 Dec 2019 18:14:38 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 10:14:34 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: CPU lockup in or near new filecache code
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
Date:   Wed, 11 Dec 2019 13:14:33 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
 <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 10, 2019, at 3:45 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Tue, 2019-12-10 at 11:27 -0500, Chuck Lever wrote:
>> Under stress, I'm seeing BUGs similar to this quite a bit on my v5.5-
>> rc1 NFS server.
>> As near as I can tell, the nfsd thread is looping under
>> nfsd_file_acquire somewhere.
>>=20
>> Dec  9 13:22:52 klimt kernel: watchdog: BUG: soft lockup - CPU#0
>> stuck for 22s! [nfsd:2002]
>> Dec  9 13:22:52 klimt kernel: Modules linked in: rpcsec_gss_krb5
>> ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager
>> ocfs2_stackglue ib_umad ib_ipoib mlx4_ib sb_edac x86_pkg_temp_thermal
>> coretemp kvm_intel kvm irqbypass ext4 crct10dif_pclmul crc32_pclmul
>> ghash_clmulni_intel mbcache jbd2 iTCO_wdt iTCO_vendor_support
>> aesni_intel glue_helper crypto_simd cryptd pcspkr rpcrdma i2c_i801
>> lpc_ich rdma_ucm mfd_core ib_iser rdma_cm mei_me mei iw_cm raid0
>> ib_cm libiscsi sg scsi_transport_iscsi ioatdma wmi ipmi_si
>> ipmi_devintf ipmi_msghandler acpi_power_meter nfsd nfs_acl lockd
>> auth_rpcgss grace sunrpc ip_tables xfs libcrc32c mlx4_en sr_mod cdrom
>> sd_mod qedr ast drm_vram_helper drm_ttm_helper ttm drm_kms_helper
>> crc32c_intel syscopyarea sysfillrect sysimgblt fb_sys_fops drm ahci
>> libahci libata igb mlx4_core dca i2c_algo_bit i2c_core nvme nvme_core
>> qede qed dm_mirror dm_region_hash dm_log dm_mod crc8 ib_uverbs dax
>> ib_core
>> Dec  9 13:22:52 klimt kernel: CPU: 0 PID: 2002 Comm: nfsd Tainted:
>> G             L    5.5.0-rc1-00002-gc56d8b96a170 #1400
>> Dec  9 13:22:52 klimt kernel: Hardware name: Supermicro Super
>> Server/X10SRL-F, BIOS 1.0c 09/09/2015
>> Dec  9 13:22:52 klimt kernel: RIP: 0010:put_task_struct+0xc/0x28
>> Dec  9 13:22:52 klimt kernel: Code: 05 11 01 00 75 17 48 c7 c7 b1 b4
>> eb 81 31 c0 c6 05 4f 05 11 01 01 e8 a7 ad fd ff 0f 0b c3 48 8d 57 20
>> 83 c8 ff f0 0f c1 47 20 <83> f8 01 75 05 e9 cf 7e fd ff 85 c0 7f 0d
>> be 03 00 00 00 48 89 d7
>> Dec  9 13:22:52 klimt kernel: RSP: 0018:ffffc90000f7bb88 EFLAGS:
>> 00000213 ORIG_RAX: ffffffffffffff13
>> Dec  9 13:22:52 klimt kernel: RAX: 0000000000000002 RBX:
>> ffff888844120000 RCX: 0000000000000000
>> Dec  9 13:22:52 klimt kernel: RDX: ffff888844120020 RSI:
>> 0000000000000000 RDI: ffff888844120000
>> Dec  9 13:22:52 klimt kernel: RBP: 0000000000000001 R08:
>> ffff888817527b00 R09: ffffffff8121d707
>> Dec  9 13:22:52 klimt kernel: R10: ffffc90000f7bbc8 R11:
>> 000000008e6571d9 R12: ffff888855055750
>> Dec  9 13:22:52 klimt kernel: R13: 0000000000000000 R14:
>> ffff88882dcd9320 R15: ffff88881741a8c0
>> Dec  9 13:22:52 klimt kernel: FS:  0000000000000000(0000)
>> GS:ffff88885fc00000(0000) knlGS:0000000000000000
>> Dec  9 13:22:52 klimt kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Dec  9 13:22:52 klimt kernel: CR2: 00007f816a386000 CR3:
>> 0000000855686003 CR4: 00000000001606f0
>> Dec  9 13:22:52 klimt kernel: Call Trace:
>> Dec  9 13:22:52 klimt kernel: wake_up_q+0x34/0x40
>> Dec  9 13:22:52 klimt kernel:
>> __mutex_unlock_slowpath.isra.14+0x9d/0xeb
>> Dec  9 13:22:52 klimt kernel: fsnotify_add_mark+0x53/0x5d
>> Dec  9 13:22:52 klimt kernel: nfsd_file_acquire+0x423/0x576 [nfsd]
>> Dec  9 13:22:52 klimt kernel: nfs4_get_vfs_file+0x14c/0x20f [nfsd]
>> Dec  9 13:22:52 klimt kernel: nfsd4_process_open2+0xcd6/0xd98 [nfsd]
>> Dec  9 13:22:52 klimt kernel: ? fh_verify+0x42e/0x4ef [nfsd]
>> Dec  9 13:22:52 klimt kernel: ? nfsd4_process_open1+0x233/0x29d
>> [nfsd]
>> Dec  9 13:22:52 klimt kernel: nfsd4_open+0x500/0x5cb [nfsd]
>> Dec  9 13:22:52 klimt kernel: nfsd4_proc_compound+0x32a/0x5c7 [nfsd]
>> Dec  9 13:22:52 klimt kernel: nfsd_dispatch+0x102/0x1e2 [nfsd]
>> Dec  9 13:22:52 klimt kernel: svc_process_common+0x3b3/0x65d [sunrpc]
>> Dec  9 13:22:52 klimt kernel: ? svc_xprt_put+0x12/0x21 [sunrpc]
>> Dec  9 13:22:52 klimt kernel: ? nfsd_svc+0x2be/0x2be [nfsd]
>> Dec  9 13:22:52 klimt kernel: ? nfsd_destroy+0x51/0x51 [nfsd]
>> Dec  9 13:22:52 klimt kernel: svc_process+0xf6/0x115 [sunrpc]
>> Dec  9 13:22:52 klimt kernel: nfsd+0xf2/0x149 [nfsd]
>> Dec  9 13:22:52 klimt kernel: kthread+0xf6/0xfb
>> Dec  9 13:22:52 klimt kernel: ? kthread_queue_delayed_work+0x74/0x74
>> Dec  9 13:22:52 klimt kernel: ret_from_fork+0x3a/0x50
>>=20
>=20
> Does the very first patch in the series I just sent out help?

The test is to run (cd git; make -j12 test) on a 12-core client
over NFSv4.1 on RDMA with disconnect injection enabled.

I run the test with sys, krb5, krb5i, and krb5p.

The server used to crash 0-2 times per security flavor.

With your patch applied the server was stable enough to complete
all four security flavors without a kworker lockup. A definite
improvement. For the first patch:

Tested-by: Chuck Lever <chuck.lever@oracle.com>


--
Chuck Lever



