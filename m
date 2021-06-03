Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184D39ABFB
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFCUwc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUwc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0002613BF;
        Thu,  3 Jun 2021 20:50:46 +0000 (UTC)
Subject: [PATCH 02/29] lockd: Create a simplified .vs_dispatch method for NLM
 requests
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:50:46 -0400
Message-ID: <162275344613.32691.16128075802320636795.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To enable xdr_stream-based encoding and decoding, create a bespoke
RPC dispatch function for the lockd service.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 1a639e34847d..2de048f80eb8 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -766,6 +766,46 @@ static void __exit exit_nlm(void)
 module_init(init_nlm);
 module_exit(exit_nlm);
 
+/**
+ * nlmsvc_dispatch - Process an NLM Request
+ * @rqstp: incoming request
+ * @statp: pointer to location of accept_stat field in RPC Reply buffer
+ *
+ * Return values:
+ *  %0: Processing complete; do not send a Reply
+ *  %1: Processing complete; send Reply in rqstp->rq_res
+ */
+static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+{
+	const struct svc_procedure *procp = rqstp->rq_procinfo;
+	struct kvec *argv = rqstp->rq_arg.head;
+	struct kvec *resv = rqstp->rq_res.head;
+
+	svcxdr_init_decode(rqstp);
+	if (!procp->pc_decode(rqstp, argv->iov_base))
+		goto out_decode_err;
+
+	*statp = procp->pc_func(rqstp);
+	if (*statp == rpc_drop_reply)
+		return 0;
+	if (*statp != rpc_success)
+		return 1;
+
+	svcxdr_init_encode(rqstp);
+	if (!procp->pc_encode(rqstp, resv->iov_base + resv->iov_len))
+		goto out_encode_err;
+
+	return 1;
+
+out_decode_err:
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_encode_err:
+	*statp = rpc_system_err;
+	return 1;
+}
+
 /*
  * Define NLM program and procedures
  */
@@ -775,6 +815,7 @@ static const struct svc_version	nlmsvc_version1 = {
 	.vs_nproc	= 17,
 	.vs_proc	= nlmsvc_procedures,
 	.vs_count	= nlmsvc_version1_count,
+	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
 static unsigned int nlmsvc_version3_count[24];
@@ -783,6 +824,7 @@ static const struct svc_version	nlmsvc_version3 = {
 	.vs_nproc	= 24,
 	.vs_proc	= nlmsvc_procedures,
 	.vs_count	= nlmsvc_version3_count,
+	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
 #ifdef CONFIG_LOCKD_V4
@@ -792,6 +834,7 @@ static const struct svc_version	nlmsvc_version4 = {
 	.vs_nproc	= 24,
 	.vs_proc	= nlmsvc_procedures4,
 	.vs_count	= nlmsvc_version4_count,
+	.vs_dispatch	= nlmsvc_dispatch,
 	.vs_xdrsize	= NLMSVC_XDRSIZE,
 };
 #endif


