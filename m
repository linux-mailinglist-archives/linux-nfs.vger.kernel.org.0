Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA149338E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiASDRW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 22:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiASDRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 22:17:21 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2736C061574
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 19:17:21 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id t1so1508683qvp.4
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 19:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB3O603X/2apNdQO8zjVx4mhog3iRL/2sgo/eAaFN20=;
        b=lviWytN6P567cQMl4zuTWZ/m5IOsOPWr83UhSU5S+KLf9kHBbdEJA1bmSWLkH+pFE6
         s7UHzFaOAaB2qQ6hdRwvUrjejbkeFMa7pXy2JLFaBwnKk0SB9zQBnFzbzZ+5s4/rSjMt
         /kzf6Sd6yCjptFoxirBCYCelQHE+DenijzFQGdPfLRlBk5BxsDBQaZ83j2h19yWBq+9J
         GQ69lgYAiR87GhohiqDSPhBLaJ1vvnA4I+y1VSZCmXtt2aLZqBziz4e0mXCV92AuWX5T
         72p9DCOVSQN0W+DJTDGu16I1u1HcPXq1tISzuXbxDA5NhoCOD/6Q8IlQzykM5Z58z8Y2
         bpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB3O603X/2apNdQO8zjVx4mhog3iRL/2sgo/eAaFN20=;
        b=Vijwh+MjNqEutFBGEWXzfanJTn1beHG6ePHNLflt6w8SW293XQgtZSvRbAgwljUSRl
         +093Y7tr+7e4oQE5U+h6EIEXPsEJY3i+15U2hNvnC4x1d4OFiY61qI1nJwmNsX9pnmTz
         ySVGWBmsgHEp3KSce90+y2uF0Qs8Q3nqONtNbSzJnpaB0gkueeSMAFGRMyp7FFttgy7r
         XOSN6+nW/oOzt2L1hi6Y0/gObn+ZELG/ibuo1fMX3bNbrMSMSF9ZUghZWaq9OUAVJPZJ
         SAaDk0+P4iadMetF1n/2WrR26kN9WfWvIaT+XDYDVHP0radSG0wDJRNNI5+A3RF/NnPq
         Kk2Q==
X-Gm-Message-State: AOAM531S4t3awInnCq+RN+dHCW3yvkB4vo/yXGPeMZWJQFDgK9XZO1DL
        YRNKAC2l8G7TPLhD4/rIRAs+e0yjtQ==
X-Google-Smtp-Source: ABdhPJxNUEOg59qClsbnZip5ZL0SHfQYl3wyVM3Dv8zaNu82umxwKL26h5LBngfFH8HR90VJCTpSmA==
X-Received: by 2002:a05:6214:e47:: with SMTP id o7mr11622617qvc.118.1642562240562;
        Tue, 18 Jan 2022 19:17:20 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w9sm12436156qko.71.2022.01.18.19.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 19:17:19 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Avoid duplicate uncached readdir calls on eof
Date:   Tue, 18 Jan 2022 22:10:52 -0500
Message-Id: <20220119031052.302179-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we've reached the end of the directory, then cache that information
in the context so that we don't need to do an uncached readdir in order
to rediscover that fact.

Fixes: 794092c57f89 ("NFS: Do uncached readdir when we're seeking a cookie in an empty page cache")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 20 +++++++++++++++-----
 include/linux/nfs_fs.h |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 07ad7095fffb..87236a8e5817 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -79,6 +79,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
 		ctx->page_index = 0;
+		ctx->eof = false;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -167,6 +168,7 @@ struct nfs_readdir_descriptor {
 	unsigned int	cache_entry_index;
 	signed char duped;
 	bool plus;
+	bool eob;
 	bool eof;
 };
 
@@ -988,7 +990,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 		ent = &array->array[i];
 		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
 		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
-			desc->eof = true;
+			desc->eob = true;
 			break;
 		}
 		memcpy(desc->verf, verf, sizeof(desc->verf));
@@ -1004,7 +1006,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			desc->duped = 1;
 	}
 	if (array->page_is_eof)
-		desc->eof = true;
+		desc->eof = !desc->eob;
 
 	kunmap(desc->page);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
@@ -1047,7 +1049,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
-	for (i = 0; !desc->eof && i < sz && arrays[i]; i++) {
+	for (i = 0; !desc->eob && i < sz && arrays[i]; i++) {
 		desc->page = arrays[i];
 		nfs_do_filldir(desc, verf);
 	}
@@ -1106,9 +1108,15 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->duped = dir_ctx->duped;
 	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
+	desc->eof = dir_ctx->eof;
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
+	if (desc->eof) {
+		res = 0;
+		goto out_free;
+	}
+
 	if (test_and_clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags) &&
 	    list_is_singular(&nfsi->open_files))
 		invalidate_mapping_pages(inode->i_mapping, page_index + 1, -1);
@@ -1142,7 +1150,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
-	} while (!desc->eof);
+	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
 	dir_ctx->dir_cookie = desc->dir_cookie;
@@ -1150,9 +1158,10 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
+	dir_ctx->eof = desc->eof;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
-
+out_free:
 	kfree(desc);
 
 out:
@@ -1194,6 +1203,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
+		dir_ctx->eof = false;
 	}
 	spin_unlock(&filp->f_lock);
 	return offset;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 05f249f20f55..6a872d269bb9 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -105,6 +105,7 @@ struct nfs_open_dir_context {
 	__u64 dup_cookie;
 	pgoff_t page_index;
 	signed char duped;
+	bool eof;
 };
 
 /*
-- 
2.34.1

