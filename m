Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2591838B46D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhETQk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhETQk1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 12:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6EC6101E
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528745;
        bh=KBF+FLUXN2OcriIanNDgUkOdv6lzu8V/J/I4A1WxEKE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TqAHJfBDz/ALp9p/X5zwexjtzHLcZqi40LhlrzamQ2GOIr8dXD4NcqCLbBfl8yN92
         7Cok8C41l5Hs/2HNPXytTkkIGELeH0PRMTimmYQvJqeSHmBUWnvBlaTgcj3mt56EoS
         Fp+o+jtbQ7iv0mf6ww1I2fpo+Tj2fZ1kVYrcy/RgtTD0GKE/VeQ9ChXHlc8aOEjMXv
         QXhTWqr5glezXyVfyFzkpGmMioijvVK+sgZXW1puudWABKN1cc8LIff9K11bBXggl7
         Rt+mBoZpQi2ur3DfpNFt1ETlGF1vunUR/zXt65vnSrB2dPjFMUh02kkHq41PILV9P0
         NY0vR5hl2Ug1w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFSv4: Add support for application leases underpinned by a delegation
Date:   Thu, 20 May 2021 12:39:01 -0400
Message-Id: <20210520163902.215745-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520163902.215745-3-trondmy@kernel.org>
References: <20210520163902.215745-1-trondmy@kernel.org>
 <20210520163902.215745-2-trondmy@kernel.org>
 <20210520163902.215745-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFSv4 client already holds a delegation for a file, then we can
support application leases (i.e. fcntl(fd, F_SETLEASE,...)) because the
underlying delegation guarantees that the file is not being modified on
the server by another client in a way that might conflict with the lease
guarantees.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h  |  3 ++-
 fs/nfs/nfs4file.c |  8 +++++++-
 fs/nfs/nfs4proc.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4c44322c2643..6a04ba9e5e6a 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -322,7 +322,8 @@ extern int update_open_stateid(struct nfs4_state *state,
 				const nfs4_stateid *open_stateid,
 				const nfs4_stateid *deleg_stateid,
 				fmode_t fmode);
-
+extern int nfs4_proc_setlease(struct file *file, long arg,
+			      struct file_lock **lease, void **priv);
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
 extern void nfs4_update_changeattr(struct inode *dir,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..aafb77f9bfdf 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -435,6 +435,12 @@ void nfs42_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
+static int nfs4_setlease(struct file *file, long arg, struct file_lock **lease,
+			 void **priv)
+{
+	return nfs4_proc_setlease(file, arg, lease, priv);
+}
+
 const struct file_operations nfs4_file_operations = {
 	.read_iter	= nfs_file_read,
 	.write_iter	= nfs_file_write,
@@ -448,7 +454,7 @@ const struct file_operations nfs4_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
-	.setlease	= simple_nosetlease,
+	.setlease	= nfs4_setlease,
 #ifdef CONFIG_NFS_V4_2
 	.copy_file_range = nfs4_copy_file_range,
 	.llseek		= nfs4_file_llseek,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0cd965882232..e1abd024a492 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7420,6 +7420,43 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	return nfs4_retry_setlk(state, cmd, request);
 }
 
+static int nfs4_delete_lease(struct file *file, void **priv)
+{
+	return generic_setlease(file, F_UNLCK, NULL, priv);
+}
+
+static int nfs4_add_lease(struct file *file, long arg, struct file_lock **lease,
+			  void **priv)
+{
+	struct inode *inode = file_inode(file);
+	fmode_t type = arg == F_RDLCK ? FMODE_READ : FMODE_WRITE;
+	int ret;
+
+	/* No delegation, no lease */
+	if (!nfs4_have_delegation(inode, type))
+		return -ENOLCK;
+	ret = generic_setlease(file, arg, lease, priv);
+	if (ret || nfs4_have_delegation(inode, type))
+		return ret;
+	/* We raced with a delegation return */
+	nfs4_delete_lease(file, priv);
+	return -ENOLCK;
+}
+
+int nfs4_proc_setlease(struct file *file, long arg, struct file_lock **lease,
+		       void **priv)
+{
+	switch (arg) {
+	case F_RDLCK:
+	case F_WRLCK:
+		return nfs4_add_lease(file, arg, lease, priv);
+	case F_UNLCK:
+		return nfs4_delete_lease(file, priv);
+	default:
+		return -EINVAL;
+	}
+}
+
 int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state, const nfs4_stateid *stateid)
 {
 	struct nfs_server *server = NFS_SERVER(state->inode);
-- 
2.31.1

