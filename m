Return-Path: <linux-nfs+bounces-10473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B0A4FD57
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F97916BAC4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B4233701;
	Wed,  5 Mar 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D/CzNPdY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFE22E017
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173284; cv=none; b=u5PYllc3GUgANlJhv6pevXLb463SyLl1D/ua5kqf7NAfAqNjal5kR2C7Q0usEJ8cqIISVeXndhjNh+oL48Wp/F5MphVNq69Dnnnk4ZidBCMpf2NcWLRTg/Cxqkvh3m3ptjMgyMIdQSXL3Js4IpncoQ76HVKYwJUzzlzljm7dVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173284; c=relaxed/simple;
	bh=jdLDJbaQQsoDFa4s+c02wBLg7YrqNZ8Jn1IQPeKEYaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=g1ezfuHxXOAHYUzkLVbcDfQHTH6fa1jyWogR93bGpwuuujpu2kS0LSfvn0WGyCud/u2DkiuAIjIW63Q/Q2G56KjFKDVSKzyCRWP7svOFFLKSiXCpWpXdj1ixKAYu11nxVZNU3rZWri3Q6wTn535LNQnOfv56a1I7JQFPhkRV1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=D/CzNPdY; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250305111438epoutp026c4390c0eceed08bbbf58f01882620b5~p498dRLF82998129981epoutp02k
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 11:14:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250305111438epoutp026c4390c0eceed08bbbf58f01882620b5~p498dRLF82998129981epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741173278;
	bh=zHdQi7kjXKUJJwwKVQr1SUHzVf3qWJSfUQ7rXz+WnZo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=D/CzNPdY3AlrRJJ9x2iBoPqlu4wDvVlGtd3pWFfwE66jBXa9Yu97GNKmP/ocwDxzs
	 iDnA6WrLxDdM3RlcmsAm/mWhjnXQVwixwQP3RuFQ6Jd7pj7fLQhugJRmVmzP0rfaTb
	 596BrIHTw/pbFLW7F39/pNYL8hWeXhwLILGF4UwU=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250305111437epcas5p1d4310e39928fbd78a049d7cc482138bf~p497_ScKQ1240812408epcas5p1C;
	Wed,  5 Mar 2025 11:14:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.3D.19956.D1238C76; Wed,  5 Mar 2025 20:14:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250305093229epcas5p477214b3cd1e48e3d862531b647d34585~p3kw3UZFW2244022440epcas5p49;
	Wed,  5 Mar 2025 09:32:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250305093229epsmtrp2f08a84e8a960b2d9e5c7947bc1061fab~p3kw2oTYy1328613286epsmtrp2N;
	Wed,  5 Mar 2025 09:32:29 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-a0-67c8321d6ad6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.36.18729.D2A18C76; Wed,  5 Mar 2025 18:32:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305093227epsmtip23e0862b1356075548972219d708d42ad~p3kvBSwTX2504625046epsmtip2L;
	Wed,  5 Mar 2025 09:32:27 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Shubham Rana <s9.rana@samsung.com>
Subject: [PATCH 1/1] fs/nfsd/nfsctl.c: fix race between nfsd registration
 and exports_proc
