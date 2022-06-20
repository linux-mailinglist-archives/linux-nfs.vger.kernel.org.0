Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309A5520C7
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiFTPZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbiFTPZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51406E0F
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o73so8021181qke.7
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hiOpeOldRv5C+cpYA4d1f38bxNJH8q04syRxbARTC6c=;
        b=ay0q7cQkXAZSzBhHJ6PnnFHvbGnGRbn/98lGjYuHobUzkyCUC4rGbB/P8Sag4HJe/M
         dtEblkAw0cVd/SNbKj8mpkAqsSW7eV4E/nHxd6KhHhFwKnq/YWfiGLPUhEW3RH7zlxZz
         K7oIUUaMnJOHwhaxDFPfuw9VknELrO95fjzKyRm3kAx3Zx5+V8Q0sQjoZ1hSwIG8MhRF
         LBsdk4Di9HJ1y5MqlSIj/qwGGrmy1w2cubuyKxqVtt8gF5FZpHZ5AyJyG6KIFeZAZH+r
         C2heJ2g4fczXx+UmTyJARIKcyBQ+v/D5FV8NmUMArNUWG0TcVxpNjxwoD8A0ky+Cj5sn
         szGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiOpeOldRv5C+cpYA4d1f38bxNJH8q04syRxbARTC6c=;
        b=ceGZRpQeJRjIasAJ22R0AfJnXIct+cZS6o7fnKZZ4IBPA4UWHthF5FZhkrnZfC0+wg
         CdsolL3WsSxC4bzB2Qy1k0z0sp8dnYyscifH7NNbg03Y/z11cAZ+LLnIGYrO7Lymvcg+
         E+gli98dpZ/BwEvdNS0enoD+CajpV+brKeVwuqMSMcPZ+zX1O+/cWlEcuggei7jLT8zg
         Kg0BqWnRM8eHqEAvdmeKOeUgv0sIw58yD88KhHv/4q3b4ifhNBCNfuwFj3HJwBfnPDij
         k5tk7WmcbK4ul6NbpD0BfsEGfpj9SdSYXT8Owxw4hqVnZNPeJWcQ3Sp4VIj9LMBLH03u
         MALg==
X-Gm-Message-State: AJIora+O3EXz4pqv1zjOFk156Nb5tg9X0PiP6sUYBtTgceir4qZamJvB
        w4GBqO3r1gyx63cIB+AyHTmYQDB87EjGPw==
X-Google-Smtp-Source: AGRyM1uOOjjPjbihuV+Uc9iy/l+cY1LRtZVrLOXieSegrvr0XwQpeoNsVPOF3f0eYtGIC4lMqq+ZhQ==
X-Received: by 2002:a05:620a:1b98:b0:6a7:7e6d:d886 with SMTP id dv24-20020a05620a1b9800b006a77e6dd886mr16934958qkb.595.1655738676423;
        Mon, 20 Jun 2022 08:24:36 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 05/12] SUNRPC parameterize rpc_clnt_iterate_for_each_xprt with iterator init function
Date:   Mon, 20 Jun 2022 11:24:00 -0400
Message-Id: <20220620152407.63127-6-olga.kornievskaia@gmail.com>
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

Allow for rpc_clnt_iterate_for_each_xprt() to take in an iterator
initialization function if no function passed in a default initiator
is used.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c           |  2 +-
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 17 ++++++++++++-----
 net/sunrpc/debugfs.c        |  2 +-
 net/sunrpc/stats.c          |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cf898bea3bfd..5e4c32924347 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8532,7 +8532,7 @@ int nfs4_proc_bind_conn_to_session(struct nfs_client *clp, const struct cred *cr
 		.clp = clp,
 		.cred = cred,
 	};
-	return rpc_clnt_iterate_for_each_xprt(clp->cl_rpcclient,
+	return rpc_clnt_iterate_for_each_xprt(clp->cl_rpcclient, NULL,
 			nfs4_proc_bind_conn_to_session_callback, &data);
 }
 
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index e74a0740603b..20aed14fe222 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -213,6 +213,7 @@ const char	*rpc_peeraddr2str(struct rpc_clnt *, enum rpc_display_format_t);
 int		rpc_localaddr(struct rpc_clnt *, struct sockaddr *, size_t);
 
 int 		rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
