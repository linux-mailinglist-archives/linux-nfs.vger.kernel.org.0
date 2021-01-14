Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA72F65C0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhANQXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbhANQXP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1298623B3E;
        Thu, 14 Jan 2021 16:22:35 +0000 (UTC)
Subject: [PATCH v1 1/5] svcrdma: Refactor svc_rdma_init() and
 svc_rdma_clean_up()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:34 -0500
Message-ID: <161064135435.6061.6371647855819015017.stgit@klimt.1015granger.net>
In-Reply-To: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
References: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Setting up the proc variables is about to get more complicated.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 526da5d4710b..1fc1d5cbeb9b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -224,27 +224,43 @@ static struct ctl_table svcrdma_root_table[] = {
 	{ },
 };
 
+static void svc_rdma_proc_cleanup(void)
+{
+	if (!svcrdma_table_header)
+		return;
+	unregister_sysctl_table(svcrdma_table_header);
+	svcrdma_table_header = NULL;
+}
+
+static int svc_rdma_proc_init(void)
+{
+	if (svcrdma_table_header)
+		return 0;
+
+	svcrdma_table_header = register_sysctl_table(svcrdma_root_table);
+	return 0;
+}
+
 void svc_rdma_cleanup(void)
 {
 	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
-	if (svcrdma_table_header) {
-		unregister_sysctl_table(svcrdma_table_header);
-		svcrdma_table_header = NULL;
-	}
 	svc_unreg_xprt_class(&svc_rdma_class);
+	svc_rdma_proc_cleanup();
 }
 
 int svc_rdma_init(void)
 {
+	int rc;
+
 	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
 	dprintk("\tsvcrdma_ord      : %d\n", svcrdma_ord);
 	dprintk("\tmax_requests     : %u\n", svcrdma_max_requests);
 	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
 	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
 
-	if (!svcrdma_table_header)
-		svcrdma_table_header =
-			register_sysctl_table(svcrdma_root_table);
+	rc = svc_rdma_proc_init();
+	if (rc)
+		return rc;
 
 	/* Register RDMA with the SVC transport switch */
 	svc_reg_xprt_class(&svc_rdma_class);


