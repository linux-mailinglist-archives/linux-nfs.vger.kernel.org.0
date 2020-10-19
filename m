Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B2292D35
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgJSRzv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 13:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgJSRzv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Oct 2020 13:55:51 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7802C22276;
        Mon, 19 Oct 2020 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603130150;
        bh=kzf1R9mZzvhB5acCKaCgu6TVdwehnQOvJGWaDELDaUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+ah/iGS3pUhIyEPsqrPAXKjCq+YU42U1HPWHS3vLCIopXMhYdp1IbvZOh0IpY47W
         /9xjXiMQlAo4dME8MLPA2By2ADsiUI2+5bmy5DgQ0zOQk0QupK0L3dTCDCOd1IWk+B
         wMkzZN+adlw80kYuPcJ92HEA2RBTZQOGidMZFbx0=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv3: Add emulation of the lookupp() operation
Date:   Mon, 19 Oct 2020 13:53:30 -0400
Message-Id: <20201019175330.595894-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019175330.595894-2-trondmy@kernel.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <20201019175330.595894-1-trondmy@kernel.org>
 <20201019175330.595894-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to use the open_by_filehandle() operations on NFSv3, we need
to be able to emulate lookupp() so that nfs_get_parent() can be used
to convert disconnected dentries into connected ones.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3proc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a6a222435e9b..63d1979933f3 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -155,7 +155,8 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 
 static int
 __nfs3_proc_lookup(struct inode *dir, const char *name, size_t len,
-		   struct nfs_fh *fhandle, struct nfs_fattr *fattr)
+		   struct nfs_fh *fhandle, struct nfs_fattr *fattr,
+		   unsigned short task_flags)
 {
 	struct nfs3_diropargs	arg = {
 		.fh		= NFS_FH(dir),
@@ -172,7 +173,6 @@ __nfs3_proc_lookup(struct inode *dir, const char *name, size_t len,
 		.rpc_resp	= &res,
 	};
 	int			status;
-	unsigned short task_flags = 0;
 
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
@@ -197,13 +197,25 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 		 struct nfs_fh *fhandle, struct nfs_fattr *fattr,
 		 struct nfs4_label *label)
 {
+	unsigned short task_flags = 0;
+
 	/* Is this is an attribute revalidation, subject to softreval? */
 	if (nfs_lookup_is_soft_revalidate(dentry))
 		task_flags |= RPC_TASK_TIMEOUT;
 
 	dprintk("NFS call  lookup %pd2\n", dentry);
 	return __nfs3_proc_lookup(dir, dentry->d_name.name,
-				  dentry->d_name.len, fhandle, fattr);
+				  dentry->d_name.len, fhandle, fattr,
+				  task_flags);
+}
+
+static int nfs3_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
+			     struct nfs_fattr *fattr, struct nfs4_label *label)
+{
+	const char *dotdot = "..";
+	const size_t len = sizeof(dotdot) - 1;
+
+	return __nfs3_proc_lookup(inode, dotdot, len, fhandle, fattr, 0);
 }
 
 static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
@@ -1012,6 +1024,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
 	.lookup		= nfs3_proc_lookup,
+	.lookupp	= nfs3_proc_lookupp,
 	.access		= nfs3_proc_access,
 	.readlink	= nfs3_proc_readlink,
 	.create		= nfs3_proc_create,
-- 
2.26.2

