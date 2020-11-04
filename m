Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9422A69AD
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgKDQ1R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:16 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA7C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:15 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x20so19839228qkn.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t7Ey1sfa1pwR5vNbG6pigwJU2WMDmtROpcMLzXcWqGE=;
        b=PrYCbf+fhQLGh2UTr8Rv1yRCaAWw1TF/IMrx1ilHv/4UA64DU5zgyeI5nfVauJoiph
         m6wMjQpM80bgvG5XYUEEeOk03CtkXLkXuS5HGzdLt3ZfUHpm5YUzZbZmUhWQBJuS3cMV
         HwYXQ7N3Xb2DpmFZ9RG+qQCT9NASbkNmFKCg8gMkPH7tEmPAEHjBninB7F4CrxOAxicW
         H7CBe51xfaYssYwgrRzZk0ejjp8CmMiEuzgV9Lsxx/0Kbnvp+tbS8JZXrlRqfrVhAqUK
         b/Jo/kkxwOVWp9AECjbCsH21Tvt4AvbhqGy/pPlCSxy+Q6kULevQxBpji4c7kRLeT8aF
         XDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7Ey1sfa1pwR5vNbG6pigwJU2WMDmtROpcMLzXcWqGE=;
        b=XWH6z3duZ5JXqjGqsL6+2ak7BCwyRPsQYZwy8vNvhp/y2vSrMFy4tj8Y52yLroTVD0
         1mUmCB6FF3reKG+9ENeVrP7YtHgEFYSTOR1Rm/bAM7mDK7ONosgmPTACs90s+4+p7kP0
         K64KCPMX+DJc6LhzSQ+glr28a3JlyucfXYhliAyi7Xr+fY7+RQxTsMSpIYwZp35d9KM+
         BYvDG4BwwsWyB23MEh3c19JLmrqsH4H3CHZ94IARNiJyhxSxzWhGYbALs0N7TC8ty1O/
         zyb5WNOhlsIDLaSM5J9uneTqhAwhSCRhLIaTU7+BnVA+A179gxXsH5g5LsGx1ynMsfGn
         +OtA==
X-Gm-Message-State: AOAM530gwc0CDg4c940fAGK4tbXzF8/eCkQT51bYjpq5NacwLHkuemQ4
        vV2YADsrbwZG1Hy3zAlLMbWwayPGv3Zg
X-Google-Smtp-Source: ABdhPJzyn7XImTdpts21rpRFfctLbyYixB1CJWdKSmyd8LSDGvvMEv9mM2tYMcNiBx+0rK2Tdbfs1Q==
X-Received: by 2002:a37:a68b:: with SMTP id p133mr24853911qke.272.1604507234714;
        Wed, 04 Nov 2020 08:27:14 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:13 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 12/17] NFS: Reduce readdir stack usage
Date:   Wed,  4 Nov 2020 11:16:33 -0500
Message-Id: <20201104161638.300324-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-12-trond.myklebust@hammerspace.com>
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
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The descriptor and the struct nfs_entry are both large structures,
so don't allocate them from the stack.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 58 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 48856cee10de..c3af54640f6c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -761,23 +761,24 @@ static
 int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
 {
 	struct page **pages;
-	struct nfs_entry entry;
+	struct nfs_entry *entry;
 	size_t array_size;
 	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
 
-	entry.prev_cookie = 0;
-	entry.cookie = nfs_readdir_page_last_cookie(page);
-	entry.eof = 0;
-	entry.fh = nfs_alloc_fhandle();
-	entry.fattr = nfs_alloc_fattr();
-	entry.server = NFS_SERVER(inode);
-	if (entry.fh == NULL || entry.fattr == NULL)
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->cookie = nfs_readdir_page_last_cookie(page);
+	entry->fh = nfs_alloc_fhandle();
+	entry->fattr = nfs_alloc_fattr();
+	entry->server = NFS_SERVER(inode);
+	if (entry->fh == NULL || entry->fattr == NULL)
 		goto out;
 
-	entry.label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
-	if (IS_ERR(entry.label)) {
-		status = PTR_ERR(entry.label);
+	entry->label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
+	if (IS_ERR(entry->label)) {
+		status = PTR_ERR(entry->label);
 		goto out;
 	}
 
@@ -788,7 +789,7 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 	do {
 		unsigned int pglen;
-		status = nfs_readdir_xdr_filler(desc, entry.cookie,
+		status = nfs_readdir_xdr_filler(desc, entry->cookie,
 						pages, dtsize);
 		if (status < 0)
 			break;
@@ -799,15 +800,16 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 			break;
 		}
 
-		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
+		status = nfs_readdir_page_filler(desc, entry, pages, page, pglen);
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_label:
-	nfs4_label_free(entry.label);
+	nfs4_label_free(entry->label);
 out:
-	nfs_free_fattr(entry.fattr);
-	nfs_free_fhandle(entry.fh);
+	nfs_free_fattr(entry->fattr);
+	nfs_free_fhandle(entry->fh);
+	kfree(entry);
 	return status;
 }
 
@@ -974,13 +976,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
-	nfs_readdir_descriptor_t my_desc = {
-		.file = file,
-		.ctx = ctx,
-		.plus = nfs_use_readdirplus(inode, ctx),
-	},
-			*desc = &my_desc;
-	int res = 0;
+	struct nfs_readdir_descriptor *desc;
+	int res;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
 			file, (long long)ctx->pos);
@@ -992,10 +989,19 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
+	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
 		res = nfs_revalidate_mapping(inode, file->f_mapping);
-	if (res < 0)
+		if (res < 0)
+			goto out;
+	}
+
+	res = -ENOMEM;
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		goto out;
+	desc->file = file;
+	desc->ctx = ctx;
+	desc->plus = nfs_use_readdirplus(inode, ctx);
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1040,6 +1046,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	spin_unlock(&file->f_lock);
 
+	kfree(desc);
+
 out:
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
-- 
2.28.0

