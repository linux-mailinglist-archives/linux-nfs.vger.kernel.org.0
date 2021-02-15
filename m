Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7D31C0D4
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhBORlp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhBORld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:41:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BEC06178C
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so9061046edb.9
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxL4xgluh2lEgYgmCoXEb71nIHVpJpsiBxGVUgUXHxk=;
        b=ydpIb8BdWIvZQJDen7oaUJC36KrToEq/CzAiqC+wy0M5WKzYu7SDurbOI6LC7mpvep
         w7x1dsw9wCN+Nr0BXrsZNux1+kC/VNeNQROa7e5wN8BzlM+FLo+ymVnf1DdwLQuo9xrJ
         wxjmRjCCmo3mtAPeBoB55qdd99iicafhp+Ysaxk8Q+YvEqpaszkuKGK8x2XPf1J/MiUJ
         0C3PLou6WZWf3aGCHJyIOARGoF1ca9zqVlkMrqmnxhX3CasvSGhRIMsXuisYcD8eBnqK
         TW3EjPsWTUEsBfrwncuS+8sWgCXjtJ7GxVlZHaCeYT9nY5o3P7HF/Dx4Xf0I95Xjz5lC
         uu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxL4xgluh2lEgYgmCoXEb71nIHVpJpsiBxGVUgUXHxk=;
        b=EslLba2WFjeKaWKrsvgdP+jEn6x79qpNGuCHRnp2l7LCVh7M1j5HLNW7yFDRhOtCpw
         yRVaYP9dH6NZ0+FP+cRuUDC+tKg0X8oFVCdlanu+Cuz6HheVc/LPFQ8L1OKumSCGwYx7
         GPZ5RvowcMZTBYCSAzfsvQTnzSho+iq+V0k4IJuGUXIX7KSTDzkdu9I2LH67m0XxwAG/
         35gRQHu/LcgnmAjy5mklBoSOTxlau2LWcfHX87F+h6N4gXM1WuyWQ4GBi7PpWt8DMI4C
         toYYk/wALT6QwGYHOKiQSGHdnh4I1HemUoansAEC5qMMIQrshXy70D+42S53ZYkucE+1
         qtxw==
X-Gm-Message-State: AOAM533x33Z7DKOtQhy9vIl1vQQz9cE5XjDjRZY9H5TSvdeiTbUfk6KY
        p81Ws3iwhjUktZn3IW81ZI6lH9OlDW9MBw==
X-Google-Smtp-Source: ABdhPJzIYmhG4MTsWYZ680kXyYpv/yNY2SURiPGw9kW3zTYJwSKRkrfGOkmsBn88Bc+Y5v8b5oMmeg==
X-Received: by 2002:aa7:d849:: with SMTP id f9mr3619350eds.76.1613410813165;
        Mon, 15 Feb 2021 09:40:13 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:12 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 7/8] sunrpc: change rpc_clnt_add_xprt() to rpc_add_xprt()
Date:   Mon, 15 Feb 2021 19:40:01 +0200
Message-Id: <20210215174002.2376333-8-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This change of API allows adding transports without holding a reference
to an rpc client.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 fs/nfs/pnfs_nfs.c           | 12 +++++++-----
 include/linux/sunrpc/clnt.h | 12 +++++++-----
 net/sunrpc/clnt.c           | 31 +++++++++++++++++--------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 49d3389bd813..1e61626bd0fa 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -878,8 +878,9 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
 			/* Add this address as an alias */
