Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACF437B93
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhJVRNv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhJVRNg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF3C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x123so5252468qke.7
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4AgfJ1e9Qf2D5nt6QqsHll9uhHkm7nf6JI0zJvbN3U=;
        b=kwCVCS9CZQsT1C6OgA+9VhOd+BPxNdHWoPO8aS9uDCBN1iUdmLdSKgfvDZ+68p/gRQ
         fk9K1SdiFiU4cxPLtvHDdN1qpt6Xy/W0RZpLDwxPbExK5l2y+LjO6zAKzKtV5NXLQoRF
         uCng4NuL2WBzL+ut4sI0MIgbilGjeZdU13JzL9xJJuuztEsVBT9iPTp5mGzb6xA9bSYW
         Pz0beJSgaQ9fHRkncqIqF+1MfiHlRjTwJnay25jet+JDKV/qG4pJ2C+2ZxhcqRV2edU9
         nj9lulmbc9lLOsyhZEMEBCmlv6q4u7sFKygYzNH7qaFHO3dtYvT6kXIZ51UBbVy4M/Im
         M/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=c4AgfJ1e9Qf2D5nt6QqsHll9uhHkm7nf6JI0zJvbN3U=;
        b=iwQn7jyl9TMj0lZ3RpL7SZnCO4411JUd2F+UPs1HBm6P52r/bh+ri8SOb9gINSDKC9
         CsTmeBX75TdM2cLqLVTFbl+VOX9P3AHpy5rBq80cL+sDnPBTO9Kuc3suSdUBO/Bl9L7b
         +dBK4m1HwaSeSNR2qQnB1Qrwir0QytbTt5/qdrD2nYx6ligL02EAx2UVnVhmAJkNEcQw
         sEy53uhR5yYcuyQKJaiDTRccyzLg2mpG01SOPVnE3tw9crNwKq78tP9M3fniFWXtjBv9
         Ur7f9FEK9C70lsP5xapt7Xj86Js56Afedz9Hx6lrIXxM2ColZgqgIdzSifxCViBmdDdg
         ANGQ==
X-Gm-Message-State: AOAM530irTezArAjjXQXTQj2RgNer5GhNfkMj34eQlUgmCONSWsVe/iQ
        WZsLTdO1vHSB5+OOrnn1iXI=
X-Google-Smtp-Source: ABdhPJxPAP005u4QGNnHEVek+5a38KT/d8aPpTXDcQ0Ohja4e6z0FB97zcPhruiBiMg7AuALBmkYPg==
X-Received: by 2002:a37:8387:: with SMTP id f129mr1083890qkd.79.1634922677482;
        Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 05/14] NFS: Remove the label from the nfs4_lookup_res struct
