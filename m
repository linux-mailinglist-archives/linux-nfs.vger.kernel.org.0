Return-Path: <linux-nfs+bounces-10495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95236A54628
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C3A1716FA
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B07209F35;
	Thu,  6 Mar 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gl4prFYy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3A20897B
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252907; cv=none; b=iUQ8XEyFgUX/JMrZFO/ISN6oCSqfBPHx4IZPjxc66ZA+Isd2/sehfbRXeKVpPbSKubiIZ+/3ONOEdqKLY068p6efooqETjRpyq5yLXsRAgQ9Rdq6GTowHYwSnb2I3bs2FrcoAW47szcG1IEmsikwXLcQ+F/6urulCAnDmfjmPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252907; c=relaxed/simple;
	bh=OIik2RI9qIy0xGcVlcIQ9Lf//sdqTBTRU2HuJLiXVzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=i32qurC21HirBYKJ8+XUn6Tj9IdtamlGrFzsB4Ew+5Rris1q7soVM7mdJzEN+UUYOcwzseXs0E7JCi1I+sM1SMle4XRoB760fo30luZohLQY0MbLW2fYZDiWzo0myeHqq3Qt3+/pKsDzokDUTpizA4C+IKFczp6VFEb3sHgxMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gl4prFYy; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250306092143epoutp03fba78a4d6824643966949cccebd58419~qLEpXlb_h2899328993epoutp03R
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 09:21:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250306092143epoutp03fba78a4d6824643966949cccebd58419~qLEpXlb_h2899328993epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741252903;
	bh=Toj+T87tTrxlVRA6BA9XF8FjrBO9X4SjJLlUboAI4X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gl4prFYyfH+ho/XspXm6Lywgz2bciZ6q5w00jP7KLqMhhzD6I6+u8R5HBPMLIVTtV
	 A4Uce/+GcaluGvYFwdyFsX3SpTAeDeAlavAI0+b/6nie76YXkcmFb9hfYZ3LNgHLgG
	 7UQjprtUNiUHgWUJ0OjDy67OlZwgyYfQ2kj8bMws=
