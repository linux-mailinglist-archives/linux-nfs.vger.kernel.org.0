Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF4437B96
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhJVRNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhJVRNi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:38 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC9C061766
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k29so2846421qve.6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98iznrXyfh8l73YhtCVWp+OfnflrSOZ8i2XhOhQ55oI=;
        b=WbtKaRuh79gsKA6gIuzmdftQKq9lfOaGGwEVPkRkXlDWfz1jThZcveC6+bCF2smCf0
         7NJGykjlFpVabe/SVjARzn6BjtxZYCFctxj1w8nwE4m8mPJd5PhGSVw0niVdtyrfZWmx
         Hzkt3BddWLCPUIIs4R1shPu/BEQNTstzpaba04Xydzrmg4C3iDe2O0YIfNlBkQPZrxj4
         qMvd0C27Z2kUS5q3ANjNHhbDaz0JbWt9yu+YVS/Pxj/SQ550wCwGqBDXClcUGmkZ0g8E
         pS8SZysqTQTHHycrMvYJyXig1iyQSRoQibjYhBAER/iNtuLLgL0AN9ll3jG6tGa6LT/R
         03GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=98iznrXyfh8l73YhtCVWp+OfnflrSOZ8i2XhOhQ55oI=;
        b=A1SIa857gqIjcj+4E352KjW8Ny+xHJorhNvHiPhhJx0yQO6bHc76cWcqpznk+tgAPX
         rjNBQXvy3kCZJe9B4/j0yI3H7ycltJjuL8k/gvWw4zQsYj9w6+7L+wP5BBvJOHEbJZwe
         OVn//bc7ycYZRqvrDiDG1ahzGTMbb2eZVDreCKYD8EOmHTdC3ACER2/Kvozo34FXGtOV
         /YAu8PxFepefGEPGj7TmAMywEYUf2musVjEPzBksPanciwRMUxpJ9tie6ad0XD0+kMwy
         RgQvvvaK6Lk1VdSA0jUC0ptLVCJi9TNM+gwQFGJbQIpB0bp27aCkTKWr089+zniWAJ6i
         rfeA==
X-Gm-Message-State: AOAM532d2mSPy/Jof4sicjGL3H3i3PZ3E04SCksL6BPQShrRCf51MmJR
        PVts1PDwCYXTUqF1DCWTb9A=
X-Google-Smtp-Source: ABdhPJz4n6lI/KWKD4E1Vi8PmEZmSL++Eio9puqbuXnfWGQP2u+0AQb0uLfoFOZNZUzyhnYV9PeH6A==
X-Received: by 2002:a0c:fb0d:: with SMTP id c13mr1267744qvp.25.1634922679394;
        Fri, 22 Oct 2021 10:11:19 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:19 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 08/14] NFS: Remove the nfs4_label from the nfs4_getattr_res
Date:   Fri, 22 Oct 2021 13:11:07 -0400
Message-Id: <20211022171113.16739-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/client.c         |  2 +-
 fs/nfs/dir.c            |  2 +-
 fs/nfs/export.c         | 18 ++++--------------
 fs/nfs/inode.c          | 20 +++++---------------
 fs/nfs/nfs3proc.c       |  3 +--
 fs/nfs/nfs4_fs.h        |  3 +--
 fs/nfs/nfs4file.c       |  2 +-
 fs/nfs/nfs4proc.c       | 25 +++++++++++--------------
 fs/nfs/nfs4xdr.c        |  2 +-
 fs/nfs/proc.c           |  3 +--
 include/linux/nfs_xdr.h |  4 +---
 11 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 23e165d5ec9c..6956079b7741 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1025,7 +1025,7 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
