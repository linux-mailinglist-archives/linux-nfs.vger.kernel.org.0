Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BD5520CA
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiFTP0F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbiFTPZ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6A329
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i17so9677747qvo.13
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtphTpz7ijVKD36pVaA+RVVdZdeigjx2bTQbCQuaqA4=;
        b=b895MBCUP2wjX9Se8uTc4rOByk0LDR9lHLaNMaz2WBKTc15VavL7lVDb6UlnRDWkb0
         aiT3iWgo1Zo4XRKhYwlftExvSm0NsrswHYCpYr+myQGRqBcwLylJC09C7AjkRpeSCxUG
         xmU6TfWUw9wdQwhSNhmlbZmTz5Ky8psQ8UvfEQmSJKJOzYxyXL5D4+n4H5POdg6RPMkh
         iwDA+177zX7d1DUKZcSZf9Ru8ybNmZsPtHMx5Y+N3D9m1enIIobyluEB8YAFnrWtG7U1
         l6VRaSXBE8+7OGWmCqGgbFB1PUjn9rzGJRZMBBZMuL2aqiwmT0AZUYc4wr8lXwqHEJMx
         mP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtphTpz7ijVKD36pVaA+RVVdZdeigjx2bTQbCQuaqA4=;
        b=qaN3d64DjApKz0zolGyeIPnTrhlHNUegtUUk1gCOW5aXTP8ZWGcLJiSefN2FxzIhI1
         wYIgpBFmuz1QAp6xiGSmrcD4lXLg6/KwC4/gah7iQKM8D8++srZCNKczZs3ZwGMFoa6y
         xhg6LyPMtYZ+A7D9OiszVANH2zEB0SnvLN3UAMMSo2jNVPpmyzX5rzJZBJy6AXxpePUf
         xGQ6DTTWXzQKYwR6kYw5vcM484F2L8b3EP207sDqNY7iY/Uqpfw5c07SqvW9/vC3DMRM
         oKHKyNkkJDHZHeEkOB/Rn98s8O75qy1cm/8oO7QnKfMm8nwhdSEvFYYej/ZbOCJ+FL1b
         QJaA==
X-Gm-Message-State: AJIora8C3EmyYdXJUkL+zkc4wy/YulhEXWGKifihqH0iaFyXiVzgCv+M
        FYjzMCZg7kSpd+Kf5QBVEnD4X3O6Wm2dQQ==
X-Google-Smtp-Source: AGRyM1vjihN/I1e42DwkTxf/7sy4/1BchAp0Y6WdajcFpM6vEghmwL7N454BdDCdUqewCaI6yo0D4Q==
X-Received: by 2002:a05:6214:c26:b0:464:3fdd:a3e6 with SMTP id a6-20020a0562140c2600b004643fdda3e6mr19147415qvd.113.1655738683914;
        Mon, 20 Jun 2022 08:24:43 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 11/12] SUNRPC create a function that probes only offline transports
Date:   Mon, 20 Jun 2022 11:24:06 -0400
Message-Id: <20220620152407.63127-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

