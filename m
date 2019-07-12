Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E126741D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfGLRXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 13:23:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41781 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLRXQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Jul 2019 13:23:16 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so17758879ioj.8
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2019 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRxEucOKvh330u2yQw+VANkemc34EsEZ8HNyJNjE/r8=;
        b=ib20pIjQm9lM9aOuIq44c+8ONg3NKPzPDELDKEoESE0S5HaF8wzimWXUj1KxkLwuUG
         E7DrvKhch/hxBrQil7F1s/U/AMcC7bnbMdNaioiKxUkLSh4JSBvTcXrUAurFCpGYT6uw
         GDNJYb3u/lnW326JjbNRUQWboLwR6eU5dfsTkSXCsZ6dA6XmvO8eO++lXlGJgwiERz4a
         SOofjmwD+sdrOltQl654nZGRw9mbEYGi6nHs9x30ds7urNA4M6yJ66jCJFRSqLgxSaEe
         CAHDUDATZV99uWgRBJXA2bp0CSfrBdoSgYDR4R2+p7wcEPk/ndtXFHcsraxlozHsS50P
         bvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRxEucOKvh330u2yQw+VANkemc34EsEZ8HNyJNjE/r8=;
        b=Hj/OKTAuZpRetIWs3syC30SR71c58WrJ5uDTmun9NtWiIa1IHurDasBfhGwQBwi58o
         W7jnDdShIDmPUwVP/mwG2iIdcult3D/f2mUVqLPD3ZoCsFrYegWPgA3joncPz/LgBe/r
         tu0wimT4XepJYhZX0NtGwYGvMwTp9BhzRT5VlkGkyh15Usyhua1jIWSSXo6AJqCJEtmu
         DdxQszTYO86N1yUaq5ivW08QmN3AiNIybVHEuaCJFGmu3TjEYcRqB4O5/v3Dnna3YGgD
         HDC1Ekc9Ntk2+y75C4JvtQkI0pJWc1QNTFdAB9morctVDr97GNSjLmjtgmh3P4i1o9Ke
         UymA==
X-Gm-Message-State: APjAAAVfPbDy1i61Lu1fAgVTaNpTGvyqRIHQ5q+VvzcR8zwq1bKvaWtF
        G8c/nzNYiNN3A2vcGbXv4wBsIHpPFg==
X-Google-Smtp-Source: APXvYqykCf/2PZb1sQF34OEahG4XMeUkthu5sdhzoEJis9oDMxlN1nKOASyXhi3ZsnSc25MPALBOaw==
X-Received: by 2002:a02:3b62:: with SMTP id i34mr13091154jaf.91.1562952194706;
        Fri, 12 Jul 2019 10:23:14 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i23sm6392496ioj.24.2019.07.12.10.23.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:23:13 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Olga Kornievskaia <aglo@umich.edu>, Neil Brown <neilb@suse.com>
Subject: [PATCH] SUNRPC: Fix transport accounting when caller specifies an rpc_xprt
Date:   Fri, 12 Jul 2019 13:21:06 -0400
Message-Id: <20190712172106.18893-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we do the required accounting for the round robin queue
when the caller to rpc_init_task() has passed in a transport to be
used.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Reported-by: Neil Brown <neilb@suse.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h |  2 ++
 net/sunrpc/clnt.c           | 42 ++++++++++++++++++-------------------
 net/sunrpc/sched.c          |  3 ++-
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 4619098affa3..4e070e00c143 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -164,6 +164,8 @@ void		rpc_shutdown_client(struct rpc_clnt *);
 void		rpc_release_client(struct rpc_clnt *);
 void		rpc_task_release_transport(struct rpc_task *);
 void		rpc_task_release_client(struct rpc_task *);
+struct rpc_xprt	*rpc_task_get_xprt(struct rpc_clnt *clnt,
+		struct rpc_xprt *xprt);
 
 int		rpcb_create_local(struct net *);
 void		rpcb_put_local(struct net *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d599fab8adcb..383555d2b522 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -978,11 +978,10 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 }
 EXPORT_SYMBOL_GPL(rpc_bind_new_program);
 
-static struct rpc_xprt *
-rpc_task_get_xprt(struct rpc_clnt *clnt)
+struct rpc_xprt *
+rpc_task_get_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
 	struct rpc_xprt_switch *xps;
-	struct rpc_xprt *xprt= xprt_iter_get_next(&clnt->cl_xpi);
 
 	if (!xprt)
 		return NULL;
@@ -995,24 +994,6 @@ rpc_task_get_xprt(struct rpc_clnt *clnt)
 	return xprt;
 }
 
-static struct rpc_xprt *
-rpc_task_get_first_xprt(struct rpc_clnt *clnt)
-{
-	struct rpc_xprt_switch *xps;
-	struct rpc_xprt *xprt;
-
-	rcu_read_lock();
-	xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
-	if (xprt) {
-		atomic_long_inc(&xprt->queuelen);
-		xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
-		atomic_long_inc(&xps->xps_queuelen);
-	}
-	rcu_read_unlock();
-
-	return xprt;
-}
-
 static void
 rpc_task_release_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
@@ -1057,6 +1038,23 @@ void rpc_task_release_client(struct rpc_task *task)
 	}
 }
 
+static struct rpc_xprt *
+rpc_task_get_first_xprt(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt *xprt;
+
+	rcu_read_lock();
+	xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	rcu_read_unlock();
+	return rpc_task_get_xprt(clnt, xprt);
+}
+
+static struct rpc_xprt *
+rpc_task_get_next_xprt(struct rpc_clnt *clnt)
+{
+	return rpc_task_get_xprt(clnt, xprt_iter_get_next(&clnt->cl_xpi));
+}
+
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
@@ -1065,7 +1063,7 @@ void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
 	else
-		task->tk_xprt = rpc_task_get_xprt(clnt);
+		task->tk_xprt = rpc_task_get_next_xprt(clnt);
 }
 
 static
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 8a0779e963f9..1f275aba786f 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1092,7 +1092,8 @@ static void rpc_init_task(struct rpc_task *task, const struct rpc_task_setup *ta
 	/* Initialize workqueue for async tasks */
 	task->tk_workqueue = task_setup_data->workqueue;
 
-	task->tk_xprt = xprt_get(task_setup_data->rpc_xprt);
+	task->tk_xprt = rpc_task_get_xprt(task_setup_data->rpc_client,
+			xprt_get(task_setup_data->rpc_xprt));
 
 	task->tk_op_cred = get_rpccred(task_setup_data->rpc_op_cred);
 
-- 
2.21.0

