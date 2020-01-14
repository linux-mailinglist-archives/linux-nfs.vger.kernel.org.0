Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1413913B085
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgANRIp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 12:08:45 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40986 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRIo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 12:08:44 -0500
Received: by mail-yw1-f67.google.com with SMTP id l22so9631504ywc.8
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYbPZLDV8lg/9RBDwjprH3u6XrC2Zex0Mo/gQHyfMMY=;
        b=pFEuQP3a9CgKMY/KTQ/NpDJHGkt8KBanFch36xB4lyGKnO8ISCVJmBLe6sW2IS1Jlg
         L9S7HthFoslji9HVwGx7eQmUfUslBVn6W5A3BFk6PPPD5gDxBujii5wmg9uPa29RSs22
         o86zOmqO2+6oLYJ/o4xsncyG78qXkfKXh6+W8OYY6m2Dva1veE7yfTDwSbTEFWypC8F3
         nwr3n47osHSAU5fGLXYNlZHEUFHiFJTHxyE4VP1LEdBLOqibLc+c4SXvKlcZXNZgbmgg
         Af14w0qzrk01UikkiM446Eb4Hm3D5c2j05gtan5hKKY6xyL/908xbMX1hNLu3E3yO3lS
         Pb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYbPZLDV8lg/9RBDwjprH3u6XrC2Zex0Mo/gQHyfMMY=;
        b=pwXDbPqQF7ywfE05yntTor48sUpON+IqIU4QhPYAdONmcvRxbxFzdXROHjVZcPx44+
         J/pG9lKLjTRyOzHNHigKwa2AeLUlX8bSeopuwBvm+yZGsaAKuZ4gvH75xTQmEL1Q3THY
         N02tRP7bgzlght4rAglxfEnP6AotiCy6AenRjJsIacOI0uMkoaJX20WWL7sgDnGxlUWr
         477LYOMZbUR41EV2xIjugtioJaHTZ+1jCGWaTb20gvbPrGPbf0C5zgl2fzS+/veQv+Vl
         Ce6mz10iIyjzAeHjCZI9GXfEUMyOW03GDb/HwzQptrqbPjx/geT4QlckhzehMqd8J97T
         /H9A==
X-Gm-Message-State: APjAAAVvViGWzIhMOZSxZnuqmf5ytx4/0WFFoOCMndSDfYkBqWbx9oVn
        qd6hsXRa4iMA3uwp71IGP98Hnt0=
X-Google-Smtp-Source: APXvYqwCV2Akea8B/HQOxD1Qf8ZHFE+7STF0wYa3pJziuE0lzdMzSCXzWNowLzRxA26Li6BC1kSsvQ==
X-Received: by 2002:a81:a1d3:: with SMTP id y202mr17775959ywg.300.1579021723197;
        Tue, 14 Jan 2020 09:08:43 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q185sm6936143ywh.61.2020.01.14.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:08:42 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Add softreval behaviour to nfs_lookup_revalidate()
Date:   Tue, 14 Jan 2020 12:06:34 -0500
Message-Id: <20200114170634.923384-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server is unavaliable, we want to allow the revalidating
lookup to time out, and to default to validating the cached dentry
if the 'softreval' mount option is set.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c            | 15 +++++++++++----
 fs/nfs/internal.h       |  9 +++++++++
 fs/nfs/namespace.c      |  2 +-
 fs/nfs/nfs3proc.c       | 17 +++++++++++------
 fs/nfs/nfs4_fs.h        |  6 ++++--
 fs/nfs/nfs4namespace.c  |  3 +--
 fs/nfs/nfs4proc.c       | 28 ++++++++++++++++++----------
 fs/nfs/proc.c           | 15 ++++++++++-----
 include/linux/nfs_xdr.h |  2 +-
 9 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9405eeadc3f3..bfc66f3f00e1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1142,10 +1142,17 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	if (fhandle == NULL || fattr == NULL || IS_ERR(label))
 		goto out;
 
-	ret = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr, label);
+	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
 	if (ret < 0) {
-		if (ret == -ESTALE || ret == -ENOENT)
+		switch (ret) {
+		case -ESTALE:
+		case -ENOENT:
 			ret = 0;
+			break;
+		case -ETIMEDOUT:
+			if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+				ret = 1;
+		}
 		goto out;
 	}
 	ret = 0;
@@ -1408,7 +1415,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		goto out;
 
 	trace_nfs_lookup_enter(dir, dentry, flags);
-	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr, label);
+	error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
 	if (error == -ENOENT)
 		goto no_entry;
 	if (error < 0) {
@@ -1683,7 +1690,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	d_drop(dentry);
 
 	if (fhandle->size == 0) {
-		error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, fhandle, fattr, NULL);
+		error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, NULL);
 		if (error)
 			goto out_error;
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 24a65da58aa9..9be371e38e37 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -31,6 +31,15 @@ static inline int nfs_attr_use_mounted_on_fileid(struct nfs_fattr *fattr)
 	return 1;
 }
 