For only offline transports, attempt to check connectivity via
a NULL call and, if that succeeds, call a provided session trunking
detection function.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c           |  2 +-
 include/linux/sunrpc/clnt.h |  3 ++-
 net/sunrpc/clnt.c           | 47 +++++++++++++++++++++++++++++++++----
 net/sunrpc/debugfs.c        |  3 ++-
 net/sunrpc/stats.c          |  2 +-
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 152da2bc5100..00778f351283 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8533,7 +8533,7 @@ int nfs4_proc_bind_conn_to_session(struct nfs_client *clp, const struct cred *cr
 		.cred = cred,
 	};
 	return rpc_clnt_iterate_for_each_xprt(clp->cl_rpcclient, NULL,
-			nfs4_proc_bind_conn_to_session_callback, &data);
+			nfs4_proc_bind_conn_to_session_callback, &data, false);
 }
 
 /*
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index ac1024da86c5..a0160b83d4a4 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -215,7 +215,7 @@ int		rpc_localaddr(struct rpc_clnt *, struct sockaddr *, size_t);
 int 		rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
 			int (*setup)(struct rpc_clnt *, struct rpc_xprt_iter *),
 			int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
-			void *data);
+			void *data, bool do_rewind);
 
 int 		rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 			struct rpc_xprt_switch *xps,
@@ -236,6 +236,7 @@ int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
 			struct rpc_xprt *,
 			void *);
 void		rpc_clnt_manage_trunked_xprts(struct rpc_clnt *, void *);
+void		rpc_probe_trunked_xprts(struct rpc_clnt *, void *);
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6b04b29bf842..348d0772c91d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -830,7 +830,7 @@ int rpc_clnt_xprt_iter_offline_init(struct rpc_clnt *clnt,
 int rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
 		int (*setup)(struct rpc_clnt *, struct rpc_xprt_iter *),
 		int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
-		void *data)
+		void *data, bool do_rewind)
 {
 	struct rpc_xprt_iter xpi;
 	int ret;
@@ -850,6 +850,9 @@ int rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
 		xprt_put(xprt);
 		if (ret < 0)
 			break;
+
+		if (do_rewind)
+			xprt_iter_rewind(&xpi);
 	}
 	xprt_iter_destroy(&xpi);
 	return ret;
@@ -3032,6 +3035,40 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
 
+static int rpc_xprt_probe_trunked(struct rpc_clnt *clnt,
+				  struct rpc_xprt *xprt,
+				  void *data)
+{
+	struct rpc_xprt_switch *xps;
+	struct rpc_xprt *main_xprt;
+	int status = 0;
+
+	xprt_get(xprt);
+
+	rcu_read_lock();
+	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	status = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
+				(struct sockaddr *)&main_xprt->addr);
+	rcu_read_unlock();
+	xprt_put(main_xprt);
+	if (status || !test_bit(XPRT_OFFLINE, &xprt->state))
+		goto out;
+
+	status = rpc_clnt_add_xprt_helper(clnt, xprt, data);
+out:
+	xprt_put(xprt);
+	xprt_switch_put(xps);
+	return status;
+}
+
+void rpc_probe_trunked_xprts(struct rpc_clnt *clnt, void *data)
+{
+	rpc_clnt_iterate_for_each_xprt(clnt, rpc_clnt_xprt_iter_offline_init,
+			rpc_xprt_probe_trunked, data, true);
+}
+EXPORT_SYMBOL_GPL(rpc_probe_trunked_xprts);
+
 static int rpc_xprt_offline_destroy(struct rpc_clnt *clnt,
 				    struct rpc_xprt *xprt,
 				    void *data)
@@ -3071,7 +3108,7 @@ static int rpc_xprt_offline_destroy(struct rpc_clnt *clnt,
 void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt, void *data)
 {
 	rpc_clnt_iterate_for_each_xprt(clnt, NULL, rpc_xprt_offline_destroy,
-			data);
+			data, false);
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
 
@@ -3105,7 +3142,7 @@ rpc_set_connect_timeout(struct rpc_clnt *clnt,
 	};
 	rpc_clnt_iterate_for_each_xprt(clnt, NULL,
 			rpc_xprt_set_connect_timeout,
-			&timeout);
+			&timeout, false);
 }
 EXPORT_SYMBOL_GPL(rpc_set_connect_timeout);
 
@@ -3228,7 +3265,7 @@ rpc_clnt_swap_activate(struct rpc_clnt *clnt)
 		clnt = clnt->cl_parent;
 	if (atomic_inc_return(&clnt->cl_swapper) == 1)
 		return rpc_clnt_iterate_for_each_xprt(clnt, NULL,
-				rpc_clnt_swap_activate_callback, NULL);
+				rpc_clnt_swap_activate_callback, NULL, false);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_swap_activate);
@@ -3247,7 +3284,7 @@ rpc_clnt_swap_deactivate(struct rpc_clnt *clnt)
 {
 	if (atomic_dec_if_positive(&clnt->cl_swapper) == 0)
 		rpc_clnt_iterate_for_each_xprt(clnt, NULL,
-				rpc_clnt_swap_deactivate_callback, NULL);
+				rpc_clnt_swap_deactivate_callback, NULL, false);
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_swap_deactivate);
 #endif /* CONFIG_SUNRPC_SWAP */
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index ab60b4d3deb2..9c700bad1ec5 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -160,7 +160,8 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
 			    &tasks_fops);
 
-	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_xprt_debugfs, &xprtnum);
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_xprt_debugfs, &xprtnum,
+			false);
 }
 
 void
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index e50f73a4aca5..60e2d738a8f1 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -258,7 +258,7 @@ void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
 	seq_printf(seq, "p/v: %u/%u (%s)\n",
 			clnt->cl_prog, clnt->cl_vers, clnt->cl_program->name);
 
-	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_print_stats, seq);
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_print_stats, seq, false);
 
 	seq_printf(seq, "\tper-op statistics\n");
 	for (op = 0; op < maxproc; op++) {
-- 
2.27.0