Date: Wed,  5 Mar 2025 15:02:22 +0530
Message-Id: <20250305093222.1051935-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7bCmhq6s0Yl0gzO/dCz+333OZDF/0WY2
	i5/LVrFbXN41h83iwoHTrBaH57exWOyd38BiMenZJ3aL748vMVqc+nWKyYHLY9OqTjaPj09v
	sXi833eVzaNvyypGj82nqz0uP7nC6PF5k1wAexSXTUpqTmZZapG+XQJXxqyfLxgL/qpV3J33
	hL2BsUuxi5GTQ0LARGL9hh62LkYuDiGB3YwSx3u3MEM4nxglZm+7xgLhfGOUmNp1kbWLkQOs
	5fZzqI69jBJHV7xhhXC+MEpMedDMBjKXTUBPYtWuPSwgtohAhcTk228YQYqYBboZJf5PPsgE
	khAWiJHYveU3WAOLgKrE/UMTGEFsXgE7ibW7upghDpSXmHnpOztEXFDi5MwnYEOZgeLNW2eD
	3Soh8JNd4ubcBjaIBheJ1tlv2SFsYYlXx7dA2VISn9/tZYN4oVxi64R6iN4WRon9c6ZA9dpL
	PLm4EOxNZgFNifW79CHCshJTT61jgtjLJ9H7+wkTRJxXYsc8GFtVouXmBlYIW1ri88ePLBCr
	PCT2rQS7QEggVuLc/inMExjlZyH5ZhaSb2YhLF7AyLyKUTK1oDg3PbXYtMA4L7Vcrzgxt7g0
	L10vOT93EyM4EWl572B89OCD3iFGJg7GQ4wSHMxKIryvTx1PF+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM7bvLMlXUggPbEkNTs1tSC1CCbLxMEp1cB0If9DhfzLo9sUVpybPU9IXU9y/fJik/sv
	s6qZb0XfuWSSIOvJGydy3U/pT0q0DAtHwR9H+cX+LZ99+tWUyrWqlhwRTUjRaH+1RrujUDSt
	cCt3pdv3r9zX13AE59y9pTbhT1J5/I/4iNNGTgeOhayt+rSsNqF5bdGBmKzV8bZFZxYLHtl3
	Z7b8lDaPz8cW7F3zda982Z1L79VjZ06ZOO/P5ej/omwZbfMrNBXSk14+Eq4Tzjp2Ly1syomU
	XG7/zxFOKSdFfq35ltAQMvWt9h+W83+efSgS6999l11m8bLoae5lz80UFJQ4GB7cvlKVtfpI
	1LMLrOs8rm6YcfNv8D6Gb99dFk2/xNV86xx71/nFSizFGYmGWsxFxYkA/LJPt7MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvK6u1Il0g7UT9S3+333OZDF/0WY2
	i5/LVrFbXN41h83iwoHTrBaH57exWOyd38BiMenZJ3aL748vMVqc+nWKyYHLY9OqTjaPj09v
	sXi833eVzaNvyypGj82nqz0uP7nC6PF5k1wAexSXTUpqTmZZapG+XQJXxqyfLxgL/qpV3J33
	hL2BsUuxi5GDQ0LAROL2c7YuRi4OIYHdjBJ/p+9j72LkBIpLS/z8954FwhaWWPnvOTtE0SdG
	ieU7PoIVsQnoSazatYcFJCEi0MAo8fjLX7BRzAL9jBJb1r5lBqkSFoiSmNtzgQ3EZhFQlbh/
	aAIjiM0rYCexdlcXM8QKeYmZl76zQ8QFJU7OfAK2mhko3rx1NvMERr5ZSFKzkKQWMDKtYpRM
	LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDmwtzR2M21d90DvEyMTBeIhRgoNZSYT39anj
	6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYtu0U+fUi
	beLLf67Xm0U9JKLffJstze1jZdvHfr+Yw6jz/vpr8zo7eY+z5UY4Sh3KatKJmRMWJpKQWGgd
	82v2/Mmz96y3Ner5bRbK592QuLe27M6FjEmGiTU/3G5cU52wj3f57t7JYh9My+ZF3JrrYKZj
	e2/ZnXrBz8+UL+iIHTv8RU7tlJ+3J7vIlliNqFm7dsW/+V5vdGMGo2i7S5dgtGz9k0cePaFF
	ByevbTZOszohINmno8pwMFrq/+nYA6pRDMv1Fy0uFK1bMdXhzJL6gFV/jc788/kUvEfuud0+
	l6JY1udy1zmYLsu2H/y4nz98ctrduRO3rwidcWzPYaOoEJMdOxWbmC7/j7jiI7lDiaU4I9FQ
	i7moOBEAZNrNc9sCAAA=
X-CMS-MailID: 20250305093229epcas5p477214b3cd1e48e3d862531b647d34585
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20250305093229epcas5p477214b3cd1e48e3d862531b647d34585
References: <CGME20250305093229epcas5p477214b3cd1e48e3d862531b647d34585@epcas5p4.samsung.com>

1) As of now nfsd calls create_proc_exports_entry() at start of init_nfsd
and cleanup by remove_proc_entry() at last of exit_nfsd.

Which causes kernel OOPS if there is race between below 2 operations:
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
exports_net_open+0x50/0x68 [nfsd]
exports_proc_open+0x2c/0x38 [nfsd]

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

With change no Kernel OOPs.

2) Also unregister of register_filesystem() was missed in case
genl_register_family() fails.
Corrected that also.

Co-developed-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Shubham Rana <s9.rana@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 fs/nfsd/nfsctl.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ac265d6fde35..d936a99ada2a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2291,12 +2291,10 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = create_proc_exports_entry();
-	if (retval)
-		goto out_free_lockd;
+
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_exports;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2305,22 +2303,28 @@ static int __init init_nfsd(void)
 		goto out_free_cld;
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
-		goto out_free_all;
+		goto out_free_nfsd4;
 	retval = genl_register_family(&nfsd_nl_family);
+	if (retval)
+		goto out_free_filesystem;
+	retval = create_proc_exports_entry();
 	if (retval)
 		goto out_free_all;
+
 	nfsd_localio_ops_init();
 
 	return 0;
+
 out_free_all:
+	genl_unregister_family(&nfsd_nl_family);
+out_free_filesystem:
+	unregister_filesystem(&nfsd_fs_type);
+out_free_nfsd4:
 	nfsd4_destroy_laundry_wq();
 out_free_cld:
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_exports:
-	remove_proc_entry("fs/nfs/exports", NULL);
-	remove_proc_entry("fs/nfs", NULL);
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2333,14 +2337,14 @@ static int __init init_nfsd(void)
 
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


