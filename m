Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5146F452
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhLIT5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLIT5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:15 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B18C061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:42 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id c3so7980938iob.6
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHl02dwAYkBDWZNRlGpbllrmkJ9HL+wOCoOLgYoToWA=;
        b=ZSwbCaxG2Guk4BUP+ZRkmMBnf4PYNJvIKg7FNyoft/tzUjfFOoLkEji4/bGD33rSxU
         7Tp5fITmWGfk/u25vYIQcoJNnb9hi/VaEAbDsxEt/c2qIqm8BxuClaol+ACrGcQHV/Or
         CkdwqhTcJbxKzJBGUByUtzyRwId+84dXyNhKoyIOny3bNUu+9fvQy+sm/WF8/l+Rz3FJ
         go5R2wXLyCC5ruzpgy1D0Q72cfezHJaJ+Fg8pnxCuldxtpzHgPsmtVrMa0a65Bu4dvB9
         g4sFNMpdE8uHjVH1VZfjZDd6MKrfOMNLQfizzNLose9O3AFN8Y9AvWa82pXQlxRhSdpH
         IjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHl02dwAYkBDWZNRlGpbllrmkJ9HL+wOCoOLgYoToWA=;
        b=7dh9ssEjLOAiOUolJZSB71IFEVLud9aGWv96y2QWQ5Ek6zy/UJ5gmRsU4ESHzy3hxI
         00jUDv+CBqAG/blm8ZpbAxyMLLdzHIlw8tOOcAWVc2eFHSBTqQ85FFdqrGDSR6yH0KVo
         8Y8hbANl2MIEh9lybw3LY6GLE2YEpZcuxMCY+Ih40evqme8GHXD+pMbiw1+abI7a99OT
         a9RoRL6cm+Ow5K6SakKiHBmXuuSgaf5iEhARsCI1FB2KGNYW8j3+XnzNG+NisGgaAPGx
         z6bXtC+4mB3QFec7a6sXsu2lx3kschp9us2I0h+Crhrgri6jd+0o2VJ7tkF8pYyDLRLe
         xX5g==
X-Gm-Message-State: AOAM532IaO6SDSSZPGxrKrgiMSSaeXKYvsBWW9e6HinBCL3E/WzIKQil
        V5Eb+g2mxdsNGmqS1mBomfJ0C1mMvbg=
X-Google-Smtp-Source: ABdhPJyyeDvnIaok2uVBg1MgpbV6C0rOJok6juRvwG/Q8jjP7t+qMmoVPoKZHUWkOE8DJ7PGVYH84Q==
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr11560046jap.145.1639079621363;
        Thu, 09 Dec 2021 11:53:41 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:40 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] NFSv4.1 query for fs_location attr on a new file system
Date:   Thu,  9 Dec 2021 14:53:31 -0500
Message-Id: <20211209195335.32404-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Query the server for other possible trunkable locations for a given
file system on a 4.1+ mount.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c         |  7 ++++
 fs/nfs/nfs4_fs.h        |  9 ++---
 fs/nfs/nfs4proc.c       | 75 +++++++++++++++++++++++++++++++++++------
 fs/nfs/nfs4state.c      |  3 +-
 include/linux/nfs_xdr.h |  1 +
 5 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 1e4dc1ab9312..f7e39cc4472b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -860,6 +860,13 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 			server->namelen = pathinfo.max_namelen;
 	}
 
+	if (clp->rpc_ops->discover_trunking != NULL &&
+			(server->caps & NFS_CAP_FS_LOCATIONS)) {
+		error = clp->rpc_ops->discover_trunking(server, mntfh);
+		if (error < 0)
+			return error;
+	}
+
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index ed5eaca6801e..2402a3d8ba99 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -260,8 +260,8 @@ struct nfs4_state_maintenance_ops {
 };
 
 struct nfs4_mig_recovery_ops {
-	int (*get_locations)(struct inode *, struct nfs4_fs_locations *,
-		struct page *, const struct cred *);
+	int (*get_locations)(struct nfs_server *, struct nfs_fh *,
+		struct nfs4_fs_locations *, struct page *, const struct cred *);
 	int (*fsid_present)(struct inode *, const struct cred *);
 };
 
@@ -302,8 +302,9 @@ extern int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait);
 extern int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle);
 extern int nfs4_proc_fs_locations(struct rpc_clnt *, struct inode *, const struct qstr *,
 				  struct nfs4_fs_locations *, struct page *);
-extern int nfs4_proc_get_locations(struct inode *, struct nfs4_fs_locations *,
-		struct page *page, const struct cred *);
+extern int nfs4_proc_get_locations(struct nfs_server *, struct nfs_fh *,
+				   struct nfs4_fs_locations *,
+				   struct page *page, const struct cred *);
 extern int nfs4_proc_fsid_present(struct inode *, const struct cred *);
 extern struct rpc_clnt *nfs4_proc_lookup_mountpoint(struct inode *,
 						    struct dentry *,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 199f03c9d0b2..9a6b53ec0eaa 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3933,6 +3933,59 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	return err;
 }
 
