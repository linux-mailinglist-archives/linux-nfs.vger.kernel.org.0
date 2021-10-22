Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA839437B8F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhJVRNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhJVRNe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 13:13:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D5C061767
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 77so5252902qkh.6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATXqp+u2xOFY4EmAsSU7YBw6zEz6R5+BwfQfDiixPWE=;
        b=N1GUZft7Cv4FFBoNwRWK6k95pOtHW5svC8kYNqlrisvve0DMfUmCILz5kczki0Osxy
         b4GxU1QngdNfgd9Ak6IxNIY7WIx8PeEkgiRol5TSjhhGiNpe8mn7jFCedXBZc4WZXs1X
         mcCr5nC2ptQPD7gFR/uWS4TEJ1MmCZ0aFWQLxP+icioW59rKi7KKGUHPGWi7hosTI1fX
         85tHhCRTe1u1Puex/of6HhRfjW3ztXoSwfhNoZD2dOAqkor0iOvss6ID5+E/+uqSfaCI
         xPLe8nWaZnWrTkt7UheoRlusSCalyxpp2D5OqFaWqi5pjhpvooa1Hzof3/GZ9FAXAgqM
         nlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ATXqp+u2xOFY4EmAsSU7YBw6zEz6R5+BwfQfDiixPWE=;
        b=oXUCpdOrr/DP2h6LKxesjOdNM51s9a/65z12UlqRkFn11LcAX0IwnxhuF77/J9rbhw
         /JTJ7+zrfptsK4RcXgtSBH+LkoymL0IfUkWZ8xAUbBlhT4eJzhsN8/7DjyOKbE84AQkA
         XswREvn2evoAMrTxoZ0QaJGt26FKfGckR46+uR7KkwKCitURVwDsS2ihhZCuovcQgTZf
         l0xjxlaNw8VX95iMf5Hx6pqxhICxVjF0GKJReKJ0FCheW0dpWh1+Ylf0C2ULHQw8YunT
         5914iJFqh7ZJBymn1ysExH50jhfcPWYpRpjwVU51C+O9MrStzofXQgiUMUGJVaRQZfl4
         ck+A==
X-Gm-Message-State: AOAM532PmJ0qQS/rJTazVuIvCgTkfq9B0ZAc1l/3My5UOEjfGVZcn/hU
        bZGwR6+qbKDRQw/ZzYvsUSM=
X-Google-Smtp-Source: ABdhPJwQ5sPokgAvarlKjZz9ddKTMApleheOOx9yOMUbx1IVpP1pu+STbG7ML5Q68fuHEhi0WKB1kg==
X-Received: by 2002:ae9:de82:: with SMTP id s124mr1120567qkf.182.1634922675503;
        Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id s22sm4484586qko.135.2021.10.22.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:11:15 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 02/14] NFS: Remove the nfs4_label from the nfs_entry struct
Date:   Fri, 22 Oct 2021 13:11:01 -0400
Message-Id: <20211022171113.16739-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
References: <20211022171113.16739-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And instead allocate the fattr using nfs_alloc_fattr_with_label()

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/dir.c            | 21 +++++++--------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  1 -
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..3daa1fd60751 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -680,7 +680,8 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 			nfs_set_verifier(dentry, dir_verifier);
 			status = nfs_refresh_inode(d_inode(dentry), entry->fattr);
 			if (!status)
-				nfs_setsecurity(d_inode(dentry), entry->fattr, entry->label);
+				nfs_setsecurity(d_inode(dentry), entry->fattr,
+						entry->fattr->label);
 			goto out;
 		} else {
 			d_invalidate(dentry);
@@ -694,7 +695,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		goto out;
 	}
 
-	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr, entry->label);
+	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr, entry->fattr->label);
 	alias = d_splice_alias(inode, dentry);
 	d_lookup_done(dentry);
 	if (alias) {
@@ -730,8 +731,8 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	xdr_set_scratch_page(&stream, scratch);
 
 	do {
-		if (entry->label)
-			entry->label->len = NFS4_MAXLABELLEN;
+		if (entry->fattr->label)
+			entry->fattr->label->len = NFS4_MAXLABELLEN;
 
 		status = xdr_decode(desc, entry, &stream);
 		if (status != 0)
@@ -836,21 +837,15 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 		return -ENOMEM;
 	entry->cookie = nfs_readdir_page_last_cookie(page);
 	entry->fh = nfs_alloc_fhandle();
-	entry->fattr = nfs_alloc_fattr();
+	entry->fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	entry->server = NFS_SERVER(inode);
 	if (entry->fh == NULL || entry->fattr == NULL)
 		goto out;
 
-	entry->label = nfs4_label_alloc(NFS_SERVER(inode), GFP_NOWAIT);
-	if (IS_ERR(entry->label)) {
-		status = PTR_ERR(entry->label);
-		goto out;
-	}
-
 	array_size = (dtsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pages = nfs_readdir_alloc_pages(array_size);
 	if (!pages)
-		goto out_release_label;
+		goto out;
 
 	do {
 		unsigned int pglen;
@@ -873,8 +868,6 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	} while (!status && nfs_readdir_page_needs_filling(page));
 
 	nfs_readdir_free_pages(pages, array_size);
-out_release_label:
-	nfs4_label_free(entry->label);
 out:
 	nfs_free_fattr(entry->fattr);
 	nfs_free_fhandle(entry->fh);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index a8cff19c6f00..466b2832de75 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7475,7 +7475,7 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 		return -EAGAIN;
 
 	if (decode_getfattr_attrs(xdr, bitmap, entry->fattr, entry->fh,
-			NULL, entry->label, entry->server) < 0)
+			NULL, entry->fattr->label, entry->server) < 0)
 		return -EAGAIN;
 	if (entry->fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
 		entry->ino = entry->fattr->mounted_on_fileid;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e9698b6278a5..9960f6628066 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -753,7 +753,6 @@ struct nfs_entry {
 	int			eof;
 	struct nfs_fh *		fh;
 	struct nfs_fattr *	fattr;
-	struct nfs4_label  *label;
 	unsigned char		d_type;
 	struct nfs_server *	server;
 };
-- 
2.33.1

