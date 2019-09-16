Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06BB42C5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391580AbfIPVOF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40962 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391571AbfIPVOF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:05 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so2427782ioh.8
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u1LqSI0Dzdvw08DyYFFREUIyIIfvPEwHlIRWLh7nRb8=;
        b=SpOMjbX0Vgg3jIZVh3/EWsyC8cjAGHCqyfohV0/02tcGuryScQzkVgE5CnSTLSim/f
         jb20vMC3h/bAK9jI0qmYXU3/IFxAT1muwpRw/mkVmkb4qikKSvQcPDzFbTJQwKWDcuaT
         2HY7ggHD9acdHQOgmxaiyo8EUGjv/52e0xgkOqcS4r0VZahXYSr5nLUM8CSF+cIiLNns
         7ZYN19QxjuscpPM+aMWerb0tO3qgFIaIFRnhfcJadXsCU8+NbpszBvf3nSnRZ76BsLkW
         5nUBL3QnQL+VnfXwp6Ts3joQi9a15LjfU4XXv0s4ylqL2qs71/pX+Pq5qO/8vTn8ym7P
         RzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u1LqSI0Dzdvw08DyYFFREUIyIIfvPEwHlIRWLh7nRb8=;
        b=ErPmsf0b9EvC8hSham0ZOmv6SxPZiFjXj/dw+coh7xtz7ZMd2yFOC1YeXvqyDiHQVs
         6EzUiDmXfywTBd0UDlschhwoBvT+EZz/2Fsexskgzyo+ogR85k57rjbZOsLeoT1TIipj
         L/NBh09ydMxyvJMJabHMR1T6TuvNu8wHd8S41MbaMfJyOac0z9pGGcaE9UI+5243V04X
         98vbORnpxnqyP52PVi2LCFqCr14KueVN3EfRNc2ca9ku5mloFbYM3U0igiT5eQuwN/nl
         fE93NAeKml2BdLH6ILtrVVuHW5FpWnA4y3zghNskZvkE+xW617nSP/k/uPbTIIN+cJI2
         8THQ==
X-Gm-Message-State: APjAAAWaJckv4xbCudM5nVeSMcvQxGlw5SjTVu61yZ+ZQtHMohJdOOEC
        BrRkeoXwWIw8DI6IXM5t2i8=
X-Google-Smtp-Source: APXvYqwKhMcZjOrz/RjMm6Y5aUYaHkhXqrNS+JMya0XKo9evMr2EyZP8hdLRgbsbPw1z2RgMGFMpFg==
X-Received: by 2002:a5d:9410:: with SMTP id v16mr402887ion.10.1568668444524;
        Mon, 16 Sep 2019 14:14:04 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:04 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 09/19] NFS: handle source server reboot
