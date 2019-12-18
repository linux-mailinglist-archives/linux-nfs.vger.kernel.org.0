Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6E125518
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLRVum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 16:50:42 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42204 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLRVum (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 16:50:42 -0500
Received: by mail-yb1-f194.google.com with SMTP id z10so1389220ybr.9
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nPentUX9ZZH8NREHTSACxAT/pk2d4nmo9BvF5stMjJs=;
        b=ZU3QsHxe2F+VasBLqlEGwnjxU5r8YZyuxdtXrAIHAfOZrOzHpB/cwBeeiNR2Cy73gA
         53iNpJ5DzohwLWLepmXyIAucvpHMCsKN6ks0GiWxk/3jakn8pNxmXNAShtWXDJcLWw9N
         NF3vD7V86WL+FFkR4fMiD0+0w9X5qGGtYBTvCyDW157oTtVEbRCOPem8W4bIkcdZdiFz
         lga9cK87jUJQH1ouVxQZl1oeQoz5jimFGMcRsjXBfyKBkV2w0q38OJgj71lHLpy8vWKW
         ufTPGIn4hYmhN9W3+ph6wQmx9GA7fWW3NQ9jwpQcTNafECQ2lpjsT/PVvXusAdfuc3JQ
         lb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nPentUX9ZZH8NREHTSACxAT/pk2d4nmo9BvF5stMjJs=;
        b=bq8o4lh6EOY5UFoOZeSSG8y0HSxJ5k9he8H/+pJ6PkqdTV/mVklmMFjpVLU1tNHxEO
         cwb4TST/vGXLIhPT5uNvlDVNRThYLYaikdMEauaMsU7GIOU1eI5SKfMqO8lK5yFkIYv3
         hHqmVJYGHFps4y1ezbMr1KZeuM7fy/d/z8gJmh1k8enJ5QsAQfhGfOYihsPJN4jxZpUy
         gyOKvpD7tEBYf6kwvVIO/jsz09imKbn4jp81dJYS03KEOEzWsfctESLNDw+BGXtRkXAX
         2XddG2RMYhxTPK0uIawxV3O8+ig5fyJOrKms4YJ9hU1M4hGUdVwDilcwhMEJamsACkIR
         SQNg==
X-Gm-Message-State: APjAAAU8ttEYrry2ITb4YcqwDIvTkFFZru3+PF9HohSahzM05BUJdS9e
        hFexp8VY7RAmYEfWs7PiUP4=
X-Google-Smtp-Source: APXvYqyv3aQScFLTWze3pLabbs43cx4vLWwGFqZd/0TTNNCMbg7GY/u1C/c9fSFBCbSIlK0NRYYioQ==
X-Received: by 2002:a25:cf49:: with SMTP id f70mr4036764ybg.11.1576705841086;
        Wed, 18 Dec 2019 13:50:41 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id d186sm1582874ywe.0.2019.12.18.13.50.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 Dec 2019 13:50:40 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3] NFSv4.x recover from pre-mature loss of openstateid
Date:   Wed, 18 Dec 2019 16:50:42 -0500
Message-Id: <20191218215042.30513-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Ever since the commit 0e0cb35b417f, it's possible to lose an open stateid
while retrying a CLOSE due to ERR_OLD_STATEID. Once that happens,
operations that require openstateid fail with EAGAIN which is propagated
to the application then tests like generic/446 and generic/168 fail with
"Resource temporarily unavailable".

Instead of returning this error, initiate state recovery when possible to
recover the open stateid and then try calling nfs4_select_rw_stateid()
again.

Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 36 ++++++++++++++++++++++++++++--------
 fs/nfs/nfs4proc.c  |  2 ++
 fs/nfs/pnfs.c      |  2 --
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 1fe83e0f663e..9637aad36bdc 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -61,8 +61,11 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 
 	status = nfs4_set_rw_stateid(&args.falloc_stateid, lock->open_context,
 			lock, FMODE_WRITE);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
+	}
 
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
@@ -287,8 +290,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	} else {
 		status = nfs4_set_rw_stateid(&args->src_stateid,
 				src_lock->open_context, src_lock, FMODE_READ);
-		if (status)
+		if (status) {
+			if (status == -EAGAIN)
+				status = -NFS4ERR_BAD_STATEID;
 			return status;
+		}
 	}
 	status = nfs_filemap_write_and_wait_range(file_inode(src)->i_mapping,
 			pos_src, pos_src + (loff_t)count - 1);
@@ -297,8 +303,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 
 	status = nfs4_set_rw_stateid(&args->dst_stateid, dst_lock->open_context,
 				     dst_lock, FMODE_WRITE);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
+	}
 
 	status = nfs_sync_inode(dst_inode);
 	if (status)
@@ -546,8 +555,11 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 	status = nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx,
 				     FMODE_READ);
 	nfs_put_lock_context(l_ctx);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
+	}
 
 	status = nfs4_call_sync(src_server->client, src_server, &msg,
 				&args->cna_seq_args, &res->cnr_seq_res, 0);
@@ -618,8 +630,11 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
 
 	status = nfs4_set_rw_stateid(&args.sa_stateid, lock->open_context,
 			lock, FMODE_READ);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
+	}
 
 	status = nfs_filemap_write_and_wait_range(inode->i_mapping,
 			offset, LLONG_MAX);
@@ -994,13 +1009,18 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 
 	status = nfs4_set_rw_stateid(&args.src_stateid, src_lock->open_context,
 			src_lock, FMODE_READ);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
-
+	}
 	status = nfs4_set_rw_stateid(&args.dst_stateid, dst_lock->open_context,
 			dst_lock, FMODE_WRITE);
-	if (status)
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
 		return status;
+	}
 
 	res.dst_fattr = nfs_alloc_fattr();
 	if (!res.dst_fattr)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d37161409a..f9bb4b43a519 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3239,6 +3239,8 @@ static int _nfs4_do_setattr(struct inode *inode,
 		nfs_put_lock_context(l_ctx);
 		if (status == -EIO)
 			return -EBADF;
+		else if (status == -EAGAIN)
+			goto zero_stateid;
 	} else {
 zero_stateid:
 		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cec3070ab577..3ac6b4dea72d 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1998,8 +1998,6 @@ pnfs_update_layout(struct inode *ino,
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
-			if (status != -EAGAIN)
-				goto out_unlock;
 			spin_unlock(&ino->i_lock);
 			nfs4_schedule_stateid_recovery(server, ctx->state);
 			pnfs_clear_first_layoutget(lo);
-- 
2.18.1