Date:   Fri, 22 Oct 2021 13:11:04 -0400
Message-Id: <20211022171113.16739-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And usethe fattr's label field instead. I also adjust function calls to
remove labels along the way.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c            | 34 ++++++++++++----------------------
 fs/nfs/namespace.c      |  3 +--
 fs/nfs/nfs3proc.c       |  3 +--
 fs/nfs/nfs4proc.c       | 16 +++++++---------
 fs/nfs/nfs4xdr.c        |  4 ++--
 fs/nfs/proc.c           |  3 +--
 include/linux/nfs_xdr.h |  4 +---
 7 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3daa1fd60751..5f6996ee46be 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1488,19 +1488,17 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 {
 	struct nfs_fh *fhandle;
 	struct nfs_fattr *fattr;
-	struct nfs4_label *label;
 	unsigned long dir_verifier;
 	int ret;
 
 	ret = -ENOMEM;
 	fhandle = nfs_alloc_fhandle();
-	fattr = nfs_alloc_fattr();
-	label = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
-	if (fhandle == NULL || fattr == NULL || IS_ERR(label))
+	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
+	if (fhandle == NULL || fattr == NULL)
 		goto out;
 
 	dir_verifier = nfs_save_change_attribute(dir);
-	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
+	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
 	if (ret < 0) {
 		switch (ret) {
 		case -ESTALE:
@@ -1519,7 +1517,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 	if (nfs_refresh_inode(inode, fattr) < 0)
 		goto out;
 
-	nfs_setsecurity(inode, fattr, label);
+	nfs_setsecurity(inode, fattr, fattr->label);
 	nfs_set_verifier(dentry, dir_verifier);
 
 	/* set a readdirplus hint that we had a cache miss */
@@ -1528,7 +1526,6 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
 out:
 	nfs_free_fattr(fattr);
 	nfs_free_fhandle(fhandle);
-	nfs4_label_free(label);
 
 	/*
 	 * If the lookup failed despite the dentry change attribute being
@@ -1752,7 +1749,6 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	struct inode *inode = NULL;
 	struct nfs_fh *fhandle = NULL;
 	struct nfs_fattr *fattr = NULL;
-	struct nfs4_label *label = NULL;
 	unsigned long dir_verifier;
 	int error;
 
@@ -1771,27 +1767,23 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 
 	res = ERR_PTR(-ENOMEM);
 	fhandle = nfs_alloc_fhandle();
-	fattr = nfs_alloc_fattr();
+	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(dir));
 	if (fhandle == NULL || fattr == NULL)
 		goto out;
 
-	label = nfs4_label_alloc(NFS_SERVER(dir), GFP_NOWAIT);
-	if (IS_ERR(label))
-		goto out;
-
 	dir_verifier = nfs_save_change_attribute(dir);
 	trace_nfs_lookup_enter(dir, dentry, flags);
-	error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, label);
+	error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
 	if (error == -ENOENT)
 		goto no_entry;
 	if (error < 0) {
 		res = ERR_PTR(error);
-		goto out_label;
+		goto out;
 	}
-	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, label);
+	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, fattr->label);
 	res = ERR_CAST(inode);
 	if (IS_ERR(res))
-		goto out_label;
+		goto out;
 
 	/* Notify readdir to use READDIRPLUS */
 	nfs_force_use_readdirplus(dir);
@@ -1800,14 +1792,12 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	res = d_splice_alias(inode, dentry);
 	if (res != NULL) {
 		if (IS_ERR(res))
-			goto out_label;
+			goto out;
 		dentry = res;
 	}
 	nfs_set_verifier(dentry, dir_verifier);
-out_label:
+out:
 	trace_nfs_lookup_exit(dir, dentry, flags, error);
-	nfs4_label_free(label);
-out:
 	nfs_free_fattr(fattr);
 	nfs_free_fhandle(fhandle);
 	return res;
@@ -2056,7 +2046,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	d_drop(dentry);
 
 	if (fhandle->size == 0) {
-		error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr, NULL);
+		error = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
 		if (error)
 			goto out_error;
 	}
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index bc0c698f3350..3295af4110f1 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -308,8 +308,7 @@ int nfs_submount(struct fs_context *fc, struct nfs_server *server)
 
 	/* Look it up again to get its attributes */
 	err = server->nfs_client->rpc_ops->lookup(d_inode(parent), dentry,
-						  ctx->mntfh, ctx->clone_data.fattr,
-						  NULL);
+						  ctx->mntfh, ctx->clone_data.fattr);
 	dput(parent);
 	if (err != 0)
 		return err;
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index f7524310ddf4..717eb651f0fd 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -193,8 +193,7 @@ __nfs3_proc_lookup(struct inode *dir, const char *name, size_t len,
 
 static int
 nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
-		 struct nfs_fh *fhandle, struct nfs_fattr *fattr,
-		 struct nfs4_label *label)
+		 struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	unsigned short task_flags = 0;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fed15eafc03b..49e077841e98 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4295,7 +4295,7 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 
 static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 		struct dentry *dentry, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr, struct nfs4_label *label)
+		struct nfs_fattr *fattr)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
 	int		       status;