Date:   Mon, 16 Sep 2019 17:13:43 -0400
Message-Id: <20190916211353.18802-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the source server reboots after a server-to-server copy was
issued, we need to retry the copy from COPY_NOTIFY. We need to
detect that the source server rebooted and there is a copy waiting
on a destination server and wake it up.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c     | 68 ++++++++++++++++++++++++++++++++++----------------
 fs/nfs/nfs4_fs.h       |  1 +
 fs/nfs/nfs4file.c      |  3 +++
 fs/nfs/nfs4state.c     | 15 ++++++++---
 include/linux/nfs_fs.h |  3 ++-
 5 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 705fe69..918dd78 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -153,22 +153,26 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 }
 
 static int handle_async_copy(struct nfs42_copy_res *res,
-			     struct nfs_server *server,
+			     struct nfs_server *dst_server,
+			     struct nfs_server *src_server,
 			     struct file *src,
 			     struct file *dst,
-			     nfs4_stateid *src_stateid)
+			     nfs4_stateid *src_stateid,
+			     bool *restart)
 {
 	struct nfs4_copy_state *copy, *tmp_copy;
 	int status = NFS4_OK;
 	bool found_pending = false;
-	struct nfs_open_context *ctx = nfs_file_open_context(dst);
+	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
+	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
 
 	copy = kzalloc(sizeof(struct nfs4_copy_state), GFP_NOFS);
 	if (!copy)
 		return -ENOMEM;
 
-	spin_lock(&server->nfs_client->cl_lock);
-	list_for_each_entry(tmp_copy, &server->nfs_client->pending_cb_stateids,
+	spin_lock(&dst_server->nfs_client->cl_lock);
+	list_for_each_entry(tmp_copy,
+				&dst_server->nfs_client->pending_cb_stateids,
 				copies) {
 		if (memcmp(&res->write_res.stateid, &tmp_copy->stateid,
 				NFS4_STATEID_SIZE))
@@ -178,7 +182,7 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		break;
 	}
 	if (found_pending) {
-		spin_unlock(&server->nfs_client->cl_lock);
+		spin_unlock(&dst_server->nfs_client->cl_lock);
 		kfree(copy);
 		copy = tmp_copy;
 		goto out;
@@ -186,19 +190,32 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 
 	memcpy(&copy->stateid, &res->write_res.stateid, NFS4_STATEID_SIZE);
 	init_completion(&copy->completion);
-	copy->parent_state = ctx->state;
+	copy->parent_dst_state = dst_ctx->state;
+	copy->parent_src_state = src_ctx->state;
+
+	list_add_tail(&copy->copies, &dst_server->ss_copies);
+	spin_unlock(&dst_server->nfs_client->cl_lock);
 
-	list_add_tail(&copy->copies, &server->ss_copies);
-	spin_unlock(&server->nfs_client->cl_lock);
+	if (dst_server != src_server) {
+		spin_lock(&src_server->nfs_client->cl_lock);
+		list_add_tail(&copy->copies, &src_server->ss_copies);
+		spin_unlock(&src_server->nfs_client->cl_lock);
+	}
 
 	status = wait_for_completion_interruptible(&copy->completion);
-	spin_lock(&server->nfs_client->cl_lock);
+	spin_lock(&dst_server->nfs_client->cl_lock);
 	list_del_init(&copy->copies);
-	spin_unlock(&server->nfs_client->cl_lock);
+	spin_unlock(&dst_server->nfs_client->cl_lock);
+	if (dst_server != src_server) {
+		spin_lock(&src_server->nfs_client->cl_lock);
+		list_del_init(&copy->copies);
+		spin_unlock(&src_server->nfs_client->cl_lock);
+	}
 	if (status == -ERESTARTSYS) {
 		goto out_cancel;
-	} else if (copy->flags) {
+	} else if (copy->flags && copy->error) {
 		status = -EAGAIN;
+		*restart = true;
 		goto out_cancel;
 	}
 out:
@@ -247,7 +264,8 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 				struct nfs42_copy_args *args,
 				struct nfs42_copy_res *res,
 				struct nl4_server *nss,
-				nfs4_stateid *cnr_stateid)
+				nfs4_stateid *cnr_stateid,
+				bool *restart)
 {
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COPY],
@@ -255,7 +273,9 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		.rpc_resp = res,
 	};
 	struct inode *dst_inode = file_inode(dst);
-	struct nfs_server *server = NFS_SERVER(dst_inode);
+	struct inode *src_inode = file_inode(src);
+	struct nfs_server *dst_server = NFS_SERVER(dst_inode);
+	struct nfs_server *src_server = NFS_SERVER(src_inode);
 	loff_t pos_src = args->src_pos;
 	loff_t pos_dst = args->dst_pos;
 	size_t count = args->count;
@@ -291,13 +311,15 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		if (!res->commit_res.verf)
 			return -ENOMEM;
 	}
+	set_bit(NFS_CLNT_SRC_SSC_COPY_STATE,
+		&src_lock->open_context->state->flags);
 	set_bit(NFS_CLNT_DST_SSC_COPY_STATE,
 		&dst_lock->open_context->state->flags);
 
-	status = nfs4_call_sync(server->client, server, &msg,
+	status = nfs4_call_sync(dst_server->client, dst_server, &msg,
 				&args->seq_args, &res->seq_res, 0);
 	if (status == -ENOTSUPP)
-		server->caps &= ~NFS_CAP_COPY;
+		dst_server->caps &= ~NFS_CAP_COPY;
 	if (status)
 		goto out;
 
@@ -309,8 +331,8 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	}
 
 	if (!res->synchronous) {
-		status = handle_async_copy(res, server, src, dst,
-				&args->src_stateid);
+		status = handle_async_copy(res, dst_server, src_server, src,
+				dst, &args->src_stateid, restart);
 		if (status)
 			return status;
 	}
