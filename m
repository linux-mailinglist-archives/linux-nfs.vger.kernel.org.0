Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231692AC3DA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgKISa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 13:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKISa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 13:30:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3053C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 10:30:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id BE287448D; Mon,  9 Nov 2020 13:30:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BE287448D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604946654;
        bh=tJBbxDR0Q6CaqdXuTSn7vtGU+KO8nRm0Q7ND85ADSE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYsFfICriqL3JfOusxp0maZLFr7xVgaquPAhO1zWw3Flr7IBgrcx1h66zXB4VmA7P
         mN/EzdgPPD+oz18Fizewl0+EidOO1+yHtWqJjL0ckrQu8vsCuY8lN1gzrh5ST8p3mr
         AoGxOcUN4vH7splMOvPMPdHsuVp9pYFwU0kg5NxI=
Date:   Mon, 9 Nov 2020 13:30:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter
 server copy
Message-ID: <20201109183054.GD11144@fieldses.org>
References: <20201019034249.27990-1-dai.ngo@oracle.com>
 <20201020170114.GF1133@fieldses.org>
 <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb514565-cd47-9180-2adc-f3ba4459202b@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 20, 2020 at 11:34:35AM -0700, Dai Ngo wrote:
> 
> On 10/20/20 10:01 AM, J. Bruce Fields wrote:
> >On Sun, Oct 18, 2020 at 11:42:49PM -0400, Dai Ngo wrote:
> >>NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
> >>build errors and some configs with NFSD=m to get NFS4ERR_STALE
> >>error when doing inter server copy.
> >>
> >>Added ops table in nfs_common for knfsd to access NFS client modules.
> >OK, looks reasonable to me, applying.  Does this resolve all the
> >problems you've seen, or is there any bad case left?
> 
> Thanks Bruce.
> 
> With this patch, I no longer see the NFS4ERR_STALE in any config.
> 
> The problem with NFS4ERR_STALE was because of a bug in nfs42_ssc_open.
> When CONFIG_NFSD_V4_2_INTER_SSC is not defined, nfs42_ssc_open
> returns NULL which is incorrect allowing the operation to continue
> until nfsd4_putfh which does not have the code to handle nfserr_stale.
> 
> With this patch, when CONFIG_NFSD_V4_2_INTER_SSC is not defined the
> new nfs42_ssc_open returns ERR_PTR(-EIO) which causes the NFS client
> to switch over to the split copying (read src and write to dst).

That sounds reasonable, but I don't see any of the patches you've sent
changing that error return.  Did I overlook something, or did you mean
to append a patch to this message?

--b.