+static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
+{
+	if (!(NFS_SB(dentry->d_sb)->flags & NFS_MOUNT_SOFTREVAL))
+		return false;
+	if (!d_is_positive(dentry) || !NFS_FH(d_inode(dentry))->size)
+		return false;
+	return true;
+}
+
 struct nfs_clone_mount {
 	const struct super_block *sb;
 	const struct dentry *dentry;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 5e0e9d29f5c5..172e5343d4e0 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -266,7 +266,7 @@ struct vfsmount *nfs_submount(struct nfs_server *server, struct dentry *dentry,
 	struct dentry *parent = dget_parent(dentry);
 
 	/* Look it up again to get its attributes */
-	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), &dentry->d_name, fh, fattr, NULL);
+	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry, fh, fattr, NULL);
 	dput(parent);
 	if (err != 0)
 		return ERR_PTR(err);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index d401a9c2fe31..7898bae7d4cd 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -154,14 +154,14 @@ nfs3_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int
-nfs3_proc_lookup(struct inode *dir, const struct qstr *name,
+nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 		 struct nfs_fh *fhandle, struct nfs_fattr *fattr,
 		 struct nfs4_label *label)
 {
 	struct nfs3_diropargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len
+		.name		= dentry->d_name.name,
+		.len		= dentry->d_name.len
 	};
 	struct nfs3_diropres	res = {
 		.fh		= fhandle,
@@ -173,20 +173,25 @@ nfs3_proc_lookup(struct inode *dir, const struct qstr *name,
 		.rpc_resp	= &res,
 	};
 	int			status;
+	unsigned short task_flags = 0;
 
-	dprintk("NFS call  lookup %s\n", name->name);
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (nfs_lookup_is_soft_revalidate(dentry))
+		task_flags |= RPC_TASK_TIMEOUT;
+
+	dprintk("NFS call  lookup %pd2\n", dentry);
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
 		return -ENOMEM;
 
 	nfs_fattr_init(fattr);
-	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+	status = rpc_call_sync(NFS_CLIENT(dir), &msg, task_flags);
 	nfs_refresh_inode(dir, res.dir_attr);
 	if (status >= 0 && !(fattr->valid & NFS_ATTR_FATTR)) {
 		msg.rpc_proc = &nfs3_procedures[NFS3PROC_GETATTR];
 		msg.rpc_argp = fhandle;
 		msg.rpc_resp = fattr;
-		status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+		status = rpc_call_sync(NFS_CLIENT(dir), &msg, task_flags);
 	}
 	nfs_free_fattr(res.dir_attr);
 	dprintk("NFS reply lookup: %d\n", status);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index a7a73b1d1fec..576f709625a7 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -303,8 +303,10 @@ extern int nfs4_proc_fs_locations(struct rpc_clnt *, struct inode *, const struc
 extern int nfs4_proc_get_locations(struct inode *, struct nfs4_fs_locations *,
 		struct page *page, const struct cred *);
 extern int nfs4_proc_fsid_present(struct inode *, const struct cred *);
-extern struct rpc_clnt *nfs4_proc_lookup_mountpoint(struct inode *, const struct qstr *,
-			    struct nfs_fh *, struct nfs_fattr *);
+extern struct rpc_clnt *nfs4_proc_lookup_mountpoint(struct inode *,
+						    struct dentry *,
+						    struct nfs_fh *,
+						    struct nfs_fattr *);
 extern int nfs4_proc_secinfo(struct inode *, const struct qstr *, struct nfs4_secinfo_flavors *);
 extern const struct xattr_handler *nfs4_xattr_handlers[];
 extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 2e460c33ae48..513c272b05a9 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -392,12 +392,11 @@ struct vfsmount *nfs4_submount(struct nfs_server *server, struct dentry *dentry,
 	rpc_authflavor_t flavor = server->client->cl_auth->au_flavor;
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
-	const struct qstr *name = &dentry->d_name;
 	struct rpc_clnt *client;
 	struct vfsmount *mnt;
 
 	/* Look it up again to get its attributes and sec flavor */
-	client = nfs4_proc_lookup_mountpoint(dir, name, fh, fattr);
+	client = nfs4_proc_lookup_mountpoint(dir, dentry, fh, fattr);
 	dput(parent);
 	if (IS_ERR(client))
 		return ERR_CAST(client);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index eda02b821ea8..402410c1a988 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4175,7 +4175,7 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
-		const struct qstr *name, struct nfs_fh *fhandle,
+		struct dentry *dentry, struct nfs_fh *fhandle,
 		struct nfs_fattr *fattr, struct nfs4_label *label)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
@@ -4183,7 +4183,7 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	struct nfs4_lookup_arg args = {
 		.bitmask = server->attr_bitmask,
 		.dir_fh = NFS_FH(dir),
-		.name = name,
+		.name = &dentry->d_name,
 	};
 	struct nfs4_lookup_res res = {
 		.server = server,
@@ -4196,13 +4196,20 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
+	unsigned short task_flags = 0;
+
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (nfs_lookup_is_soft_revalidate(dentry))
+		task_flags |= RPC_TASK_TIMEOUT;
 
 	args.bitmask = nfs4_bitmask(server, label);
 
 	nfs_fattr_init(fattr);
 
-	dprintk("NFS call  lookup %s\n", name->name);
-	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args, &res.seq_res, 0);
+	dprintk("NFS call  lookup %pd2\n", dentry);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	status = nfs4_do_call_sync(clnt, server, &msg,
+			&args.seq_args, &res.seq_res, task_flags);
 	dprintk("NFS reply lookup: %d\n", status);
 	return status;
 }
@@ -4216,16 +4223,17 @@ static void nfs_fixup_secinfo_attributes(struct nfs_fattr *fattr)
 }
 
 static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
