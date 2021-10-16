Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065F7430574
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhJPWtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83504611C1;
        Sat, 16 Oct 2021 22:46:58 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 06/14] SUNRPC: Remove dprintk call site from bc_svc_process()
Date:   Sat, 16 Oct 2021 18:46:57 -0400
Message-Id:  <163442441738.1001.4289869508359067082.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; h=from:subject:message-id; bh=xuUfjymTwTPOwkzND15H/cS9LfYuQoOPGpM9MzEMfFM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZhgiW5D6/SutCTlp0qCVAQxTgN7+hIH83jnnMd oWO7wH6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWYQAKCRAzarMzb2Z/l1uoD/ 4wQi/GMLf8W1uwDZTY4ZtPkJjzuTKeTCJYwvwRZyrOrXKuaH74vsSgZEW3fyfUh7QIwqvyMyvnYan0 6G6o1UFRzxnPLV7M5dDMd14kmdtWaXvb/VGo+le1ZXUmWFhwbL3WynqE9RO49v9L7HsXKEXH/Np9bM Qc+FMYR/6paZ1x9HEOD9iKP8726tdW6VzO1HAamm9AT+f5p6b1zGfrk88ydxWCZLq+gYO/ehACIM4P psFwDk4CZWhi47tyXmARdjkspAgE6M7+35ZlMeYTQUS7ZpW7cnlXSuAZfAMoqCzkcnV8RtdWk9Tv6v voQIONgfhthDWQEQZgJ66zRlk8QpWXokrUw2BQudU72KKJQChc/TaXy9zORpRN+n7VRoe+UYV8MGIG ng9p+BkUsCyOUERUAIP+T4H2W3aFgQZvVXt84xvJzrBYeg+Ta0WykEn3td0jEBW14/Stq0bWDUCwip wR1UxpV4XqHrD+pUhWJNjGtqGmlISje5sG5bA93iZTk+ia9x6YEySV/Q1d/k6930jxrsn3imTy37H2 L19ZGfciHLgGGqhkszDDq1KBv0PpolJBg8NcpQE0AYW4F11TwpVCK7WqgGLh9vmGl82/DZPHekbDxw zYYQ/u+GBUeFQHI9Ttx+hpUchUvCBXZ5Of6Mt1ruU+m0SP39+c12pGO+HxeQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. Enabling tracepoints in the RPC client gives similar
observability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 8ca60bfaa073..dbc44178daac 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1472,7 +1472,6 @@ svc_process(struct svc_rqst *rqstp)
 	dir  = svc_getnl(argv);
 	if (dir != 0) {
 		/* direction != CALL */
-		svc_printk(rqstp, "bad direction %d, dropping request\n", dir);
 		serv->sv_stats->rpcbadfmt++;
 		goto out_drop;
 	}
@@ -1502,8 +1501,6 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	int proc_error;
 	int error;
 
-	dprintk("svc: %s(%p)\n", __func__, req);
-
 	/* Build the svc_rqst used by the common processing routine */
 	rqstp->rq_xid = req->rq_xid;
 	rqstp->rq_prot = req->rq_xprt->prot;
@@ -1561,7 +1558,6 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	rpc_put_task(task);
 
 out:
-	dprintk("svc: %s(), error=%d\n", __func__, error);
 	return error;
 }
 EXPORT_SYMBOL_GPL(bc_svc_process);