@@ -4307,7 +4307,6 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	struct nfs4_lookup_res res = {
 		.server = server,
 		.fattr = fattr,
-		.label = label,
 		.fh = fhandle,
 	};
 	struct rpc_message msg = {
@@ -4324,7 +4323,7 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	if (nfs_lookup_is_soft_revalidate(dentry))
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	args.bitmask = nfs4_bitmask(server, label);
+	args.bitmask = nfs4_bitmask(server, fattr->label);
 
 	nfs_fattr_init(fattr);
 
@@ -4346,7 +4345,7 @@ static void nfs_fixup_secinfo_attributes(struct nfs_fattr *fattr)
 
 static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
 				   struct dentry *dentry, struct nfs_fh *fhandle,
-				   struct nfs_fattr *fattr, struct nfs4_label *label)
+				   struct nfs_fattr *fattr)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
@@ -4355,7 +4354,7 @@ static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
 	const struct qstr *name = &dentry->d_name;
 	int err;
 	do {
-		err = _nfs4_proc_lookup(client, dir, dentry, fhandle, fattr, label);
+		err = _nfs4_proc_lookup(client, dir, dentry, fhandle, fattr);
 		trace_nfs4_lookup(dir, name, err);
 		switch (err) {
 		case -NFS4ERR_BADNAME:
@@ -4391,13 +4390,12 @@ static int nfs4_proc_lookup_common(struct rpc_clnt **clnt, struct inode *dir,
 }
 
 static int nfs4_proc_lookup(struct inode *dir, struct dentry *dentry,
-			    struct nfs_fh *fhandle, struct nfs_fattr *fattr,
-			    struct nfs4_label *label)
+			    struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	int status;
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 
-	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr, label);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr);
 	if (client != NFS_CLIENT(dir)) {
 		rpc_shutdown_client(client);
 		nfs_fixup_secinfo_attributes(fattr);
@@ -4412,7 +4410,7 @@ nfs4_proc_lookup_mountpoint(struct inode *dir, struct dentry *dentry,
 	struct rpc_clnt *client = NFS_CLIENT(dir);
 	int status;
 
-	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr, NULL);
+	status = nfs4_proc_lookup_common(&client, dir, dentry, fhandle, fattr);
 	if (status < 0)
 		return ERR_PTR(status);
 	return (client == NFS_CLIENT(dir)) ? rpc_clone_client(client) : client;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 4ce6d2430ff1..fc5c987d8ad9 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6179,7 +6179,7 @@ static int nfs4_xdr_dec_lookup(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
@@ -6237,7 +6237,7 @@ static int nfs4_xdr_dec_lookup_root(struct rpc_rqst *rqstp,
 	status = decode_getfh(xdr, res->fh);
 	if (status == 0)
 		status = decode_getfattr_label(xdr, res->fattr,
-						res->label, res->server);
+						res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index ea19dbf12301..408507e9354c 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -154,8 +154,7 @@ nfs_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 
 static int
 nfs_proc_lookup(struct inode *dir, struct dentry *dentry,
-		struct nfs_fh *fhandle, struct nfs_fattr *fattr,
-		struct nfs4_label *label)
+		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct nfs_diropargs	arg = {
 		.fh		= NFS_FH(dir),
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d55bf3fd5167..95219d5a8668 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1095,7 +1095,6 @@ struct nfs4_lookup_res {
 	const struct nfs_server *	server;
 	struct nfs_fattr *		fattr;
 	struct nfs_fh *			fh;
-	struct nfs4_label		*label;
 };
 
 struct nfs4_lookupp_arg {
@@ -1740,8 +1739,7 @@ struct nfs_rpc_ops {
 	int	(*setattr) (struct dentry *, struct nfs_fattr *,
 			    struct iattr *);
 	int	(*lookup)  (struct inode *, struct dentry *,
-			    struct nfs_fh *, struct nfs_fattr *,
-			    struct nfs4_label *);
+			    struct nfs_fh *, struct nfs_fattr *);
 	int	(*lookupp) (struct inode *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *);
 	int	(*access)  (struct inode *, struct nfs_access_entry *);
-- 
2.33.1