> 
> The other problem that I see was the "use-after-free" which I think
> happens only on the 1st inter server copy. I will look into this:
> 
> 
>  Sep 23 01:08:10 nfsvmf24 kernel: ------------[ cut here ]------------
> Sep 23 01:08:10 nfsvmf24 kernel: refcount_t: underflow; use-after-free.
> Sep 23 01:08:10 nfsvmf24 kernel: WARNING: CPU: 0 PID: 4217 at lib/refcount.c:28 refcount_warn_saturate+0xae/0xf0
> Sep 23 01:08:10 nfsvmf24 kernel: Modules linked in: cts rpcsec_gss_krb5 xt_REDIRECT xt_nat ip6table_nat ip6_tables iptable_nat nf_nat nf_conntrack btrfs nf_defrag_ipv6 nf_defrag_ipv4 blake2b_generic xor zstd_compress rfkill raid6_pq sb_edac intel_powerclamp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper sg pcspkr i2c_piix4 video ip_tables xfs libcrc32c sd_mod t10_pi ahci libahci libata e1000 crc32c_intel serio_raw dm_mirror dm_region_hash dm_log dm_mod
> Sep 23 01:08:10 nfsvmf24 kernel: CPU: 0 PID: 4217 Comm: copy thread Not tainted 5.9.0-rc5+ #14
> Sep 23 01:08:10 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Sep 23 01:08:10 nfsvmf24 kernel: RIP: 0010:refcount_warn_saturate+0xae/0xf0
> Sep 23 01:08:10 nfsvmf24 kernel: Code: 99 83 31 01 01 e8 27 ba b6 ff 0f 0b 5d c3 80 3d 86 83 31 01 00 75 91 48 c7 c7 20 d3 3a 84 c6 05 76 83 31 01 01 e8 07 ba b6 ff <0f> 0b 5d c3 80 3d 64 83 31 01 00 0f 85 6d ff ff ff 48 c7 c7 78 d3
> Sep 23 01:08:10 nfsvmf24 kernel: RSP: 0000:ffffc20300403e68 EFLAGS: 00010286
> Sep 23 01:08:10 nfsvmf24 kernel: RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000027
> Sep 23 01:08:10 nfsvmf24 kernel: RDX: 0000000000000027 RSI: 0000000000000086 RDI: ffff9e8c97c18c48
> Sep 23 01:08:10 nfsvmf24 kernel: RBP: ffffc20300403e68 R08: ffff9e8c97c18c40 R09: 0000000000000004
> Sep 23 01:08:10 nfsvmf24 kernel: R10: 0000000000000000 R11: 0000000000000001 R12: ffff9e8c96693300
> Sep 23 01:08:10 nfsvmf24 kernel: R13: ffff9e8c96693300 R14: ffff9e8c8a6e3000 R15: ffff9e8c959c5520
> Sep 23 01:08:10 nfsvmf24 kernel: FS:  0000000000000000(0000) GS:ffff9e8c97c00000(0000) knlGS:0000000000000000
> Sep 23 01:08:10 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Sep 23 01:08:10 nfsvmf24 kernel: CR2: 000055aedfd031a8 CR3: 000000020ee6e000 CR4: 00000000000406f0
> Sep 23 01:08:10 nfsvmf24 kernel: Call Trace:
> Sep 23 01:08:10 nfsvmf24 kernel: nfsd_file_put_noref+0x8f/0xa0
> Sep 23 01:08:10 nfsvmf24 kernel: nfsd_file_put+0x3e/0x90
> Sep 23 01:08:10 nfsvmf24 kernel: nfsd4_do_copy+0xe5/0x150
> Sep 23 01:08:10 nfsvmf24 kernel: nfsd4_do_async_copy+0x84/0x200
> Sep 23 01:08:10 nfsvmf24 kernel: kthread+0x114/0x150
> Sep 23 01:08:10 nfsvmf24 kernel: ? nfsd4_copy+0x4e0/0x4e0
> Sep 23 01:08:10 nfsvmf24 kernel: ? kthread_park+0x90/0x90
> Sep 23 01:08:10 nfsvmf24 kernel: ret_from_fork+0x22/0x30
> 
> -Dai
> 
> >
> >--b.
> >
> >>Fixes: 3ac3711adb88 ("NFSD: Fix NFS server build errors")
> >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>---
> >>changes from v2: fix 0-day build issues.
> >>changes from v3: reacted to Bruce's comments, removed paranoid error checking.
> >>---
> >>  fs/nfs/nfs4file.c       | 38 ++++++++++++++++----
> >>  fs/nfs/nfs4super.c      |  5 +++
> >>  fs/nfs/super.c          | 17 +++++++++
> >>  fs/nfs_common/Makefile  |  1 +
> >>  fs/nfs_common/nfs_ssc.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  fs/nfsd/Kconfig         |  2 +-
> >>  fs/nfsd/nfs4proc.c      |  3 +-
> >>  include/linux/nfs_ssc.h | 67 +++++++++++++++++++++++++++++++++++
> >>  8 files changed, 219 insertions(+), 8 deletions(-)
> >>  create mode 100644 fs/nfs_common/nfs_ssc.c
> >>  create mode 100644 include/linux/nfs_ssc.h
> >>
> >>diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> >>index fdfc77486ace..984938024011 100644
> >>--- a/fs/nfs/nfs4file.c
> >>+++ b/fs/nfs/nfs4file.c
> >>@@ -9,6 +9,7 @@
> >>  #include <linux/falloc.h>
> >>  #include <linux/mount.h>
> >>  #include <linux/nfs_fs.h>
> >>+#include <linux/nfs_ssc.h>
> >>  #include "delegation.h"
> >>  #include "internal.h"
> >>  #include "iostat.h"
> >>@@ -314,9 +315,8 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
> >>  static int read_name_gen = 1;
> >>  #define SSC_READ_NAME_BODY "ssc_read_%d"
> >>-struct file *
> >>-nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
> >>-		nfs4_stateid *stateid)
> >>+static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
> >>+		struct nfs_fh *src_fh, nfs4_stateid *stateid)
> >>  {
> >>  	struct nfs_fattr fattr;
> >>  	struct file *filep, *res;
> >>@@ -398,14 +398,40 @@ struct file *
> >>  	fput(filep);
> >>  	goto out_free_name;
> >>  }
> >>-EXPORT_SYMBOL_GPL(nfs42_ssc_open);
> >>-void nfs42_ssc_close(struct file *filep)
> >>+
> >>+static void __nfs42_ssc_close(struct file *filep)
> >>  {
> >>  	struct nfs_open_context *ctx = nfs_file_open_context(filep);
> >>  	ctx->state->flags = 0;
> >>  }
> >>-EXPORT_SYMBOL_GPL(nfs42_ssc_close);
> >>+
> >>+static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
> >>+	.sco_open = __nfs42_ssc_open,
> >>+	.sco_close = __nfs42_ssc_close,
> >>+};
> >>+
> >>+/**
> >>+ * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
> >>+ *
> >>+ * Return values:
> >>+ *   None
> >>+ */
> >>+void nfs42_ssc_register_ops(void)
> >>+{
> >>+	nfs42_ssc_register(&nfs4_ssc_clnt_ops_tbl);
> >>+}
> >>+
> >>+/**
> >>+ * nfs42_ssc_unregister_ops - wrapper to un-register NFS_V4 ops in nfs_common
> >>+ *
> >>+ * Return values:
> >>+ *   None.
> >>+ */
> >>+void nfs42_ssc_unregister_ops(void)
> >>+{
> >>+	nfs42_ssc_unregister(&nfs4_ssc_clnt_ops_tbl);
> >>+}
> >>  #endif /* CONFIG_NFS_V4_2 */
> >>  const struct file_operations nfs4_file_operations = {
> >>diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> >>index 0c1ab846b83d..93f5c1678ec2 100644
> >>--- a/fs/nfs/nfs4super.c
> >>+++ b/fs/nfs/nfs4super.c
> >>@@ -7,6 +7,7 @@
> >>  #include <linux/mount.h>
> >>  #include <linux/nfs4_mount.h>
> >>  #include <linux/nfs_fs.h>
> >>+#include <linux/nfs_ssc.h>
> >>  #include "delegation.h"
> >>  #include "internal.h"
> >>  #include "nfs4_fs.h"
> >>@@ -279,6 +280,9 @@ static int __init init_nfs_v4(void)
> >>  	if (err)
> >>  		goto out2;
> >>+#ifdef CONFIG_NFS_V4_2
> >>+	nfs42_ssc_register_ops();
> >>+#endif
> >>  	register_nfs_version(&nfs_v4);
> >>  	return 0;
> >>  out2:
> >>@@ -297,6 +301,7 @@ static void __exit exit_nfs_v4(void)
> >>  	unregister_nfs_version(&nfs_v4);
> >>  #ifdef CONFIG_NFS_V4_2
> >>  	nfs4_xattr_cache_exit();
> >>+	nfs42_ssc_unregister_ops();
> >>  #endif
> >>  	nfs4_unregister_sysctl();
> >>  	nfs_idmap_quit();
> >>diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> >>index 7a70287f21a2..f7dad8227a5f 100644
> >>--- a/fs/nfs/super.c
> >>+++ b/fs/nfs/super.c
> >>@@ -57,6 +57,7 @@
> >>  #include <linux/rcupdate.h>
> >>  #include <linux/uaccess.h>
> >>+#include <linux/nfs_ssc.h>
> >>  #include "nfs4_fs.h"
> >>  #include "callback.h"
> >>@@ -85,6 +86,10 @@
> >>  };
> >>  EXPORT_SYMBOL_GPL(nfs_sops);
> >>+static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
> >>+	.sco_sb_deactive = nfs_sb_deactive,
> >>+};
> >>+
> >>  #if IS_ENABLED(CONFIG_NFS_V4)
> >>  static int __init register_nfs4_fs(void)
> >>  {
> >>@@ -106,6 +111,16 @@ static void unregister_nfs4_fs(void)
> >>  }
> >>  #endif
> >>+static void nfs_ssc_register_ops(void)
> >>+{
> >>+	nfs_ssc_register(&nfs_ssc_clnt_ops_tbl);
> >>+}
> >>+
> >>+static void nfs_ssc_unregister_ops(void)
> >>+{
> >>+	nfs_ssc_unregister(&nfs_ssc_clnt_ops_tbl);
> >>+}
> >>+
> >>  static struct shrinker acl_shrinker = {
> >>  	.count_objects	= nfs_access_cache_count,
> >>  	.scan_objects	= nfs_access_cache_scan,
> >>@@ -133,6 +148,7 @@ int __init register_nfs_fs(void)
> >>  	ret = register_shrinker(&acl_shrinker);
> >>  	if (ret < 0)
> >>  		goto error_3;
> >>+	nfs_ssc_register_ops();
> >>  	return 0;
> >>  error_3:
> >>  	nfs_unregister_sysctl();
> >>@@ -152,6 +168,7 @@ void __exit unregister_nfs_fs(void)
> >>  	unregister_shrinker(&acl_shrinker);
> >>  	nfs_unregister_sysctl();
> >>  	unregister_nfs4_fs();
> >>+	nfs_ssc_unregister_ops();
> >>  	unregister_filesystem(&nfs_fs_type);
> >>  }
> >>diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> >>index 4bebe834c009..fa82f5aaa6d9 100644
> >>--- a/fs/nfs_common/Makefile
> >>+++ b/fs/nfs_common/Makefile
> >>@@ -7,3 +7,4 @@ obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
> >>  nfs_acl-objs := nfsacl.o
> >>  obj-$(CONFIG_GRACE_PERIOD) += grace.o
> >>+obj-$(CONFIG_GRACE_PERIOD) += nfs_ssc.o
> >>diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
> >>new file mode 100644
> >>index 000000000000..f43bbb373913
> >>--- /dev/null
> >>+++ b/fs/nfs_common/nfs_ssc.c
> >>@@ -0,0 +1,94 @@
> >>+// SPDX-License-Identifier: GPL-2.0-only
> >>+/*
> >>+ * fs/nfs_common/nfs_ssc_comm.c
> >>+ *
> >>+ * Helper for knfsd's SSC to access ops in NFS client modules
> >>+ *
> >>+ * Author: Dai Ngo <dai.ngo@oracle.com>
> >>+ *
> >>+ * Copyright (c) 2020, Oracle and/or its affiliates.
> >>+ */
> >>+
> >>+#include <linux/module.h>
> >>+#include <linux/fs.h>
> >>+#include <linux/nfs_ssc.h>
> >>+#include "../nfs/nfs4_fs.h"
> >>+
> >>+MODULE_LICENSE("GPL");
> >>+
> >>+struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
> >>+EXPORT_SYMBOL_GPL(nfs_ssc_client_tbl);
> >>+
> >>+#ifdef CONFIG_NFS_V4_2
> >>+/**
> >>+ * nfs42_ssc_register - install the NFS_V4 client ops in the nfs_ssc_client_tbl
> >>+ * @ops: NFS_V4 ops to be installed
> >>+ *
> >>+ * Return values:
> >>+ *   None
> >>+ */
> >>+void nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops)
> >>+{
> >>+	nfs_ssc_client_tbl.ssc_nfs4_ops = ops;
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs42_ssc_register);
> >>+
> >>+/**
> >>+ * nfs42_ssc_unregister - uninstall the NFS_V4 client ops from
> >>+ *				the nfs_ssc_client_tbl
> >>+ * @ops: ops to be uninstalled
> >>+ *
> >>+ * Return values:
> >>+ *   None
> >>+ */
> >>+void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops)
> >>+{
> >>+	if (nfs_ssc_client_tbl.ssc_nfs4_ops != ops)
> >>+		return;
> >>+
> >>+	nfs_ssc_client_tbl.ssc_nfs4_ops = NULL;
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs42_ssc_unregister);
> >>+#endif /* CONFIG_NFS_V4_2 */
> >>+
> >>+#ifdef CONFIG_NFS_V4_2
> >>+/**
> >>+ * nfs_ssc_register - install the NFS_FS client ops in the nfs_ssc_client_tbl
> >>+ * @ops: NFS_FS ops to be installed
> >>+ *
> >>+ * Return values:
> >>+ *   None
> >>+ */
> >>+void nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
> >>+{
> >>+	nfs_ssc_client_tbl.ssc_nfs_ops = ops;
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs_ssc_register);
> >>+
> >>+/**
> >>+ * nfs_ssc_unregister - uninstall the NFS_FS client ops from
> >>+ *				the nfs_ssc_client_tbl
> >>+ * @ops: ops to be uninstalled
> >>+ *
> >>+ * Return values:
> >>+ *   None
> >>+ */
> >>+void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
> >>+{
> >>+	if (nfs_ssc_client_tbl.ssc_nfs_ops != ops)
> >>+		return;
> >>+	nfs_ssc_client_tbl.ssc_nfs_ops = NULL;
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
> >>+
> >>+#else
> >>+void nfs_ssc_register(const struct nfs_ssc_client_ops *ops)
> >>+{
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs_ssc_register);
> >>+
> >>+void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops)
> >>+{
> >>+}
> >>+EXPORT_SYMBOL_GPL(nfs_ssc_unregister);
> >>+#endif /* CONFIG_NFS_V4_2 */
> >>diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> >>index 99d2cae91bd6..f368f3215f88 100644
> >>--- a/fs/nfsd/Kconfig
> >>+++ b/fs/nfsd/Kconfig
> >>@@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
> >>  config NFSD_V4_2_INTER_SSC
> >>  	bool "NFSv4.2 inter server to server COPY"
> >>-	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
> >>+	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
> >>  	help
> >>  	  This option enables support for NFSv4.2 inter server to
> >>  	  server copy where the destination server calls the NFSv4.2
> >>diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>index eaf50eafa935..84e10aef1417 100644
> >>--- a/fs/nfsd/nfs4proc.c
> >>+++ b/fs/nfsd/nfs4proc.c
> >>@@ -38,6 +38,7 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/kthread.h>
> >>  #include <linux/sunrpc/addr.h>
> >>+#include <linux/nfs_ssc.h>
> >>  #include "idmap.h"
> >>  #include "cache.h"
> >>@@ -1247,7 +1248,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> >>  static void
> >>  nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> >>  {
> >>-	nfs_sb_deactive(ss_mnt->mnt_sb);
> >>+	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> >>  	mntput(ss_mnt);
> >>  }
> >>diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> >>new file mode 100644
> >>index 000000000000..f5ba0fbff72f
> >>--- /dev/null
> >>+++ b/include/linux/nfs_ssc.h
> >>@@ -0,0 +1,67 @@
> >>+/* SPDX-License-Identifier: GPL-2.0 */
> >>+/*
> >>+ * include/linux/nfs_ssc.h
> >>+ *
> >>+ * Author: Dai Ngo <dai.ngo@oracle.com>
> >>+ *
> >>+ * Copyright (c) 2020, Oracle and/or its affiliates.
> >>+ */
> >>+
> >>+#include <linux/nfs_fs.h>
> >>+
> >>+extern struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
> >>+
> >>+/*
> >>+ * NFS_V4
> >>+ */
> >>+struct nfs4_ssc_client_ops {
> >>+	struct file *(*sco_open)(struct vfsmount *ss_mnt,
> >>+		struct nfs_fh *src_fh, nfs4_stateid *stateid);
> >>+	void (*sco_close)(struct file *filep);
> >>+};
> >>+
> >>+/*
> >>+ * NFS_FS
> >>+ */
> >>+struct nfs_ssc_client_ops {
> >>+	void (*sco_sb_deactive)(struct super_block *sb);
> >>+};
> >>+
> >>+struct nfs_ssc_client_ops_tbl {
> >>+	const struct nfs4_ssc_client_ops *ssc_nfs4_ops;
> >>+	const struct nfs_ssc_client_ops *ssc_nfs_ops;
> >>+};
> >>+
> >>+extern void nfs42_ssc_register_ops(void);
> >>+extern void nfs42_ssc_unregister_ops(void);
> >>+
> >>+extern void nfs42_ssc_register(const struct nfs4_ssc_client_ops *ops);
> >>+extern void nfs42_ssc_unregister(const struct nfs4_ssc_client_ops *ops);
> >>+
> >>+#ifdef CONFIG_NFSD_V4_2_INTER_SSC
> >>+static inline struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> >>+		struct nfs_fh *src_fh, nfs4_stateid *stateid)
> >>+{
> >>+	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> >>+		return (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_open)(ss_mnt, src_fh, stateid);
> >>+	return ERR_PTR(-EIO);
> >>+}
> >>+
> >>+static inline void nfs42_ssc_close(struct file *filep)
> >>+{
> >>+	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> >>+		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
> >>+}
> >>+#endif
> >>+
> >>+/*
> >>+ * NFS_FS
> >>+ */
> >>+extern void nfs_ssc_register(const struct nfs_ssc_client_ops *ops);
> >>+extern void nfs_ssc_unregister(const struct nfs_ssc_client_ops *ops);
> >>+
> >>+static inline void nfs_do_sb_deactive(struct super_block *sb)
> >>+{
> >>+	if (nfs_ssc_client_tbl.ssc_nfs_ops)
> >>+		(*nfs_ssc_client_tbl.ssc_nfs_ops->sco_sb_deactive)(sb);
> >>+}
> >>-- 
> >>1.8.3.1
