Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B3405DEA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhIIUOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242975AbhIIUOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:44 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCEC061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 22so3275146qkg.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sbn9MMzx9Qf6jojTYE6hk0xVO7WLnirjP6C8mQNemI4=;
        b=ln2nSEvocw88ii2qKzKVBF9NwQO1XY7CyVhWus/kF7nV6OdFNtj4/ru/ICSWcXdqYv
         DueNzXWvaXwjxGgZEuEM+FiXN1x1x0TCC4aJtRgSy8VBjZsZeKZ44/X9hJGFP9ve35Wi
         zNXt7vss2pAW/d8BHstyuzkWIFSACoO6SPXY3GSwuPxXqBfhBddaCQHUH3RNPwikc+Qw
         rNhYoUDFJ2oCFbQbCRJVN19R27hfhx0NAZp2Sc8qESIrbwyyTXcaEQidUZYIf+7q07jn
         q7neiXOB5tn94LyeZjaF3RE/gWMa9kw8TwWr4GWH8vekrwQILaBC2NschTa84ReB9nBZ
         4WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Sbn9MMzx9Qf6jojTYE6hk0xVO7WLnirjP6C8mQNemI4=;
        b=W6Ne7JpRLx028s9ZmhVplc7amJ0wYa73tXSzVcnwYWet+0sdpj/8OLGKUckTi+3tlQ
         NxmFmoNzvEN/RGCjCSbLxE6DjlaTrISawewbR0NsXM/Z4k+CS+D9Wz5sFd8UgKr/H4oJ
         iGtTg2fjqqJRmN3HJkHSzCt5b6qANrxwFObjbVH1nPHl6o07j3nlM7e5qD/OwC6L6v9t
         inF+JFG9x1kJpfyNLpqLReQhoNsIMXLh9tAmqQj6fSwfEwBnE/Fe0M4RktPvBd45iQPn
         LwpoV8SXrlhYaEmA+9T4/XMzn7b7SmCYh8+qz3tUdWuMVO3BCg4X6UpmNBD2zKuD9dBX
         B9MQ==
X-Gm-Message-State: AOAM532omr4FSYhvondwZA7XVyy9nPafIPEvcWVrjGtUlwZzm2oe4YaL
        2O8jNUpKSOPeAsGe97aQnXYp1BIv3+0=
X-Google-Smtp-Source: ABdhPJxzyzp0KVybd+f9IMuHJWwLlFJEke2mrj4wvPnDg7eSg053cIrQMOE3JPlKZB3j5xoLUWbbBA==
X-Received: by 2002:a37:6458:: with SMTP id y85mr4602070qkb.418.1631218414238;
        Thu, 09 Sep 2021 13:13:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:33 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 09/14] NFS: Remove the nfs4_label from the nfs_setattrres
Date:   Thu,  9 Sep 2021 16:13:22 -0400
Message-Id: <20210909201327.108759-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
References: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/inode.c          |  2 +-
 fs/nfs/nfs4proc.c       | 56 ++++++++++++-----------------------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 4 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 73edabb00a9d..99ee138a0a5e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -632,7 +632,7 @@ nfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (S_ISREG(inode->i_mode))
 		nfs_sync_inode(inode);
 
-	fattr = nfs_alloc_fattr();
+	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	if (fattr == NULL) {
 		error = -ENOMEM;
 		goto out;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7b9aecd20744..a3b204f2f85c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -97,8 +97,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 			      struct nfs_fattr *fattr, struct inode *inode);
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			    struct nfs_fattr *fattr, struct iattr *sattr,
-			    struct nfs_open_context *ctx, struct nfs4_label *ilabel,
-			    struct nfs4_label *olabel);
+			    struct nfs_open_context *ctx, struct nfs4_label *ilabel);
 #ifdef CONFIG_NFS_V4_1
 static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		const struct cred *cred,
@@ -3176,7 +3175,7 @@ static int _nfs4_do_open(struct inode *dir,
 			nfs_fattr_init(opendata->o_res.f_attr);
 			status = nfs4_do_setattr(state->inode, cred,
 					opendata->o_res.f_attr, sattr,
-					ctx, label, opendata->o_res.f_attr->label);
+					ctx, label);
 			if (status == 0) {
 				nfs_setattr_update_inode(state->inode, sattr,
 						opendata->o_res.f_attr);
@@ -3341,8 +3340,7 @@ static int _nfs4_do_setattr(struct inode *inode,
 
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			   struct nfs_fattr *fattr, struct iattr *sattr,
-			   struct nfs_open_context *ctx, struct nfs4_label *ilabel,
-			   struct nfs4_label *olabel)
+			   struct nfs_open_context *ctx, struct nfs4_label *ilabel)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	__u32 bitmask[NFS4_BITMASK_SZ];
@@ -3356,7 +3354,6 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 	};
 	struct nfs_setattrres  res = {
 		.fattr		= fattr,
-		.label		= olabel,
 		.server		= server,
 	};
 	struct nfs4_exception exception = {
@@ -3373,7 +3370,7 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		adjust_flags |= NFS_INO_INVALID_OTHER;
 
 	do {
-		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, olabel),
+		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label),
 					inode, adjust_flags);
 
 		err = _nfs4_do_setattr(inode, &arg, &res, cred, ctx);
