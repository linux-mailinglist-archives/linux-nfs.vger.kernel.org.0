Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27848D29E5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfJJMq7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42941 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfJJMq7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:59 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so13264055iod.9
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hshp1oYTyfoMLQ+k0J7lOTxVumPki+FPii/qZM5aFiM=;
        b=CL1+oQMsN76oSfwZVBht+iaUcD7wsqKhUj0GEXgDeCfYAU6NHI2S8QO1JKS23CxLxi
         +b+cnQBl0t4zRvJri4N1iNvOyBTU0JeFtPO2MnH+LXKH7aNeLAaAXEtb7VZD73bO6lJG
         LIJhX6gT9wEglfetxlzasxvv/+WF+YhJ/QU8aW7pDSNRCFkSl5RqU2MINRBOnrjJ+caB
         /WyXmbTuRoTpoBWMmDPKq4rS4+S8KTwELoffxuJppIrpuT2x9CmTrPJk5dr9xk6XyduY
         +MesG1mK+aiP+SyC6n0gVZ12iIH/wDss9f5a9RM5jfWlTvM7rp8xy6Brc5XNoaTU9LAL
         1geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hshp1oYTyfoMLQ+k0J7lOTxVumPki+FPii/qZM5aFiM=;
        b=TlntV+Pp9si+O3i96KWBVvqAAT9osvGdGRSjsSR2fIV0GdQzp9Us3TthqXa+mclyUf
         sgQIfOkPCirm5z6pRdqAQufJ9StNCeQscXwJqSSCmwI+5OQ1Ftco79xj/rVMR17wlA6h
         fcCus8WfW88vTlothhDY/TK0bz5FhRVC8FnOqYXgMXRG4dwkN1gtSnaLy61KIC0SL41E
         PTeGo+OvvY7BP0b0Nw4SouNnVk9Kv3k8FgEpCKRR2QQMTiNTrGkul6OecrhJ+8l9trMt
         wuw7tCsJqLBKF7ar11Zqvw8QwEqIoxiv3pjfAwWWyFelKA5/Uv6s4QOlGLYyNel8kgjn
         ua5A==
X-Gm-Message-State: APjAAAWz2PRXwBG2QS5yDyFnAFCjoxjehuEIlvoclCoCYgIwU56QVNLU
        gTkGLdtESz+yIj2Sh3gXOg8=
X-Google-Smtp-Source: APXvYqyioYCLMu4aJmSNPoFm9rht+TZWNZSaJlCfxU+3e28tcRgJTaPxxVvL04uF4yOA5cuobLjEdw==
X-Received: by 2002:a5d:8b48:: with SMTP id c8mr10036698iot.64.1570711617953;
        Thu, 10 Oct 2019 05:46:57 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 11/20] NFS based on file size issue sync copy or fallback to generic copy offload
Date:   Thu, 10 Oct 2019 08:46:13 -0400
Message-Id: <20191010124622.27812-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
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
index 02e3810..c891af9 100644
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
index 9c7feac..aab6b7b 100644
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
index 2af30b7..8978325 100644
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
1.8.3.1