+			int (*setup)(struct rpc_clnt *, struct rpc_xprt_iter *),
 			int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
 			void *data);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 410bd6c352ad..b26267606de0 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -817,6 +817,8 @@ int rpc_clnt_xprt_iter_offline_init(struct rpc_clnt *clnt,
 /**
  * rpc_clnt_iterate_for_each_xprt - Apply a function to all transports
  * @clnt: pointer to client
+ * @setup: an optional iterator init function to use, if none supplied
+ *   default rpc_clnt_xprt_iter_init() iterator is used
  * @fn: function to apply
  * @data: void pointer to function data
  *
@@ -826,13 +828,17 @@ int rpc_clnt_xprt_iter_offline_init(struct rpc_clnt *clnt,
  * On error, the iteration stops, and the function returns the error value.
  */
 int rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
+		int (*setup)(struct rpc_clnt *, struct rpc_xprt_iter *),
 		int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
 		void *data)
 {
 	struct rpc_xprt_iter xpi;
 	int ret;
 
-	ret = rpc_clnt_xprt_iter_init(clnt, &xpi);
+	if (!setup)
+		ret = rpc_clnt_xprt_iter_init(clnt, &xpi);
+	else
+		ret = setup(clnt, &xpi);
 	if (ret)
 		return ret;
 	for (;;) {
@@ -3052,7 +3058,8 @@ static int rpc_xprt_offline_destroy(struct rpc_clnt *clnt,
 
 void rpc_clnt_manage_trunked_xprts(struct rpc_clnt *clnt, void *data)
 {
-	rpc_clnt_iterate_for_each_xprt(clnt, rpc_xprt_offline_destroy, data);
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL, rpc_xprt_offline_destroy,
+			data);
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_manage_trunked_xprts);
 
@@ -3084,7 +3091,7 @@ rpc_set_connect_timeout(struct rpc_clnt *clnt,
 		.connect_timeout = connect_timeout,
 		.reconnect_timeout = reconnect_timeout,
 	};
-	rpc_clnt_iterate_for_each_xprt(clnt,
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL,
 			rpc_xprt_set_connect_timeout,
 			&timeout);
 }
@@ -3181,7 +3188,7 @@ rpc_clnt_swap_activate(struct rpc_clnt *clnt)
 	while (clnt != clnt->cl_parent)
 		clnt = clnt->cl_parent;
 	if (atomic_inc_return(&clnt->cl_swapper) == 1)
-		return rpc_clnt_iterate_for_each_xprt(clnt,
+		return rpc_clnt_iterate_for_each_xprt(clnt, NULL,
 				rpc_clnt_swap_activate_callback, NULL);
 	return 0;
 }
@@ -3200,7 +3207,7 @@ void
 rpc_clnt_swap_deactivate(struct rpc_clnt *clnt)
 {
 	if (atomic_dec_if_positive(&clnt->cl_swapper) == 0)
-		rpc_clnt_iterate_for_each_xprt(clnt,
+		rpc_clnt_iterate_for_each_xprt(clnt, NULL,
 				rpc_clnt_swap_deactivate_callback, NULL);
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_swap_deactivate);
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 7dc9cc929bfd..ab60b4d3deb2 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -160,7 +160,7 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
 			    &tasks_fops);
 
-	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_xprt_debugfs, &xprtnum);
 }
 
 void
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 52908f9e6eab..e50f73a4aca5 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -258,7 +258,7 @@ void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
 	seq_printf(seq, "p/v: %u/%u (%s)\n",
 			clnt->cl_prog, clnt->cl_vers, clnt->cl_program->name);
 
-	rpc_clnt_iterate_for_each_xprt(clnt, do_print_stats, seq);
+	rpc_clnt_iterate_for_each_xprt(clnt, NULL, do_print_stats, seq);
 
 	seq_printf(seq, "\tper-op statistics\n");
 	for (op = 0; op < maxproc; op++) {
-- 
2.27.0