-			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
-					rpc_clnt_test_and_add_xprt, NULL);
+			rpc_add_xprt(&clp->cl_rpcclient->cl_xpi,
+				     clp->cl_rpcclient, &xprt_args,
+				     rpc_clnt_test_and_add_xprt, NULL);
 			continue;
 		}
 		clp = get_v3_ds_connect(mds_srv,
@@ -945,9 +946,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			* add as an alias
 			*/
 			xprtdata.cred = nfs4_get_clid_cred(clp),
-			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
-					  rpc_clnt_setup_test_and_add_xprt,
-					  &rpcdata);
+			rpc_add_xprt(&clp->cl_rpcclient->cl_xpi,
+				     clp->cl_rpcclient, &xprt_args,
+				     rpc_clnt_setup_test_and_add_xprt,
+				     &rpcdata);
 			if (xprtdata.cred)
 				put_cred(xprtdata.cred);
 		} else {
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 503653720e18..19bb23143eef 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -210,21 +210,23 @@ int 		rpc_clnt_iterate_for_each_xprt(struct rpc_clnt *clnt,
 			int (*fn)(struct rpc_clnt *, struct rpc_xprt *, void *),
 			void *data);
 
-int 		rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
+int 		rpc_clnt_test_and_add_xprt(void *clnt,
 			struct rpc_xprt_switch *xps,
 			struct rpc_xprt *xprt,
 			void *dummy);
-int		rpc_clnt_add_xprt(struct rpc_clnt *, struct xprt_create *,
-			int (*setup)(struct rpc_clnt *,
+int		rpc_add_xprt(struct rpc_xprt_iter *iter,
+		        void *ctx,
+		        struct xprt_create *xprtargs,
+		        int (*setup)(void *ctx,
 				struct rpc_xprt_switch *,
 				struct rpc_xprt *,
 				void *),
-			void *data);
+		        void *data);
 void		rpc_set_connect_timeout(struct rpc_clnt *clnt,
 			unsigned long connect_timeout,
 			unsigned long reconnect_timeout);
 
-int		rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *,
+int		rpc_clnt_setup_test_and_add_xprt(void *,
 			struct rpc_xprt_switch *,
 			struct rpc_xprt *,
 			void *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0a4811be01cd..b94d274a5446 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -598,7 +598,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		return clnt;
 
 	for (i = 0; i < args->nconnect - 1; i++) {
-		if (rpc_clnt_add_xprt(clnt, &xprtargs, NULL, NULL) < 0)
+		if (rpc_add_xprt(&clnt->cl_xpi, NULL, &xprtargs, NULL, NULL) < 0)
 			break;
 	}
 	return clnt;
@@ -2751,10 +2751,11 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  * @xprt: pointer struct rpc_xprt
  * @dummy: unused
  */
-int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
+int rpc_clnt_test_and_add_xprt(void *ptr,
 		struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
 		void *dummy)
 {
+	struct rpc_clnt *clnt = ptr;
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
 
@@ -2795,11 +2796,12 @@ EXPORT_SYMBOL_GPL(rpc_clnt_test_and_add_xprt);
  * @data: a struct rpc_add_xprt_test pointer that holds the test function
  *        and test function call data
  */
-int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
+int rpc_clnt_setup_test_and_add_xprt(void *ptr,
 				     struct rpc_xprt_switch *xps,
 				     struct rpc_xprt *xprt,
 				     void *data)
 {
+	struct rpc_clnt *clnt = ptr;
 	struct rpc_task *task;
 	struct rpc_add_xprt_test *xtest = (struct rpc_add_xprt_test *)data;
 	int status = -EADDRINUSE;
@@ -2852,13 +2854,14 @@ EXPORT_SYMBOL_GPL(rpc_clnt_setup_test_and_add_xprt);
  * adding the new transport.
  *
  */
-int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
-		struct xprt_create *xprtargs,
-		int (*setup)(struct rpc_clnt *,
-			struct rpc_xprt_switch *,
-			struct rpc_xprt *,
-			void *),
-		void *data)
+int rpc_add_xprt(struct rpc_xprt_iter *iter,
+		 void *ctx,
+		 struct xprt_create *xprtargs,
+		 int (*setup)(void *ctx,
+			      struct rpc_xprt_switch *,
+			      struct rpc_xprt *,
+			      void *),
+		 void *data)
 {
 	struct rpc_xprt_switch *xps;
 	struct rpc_xprt *xprt;
@@ -2868,8 +2871,8 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	int ret = 0;
 
 	rcu_read_lock();
-	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
-	xprt = xprt_iter_xprt(&clnt->cl_xpi);
+	xps = xprt_switch_get(rcu_dereference(iter->xpi_xpswitch));
+	xprt = xprt_iter_xprt(iter);
 	if (xps == NULL || xprt == NULL) {
 		rcu_read_unlock();
 		xprt_switch_put(xps);
@@ -2895,7 +2898,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 
 	rpc_xprt_switch_set_roundrobin(xps);
 	if (setup) {
-		ret = setup(clnt, xps, xprt, data);
+		ret = setup(ctx, xps, xprt, data);
 		if (ret != 0)
 			goto out_put_xprt;
 	}
@@ -2906,7 +2909,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	xprt_switch_put(xps);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rpc_clnt_add_xprt);
+EXPORT_SYMBOL_GPL(rpc_add_xprt);
 
 struct connect_timeout_data {
 	unsigned long connect_timeout;
-- 
2.26.2