-						       fattr, NULL, NULL);
+						       fattr, NULL);
 		if (error < 0) {
 			dprintk("nfs_create_server: getattr error = %d\n", -error);
 			goto error;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5f6996ee46be..7692d932add9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2054,7 +2054,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		struct nfs_server *server = NFS_SB(dentry->d_sb);
 		error = server->nfs_client->rpc_ops->getattr(server, fhandle,
-				fattr, NULL, NULL);
+				fattr, NULL);
 		if (error < 0)
 			goto out_error;
 	}
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 895b404888dd..a0462f7e7e35 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -64,7 +64,6 @@ static struct dentry *
 nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 		 int fh_len, int fh_type)
 {
-	struct nfs4_label *label = NULL;
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
 	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
@@ -79,7 +78,7 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	if (fh_len < len || fh_type != len)
 		return NULL;
 
-	fattr = nfs_alloc_fattr();
+	fattr = nfs_alloc_fattr_with_label(NFS_SB(sb));
 	if (fattr == NULL) {
 		dentry = ERR_PTR(-ENOMEM);
 		goto out;
@@ -95,28 +94,19 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	if (inode)
 		goto out_found;
 
-	label = nfs4_label_alloc(NFS_SB(sb), GFP_KERNEL);
-	if (IS_ERR(label)) {
-		dentry = ERR_CAST(label);
-		goto out_free_fattr;
-	}
-
 	rpc_ops = NFS_SB(sb)->nfs_client->rpc_ops;
-	ret = rpc_ops->getattr(NFS_SB(sb), server_fh, fattr, label, NULL);
+	ret = rpc_ops->getattr(NFS_SB(sb), server_fh, fattr, NULL);
 	if (ret) {
 		dprintk("%s: getattr failed %d\n", __func__, ret);
 		trace_nfs_fh_to_dentry(sb, server_fh, fattr->fileid, ret);
 		dentry = ERR_PTR(ret);
-		goto out_free_label;
+		goto out_free_fattr;
 	}
 
-	inode = nfs_fhget(sb, server_fh, fattr, label);
+	inode = nfs_fhget(sb, server_fh, fattr, fattr->label);
 
 out_found:
 	dentry = d_obtain_alias(inode);
-
-out_free_label:
-	nfs4_label_free(label);
 out_free_fattr:
 	nfs_free_fattr(fattr);
 out:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 309a8921eea3..73edabb00a9d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1175,7 +1175,6 @@ int
 __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	int		 status = -ESTALE;
-	struct nfs4_label *label = NULL;
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_inode *nfsi = NFS_I(inode);
 
@@ -1197,20 +1196,13 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	}
 
 	status = -ENOMEM;
-	fattr = nfs_alloc_fattr();
+	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	if (fattr == NULL)
 		goto out;
 
 	nfs_inc_stats(inode, NFSIOS_INODEREVALIDATE);
 
-	label = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
-	if (IS_ERR(label)) {
-		status = PTR_ERR(label);
-		goto out;
-	}
-
-	status = NFS_PROTO(inode)->getattr(server, NFS_FH(inode), fattr,
-			label, inode);
+	status = NFS_PROTO(inode)->getattr(server, NFS_FH(inode), fattr, inode);
 	if (status != 0) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) getattr failed, error=%d\n",
 			 inode->i_sb->s_id,
@@ -1227,7 +1219,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 			else
 				nfs_zap_caches(inode);
 		}
-		goto err_out;
+		goto out;
 	}
 
 	status = nfs_refresh_inode(inode, fattr);
@@ -1235,20 +1227,18 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) refresh failed, error=%d\n",
 			 inode->i_sb->s_id,
 			 (unsigned long long)NFS_FILEID(inode), status);
-		goto err_out;
+		goto out;
 	}
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
 
-	nfs_setsecurity(inode, fattr, label);
+	nfs_setsecurity(inode, fattr, fattr->label);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) revalidation complete\n",
 		inode->i_sb->s_id,
 		(unsigned long long)NFS_FILEID(inode));
 
-err_out:
-	nfs4_label_free(label);
 out:
 	nfs_free_fattr(fattr);
 	trace_nfs_revalidate_inode_exit(inode, status);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 516f3340b226..7bae21a2ba05 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -100,8 +100,7 @@ nfs3_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
  */
 static int
 nfs3_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr, struct nfs4_label *label,
-		struct inode *inode)
+		struct nfs_fattr *fattr, struct inode *inode)
 {
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs3_procedures[NFS3PROC_GETATTR],
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index b621e29e6187..ed5eaca6801e 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -316,8 +316,7 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
 extern int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
-			     struct nfs_fattr *fattr, struct nfs4_label *label,
-			     struct inode *inode);
+			     struct nfs_fattr *fattr, struct inode *inode);
 extern int update_open_stateid(struct nfs4_state *state,
 				const nfs4_stateid *open_stateid,
 				const nfs4_stateid *deleg_stateid,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c91565227ea2..ef78e06bcd21 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -330,7 +330,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 
 	nfs_fattr_init(&fattr);
 
-	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
+	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL);
 	if (status < 0) {
 		res = ERR_PTR(status);
 		goto out;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 51b86de47b60..7b9aecd20744 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -93,7 +93,8 @@ struct nfs4_opendata;
 static int _nfs4_recover_proc_open(struct nfs4_opendata *data);
 static int nfs4_do_fsinfo(struct nfs_server *, struct nfs_fh *, struct nfs_fsinfo *);
 static void nfs_fixup_referral_attributes(struct nfs_fattr *fattr);
-static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle, struct nfs_fattr *fattr, struct nfs4_label *label, struct inode *inode);
+static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+			      struct nfs_fattr *fattr, struct inode *inode);
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			    struct nfs_fattr *fattr, struct iattr *sattr,
 			    struct nfs_open_context *ctx, struct nfs4_label *ilabel,
