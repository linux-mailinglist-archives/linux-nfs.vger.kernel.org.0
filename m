Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B71439AE79
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCXCI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 19:02:08 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:44755 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCXCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 19:02:07 -0400
Received: by mail-qt1-f172.google.com with SMTP id t17so5627056qta.11
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n58lc8G0mdEq7LF3zlLfa7Uh+6yQYWsYuOuqcdnDFK4=;
        b=lSWw7xzZeRqANBG8uNKJ2F/rWADktusI6FlTydtxOOH9zfp2wRCAAvZQ1cmL6RUuuy
         7bw72Z8ZJpGR6zepvxnlRRS3Adf0hxaDUkyNsRbNysihhjfxyLfA07B98hc9+Hq8mHzs
         8+56lUfuQCuCPM/Gpll72pg7Wa/H/kCndv48I+gLp12ittjMpbmRj4JzaR6alEjJZk5X
         dgeEi1plt/6Taas8ZnmzSbxKxxCSVMxFTmMIBM/kjbK4hV2uzlpa4qa0gxNXZqyZPTn6
         3xUDapmKcPRVWDQC++NPuZRRglXUI8EGqtuSW+1pCBd7KMFjZBCbE27rEhIoV4lZlcKZ
         dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n58lc8G0mdEq7LF3zlLfa7Uh+6yQYWsYuOuqcdnDFK4=;
        b=S1MtS4oDxqkhxTRA6lq9iwacSTZzfoYQ27wLiK+2R9EJNAwU5oPx1WOxk9Qsj5V7iW
         1BaRsj1q1ayITsoi6wxSqopbfbOTnEcSXVTX3m/L+ebbZ5fmIYu/EhhKAWrwMmfX7gzx
         9QqIhvT1RIUx0KV503Nl/Q2R5LAYGUA4bRxclqvTnrRZWgw7DohqFPGUsCxc0omKS/xa
         5OqalhA8Ddpm8YKHgvrowWJglljAgKwF+58fs7NM5bQ2QbgPDmE5xh5HFPDjp/2q63n+
         FHrrxVxcbDPagla2dsDQJ1vI6W2U04dkmhnmA4HSyENXgUIBK5Q1+u7XmfvyYEtPSH3c
         OXIw==
X-Gm-Message-State: AOAM531cSpOun9Ys3cV8Kw+wdKfKExcQkyRL54cX2pQ/T2Iu7J//yap5
        myaP9L6Neongz3pyJ2vm6k0=
X-Google-Smtp-Source: ABdhPJwoCkxDItECau2UvYGKkXki2rVisvNKjCJI0b0nt+Wku++TCNO9NkghXhkJbTwu1ke0LP91+w==
X-Received: by 2002:ac8:70cf:: with SMTP id g15mr1868462qtp.360.1622761152449;
        Thu, 03 Jun 2021 15:59:12 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id h19sm1479497qtq.5.2021.06.03.15.59.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:59:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/3] NFSv4.1 identify and mark RPC tasks that can move between transports
Date:   Thu,  3 Jun 2021 18:59:06 -0400
Message-Id: <20210603225907.19981-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
References: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
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
index e25c16257545..40e8d36cbfa8 100644
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
 
+	if (server->nfs_client->cl_minorversion)
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

