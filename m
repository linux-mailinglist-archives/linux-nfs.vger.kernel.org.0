Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0862942C3D6
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhJMOtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOtA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC2461166;
        Wed, 13 Oct 2021 14:46:57 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 1/6] svcrdma: Remove dprintk() call sites in module handlers
Date:   Wed, 13 Oct 2021 10:46:56 -0400
Message-Id:  <163413641616.6408.5066105649819002503.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; h=from:subject:message-id; bh=BR5geGc6pgqOYwr1XgHbnHSOKXn49/1oY3gm/WvKgZ4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvFgHf5DrKFwyAfMiORCtbAn6ShpjP9nv9Xo6diH stxOHgSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxYAAKCRAzarMzb2Z/lx/MEA CHHPjgYH/RVD7ww22wkOv+aPw6Ekl92OHvHCIRvMsQutiBcWWA4pcdRAXfXLu05vKQm1BsPjEvoU0h X3q9yC/+17BlG1J8pu7bUYz0ZIeSACReJSXcL9GRJ3vTqdkYYE84q60G4ffXHaW05tPHC2US+wJRT+ z40K3W7U6UlSqL3H46U+4p5k4EowysC7dBMpbdyFmUcTB5Rd5IXmumYLQ+E2j5Jpe8XJuepHz+X56h ivVGchZIywthab+pH1CpLgGv48TLETjwfZ528ytQb3w9/yfX+jn5TYPh/Ygacrfo7y4PxhfRSWfqzE 4vYQ+H3FEFz5PCKaVydK+SOnwC30/4qEMzk8WBy/DVAoLbNbpYRUFHF2PWEKgVEImi4uwxRgREskIV /1hEKQIV7OhyluBt6zX0TGEzK292t997Ok+UETpDjn3Ha8j8vQBBypQIOgtObuvlwZfdz91hwqDmCV 3OkVDBsrTEUKW0mLEye5rJ1PXtbr/ZY5iABb6FHNd/KfBAorgfXV2I1jVOv++1c79VZPh0mCImtgvC EaxMvIciwHqwb332yrB+6HbAghnxfCTy6Qj6pcZOY1JQ4Uxbd6xVECpvS7pwRxBXXOFdGlcbpWon2F 2P3i13uJkK7mEf44aKqr5SFGl2DWQHbvFnSgqmac+12iZfDAxaq3W4dW7dmA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As part of the deprecation of dprintk, remove low-value dprintk call
sites in the module init and clean-up functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 5bc20e9d09cd..2470a7926469 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -49,8 +49,6 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/svc_rdma.h>
 
-#define RPCDBG_FACILITY	RPCDBG_SVCXPRT
-
 /* RPC/RDMA parameters */
 unsigned int svcrdma_ord = 16;	/* historical default */
 static unsigned int min_ord = 1;
@@ -275,7 +273,6 @@ static int svc_rdma_proc_init(void)
 
 void svc_rdma_cleanup(void)
 {
-	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
 	svc_unreg_xprt_class(&svc_rdma_class);
 	svc_rdma_proc_cleanup();
 }
@@ -284,12 +281,6 @@ int svc_rdma_init(void)
 {
 	int rc;
 
-	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
-	dprintk("\tsvcrdma_ord      : %d\n", svcrdma_ord);
-	dprintk("\tmax_requests     : %u\n", svcrdma_max_requests);
-	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
-	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
-
 	rc = svc_rdma_proc_init();
 	if (rc)
 		return rc;

