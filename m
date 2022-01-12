Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39148C736
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 16:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbiALP1w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jan 2022 10:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiALP1u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jan 2022 10:27:50 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CBC06173F
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jan 2022 07:27:50 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f17so3369870qtf.8
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jan 2022 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nAOFpol+s69EXENGFOSxREkfMCJOxZxBSingJhNjNI=;
        b=E4wIq3wmjcgqLRcahH2f5wfVoryTlR33dhaoDZG1DoUif5jwrGnw7b130OI1Y9UXBu
         m5l0OrySPj6evMhGfAf+qFtoXcGjkVaxlY+G74RT8e5RVjFtIfuv4C8u3BGaV+Ofw2/T
         huV8W+1xyN/lNkMmaxIF40QHTlH2xXeI35GVgYt/ny7hDLXxJpIVIV5fnqZlEHw1T0Nz
         r88VNOAX8/WKtIs2NzNLTHz+k8J8k/V/nSsCB8rwm0/eBv1dORJ3bR7U1NZWsPv9Rn6b
         /omkOdvLA7bef4d5MF6VKPKy5DfaqGBJcZfqdtjqlVxUrDm5X3aRDAoj4JBQThsPromG
         bluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nAOFpol+s69EXENGFOSxREkfMCJOxZxBSingJhNjNI=;
        b=CDobrSQ90bunvuKl1PsiZHb8JOXUv5LmM36bxJRQrGncLJQCc/g3JM/p9Q5SuOD2xI
         HEeI+d9NZIN7Pqw3yrEKdgwEKt40aXggffx4kRA2SNJJHEnZZsp9VhgVRyst3diWv9mB
         93aWQyUDRer1feU6VYfSxZCU/aTfn5cu9oDR16YdZDvAnzS26oH6VqWlnagfM5NyHNG+
         UcuK1mCVY9hoTbztURpUvYr7lLMnDDxEfu7Z2UwEqDFp1uUidZmdnBOzPS50CEV8LCTW
         X4h2z8iS2GJ8vIJAhXh2DH9lYQ1HY1ZaUW+f57u0D6n4JgZ0iL08KperAnedv6TvrGTB
         idwg==
X-Gm-Message-State: AOAM531VvE47exaRpSvsuohHSZmIR+q9434qvcgi3zIpTrKl2NJjF103
        5xQggo1Rq7ztsyrSrU/K9LE=
X-Google-Smtp-Source: ABdhPJweQm6LSbxXqMOYl0AYUr+kZfxmy7mK6bagN8nSdZKjezN7VedtPsNEs8tYNcqtBAwiounYAw==
X-Received: by 2002:ac8:5886:: with SMTP id t6mr298198qta.169.1642001269347;
        Wed, 12 Jan 2022 07:27:49 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:dcfa:f91b:b276:9981])
        by smtp.gmail.com with ESMTPSA id r4sm51248qta.51.2022.01.12.07.27.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 07:27:48 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/7] NFSv4.1 query for fs_location attr on a new file system
Date:   Wed, 12 Jan 2022 10:27:38 -0500
Message-Id: <20220112152738.15915-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Query the server for other possible trunkable locations for a given
file system on a 4.1+ mount.

v2:
-- added missing static to nfs4_discover_trunking,
reported by the kernel test robot

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c         |  7 ++++
 fs/nfs/nfs4_fs.h        |  9 ++---
 fs/nfs/nfs4proc.c       | 76 +++++++++++++++++++++++++++++++++++------
 fs/nfs/nfs4state.c      |  3 +-
 include/linux/nfs_xdr.h |  1 +
 5 files changed, 81 insertions(+), 15 deletions(-)

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
index 5fe976e615aa..48fa2b7c412a 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -288,8 +288,8 @@ struct nfs4_state_maintenance_ops {
 };
 
 struct nfs4_mig_recovery_ops {
-	int (*get_locations)(struct inode *, struct nfs4_fs_locations *,
-		struct page *, const struct cred *);
+	int (*get_locations)(struct nfs_server *, struct nfs_fh *,
+		struct nfs4_fs_locations *, struct page *, const struct cred *);
 	int (*fsid_present)(struct inode *, const struct cred *);
 };
 
@@ -330,8 +330,9 @@ extern int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait);
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
index 8ab90fe923ff..cd0f8c1ac7ff 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3971,6 +3971,60 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
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
+static int nfs4_discover_trunking(struct nfs_server *server,
+				  struct nfs_fh *fhandle)
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
@@ -7866,18 +7920,18 @@ int nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
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
@@ -7923,17 +7977,17 @@ static int _nfs40_proc_get_locations(struct inode *inode,
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
@@ -8105,11 +8159,11 @@ int nfs4_set_nfs4_statx(struct inode *inode,
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
@@ -8122,10 +8176,11 @@ int nfs4_proc_get_locations(struct inode *inode,
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
@@ -10595,6 +10650,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
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
index 55d3a25cfe03..39390d9df9e1 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1821,6 +1821,7 @@ struct nfs_rpc_ops {
 	struct nfs_server *(*create_server)(struct fs_context *);
 	struct nfs_server *(*clone_server)(struct nfs_server *, struct nfs_fh *,
 					   struct nfs_fattr *, rpc_authflavor_t);
+	int	(*discover_trunking)(struct nfs_server *, struct nfs_fh *);
 };
 
 /*
-- 
2.27.0