@@ -2707,8 +2708,7 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 	}
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
 		nfs4_sequence_free_slot(&o_res->seq_res);
-		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
-				o_res->f_attr->label, NULL);
+		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
 	}
 	return 0;
 }
@@ -4091,7 +4091,6 @@ static int nfs4_proc_get_root(struct nfs_server *server, struct nfs_fh *mntfh,
 {
 	int error;
 	struct nfs_fattr *fattr = info->fattr;
-	struct nfs4_label *label = fattr->label;
 
 	error = nfs4_server_capabilities(server, mntfh);
 	if (error < 0) {
@@ -4099,7 +4098,7 @@ static int nfs4_proc_get_root(struct nfs_server *server, struct nfs_fh *mntfh,
 		return error;
 	}
 
-	error = nfs4_proc_getattr(server, mntfh, fattr, label, NULL);
+	error = nfs4_proc_getattr(server, mntfh, fattr, NULL);
 	if (error < 0) {
 		dprintk("nfs4_get_root: getattr error = %d\n", -error);
 		goto out;
@@ -4162,8 +4161,7 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 }
 
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
-				struct nfs_fattr *fattr, struct nfs4_label *label,
-				struct inode *inode)
+				struct nfs_fattr *fattr, struct inode *inode)
 {
 	__u32 bitmask[NFS4_BITMASK_SZ];
 	struct nfs4_getattr_arg args = {
@@ -4172,7 +4170,6 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	};
 	struct nfs4_getattr_res res = {
 		.fattr = fattr,
-		.label = label,
 		.server = server,
 	};
 	struct rpc_message msg = {
@@ -4189,7 +4186,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode, 0);
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label), inode, 0);
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 	return nfs4_do_call_sync(server->client, server, &msg,
@@ -4197,15 +4194,14 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 }
 
 int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
-				struct nfs_fattr *fattr, struct nfs4_label *label,
-				struct inode *inode)
+				struct nfs_fattr *fattr, struct inode *inode)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	int err;
 	do {
-		err = _nfs4_proc_getattr(server, fhandle, fattr, label, inode);
+		err = _nfs4_proc_getattr(server, fhandle, fattr, inode);
 		trace_nfs4_getattr(server, fhandle, fattr, err);
 		err = nfs4_handle_exception(server, err,
 				&exception);
@@ -5975,17 +5971,18 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
 					size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs_fattr fattr;
 	struct nfs4_label label = {0, 0, buflen, buf};
 
 	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
+	struct nfs_fattr fattr = {
+		.label = &label,
+	};
 	struct nfs4_getattr_arg arg = {
 		.fh		= NFS_FH(inode),
 		.bitmask	= bitmask,
 	};
 	struct nfs4_getattr_res res = {
 		.fattr		= &fattr,
-		.label		= &label,
 		.server		= server,
 	};
 	struct rpc_message msg = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 8d9d4df75f88..b002a39d39ea 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6394,7 +6394,7 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_putfh(xdr);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 408507e9354c..d941cd0fe34d 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -100,8 +100,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
  */
 static int
 nfs_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
-		struct nfs_fattr *fattr, struct nfs4_label *label,
-		struct inode *inode)
+		struct nfs_fattr *fattr, struct inode *inode)
 {
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs_procedures[NFSPROC_GETATTR],
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index cb28e01ea41e..817f1bf5f187 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1063,7 +1063,6 @@ struct nfs4_getattr_res {
 	struct nfs4_sequence_res	seq_res;
 	const struct nfs_server *	server;
 	struct nfs_fattr *		fattr;
-	struct nfs4_label		*label;
 };
 
 struct nfs4_link_arg {
@@ -1732,8 +1731,7 @@ struct nfs_rpc_ops {
 	int	(*submount) (struct fs_context *, struct nfs_server *);
 	int	(*try_get_tree) (struct fs_context *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
-			    struct nfs_fattr *, struct nfs4_label *,
-			    struct inode *);
+			    struct nfs_fattr *, struct inode *);
 	int	(*setattr) (struct dentry *, struct nfs_fattr *,
 			    struct iattr *);
 	int	(*lookup)  (struct inode *, struct dentry *,
-- 
2.33.1

