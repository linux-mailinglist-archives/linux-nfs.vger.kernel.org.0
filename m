Return-Path: <linux-nfs+bounces-10534-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA40A57E04
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 21:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688A33B306E
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Mar 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D881EFF90;
	Sat,  8 Mar 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss2CW70N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5882A8C1
	for <linux-nfs@vger.kernel.org>; Sat,  8 Mar 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464883; cv=none; b=QsTmsSAczy76WkjAWetO4gwg077OYCXIe/GKQydXdtjPeo+8CQAlmQSOOyd4mdVtML13PBRfR0vcUxwJ3radqFEZrbPbHrzbPKrDWNj0enZe2sUa+VVkS28EhX0lFo0kC7SWWggECNZua65IbzkxcJ2la9yDw7ZGtqwdzoCekJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464883; c=relaxed/simple;
	bh=pF0S4nfw9HlMk6PSfld8LUhuSbuAdDR5p9p7zntb9uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLDWF9xmSPC3wZjm966Jk/4qrFAUc5i2/0GjPoCu8UXzQRpHE2GwVXja2TBBgsqw1H5SvVFtJWz4xVOP4BLy83sBhxsg1dmwj4SpDr4gC86TyheYaSLiExuBKYSgBd6tdvvcopa7iRYACpqFXrNeH+fsYtTpgQW49SkdUk+mDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss2CW70N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0716FC4CEE7;
	Sat,  8 Mar 2025 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464882;
	bh=pF0S4nfw9HlMk6PSfld8LUhuSbuAdDR5p9p7zntb9uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ss2CW70N5XxIblkF9qVRijI2weJMgtuCPlpRkFx+Dk5gUTB0gcJvM+z6H9UyNOxtd
	 sUs7rpMeqWXbKrNtFFNVs3M563Dmc8YshbDEkTpaZ9e6KdWfGmsd8BndlEIAWtRI6w
	 QlHfXq9wGC7pIe9bHbC95uFwS7CS+LLN4ikH3tiOwq2LABV4IdJRw149GN0SSGvVsf
	 ikkx1zv55+S6uWHRiQl2C3vXmA9QEuGZnPnA2KhuGHARx0ubLa+5Ot7wFJjp2DJhcZ
	 UZ6hT+Ngv3K7Ueaytfh2OqXNGOV3ki6pdNxk2u3anenZf9R5H/heUkno11ffxBiTc5
	 JTYvr3jh31Zjw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Add /sys/kernel/debug/nfsd
Date: Sat,  8 Mar 2025 15:14:37 -0500
Message-ID: <20250308201438.2217-2-cel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308201438.2217-1-cel@kernel.org>
References: <20250308201438.2217-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Create a small sandbox under /sys/kernel/debug for experimental NFS
server feature settings. There is no API/ABI compatibility guarantee
for these settings.

The only documentation for such settings, if any documentation exists,
is in the kernel source code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Makefile  |  1 +
 fs/nfsd/debugfs.c | 18 ++++++++++++++++++
 fs/nfsd/nfsctl.c  |  4 ++++
 fs/nfsd/nfsd.h    |  8 ++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 fs/nfsd/debugfs.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 2f687619f65b..55744bb786c9 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -24,6 +24,7 @@ nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
 nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
+nfsd-$(CONFIG_DEBUG_FS) += debugfs.o
 
 
 .PHONY: xdrgen
diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
new file mode 100644
index 000000000000..e913268d9c2d
--- /dev/null
+++ b/fs/nfsd/debugfs.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+
+#include "nfsd.h"
+
+static struct dentry *nfsd_top_dir __read_mostly;
+
+void nfsd_debugfs_exit(void)
+{
+	debugfs_remove_recursive(nfsd_top_dir);
+	nfsd_top_dir = NULL;
+}
+
+void nfsd_debugfs_init(void)
+{
+	nfsd_top_dir = debugfs_create_dir("nfsd", NULL);
+}
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ce2a71e4904c..1919eafe500a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2276,6 +2276,8 @@ static int __init init_nfsd(void)
 {
 	int retval;
 
+	nfsd_debugfs_init();
+
 	retval = nfsd4_init_slabs();
 	if (retval)
 		return retval;
@@ -2323,6 +2325,7 @@ static int __init init_nfsd(void)
 	nfsd4_exit_pnfs();
 out_free_slabs:
 	nfsd4_free_slabs();
+	nfsd_debugfs_exit();
 	return retval;
 }
 
@@ -2339,6 +2342,7 @@ static void __exit exit_nfsd(void)
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
+	nfsd_debugfs_exit();
 }
 
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e2997f0ffbc5..8a53ddab5df0 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -156,6 +156,14 @@ void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
 void nfsd_destroy_serv(struct net *net);
 
+#ifdef CONFIG_DEBUG_FS
+void nfsd_debugfs_init(void);
+void nfsd_debugfs_exit(void);
+#else
+static inline void nfsd_debugfs_init(void) {}
+static inline void nfsd_debugfs_exit(void) {}
+#endif
+
 extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
-- 
2.48.1