@@ -4233,7 +4230,6 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 	struct inode *inode = d_inode(dentry);
 	const struct cred *cred = NULL;
 	struct nfs_open_context *ctx = NULL;
-	struct nfs4_label *label = NULL;
 	int status;
 
 	if (pnfs_ld_layoutret_on_setattr(inode) &&
@@ -4259,20 +4255,15 @@ nfs4_proc_setattr(struct dentry *dentry, struct nfs_fattr *fattr,
 			cred = ctx->cred;
 	}
 
-	label = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
-	if (IS_ERR(label))
-		return PTR_ERR(label);
-
 	/* Return any delegations if we're going to change ACLs */
 	if ((sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) != 0)
 		nfs4_inode_make_writeable(inode);
 
-	status = nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL, label);
+	status = nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL);
 	if (status == 0) {
 		nfs_setattr_update_inode(inode, sattr, fattr);
-		nfs_setsecurity(inode, fattr, label);
+		nfs_setsecurity(inode, fattr, fattr->label);
 	}
-	nfs4_label_free(label);
 	return status;
 }
 
@@ -6024,8 +6015,7 @@ static int nfs4_get_security_label(struct inode *inode, void *buf,
 
 static int _nfs4_do_set_security_label(struct inode *inode,
 		struct nfs4_label *ilabel,
-		struct nfs_fattr *fattr,
-		struct nfs4_label *olabel)
+		struct nfs_fattr *fattr)
 {
 
 	struct iattr sattr = {0};
@@ -6040,7 +6030,6 @@ static int _nfs4_do_set_security_label(struct inode *inode,
 	};
 	struct nfs_setattrres res = {
 		.fattr		= fattr,
-		.label		= olabel,
 		.server		= server,
 	};
 	struct rpc_message msg = {
@@ -6061,15 +6050,13 @@ static int _nfs4_do_set_security_label(struct inode *inode,
 
 static int nfs4_do_set_security_label(struct inode *inode,
 		struct nfs4_label *ilabel,
-		struct nfs_fattr *fattr,
-		struct nfs4_label *olabel)
+		struct nfs_fattr *fattr)
 {
 	struct nfs4_exception exception = { };
 	int err;
 
 	do {
-		err = _nfs4_do_set_security_label(inode, ilabel,
-				fattr, olabel);
+		err = _nfs4_do_set_security_label(inode, ilabel, fattr);
 		trace_nfs4_set_security_label(inode, err);
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
@@ -6080,32 +6067,21 @@ static int nfs4_do_set_security_label(struct inode *inode,
 static int
 nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 {
-	struct nfs4_label ilabel, *olabel = NULL;
-	struct nfs_fattr fattr;
+	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
+	struct nfs_fattr *fattr;
 	int status;
 
 	if (!nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
 		return -EOPNOTSUPP;
 
-	nfs_fattr_init(&fattr);
+	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
+	if (fattr == NULL)
+		return -ENOMEM;
 
-	ilabel.pi = 0;
-	ilabel.lfs = 0;
-	ilabel.label = (char *)buf;
-	ilabel.len = buflen;
-
-	olabel = nfs4_label_alloc(NFS_SERVER(inode), GFP_KERNEL);
-	if (IS_ERR(olabel)) {
-		status = -PTR_ERR(olabel);
-		goto out;
-	}
-
-	status = nfs4_do_set_security_label(inode, &ilabel, &fattr, olabel);
+	status = nfs4_do_set_security_label(inode, &ilabel, fattr);
 	if (status == 0)
-		nfs_setsecurity(inode, &fattr, olabel);
+		nfs_setsecurity(inode, fattr, fattr->label);
 
-	nfs4_label_free(olabel);
-out:
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b002a39d39ea..5c7d37633cc8 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6616,7 +6616,7 @@ static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp,
 	status = decode_setattr(xdr);
 	if (status)
 		goto out;
-	decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 817f1bf5f187..967a0098f0a9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -832,7 +832,6 @@ struct nfs_getaclres {
 struct nfs_setattrres {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs_fattr *              fattr;
-	struct nfs4_label		*label;
 	const struct nfs_server *	server;
 };
 
-- 
2.33.0

