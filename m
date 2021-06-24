Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA83B257B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFXDbW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E75C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i12so4660547ila.13
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy8L62XnZY4pyFFfTZKcTqYbSTRclV9kgxUhLZk7FgA=;
        b=A8A86WoP1JXQ/BAhQHd0uj5spyPpRXXierjqo+wvauAD2/BlAPGrRhEHpUR15fwf07
         e1PD1CxM/h4R4QfECvc2vgzyhsBBmh3b5kOEguplOzzKIQfgm7jvBoe1kAKwcCeCn0mi
         woShwOK0Po9ZqKjaVp6wBEvglTiruvRxTYg/yKLi1KyVnr8tLWdOPoSS//iyu4DAWArW
         2BTslOiD+xL3ifyRERcgUQYaffISSXA+IOssH9DcKVaMB02wgZu5LwjDO2Nn+5K00tsc
         wG0T+ro/Gvo1yEjxVkvI+zw1KC0lf2/Xb0eF1IdKUuo6iP6NNkg8b9VnjIEF/qaHFerJ
         kAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy8L62XnZY4pyFFfTZKcTqYbSTRclV9kgxUhLZk7FgA=;
        b=nBj+vE1kFoJwQKXGuc20ski7cfwn+zPCXI+yRV7qHp3ITUivBZSS+1sUZ8bdmU1bPW
         uCj/tAJuPXPiLnz4aDjGjGpKNr0uT9GduhRa/uws+fUSo/zaujJsgEFuM2vQ4bzIdG74
         xkEoxFOepV2Mc6Y+2iDbpwKQi7zSGxahjy7lFK45LcHv9F1KJhLrABoY3PFpYl44jFCS
         WT06U9t/aLQWOLh8kn8/m6OZlB5GFKWyMPoYprs/TIsiQggONkjkuiKZSqPxY9f7SPcY
         aA1ZW3oitanldfZDu6nP8AdvmP78e4Iv4Imjj+ECNGPPOtkrol3IxsllxTwBCH4n26cc
         Durg==
X-Gm-Message-State: AOAM531syf0Jc0mxYCcndnyKRvhyDcyl6SPaP1rMphAVkTKNh/98i44t
        8xl6VUyp9r+FVBWmhH/ZKUHUiD8TvZNJ6A==
X-Google-Smtp-Source: ABdhPJwn34yVtSbCAGZRCvz0iVjF4T/hIO8Ogi8h86GxgLe+pqgPlOspGAHIvrIP0NzeUJM7e7wSIA==
X-Received: by 2002:a92:cdab:: with SMTP id g11mr2059546ild.240.1624505342394;
        Wed, 23 Jun 2021 20:29:02 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:29:01 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/8] NFSv4.1 identify and mark RPC tasks that can move between transports
Date:   Wed, 23 Jun 2021 23:28:51 -0400
Message-Id: <20210624032853.4776-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In preparation for when we can re-try a task on a different transport,
identify and mark such RPC tasks as moveable. Only 4.1+ operarations can
be re-tried on a different transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c            | 38 +++++++++++++++++++++++++++++++-----
 fs/nfs/pagelist.c            |  8 ++++++--
 fs/nfs/write.c               |  6 +++++-
 include/linux/sunrpc/sched.h |  2 ++
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e653654c10bc..d3ee3700c9dd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1155,7 +1155,11 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 				   struct nfs4_sequence_args *args,
 				   struct nfs4_sequence_res *res)
 {
-	return nfs4_do_call_sync(clnt, server, msg, args, res, 0);
+	unsigned short task_flags = 0;
+
+	if (server->nfs_client->cl_minorversion)
+		task_flags = RPC_TASK_MOVEABLE;
+	return nfs4_do_call_sync(clnt, server, msg, args, res, task_flags);
 }
 
 
@@ -2569,6 +2573,9 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 	};
 	int status;
 
+	if (server->nfs_client->cl_minorversion)
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	kref_get(&data->kref);
 	data->rpc_done = false;
 	data->rpc_status = 0;
@@ -3749,6 +3756,9 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 	};
 	int status = -ENOMEM;
 
+	if (server->nfs_client->cl_minorversion)
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_CLEANUP,
 		&task_setup_data.rpc_client, &msg);
 
@@ -4188,6 +4198,9 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	};
 	unsigned short task_flags = 0;
 
+	if (nfs4_has_session(server->nfs_client))
+		task_flags = RPC_TASK_MOVEABLE;
+
 	/* Is this is an attribute revalidation, subject to softreval? */
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
@@ -4307,6 +4320,9 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	};
 	unsigned short task_flags = 0;
 
