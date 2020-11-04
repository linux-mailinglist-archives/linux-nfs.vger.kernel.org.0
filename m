Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA92A69B0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgKDQ1O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbgKDQ1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:14 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F94C061A4A
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:13 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so5249360qtp.7
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w3qSV6/1/FQDA62kfZdJX3U8JfpYXaEx8nE11jTGprM=;
        b=lrw6iy7lAYZF1WvUHdIlI7ZoHLSalCsLRiQtd5tah2lg3GYkSnPqc8vjEGvMrD5f2C
         0NpKlpYnOggy5WyZpHOsxRrUvktQn6wHH1LSg6nq0WNUD/MEMk4xv39w+7isEpdRG22k
         0z1RFQt8/h3ETrJJcZ13iDMdBKXg9brPnz53GHWTvLnQybJYaG7cb6JJ7QHl1tRLNWht
         ozPfsdpAId05dpJ5UXcMxWcZItk8UknihfHUDXOHWYsDavzXVtKqpDXi96bzDEkWcQN+
         0zJjZ4jS86pp2vBr36ZwTaeJQlAzMR2iA2NtbQx/zSutDqfnzNgT1RpXWdsTRz5shvIx
         0smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3qSV6/1/FQDA62kfZdJX3U8JfpYXaEx8nE11jTGprM=;
        b=WFrDGJ9f3goqOYqnngJo/akPzXAWMsavjDcxZP2LpRBM7kOb0zMayVChmAd9SHxlFt
         t4A0/W5tRSvBESU+hTjijarn+OTVlTCiDnTD8xVIYduy8eQmLxaQqM8emKVBB/JIutjP
         Q024Yni6XQqZMbRPNS0cANQHYxZXjp0BmfHv6h9kZmTqdfCJZENI/LuoEHh/T4LYPws2
         FyW5hUxo1kNWu+DZeBMUDa9ajjFK1g90nLf9FZxwOI+xyFok8HpCrZ3qWPljuBqM23j5
         PaxN3MDWZd1gHs41wsVgEwpODolKG37tw2YdUQ66PiKQfidkSNGXqqFOn4mnwkpCyFzR
         Hp/w==
X-Gm-Message-State: AOAM532DrA9oOkAF4RLYRIjgd8U3shkli7xa8FNaoN/hiwJmph2zEZ9X
        92phokuqyaLhfpgsF5M3wKUdumZtWpks
X-Google-Smtp-Source: ABdhPJx8QXX2BLWsW8iGDLQRY4kCgSMJiaUHCWuFm+lCRSkYmwrEHqlryDg7cG0xpl3XvmZMLjmgpg==
X-Received: by 2002:ac8:590c:: with SMTP id 12mr12387889qty.28.1604507232532;
        Wed, 04 Nov 2020 08:27:12 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:11 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/17] NFS: More readdir cleanups
Date:   Wed,  4 Nov 2020 11:16:31 -0500
Message-Id: <20201104161638.300324-11-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-10-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the redundant caching of the credential in struct
nfs_open_dir_context.
Pass the buffer size as an argument to nfs_readdir_xdr_filler().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 25 +++++++++++--------------
 include/linux/nfs_fs.h |  1 -
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 438906dae083..bc366bd8e8f3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -68,7 +68,7 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
-static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir, const struct cred *cred)
+static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
 	struct nfs_open_dir_context *ctx;
@@ -78,7 +78,6 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->attr_gencount = nfsi->attr_gencount;
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
-		ctx->cred = get_cred(cred);
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -96,7 +95,6 @@ static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_cont
 	spin_lock(&dir->i_lock);
 	list_del(&ctx->list);
 	spin_unlock(&dir->i_lock);
-	put_cred(ctx->cred);
 	kfree(ctx);
 }
 
@@ -113,7 +111,7 @@ nfs_opendir(struct inode *inode, struct file *filp)
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 
-	ctx = alloc_nfs_open_dir_context(inode, current_cred());
+	ctx = alloc_nfs_open_dir_context(inode);
 	if (IS_ERR(ctx)) {
 		res = PTR_ERR(ctx);
 		goto out;
@@ -468,12 +466,12 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 }
 
 /* Fill a page with xdr information before transferring to the cache page */
-static
-int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
-			struct nfs_entry *entry, struct file *file, struct inode *inode)
+static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
+				  u64 cookie, struct page **pages,
+				  size_t bufsize)
 {
-	struct nfs_open_dir_context *ctx = file->private_data;
-	const struct cred *cred = ctx->cred;
+	struct file *file = desc->file;
+	struct inode *inode = file_inode(file);
 	unsigned long	timestamp, gencount;
 	int		error;
 
@@ -481,8 +479,8 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
 	timestamp = jiffies;
 	gencount = nfs_inc_attr_generation_counter();
 	desc->dir_verifier = nfs_save_change_attribute(inode);
-	error = NFS_PROTO(inode)->readdir(file_dentry(file), cred, entry->cookie, pages,
-					  NFS_SERVER(inode)->dtsize, desc->plus);
+	error = NFS_PROTO(inode)->readdir(file_dentry(file), file->f_cred,
+					  cookie, pages, bufsize, desc->plus);
 	if (error < 0) {
 		/* We requested READDIRPLUS, but the server doesn't grok it */
 		if (error == -ENOTSUPP && desc->plus) {
@@ -764,7 +762,6 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 {
 	struct page **pages;
 	struct nfs_entry entry;
-	struct file	*file = desc->file;
 	size_t array_size;
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
@@ -791,8 +788,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
-
+		status = nfs_readdir_xdr_filler(desc, entry.cookie,
+						pages, dtsize);
 		if (status < 0)
 			break;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a2c6455ea3fa..dd6b463dda80 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -88,7 +88,6 @@ struct nfs_open_context {
 
 struct nfs_open_dir_context {
 	struct list_head list;
-	const struct cred *cred;
 	unsigned long attr_gencount;
 	__u64 dir_cookie;
 	__u64 dup_cookie;
-- 
2.28.0

