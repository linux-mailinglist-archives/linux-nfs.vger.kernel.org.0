Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A457562954
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391670AbfGHTYx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:53 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41037 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391667AbfGHTYx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:53 -0400
Received: by mail-io1-f42.google.com with SMTP id j5so18498714ioj.8
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZM8tDpymrPcQprwiAwHYfPLbTDi/J3kKbCfrEy6Yvqs=;
        b=p7vdBGmAI3tjcmZqophv3uoanAtAKZpLczg6pMhOgBXvqVjadky7acFF0FuGW0aZF9
         cDWC7FCb3i7aEySTq0Jye4feIc/LRCb0x7yzvZTDN+iZywfLkLwxRdz0pSbljFPooPT1
         Q11oduhkGmRKiwDwzjiPpdP496L3Q16DaRTQXczx5gyzGaLOMyCxxBA9Fb6gvE5jzcgu
         SA/NssYfETPXJFzOvMbRqkDW+vARB9nrueD8MdQh/uxWGW3cP3N2YEQbcbLVkcBQMT4w
         d776Fk9jAW9z/i3YJEYNnh3Fe2mVW7gd9s4Wk8XFLLBdTsnh1VujuaJ7jRpM8Yk4idoR
         f4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZM8tDpymrPcQprwiAwHYfPLbTDi/J3kKbCfrEy6Yvqs=;
        b=VfkO86ZepkFtkpZvKpCE0wtjKQ2fhqmEjOC90va3sMhjXyw8V229rGkSnD+/8P1YT+
         l2mh80zH7WBxwUsdkMFbDJt4J6NuQtieahBsfAcLCeGsGFSzGuqnLLVfHn+DP2QgVMbb
         XkaPFYdRPwLq2xQQkZgbfa6W2eF7eEW01hZg+f9rTmcwXIYe6zOrpM0Wis2YJCE7j+yQ
         YKqGWobWImrGkp/CMvhVVsEr0dztB4HRUNTwz5B2t1MZrzGpjaHbOoofueiltX0fF4xk
         qcJqV+XmzAQJrrIdxVnpzlEYJ0FxsuuQVcTFhEmJRPxHea3vModDSHBdk6yDK9Zlfrxy
         5XgA==
X-Gm-Message-State: APjAAAVuqLmiRS58IPeY0MZNgEJEBw0yDgYN/b6L91uvN8nAjRqLXInT
        Rn0z6LCEaGCkkcn25nZZQMI=
X-Google-Smtp-Source: APXvYqx1hv/Y/FHh5IAjgxt7jNhmn+AkJHH3kAgNhfxOS49KCX2pr/k0RxpqXIXVr09b3NEEzpqiDg==
X-Received: by 2002:a6b:e608:: with SMTP id g8mr1647396ioh.88.1562613891829;
        Mon, 08 Jul 2019 12:24:51 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:51 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 10/12] NFS: handle source server reboot
Date:   Mon,  8 Jul 2019 15:24:42 -0400
Message-Id: <20190708192444.12664-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/nfs42proc.c     | 68 +++++++++++++++++++++++++++++-------------
 fs/nfs/nfs4_fs.h       |  1 +
 fs/nfs/nfs4file.c      |  3 ++
 fs/nfs/nfs4state.c     | 26 ++++++++++++----
 include/linux/nfs_fs.h |  4 ++-
 5 files changed, 75 insertions(+), 27 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5d833f5748e9..9c7feacb0358 100644
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
+		list_add_tail(&copy->src_copies, &src_server->ss_copies);
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
+		list_del_init(&copy->src_copies);
+		spin_unlock(&src_server->nfs_client->cl_lock);
+	}
 	if (status == -ERESTARTSYS) {
 		goto out_cancel;
-	} else if (copy->flags) {
+	} else if (copy->flags || copy->error == NFS4ERR_PARTNER_NO_AUTH) {
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
@@ -388,8 +411,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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
index d49fc19361d2..2cb5f507eefd 100644
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
index 5ef3c12bb54b..3bfa041424bc 100644
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
index 045af569835c..329e3ff872ab 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1555,16 +1555,32 @@ static void nfs42_complete_copies(struct nfs4_state_owner *sp, struct nfs4_state
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
+		if ((test_bit(NFS_CLNT_DST_SSC_COPY_STATE, &state->flags) &&
+				!nfs4_stateid_match_other(&state->stateid,
+				&copy->parent_dst_state->stateid)))
+				continue;
 		copy->flags = 1;
-		complete(&copy->completion);
-		break;
+		if (test_and_clear_bit(NFS_CLNT_DST_SSC_COPY_STATE,
+				&state->flags)) {
+			clear_bit(NFS_CLNT_SRC_SSC_COPY_STATE, &state->flags);
+			complete(&copy->completion);
+		}
+	}
+	list_for_each_entry(copy, &sp->so_server->ss_copies, src_copies) {
+		if ((test_bit(NFS_CLNT_SRC_SSC_COPY_STATE, &state->flags) &&
+				!nfs4_stateid_match_other(&state->stateid,
+				&copy->parent_src_state->stateid)))
+				continue;
+		copy->flags = 1;
+		if (test_and_clear_bit(NFS_CLNT_DST_SSC_COPY_STATE,
+				&state->flags))
+			complete(&copy->completion);
 	}
 	spin_unlock(&sp->so_server->nfs_client->cl_lock);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0a11712a80e3..af584b1441ed 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -189,13 +189,15 @@ struct nfs_inode {
 
 struct nfs4_copy_state {
 	struct list_head	copies;
+	struct list_head	src_copies;
 	nfs4_stateid		stateid;
 	struct completion	completion;
 	uint64_t		count;
 	struct nfs_writeverf	verf;
 	int			error;
 	int			flags;
-	struct nfs4_state	*parent_state;
+	struct nfs4_state	*parent_src_state;
+	struct nfs4_state	*parent_dst_state;
 };
 
 /*
-- 
2.18.1

