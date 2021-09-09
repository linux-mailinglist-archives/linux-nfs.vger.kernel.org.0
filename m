Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82B405DE5
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245526AbhIIUOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhIIUOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B0C061762
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:33 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so3251091qke.7
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAUVXySS3u1L9H7GvvonXco2egjKnkr3auSgqBhT7M0=;
        b=GRmfBSRXt+q9QtMNsAA8zWZgzhpkecXGUsLbF84vCNcj56KQ2jSX1n7LCmmHDWSGBA
         cKpDgJ5MfIFrisbDSMesLnaV1l9AXjH+w2QH0rnJPOqeUfVjc4YqWirThQSdsd0PTL18
         K5n/OQwLvRWWmlgQmTJh3m82Adw6OjIk8NDZM6CzNeUfhk66Ff5RrbKHumwgNXV4h+AK
         Kgx2D5HFNJ/3dq2/sZ6wRZC14xsfgKuEebkCCxExyL5EbsO2l9BYPEYjpUl6ktBx9Ahx
         GDNSrGjNZSifsr8mujfzeYGsfJP+CgFeiL9dydFQ2sSxU/jNToJaZdnJzrK445ysIE29
         OwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kAUVXySS3u1L9H7GvvonXco2egjKnkr3auSgqBhT7M0=;
        b=T4KUJkL6TFer7sJFR9CSsHR9othVNbLtutGyoRptn945k9DapyrClq6/VbL8e40d1T
         ai2Uy+z36icerRUGdN6VNqJLYTTDz0DU+637Kdg6M3mIKboA6zWGSUR4CAbAperH3Vt4
         MPfeTFtNtzsE6r701YEcTiqPqfhhjoCjDIrcPBaAOu2ABcIFwLgwtaJHm3dnKk452SFk
         2IeRqBe7qbLfn1IkF99xgzcdRBZjzAb9u0eI5XEoGnayiyfdMHpTIC3l/V2w+jvLdjY2
         n2l2To7GOrgyZyqoWDbS1xJI2zzI7QmNyBLONN3EUpZmcMZTmLaOrQJSqNfEaR97zB8o
         hAAw==
X-Gm-Message-State: AOAM530BioJboGqvzKCiN/cPDs8KuVwDcrC533IahDqUZTiJAo4fGUuO
        UDtyMPC+wpGIWQCskZfBfDE=
X-Google-Smtp-Source: ABdhPJyXf1FjjlsmDsJPs4FMrPqzThCzsmfwDuFn7svfsxVQSHQ0et/PIYfRL8T2xsQyQOaR3Cl9lA==
X-Received: by 2002:a05:620a:f8a:: with SMTP id b10mr4600218qkn.424.1631218412233;
        Thu, 09 Sep 2021 13:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:31 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 06/14] NFS: Remove the nfs4_label from the nfs4_lookupp_res struct
Date:   Thu,  9 Sep 2021 16:13:19 -0400
Message-Id: <20210909201327.108759-7-Anna.Schumaker@Netapp.com>
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
 fs/nfs/export.c         | 26 +++++++-------------------
 fs/nfs/nfs3proc.c       |  2 +-
 fs/nfs/nfs4proc.c       | 10 ++++------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 37a1a88df771..b7c15fa4bf37 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -131,7 +131,6 @@ nfs_get_parent(struct dentry *dentry)
 	struct super_block *sb = inode->i_sb;
 	struct nfs_server *server = NFS_SB(sb);
 	struct nfs_fattr *fattr = NULL;
-	struct nfs4_label *label = NULL;
 	struct dentry *parent;
 	struct nfs_rpc_ops const *ops = server->nfs_client->rpc_ops;
 	struct nfs_fh fh;
@@ -139,31 +138,20 @@ nfs_get_parent(struct dentry *dentry)
 	if (!ops->lookupp)
 		return ERR_PTR(-EACCES);
 