@@ -358,6 +380,7 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 		.stateid	= &args.dst_stateid,
 	};
 	ssize_t err, err2;
+	bool restart = false;
 
 	src_lock = nfs_get_lock_context(nfs_file_open_context(src));
 	if (IS_ERR(src_lock))
@@ -378,7 +401,7 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 		err = _nfs42_proc_copy(src, src_lock,
 				dst, dst_lock,
 				&args, &res,
-				nss, cnr_stateid);
+				nss, cnr_stateid, &restart);
 		inode_unlock(file_inode(dst));
 
 		if (err >= 0)
@@ -387,8 +410,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			err = -EOPNOTSUPP;
 			break;
 		} else if (err == -EAGAIN) {
-			dst_exception.retry = 1;
-			continue;
+			if (!restart) {
+				dst_exception.retry = 1;
+				continue;
+			}
+			break;
 		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS && !args.sync) {
 			args.sync = true;
 			dst_exception.retry = 1;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index f1a7f40..fec976e 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -168,6 +168,7 @@ enum {
 	NFS_STATE_CHANGE_WAIT,		/* A state changing operation is outstanding */
 #ifdef CONFIG_NFS_V4_2
 	NFS_CLNT_DST_SSC_COPY_STATE,    /* dst server open state on client*/
+	NFS_CLNT_SRC_SSC_COPY_STATE,    /* src server open state on client*/
 	NFS_SRV_SSC_COPY_STATE,		/* ssc state on the dst server */
 #endif /* CONFIG_NFS_V4_2 */
 };
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index b0dbb59..d02b25d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -146,6 +146,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
 		return -EOPNOTSUPP;
+retry:
 	if (!nfs42_files_from_same_server(file_in, file_out)) {
 		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
 				GFP_NOFS);
@@ -164,6 +165,8 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				nss, cnrs);
 out:
 	kfree(cn_resp);
+	if (ret == -EAGAIN)
+		goto retry;
 	return ret;
 }
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e06a63f..881ce7b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1554,15 +1554,22 @@ static void nfs42_complete_copies(struct nfs4_state_owner *sp, struct nfs4_state
 {
 	struct nfs4_copy_state *copy;
 
-	if (!test_bit(NFS_CLNT_DST_SSC_COPY_STATE, &state->flags))
+	if (!test_bit(NFS_CLNT_DST_SSC_COPY_STATE, &state->flags) &&
+		!test_bit(NFS_CLNT_SRC_SSC_COPY_STATE, &state->flags))
 		return;
 
 	spin_lock(&sp->so_server->nfs_client->cl_lock);
 	list_for_each_entry(copy, &sp->so_server->ss_copies, copies) {
-		if (!nfs4_stateid_match_other(&state->stateid, &copy->parent_state->stateid))
-			continue;
+		if ((test_bit(NFS_CLNT_SRC_SSC_COPY_STATE, &state->flags) &&
+				!nfs4_stateid_match_other(&state->stateid,
+				&copy->parent_src_state->stateid)) ||
+		    (test_bit(NFS_CLNT_DST_SSC_COPY_STATE, &state->flags) &&
+				!nfs4_stateid_match_other(&state->stateid,
+				&copy->parent_dst_state->stateid)))
+				continue;
 		copy->flags = 1;
-		complete(&copy->completion);
+		if (test_bit(NFS_CLNT_DST_SSC_COPY_STATE, &state->flags))
+			complete(&copy->completion);
 		break;
 	}
 	spin_unlock(&sp->so_server->nfs_client->cl_lock);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0a11712..6ff1ec7 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -195,7 +195,8 @@ struct nfs4_copy_state {
 	struct nfs_writeverf	verf;
 	int			error;
 	int			flags;
-	struct nfs4_state	*parent_state;
+	struct nfs4_state	*parent_src_state;
+	struct nfs4_state	*parent_dst_state;
 };
 
 /*
-- 
1.8.3.1