Received: from epsmgec5p1new.samsung.com (unknown [182.195.42.68]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250306092142epcas5p2fe8305b799ba79678854b1af1e3405b0~qLEoqj5ZT1356713567epcas5p2x;
	Thu,  6 Mar 2025 09:21:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.33.19710.62969C76; Thu,  6 Mar 2025 18:21:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f~qLDdECj5t0432404324epcas5p4F;
	Thu,  6 Mar 2025 09:20:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306092021epsmtrp1a3db0c5c97183cae02fa7708dbbb4a91~qLDdDP_Dx2217622176epsmtrp1T;
	Thu,  6 Mar 2025 09:20:21 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-5b-67c96926ab31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.7C.18729.5D869C76; Thu,  6 Mar 2025 18:20:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250306092019epsmtip19be7b78fd75ad57748045f431ebbdd28~qLDa0Wdlb1437814378epsmtip1w;
	Thu,  6 Mar 2025 09:20:19 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, lorenzo@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	chungki0201.woo@samsung.com, Maninder Singh <maninder1.s@samsung.com>,
	Shubham Rana <s9.rana@samsung.com>
Subject: [PATCH 2/2] NFSD: fix race between nfsd registration and
 exports_proc
Date: Thu,  6 Mar 2025 14:50:07 +0530
Message-Id: <20250306092007.1419237-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306092007.1419237-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmd+/d3XW1uNnraA9rZKLQzEi59FAJq0GUvYtea+htWmpjW5pF
	OFJH6tSywnzUKrNoYYnTmOayLJrbolInltF7JU3IbNYos8d2F/Xf953znd/5vsOPwgObecFU
	aoaaVWbI0kSkgLhxNzxs7pxUq3xef8985tfzfoyxexx8Rn/BSDLfLhn4THdLNck8vm3nMSVX
	KxFzV68lGLNeQzBl7z/zGc/bLsTYvtuw+LGSBkMBKRl610dIBm/1kJKSRgOSGO2HJN1OB5K4
	G2as4W8VLE5m01IzWWVk7C5Bit1axlOMzj5w9FUtoUH1IYUogAJ6ARSVHyELkYAKpG8iaOk4
	gXPkM4LePJOffEXw4sEAKkSUb6TJMZmrmxFoutyII8MIBqpcuPddkhaDoaWV8DYm0joEN6pb
	MS/BaQOCNv05vlc1gV4DL63lPkzQoXDEYsa8WEjHwkCBhuAchkBFl8enCaDjoNj9Auc048Fa
	4fRp8D+a3KYqn1egz1BQ8/EijxtOgNr8UT6HJ4DL0ujHwfChVMvn8mRB07Ecbjbvj7nqkySn
	iQNn53meV4PT4XC9JZIrT4dTtmsYt3ccFI84Ma4uBNPZvzgU8p7W+y1MBffQkD+LBPJNVv+1
	yxA4hnLRMTSz8r88lf/lqfy3+hzCDSiIVajS5WxStCIqg80Sq2Tpqv0ZcnHSvvQG5PtdEQkm
	9ET/U9yOMAq1I6Bw0URh52qrPFCYLMs+yCr3SZX701hVO5pKEaIpwtzmPHkgLZep2b0sq2CV
	f7sYFRCswY6r72240LvAuORZBRM+cCVMWqLLZJaG2mKGc8Nev0kZTVrbd6ezY1NJA/np67J7
	T11FXxyZvG/Zm3Ww8JH2WeKZXs/CoJCNsau2lfbGRIv5p8nsV7znSmmWy5wo2v1DcWmudFnR
	rGuw3TLtltZzPyZuxnDb4MjGrQesptoT5fHdk94ur9+1Imn89eQrZT3qSZGH7z+eHt23/tdw
	fttiHbKrtyjOSwvdl80fRhYlVBlvOvWt6GO6pbGYzXGUsiqi2DYYNLOm2ZZlC52ii5rVGE++
	S9kb8SjHXOfaLRjZsdMyZ4+pLvxoRwwzZl2fJ7jKGG9a/7Dmzsq6gv7b2sQCnkIhIlQpsqgI
	XKmS/QaszKNrzAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO7VjJPpBme2a1n8v/ucyeL09yvs
	FvMXbWaz+LlsFbvF5V1z2CwuHDjNatG3ehajxeH5bSwWe+c3sFhMevaJ3eL740uMFqd+nWJy
	4PHYtKqTzePj01ssHu/3XWXz6NuyitFj8+lqj8tPrjB6fN4kF8AexWWTkpqTWZZapG+XwJVx
	+uQk1oK/KhUdD5ayNDBukO9i5OCQEDCR2HpFrIuRi0NIYDejxP7TU1i7GDmB4tISP/+9Z4Gw
	hSVW/nvODlH0iVHiwdfZ7CAJNgE9iVW79rCAJEQEpjFKLOqaA1bFLLCOUWL74bdgVcICfhKd
	K++zgdgsAqoSTcf3MoHYvAJ2Eq87G6BWyEvMvPQdrJ5TwF6i9/M9ZhBbCKjm2oIrzBD1ghIn
	Zz4Bq2cGqm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
	BEeHluYOxu2rPugdYmTiYDzEKMHBrCTCe9HvZLoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEX
	vSlCAumJJanZqakFqUUwWSYOTqkGpuUsBf+Cbm7z6pv7Vu0pd/aSiwnihwNO9Z9vmPtzUuSs
	qalhJx0CtdauVdlwb4nPZk2TP7sn342LVbwdv01felJ21HKnKqYPvI7TC9endT90Xv788Z7K
	63z5NZsN23dXLM3uDNh6kTdBy98xMip0u5BdisqZHFeJT8Vbassu76oX+mjwW1aH59jckhXP
	DFuzf4bOL522UOx49Hzn2SrRPSbzsiz3C+sL5s3lDYn4+vS4zL4518JPWTfx3MtZFWJ04Bj7
	fhOvKVd9NXe3ub/OvPj64O6p1twm93ebvptl2zPZ8uPn2VxXkup9FP/nulT5qwYHnH7//ftk
	iVimDXVG7f48P/Yqnz//XPbeziLWQ0osxRmJhlrMRcWJAMDf1m79AgAA
X-CMS-MailID: 20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f
References: <20250306092007.1419237-1-maninder1.s@samsung.com>
	<CGME20250306092021epcas5p41133e5a273e547d39ae8b724c9eca23f@epcas5p4.samsung.com>

As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
and cleanup by remove_proc_entry() at last of exit_nfsd.

Which causes kernel OOPs if there is race between below 2 operations:
(i) exportfs -r
(ii) mount -t nfsd none /proc/fs/nfsd

for 5.4 kernel ARM64:

CPU 1:
el1_irq+0xbc/0x180
arch_counter_get_cntvct+0x14/0x18
running_clock+0xc/0x18
preempt_count_add+0x88/0x110
prep_new_page+0xb0/0x220
get_page_from_freelist+0x2d8/0x1778
__alloc_pages_nodemask+0x15c/0xef0
__vmalloc_node_range+0x28c/0x478
__vmalloc_node_flags_caller+0x8c/0xb0
kvmalloc_node+0x88/0xe0
nfsd_init_net+0x6c/0x108 [nfsd]
ops_init+0x44/0x170
register_pernet_operations+0x114/0x270
register_pernet_subsys+0x34/0x50
init_nfsd+0xa8/0x718 [nfsd]
do_one_initcall+0x54/0x2e0

CPU 2 :
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010

PC is at : exports_net_open+0x50/0x68 [nfsd]

Call trace:
exports_net_open+0x50/0x68 [nfsd]
exports_proc_open+0x2c/0x38 [nfsd]
proc_reg_open+0xb8/0x198
do_dentry_open+0x1c4/0x418
vfs_open+0x38/0x48
path_openat+0x28c/0xf18
do_filp_open+0x70/0xe8
do_sys_open+0x154/0x248

Sometimes it crashes at exports_net_open() and sometimes cache_seq_next_rcu().

and same is happening on latest 6.14 kernel as well:

[    0.000000] Linux version 6.14.0-rc5-next-20250304-dirty
...
[  285.455918] Unable to handle kernel paging request at virtual address 00001f4800001f48
...
[  285.464902] pc : cache_seq_next_rcu+0x78/0xa4
...
[  285.469695] Call trace:
[  285.470083]  cache_seq_next_rcu+0x78/0xa4 (P)
[  285.470488]  seq_read+0xe0/0x11c
[  285.470675]  proc_reg_read+0x9c/0xf0
[  285.470874]  vfs_read+0xc4/0x2fc
[  285.471057]  ksys_read+0x6c/0xf4
[  285.471231]  __arm64_sys_read+0x1c/0x28
[  285.471428]  invoke_syscall+0x44/0x100
[  285.471633]  el0_svc_common.constprop.0+0x40/0xe0
[  285.471870]  do_el0_svc_compat+0x1c/0x34
[  285.472073]  el0_svc_compat+0x2c/0x80
[  285.472265]  el0t_32_sync_handler+0x90/0x140
[  285.472473]  el0t_32_sync+0x19c/0x1a0
[  285.472887] Code: f9400885 93407c23 937d7c27 11000421 (f86378a3)
[  285.473422] ---[ end trace 0000000000000000 ]---

It reproduced simply with below script:
while [ 1 ]
do
/exportfs -r
done &

while [ 1 ]
do
insmod /nfsd.ko
mount -t nfsd none /proc/fs/nfsd
umount /proc/fs/nfsd
rmmod nfsd
done &

So exporting interfaces to user space shall be done at last and
cleanup at first place.

With change there is no Kernel OOPs.

Co-developed-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 fs/nfsd/nfsctl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d773481bcf10..f9763ced743d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2291,12 +2291,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = create_proc_exports_entry();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_exports;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2307,12 +2304,17 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_nfsd4;
 	retval = genl_register_family(&nfsd_nl_family);
+	if (retval)
+		goto out_free_filesystem;
+	retval = create_proc_exports_entry();
 	if (retval)
 		goto out_free_all;
 	nfsd_localio_ops_init();
 
 	return 0;
 out_free_all:
+	genl_unregister_family(&nfsd_nl_family);
+out_free_filesystem:
 	unregister_filesystem(&nfsd_fs_type);
 out_free_nfsd4:
 	nfsd4_destroy_laundry_wq();
@@ -2320,9 +2322,6 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_exports:
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2335,14 +2334,14 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	remove_proc_entry("fs/nfs/exports", NULL);
+	remove_proc_entry("fs/nfs", NULL);
 	genl_unregister_family(&nfsd_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
-- 
2.25.1


