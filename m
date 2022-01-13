Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE2A48DCC8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiAMRUd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMRUc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 12:20:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D329C061574
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 09:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0FE61CF2
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C76C36AE9;
        Thu, 13 Jan 2022 17:20:31 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] xprtrdma: Remove definitions of RPCDBG_FACILITY
Date:   Thu, 13 Jan 2022 12:20:30 -0500
Message-Id:  <164209443001.12592.7286421071967605038.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
References:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; h=from:subject:message-id; bh=UuGIgobGMsAv6wx6oWJcLnaRwhlDji4i8dAYteI2do4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh4F9enJ2TTIK7hZ+yHiyM145PcB3w5SG6tmX1zD0/ QPO5YFiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYeBfXgAKCRAzarMzb2Z/l/M8EA CJQHCeKAh11Gmx1dhIfKViphzIQt4BZxo9oLsRGMKrHpYL440GyVUy/quTXaG4WGq6x618/pJeS/Ks nMxq1qfL8c/tB0EIP7aWt1Kgo3Ni8Ows0W1svjIVOVcH3Ll8s2oZutx+22R3EbaiqhiS0JkOONV/fx m/vYqNyRZtxjjCbs9gccDHrRH4VTvlcpp8N5VCs0czBODq2bgr7YVkYPbE0IxRVh5siYB40+otzNDS pbO2XyMy4Dx5aeNzaEzmstOTbAWks+JX5SeKj0mpf53gtqHT/2d2/F4btC/P+fTkZtbIiuLGOY0wSu MTjkgMRGQaTGWIrS2AAB76k7WLW3clEZk2jIe2MYTKAbWikoIBBN3aoSnR1PGOL3QQWUP2Bv6FL9hL FveYx8ATqXDIibaN2UAgjTM3JQ3S1wtqVFe6yZIdPM+YSww+AHLav+nZJe/n8pC6NxafCLVJZKIzJj VvQBDKi2TMjW5OTboillVpzziCU+R0zLiU7XI2XFYg6Le91hqexlV412hGK1xflCoiw9m3TENeJmbK M5Na+dOZ3Wul2tYVXdOLCB/J6JwVv6AeYjZNn+xmFe4QXgU1gG6mKw7pAOuHWmCkH4svV3bT8hJ6pV BU74dQFiTrgvs3VD3EzCocYZNBikPq1egghmjYop88UQOnGUe7bZaYfQ7hsw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecated. dprintk is no longer used in xprtrdma.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    4 ----
 net/sunrpc/xprtrdma/frwr_ops.c    |    4 ----
 net/sunrpc/xprtrdma/rpc_rdma.c    |    4 ----
 net/sunrpc/xprtrdma/transport.c   |    4 ----
 net/sunrpc/xprtrdma/verbs.c       |   11 -----------
 5 files changed, 27 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 17f174d6ea3b..faba7136dd9a 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -13,10 +13,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_TRANS
-#endif
-
 #undef RPCRDMA_BACKCHANNEL_DEBUG
 
 /**
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ff699307e820..515dd7a66a04 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -45,10 +45,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_TRANS
-#endif
-
 static void frwr_cid_init(struct rpcrdma_ep *ep,
 			  struct rpcrdma_mr *mr)
 {
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 8035a983c8ce..281ddb87ac8d 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -54,10 +54,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_TRANS
-#endif
-
 /* Returns size of largest RPC-over-RDMA header in a Call message
  *
  * The largest Call header contains a full-size Read list and a
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 16e5696314a4..42e375dbdadb 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -60,10 +60,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_TRANS
-#endif
-
 /*
  * tunables
  */
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1d6e85fe3133..f172d1298013 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -63,17 +63,6 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
-/*
- * Globals/Macros
- */
-
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY	RPCDBG_TRANS
-#endif
-
-/*
- * internal functions
- */
 static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,

