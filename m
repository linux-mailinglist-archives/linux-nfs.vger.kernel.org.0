Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F7437B91
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhJVRNu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhJVRNg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB0C061767
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id r15so5201375qkp.8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUY6Pr0LbnVoGK2T5GCq7km/HYAYOUWqp0fq63GehQI=;
        b=pHySW19zKRbgOeTLt+pgA9zDWfaAA3L2x0dg5mYy8jLSYiuRPEwEi7qpBao+HMOWP7
         yxmKjHJXbvz10RWA4oeakp6lxHfIqxIPYKKze2O9Hey3DqPXDutQiC8trFR+sWGBc5+r
         bWfAKv6k1zpRRCMs3jCeDTgmCbB+i68tksLUZ7IE3rWpk/cb1YSibyxefxCpkdAQOnKb
         HqMiBjnjTsWnl14tyHvzoMBMwy8osS42QcbLgrv+GSxJC4rqE8z8+BndBaf7YL4Y3THf
         gXM6rcQW/QYOyg/hsBSmWwKTsYr5Zop0A3o0zjyj2FVhAyTAzvaik9yCo+WsULONfWlV
         9vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gUY6Pr0LbnVoGK2T5GCq7km/HYAYOUWqp0fq63GehQI=;
        b=GSN0vNZXqv/lFkKlKHoPlCTf+WI9LvbI+lxAD4UaFqp9kM41M1SbsmQg0vqjsO4gfw
         x8MerI5u7RmANj3SoBBRMvu3MKQUYYeLdvMEp7Z/3jP5hjDBpnK00hJxRsgEEHFHe+Lr
         VxI4Njo5uWANVFCgVyru3LmrFIkZdseD09n020EyEkXH7UD6NuwujXVbYI2uF6upSjxc
         M5WZzgap1PwN5b5vIfUx8kMnuoEPvRPAFjVgchzMfUb6Aem8o/kDocXNXD1QuBSmzYbo
         UOLcU/D/inXIqFrstL09jZn8OPE6NaYkKiXETp2AFSZ6ymP4WP4xep71DU2JmcjmbPE5
         f8CQ==
X-Gm-Message-State: AOAM5335GWQUrhZdPI0pKNrnmAPeAeYPg6vvs7A31mWjOBG6J9CEc9+Y
        cfqbu6qnsa2mVV8NL3M/5DI=
X-Google-Smtp-Source: ABdhPJyYIY13c9QMtSd7k0DBVVcHYAb6oz72nYJaUYsV78YqMgH/LChZbScFC19G8q20xCJnBSv4Gg==
X-Received: by 2002:a37:a5d1:: with SMTP id o200mr1136919qke.30.1634922678147;
        Fri, 22 Oct 2021 10:11:18 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:17 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 06/14] NFS: Remove the nfs4_label from the nfs4_lookupp_res struct
Date:   Fri, 22 Oct 2021 13:11:05 -0400
Message-Id: <20211022171113.16739-7-Anna.Schumaker@Netapp.com>
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
 fs/nfs/export.c         | 26 +++++++-------------------
 fs/nfs/nfs3proc.c       |  2 +-
 fs/nfs/nfs4proc.c       | 10 ++++------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index d772c20bbfd1..895b404888dd 100644
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
index 717eb651f0fd..516f3340b226 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -208,7 +208,7 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
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
2.33.1