+static int _nfs4_discover_trunking(struct nfs_server *server,
+				   struct nfs_fh *fhandle)
+{
+	struct nfs4_fs_locations *locations = NULL;
+	struct page *page;
+	const struct cred *cred;
+	struct nfs_client *clp = server->nfs_client;
+	const struct nfs4_state_maintenance_ops *ops =
+		clp->cl_mvops->state_renewal_ops;
+	int status = -ENOMEM;
+
+	cred = ops->get_state_renewal_cred(clp);
+	if (cred == NULL) {
+		cred = nfs4_get_clid_cred(clp);
+		if (cred == NULL)
+			return -ENOKEY;
+	}
+
+	page = alloc_page(GFP_KERNEL);
+	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
+	if (page == NULL || locations == NULL)
+		goto out;
+
+	status = nfs4_proc_get_locations(server, fhandle, locations, page,
+					 cred);
+	if (status)
+		goto out;
+out:
+	if (page)
+		__free_page(page);
+	kfree(locations);
+	return status;
+}
+
+int nfs4_discover_trunking(struct nfs_server *server, struct nfs_fh *fhandle)
+{
+	struct nfs4_exception exception = {
+		.interruptible = true,
+	};
+	struct nfs_client *clp = server->nfs_client;
+	int err = 0;
+
+	if (!nfs4_has_session(clp))
+		goto out;
+	do {
+		err = nfs4_handle_exception(server,
+				_nfs4_discover_trunking(server, fhandle),
+				&exception);
+	} while (exception.retry);
+out:
+	return err;
+}
+
 static int _nfs4_lookup_root(struct nfs_server *server, struct nfs_fh *fhandle,
 		struct nfs_fsinfo *info)
 {
@@ -7819,18 +7872,18 @@ int nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
  * appended to this compound to identify the client ID which is
  * performing recovery.
  */
-static int _nfs40_proc_get_locations(struct inode *inode,
+static int _nfs40_proc_get_locations(struct nfs_server *server,
+				     struct nfs_fh *fhandle,
 				     struct nfs4_fs_locations *locations,
 				     struct page *page, const struct cred *cred)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
 	struct rpc_clnt *clnt = server->client;
 	u32 bitmask[2] = {
 		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
 	};
 	struct nfs4_fs_locations_arg args = {
 		.clientid	= server->nfs_client->cl_clientid,
-		.fh		= NFS_FH(inode),
+		.fh		= fhandle,
 		.page		= page,
 		.bitmask	= bitmask,
 		.migration	= 1,		/* skip LOOKUP */
@@ -7876,17 +7929,17 @@ static int _nfs40_proc_get_locations(struct inode *inode,
  * When the client supports GETATTR(fs_locations_info), it can
  * be plumbed in here.
  */
-static int _nfs41_proc_get_locations(struct inode *inode,
+static int _nfs41_proc_get_locations(struct nfs_server *server,
+				     struct nfs_fh *fhandle,
 				     struct nfs4_fs_locations *locations,
 				     struct page *page, const struct cred *cred)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
 	struct rpc_clnt *clnt = server->client;
 	u32 bitmask[2] = {
 		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
 	};
 	struct nfs4_fs_locations_arg args = {
-		.fh		= NFS_FH(inode),
+		.fh		= fhandle,
 		.page		= page,
 		.bitmask	= bitmask,
 		.migration	= 1,		/* skip LOOKUP */
@@ -7935,11 +7988,11 @@ static int _nfs41_proc_get_locations(struct inode *inode,
  * -NFS4ERR_LEASE_MOVED is returned if the server still has leases
  * from this client that require migration recovery.
  */
-int nfs4_proc_get_locations(struct inode *inode,
+int nfs4_proc_get_locations(struct nfs_server *server,
+			    struct nfs_fh *fhandle,
 			    struct nfs4_fs_locations *locations,
 			    struct page *page, const struct cred *cred)
 {
-	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_client *clp = server->nfs_client;
 	const struct nfs4_mig_recovery_ops *ops =
 					clp->cl_mvops->mig_recovery_ops;
@@ -7952,10 +8005,11 @@ int nfs4_proc_get_locations(struct inode *inode,
 		(unsigned long long)server->fsid.major,
 		(unsigned long long)server->fsid.minor,
 		clp->cl_hostname);
-	nfs_display_fhandle(NFS_FH(inode), __func__);
+	nfs_display_fhandle(fhandle, __func__);
 
 	do {
-		status = ops->get_locations(inode, locations, page, cred);
+		status = ops->get_locations(server, fhandle, locations, page,
+					    cred);
 		if (status != -NFS4ERR_DELAY)
 			break;
 		nfs4_handle_exception(server, status, &exception);
@@ -10424,6 +10478,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.free_client	= nfs4_free_client,
 	.create_server	= nfs4_create_server,
 	.clone_server	= nfs_clone_server,
+	.discover_trunking = nfs4_discover_trunking,
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f3265575c28d..499bef9fe118 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2098,7 +2098,8 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 	}
 
 	inode = d_inode(server->super->s_root);
-	result = nfs4_proc_get_locations(inode, locations, page, cred);
+	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
+					 page, cred);
 	if (result) {
 		dprintk("<-- %s: failed to retrieve fs_locations: %d\n",
 			__func__, result);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 967a0098f0a9..695fa84611b6 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1795,6 +1795,7 @@ struct nfs_rpc_ops {
 	struct nfs_server *(*create_server)(struct fs_context *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
+	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
 };
 
 /*
-- 
2.27.0

