Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6772562955
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391667AbfGHTYx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43350 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfGHTYx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:53 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so37810233ios.10
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bIJpgprQPfxBsVxXDMaXUeK2hzuj27H2g/+Kc9t54wc=;
        b=XZMguoSsFIHqkPYSXlyyXWDGh6B9aMEiQzl6UIDyOigyqChh/Bup4JPT9SrI/N0xgI
         1+8rfP7LZruFL1gw2/64i/ZoGAp1p1E/3fiBdGZNcjKCXK3kz61wYY2ztfMWIv4ZR2/K
         lXOJcKgUcgUFFsZVhAFcDgXarrnQE9EhvYaQY/NUtO0JsF2UuggCPw+yPoxvu3lHUam3
         t94KwVpUPNdN0dDYmShEnB/vqRAxLVdmU0dQpQNgMROx/yEg66S1r/J4iw3N0DriNg2u
         Zjryliy+yjejbgwzEo4TRviqXELuYNlIwfkjPAakHbHofzw/ryl6xwp+Amf1x9EGkE0/
         abDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bIJpgprQPfxBsVxXDMaXUeK2hzuj27H2g/+Kc9t54wc=;
        b=TD20X63BbVVgv/9BwNntK8RAjHZQiKBCROLiRf8jrUuL/i0SGUUWk8VCE87Ob8YWiH
         zaliOkRIcRzyekS3XYgQgZua6pgvBzFk7ga0XQLIXr00h6zFq80wZzuW6xKlv+mbIasP
         MU+K2qB4+ZLdhV0IpabuZj6fNtdV2VtftSDhe94amPcxXB+PefdStwhsZNyqmgNgeZiD
         F+AWx12nZZYIm+G5wYwboGWb36/resoa3sTRlX4Lda/fVuPRJYBEmnXVWyf5RkZoBY4f
         9hqCWooK3Pme/TlxG4K271aufkvsIFqi8En6AlMxvABC7HU9RePF3O0wvtuL1frVHz7H
         wI7Q==
X-Gm-Message-State: APjAAAV1dax7Def4SLSpxKvB9o+LycuOCjUhxwiK6YMWnGcVtBZC1/Ik
        mJ+6NjDc1UlJmZUH2U1+QiI=
X-Google-Smtp-Source: APXvYqy00urWbHnHNUW06O55qmy9w7tJsuVNYDPhDX+JrxUPKIUi0SBixUlFq/FZCSs89bo41H1hsg==
X-Received: by 2002:a6b:da01:: with SMTP id x1mr20531708iob.216.1562613892543;
        Mon, 08 Jul 2019 12:24:52 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:52 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 11/12] NFS based on file size issue sync copy or fallback to  generic copy offload
Date:   Mon,  8 Jul 2019 15:24:43 -0400
Message-Id: <20190708192444.12664-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For small file sizes, it make sense to issue a synchronous copy (and
save an RPC callback operation). Also, for the inter copy offload,
copy len must be larger than the cost of doing a mount between the
destination and source server (14RPCs are sent during 4.x mount).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42.h     |  2 +-
 fs/nfs/nfs42proc.c |  4 ++--
 fs/nfs/nfs4file.c  | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 02e3810cd889..c891af949886 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -16,7 +16,7 @@
 #ifdef CONFIG_NFS_V4_2
 int nfs42_proc_allocate(struct file *, loff_t, loff_t);
 ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t,
-			struct nl4_server *, nfs4_stateid *);
+			struct nl4_server *, nfs4_stateid *, bool);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
 loff_t nfs42_proc_llseek(struct file *, loff_t, int);
 int nfs42_proc_layoutstats_generic(struct nfs_server *,
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9c7feacb0358..aab6b7b6a24a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -357,7 +357,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			struct file *dst, loff_t pos_dst, size_t count,
 			struct nl4_server *nss,
-			nfs4_stateid *cnr_stateid)
+			nfs4_stateid *cnr_stateid, bool sync)
 {
 	struct nfs_server *server = NFS_SERVER(file_inode(dst));
 	struct nfs_lock_context *src_lock;
@@ -368,7 +368,7 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 		.dst_fh		= NFS_FH(file_inode(dst)),
 		.dst_pos	= pos_dst,
 		.count		= count,
-		.sync		= false,
+		.sync		= sync,
 	};
 	struct nfs42_copy_res res;
 	struct nfs4_exception src_exception = {
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 3bfa041424bc..2671619a44ff 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -138,6 +138,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	struct nl4_server *nss = NULL;
 	nfs4_stateid *cnrs = NULL;
 	ssize_t ret;
+	bool sync = false;
 
 	/* Only offload copy if superblock is the same */
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
@@ -146,8 +147,21 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
 		return -EOPNOTSUPP;
+	/* if the copy size if smaller than 2 RPC payloads, make it
+	 * synchronous
+	 */
+	if (count <= 2 * NFS_SERVER(file_inode(file_in))->rsize)
+		sync = true;
 retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
+		/* for inter copy, if copy size if smaller than 12 RPC
+		 * payloads, fallback to traditional copy. There are
+		 * 14 RPCs during an NFSv4.x mount between source/dest
+		 * servers.
+		 */
+		if (sync ||
+			count <= 14 * NFS_SERVER(file_inode(file_in))->rsize)
+			return -EOPNOTSUPP;
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
 		if (unlikely(cn_resp == NULL))
@@ -162,7 +176,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		cnrs = &cn_resp->cnr_stateid;
 	}
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
-				nss, cnrs);
+				nss, cnrs, sync);
 out:
 	kfree(cn_resp);
 	if (ret == -EAGAIN)
-- 
2.18.1