-	fattr = nfs_alloc_fattr();
-	if (fattr == NULL) {
-		parent = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	fattr = nfs_alloc_fattr_with_label(server);
+	if (fattr == NULL)
+		return ERR_PTR(-ENOMEM);
 
-	label = nfs4_label_alloc(server, GFP_KERNEL);
-	if (IS_ERR(label)) {
-		parent = ERR_CAST(label);
-		goto out_free_fattr;
-	}
-
-	ret = ops->lookupp(inode, &fh, fattr, label);
+	ret = ops->lookupp(inode, &fh, fattr);
 	if (ret) {
 		parent = ERR_PTR(ret);
-		goto out_free_label;
+		goto out;
 	}
 
-	pinode = nfs_fhget(sb, &fh, fattr, label);
+	pinode = nfs_fhget(sb, &fh, fattr, fattr->label);
 	parent = d_obtain_alias(pinode);
-out_free_label:
-	nfs4_label_free(label);
-out_free_fattr:
-	nfs_free_fattr(fattr);
 out:
+	nfs_free_fattr(fattr);
 	return parent;
 }
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index f0208a7a8dc9..84cbfbc55184 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -209,7 +209,7 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 }
 
 static int nfs3_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
-			     struct nfs_fattr *fattr, struct nfs4_label *label)
+			     struct nfs_fattr *fattr)
 {
 	const char dotdot[] = "..";
 	const size_t len = strlen(dotdot);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 49e077841e98..7e02c698c60f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4417,8 +4417,7 @@ nfs4_proc_lookup_mountpoint(struct inode *dir, struct dentry *dentry,
 }
 
 static int _nfs4_proc_lookupp(struct inode *inode,
-		struct nfs_fh *fhandle, struct nfs_fattr *fattr,
-		struct nfs4_label *label)
+		struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	struct rpc_clnt *clnt = NFS_CLIENT(inode);
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -4430,7 +4429,6 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	struct nfs4_lookupp_res res = {
 		.server = server,
 		.fattr = fattr,
-		.label = label,
 		.fh = fhandle,
 	};
 	struct rpc_message msg = {
@@ -4443,7 +4441,7 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	args.bitmask = nfs4_bitmask(server, label);
+	args.bitmask = nfs4_bitmask(server, fattr->label);
 
 	nfs_fattr_init(fattr);
 
@@ -4455,14 +4453,14 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 }
 
 static int nfs4_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
-			     struct nfs_fattr *fattr, struct nfs4_label *label)
+			     struct nfs_fattr *fattr)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	int err;
 	do {
-		err = _nfs4_proc_lookupp(inode, fhandle, fattr, label);
+		err = _nfs4_proc_lookupp(inode, fhandle, fattr);
 		trace_nfs4_lookupp(inode, err);
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index fc5c987d8ad9..77467216cd5d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6209,7 +6209,7 @@ static int nfs4_xdr_dec_lookupp(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_getfh(xdr, res->fh);
 	if (status)
 		goto out;
-	status = decode_getfattr_label(xdr, res->fattr, res->label, res->server);
+	status = decode_getfattr_label(xdr, res->fattr, res->fattr->label, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 95219d5a8668..f0a685d9b8bd 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1108,7 +1108,6 @@ struct nfs4_lookupp_res {
 	const struct nfs_server		*server;
 	struct nfs_fattr		*fattr;
 	struct nfs_fh			*fh;
-	struct nfs4_label		*label;
 };
 
 struct nfs4_lookup_root_arg {
@@ -1741,7 +1740,7 @@ struct nfs_rpc_ops {
 	int	(*lookup)  (struct inode *, struct dentry *,
 			    struct nfs_fh *, struct nfs_fattr *);
 	int	(*lookupp) (struct inode *, struct nfs_fh *,
-			    struct nfs_fattr *, struct nfs4_label *);
+			    struct nfs_fattr *);
 	int	(*access)  (struct inode *, struct nfs_access_entry *);
 	int	(*readlink)(struct inode *, struct page *, unsigned int,
 			    unsigned int);
-- 
2.33.0

