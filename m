Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE41292F22
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgJSUHx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 16:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJSUHx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:07:53 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B00E223BF;
        Mon, 19 Oct 2020 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603138072;
        bh=cgrozDlS18uUWHQbhKg4LtQ89oDU0R79IgAi9RatH3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jf0IWkARylEWxhrKF8TUQ+A+lstfeaLOyRF259eAFyuy785Q0wpi33dysf+a9UlZQ
         BYKpJIEzIQbaTLB2s3H1SpHCCOdVf9YM6RxIX0DfKE2MhDQC7gKDPRWSQkFYzrnQE8
         Z8Yfyosf/zdkK2k3KzoRVOMRPMs1QcSdRJbLJpOU=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSv3: Refactor nfs3_proc_lookup() to split out the dentry
Date:   Mon, 19 Oct 2020 16:05:42 -0400
Message-Id: <20201019200543.606847-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019200543.606847-1-trondmy@kernel.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <20201019200543.606847-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We want to reuse the lookup code in NFSv3 in order to emulate the
NFSv4 lookupp operation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3proc.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2397ceedba8a..acbdf7496d31 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -154,14 +154,14 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int
-nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
-		 struct nfs_fh *fhandle, struct nfs_fattr *fattr,
-		 struct nfs4_label *label)
+__nfs3_proc_lookup(struct inode *dir, const char *name, size_t len,
+		   struct nfs_fh *fhandle, struct nfs_fattr *fattr,
+		   unsigned short task_flags)
 {
 	struct nfs3_diropargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= dentry->d_name.name,
-		.len		= dentry->d_name.len
+		.name		= name,
+		.len		= len
 	};
 	struct nfs3_diropres	res = {
 		.fh		= fhandle,
@@ -173,17 +173,11 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 		.rpc_resp	= &res,
 	};
 	int			status;
-	unsigned short task_flags = 0;
-
-	/* Is this is an attribute revalidation, subject to softreval? */
-	if (nfs_lookup_is_soft_revalidate(dentry))
-		task_flags |= RPC_TASK_TIMEOUT;
 
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
 		return -ENOMEM;
 
-	dprintk("NFS call  lookup %pd2\n", dentry);
 	nfs_fattr_init(fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, task_flags);
 	nfs_refresh_inode(dir, res.dir_attr);
@@ -198,6 +192,23 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 	return status;
 }
 
+static int
+nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
+		 struct nfs_fh *fhandle, struct nfs_fattr *fattr,
+		 struct nfs4_label *label)
+{
+	unsigned short task_flags = 0;
+
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (nfs_lookup_is_soft_revalidate(dentry))
+		task_flags |= RPC_TASK_TIMEOUT;
+
+	dprintk("NFS call  lookup %pd2\n", dentry);
+	return __nfs3_proc_lookup(dir, dentry->d_name.name,
+				  dentry->d_name.len, fhandle, fattr,
+				  task_flags);
+}
+
 static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
 {
 	struct nfs3_accessargs	arg = {
-- 
2.26.2