+	if (server->nfs_client->cl_minorversion)
+		task_flags = RPC_TASK_MOVEABLE;
+
 	/* Is this is an attribute revalidation, subject to softreval? */
 	if (nfs_lookup_is_soft_revalidate(dentry))
 		task_flags |= RPC_TASK_TIMEOUT;
@@ -6538,7 +6554,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_delegreturn_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT | RPC_TASK_MOVEABLE,
 	};
 	int status = 0;
 
@@ -6856,6 +6872,11 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 		.workqueue = nfsiod_workqueue,
 		.flags = RPC_TASK_ASYNC,
 	};
+	struct nfs_client *client =
+		NFS_SERVER(lsp->ls_state->inode)->nfs_client;
+
+	if (client->cl_minorversion)
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	nfs4_state_protect(NFS_SERVER(lsp->ls_state->inode)->nfs_client,
 		NFS_SP4_MACH_CRED_CLEANUP, &task_setup_data.rpc_client, &msg);
@@ -7130,6 +7151,10 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int ret;
+	struct nfs_client *client = NFS_SERVER(state->inode)->nfs_client;
+
+	if (client->cl_minorversion)
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	dprintk("%s: begin!\n", __func__);
 	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
@@ -9186,7 +9211,7 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		.rpc_client = clp->cl_rpcclient,
 		.rpc_message = &msg,
 		.callback_ops = &nfs41_sequence_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT | RPC_TASK_MOVEABLE,
 	};
 	struct rpc_task *ret;
 
@@ -9509,7 +9534,8 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_layoutget_call_ops,
 		.callback_data = lgp,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF |
+			 RPC_TASK_MOVEABLE,
 	};
 	struct pnfs_layout_segment *lseg = NULL;
 	struct nfs4_exception exception = {
@@ -9650,6 +9676,7 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_layoutreturn_call_ops,
 		.callback_data = lrp,
+		.flags = RPC_TASK_MOVEABLE,
 	};
 	int status = 0;
 
@@ -9804,6 +9831,7 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_layoutcommit_ops,
 		.callback_data = data,
+		.flags = RPC_TASK_MOVEABLE,
 	};
 	struct rpc_task *task;
 	int status = 0;
@@ -10131,7 +10159,7 @@ static int nfs41_free_stateid(struct nfs_server *server,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs41_free_stateid_ops,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	struct nfs_free_stateid_data *data;
 	struct rpc_task *task;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index cf9cc62ec48e..cc232d1f16f2 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -954,6 +954,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 {
 	struct nfs_pgio_header *hdr;
 	int ret;
+	unsigned short task_flags = 0;
 
 	hdr = nfs_pgio_header_alloc(desc->pg_rw_ops);
 	if (!hdr) {
@@ -962,14 +963,17 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	}
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
-	if (ret == 0)
+	if (ret == 0) {
+		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
+			task_flags = RPC_TASK_MOVEABLE;
 		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
 					hdr,
 					hdr->cred,
 					NFS_PROTO(hdr->inode),
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
-					RPC_TASK_CRED_NOREF);
+					RPC_TASK_CRED_NOREF | task_flags);
+	}
 	return ret;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3bf82178166a..eae9bf114041 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1810,6 +1810,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
 	if (list_empty(head))
@@ -1820,8 +1821,11 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	/* Set up the argument struct */
 	nfs_init_commit(data, head, NULL, cinfo);
 	atomic_inc(&cinfo->mds->rpcs_out);
+	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
+		task_flags = RPC_TASK_MOVEABLE;
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
-				   data->mds_ops, how, RPC_TASK_CRED_NOREF);
+				   data->mds_ops, how,
+				   RPC_TASK_CRED_NOREF | task_flags);
 }
 
 /*
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd675..a237b8dbf608 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -121,6 +121,7 @@ struct rpc_task_setup {
  */
 #define RPC_TASK_ASYNC		0x0001		/* is an async task */
 #define RPC_TASK_SWAPPER	0x0002		/* is swapping in/out */
+#define RPC_TASK_MOVEABLE	0x0004		/* nfs4.1+ rpc tasks */
 #define RPC_TASK_NULLCREDS	0x0010		/* Use AUTH_NULL credential */
 #define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
 #define RPC_TASK_ROOTCREDS	0x0040		/* force root creds */
@@ -139,6 +140,7 @@ struct rpc_task_setup {
 #define RPC_IS_SOFT(t)		((t)->tk_flags & (RPC_TASK_SOFT|RPC_TASK_TIMEOUT))
 #define RPC_IS_SOFTCONN(t)	((t)->tk_flags & RPC_TASK_SOFTCONN)
 #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
+#define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
 
 #define RPC_TASK_RUNNING	0
 #define RPC_TASK_QUEUED		1
-- 
2.27.0