-				   const struct qstr *name, struct nfs_fh *fhandle,
+				   struct dentry *dentry, struct nfs_fh *fhandle,
 				   struct nfs_fattr *fattr, struct nfs4_label *label)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	struct rpc_clnt *client = *clnt;
+	const struct qstr *name = &dentry->d_name;
 	int err;
 	do {
-		err = _nfs4_proc_lookup(client, dir, name, fhandle, fattr, label);
+		err = _nfs4_proc_lookup(client, dir, dentry, fhandle, fattr, label);
 		trace_nfs4_lookup(dir, name, err);
 		switch (err) {
 		case -NFS4ERR_BADNAME:
@@ -4260,14 +4268,14 @@ static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
 	return err;
 }
 
-static int nfs4_proc_lookup(struct inode *dir, const struct qstr *name,
+static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry,
 			    struct nfs_fh *fhandle, struct nfs_fattr *fattr,
 			    struct nfs4_label *label)
 {
 	int status;
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 
-	status = nfs4_proc_lookup_common(&client, dir, name, fhandle, fattr, label);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr, label);
 	if (client != NFS_CLIENT(dir)) {
 		rpc_shutdown_client(client);
 		nfs_fixup_secinfo_attributes(fattr);
@@ -4276,13 +4284,13 @@ static int nfs4_proc_lookup(struct inode *dir, const struct qstr *name,
 }
 
 struct rpc_clnt *
-nfs4_proc_lookup_mountpoint(struct inode *dir, const struct qstr *name,
+nfs4_proc_lookup_mountpoint(struct inode *dir, struct dentry *dentry,
 			    struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 	int status;
 
-	status = nfs4_proc_lookup_common(&client, dir, name, fhandle, fattr, NULL);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr, NULL);
 	if (status < 0)
 		return ERR_PTR(status);
 	return (client == NFS_CLIENT(dir)) ? rpc_clone_client(client) : client;
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 488349f25e0f..d7e6c7fe6428 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -152,14 +152,14 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 }
 
 static int
-nfs_proc_lookup(struct inode *dir, const struct qstr *name,
+nfs_proc_lookup(struct inode *dir, struct dentry *dentry,
 		struct nfs_fh *fhandle, struct nfs_fattr *fattr,
 		struct nfs4_label *label)
 {
 	struct nfs_diropargs	arg = {
 		.fh		= NFS_FH(dir),
-		.name		= name->name,
-		.len		= name->len
+		.name		= dentry->d_name.name,
+		.len		= dentry->d_name.len
 	};
 	struct nfs_diropok	res = {
 		.fh		= fhandle,
@@ -171,10 +171,15 @@ nfs_proc_lookup(struct inode *dir, const struct qstr *name,
 		.rpc_resp	= &res,
 	};
 	int			status;
+	unsigned short task_flags = 0;
 
-	dprintk("NFS call  lookup %s\n", name->name);
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (nfs_lookup_is_soft_revalidate(dentry))
+		task_flags |= RPC_TASK_TIMEOUT;
+
+	dprintk("NFS call  lookup %pd2\n", dentry);
 	nfs_fattr_init(fattr);
-	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+	status = rpc_call_sync(NFS_CLIENT(dir), &msg, task_flags);
 	dprintk("NFS reply lookup: %d\n", status);
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 72d5695c1b47..832bd0678978 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1662,7 +1662,7 @@ struct nfs_rpc_ops {
 			    struct inode *);
 	int	(*setattr) (struct dentry *, struct nfs_fattr *,
 			    struct iattr *);
-	int	(*lookup)  (struct inode *, const struct qstr *,
+	int	(*lookup)  (struct inode *, struct dentry *,
 			    struct nfs_fh *, struct nfs_fattr *,
 			    struct nfs4_label *);
 	int	(*lookupp) (struct inode *, struct nfs_fh *,
-- 
2.24.1

