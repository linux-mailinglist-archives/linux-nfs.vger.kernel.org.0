Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A140D437B95
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhJVRNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhJVRNi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD397C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bp7so5119667qkb.12
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im5gNdi/BYCmkzFIwwDZYBuPYVM44ZJF52eTBUgQ6gA=;
        b=qVmGEBD10BoeJMGLTywSdYt7ei8VIbahCYbUZk1KVEFRynIJ9n186+iKM2vmiM7grX
         fVD8dHXaeImOIYGyZ9Nz1OrZORNd+mk1GJxCRmbM4YdwE01WOJsVEvHJWvc9tx5kCOLd
         GgxlQ3a1zYr6LziWxWDCardmAVCFctnNT9AHByT4kY3NOa3+R7n7PdtEZLXudEAoXhqe
         N7s38k+wbXfQ/zYtecNWU2odWOzct71NAq/C9gUsJqaa/CqR2zKd1zCyd7b/Sza0snbA
         Yep9GFUQxs16sH9uFJU0krCqbPMtDr0WjS8CD+dnwXlOtCVVlnzrVG8vO8ArLYfVx+MZ
         xEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=im5gNdi/BYCmkzFIwwDZYBuPYVM44ZJF52eTBUgQ6gA=;
        b=TaFt9YyDp8vM126qMAAD3ofKaGsV3YPDxE0vJHkqCgvH9FG8g38O1bIUpCUz7uqCIK
         8e1+GKHaCgRyuEfwyxsUXSk5i6xeHDAuMZhSO6akcr0unM4D1Kdan4LgAlljCN2PJqED
         2HVKfxutMcslTcvueDtAulqvEo21GVtjDuiqlQxKcOvWeGhy0PTxJmIdeL2i+wNioDUa
         fF0yGe4uNrQIovyk2bdJLKAQosFlw5vx5Q/n5EABroxRK2IMF0JAXIISmnKPPvWLtjMA
         ShZXgM5KUJ2SZB82WPaEcPfEKnQC3li31biODDFnk+3T5Djl+4PJ5/prC0Z0c1msZLgG
         ycEQ==
X-Gm-Message-State: AOAM531EzK9NtVrfyVDhjVOktzvLoBgqxgfIg367frwH81modh6LH7nD
        pkCIo0rTmdvjZtsD3drFU4o=
X-Google-Smtp-Source: ABdhPJzP8iEWEHon+ZpvDzcmmvj5OfivwL3dcnQnBD/wyr/aSQ6lAw5j/Xax55YcQLI2JtrmI2cwHw==
X-Received: by 2002:a05:620a:1aa1:: with SMTP id bl33mr1041408qkb.411.1634922680016;
        Fri, 22 Oct 2021 10:11:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:19 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 09/14] NFS: Remove the nfs4_label from the nfs_setattrres
Date:   Fri, 22 Oct 2021 13:11:08 -0400
Message-Id: <20211022171113.16739-10-Anna.Schumaker@Netapp.com>
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
2.33.1

