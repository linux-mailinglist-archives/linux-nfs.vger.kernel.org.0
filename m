Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF3425CFB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Oct 2021 22:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhJGUMN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 16:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhJGUMG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Oct 2021 16:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9903B61073;
        Thu,  7 Oct 2021 20:10:12 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Simplify the SVC dispatch code path
Date:   Thu,  7 Oct 2021 16:10:11 -0400
Message-Id:  <163363740475.2193.13625300535935236003.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093; h=from:subject:message-id; bh=Bx8EQHVcgEBG6BuCql7S9QqyZaix7P2xw6xFkJjz8YE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhX1QcQiKN/4YVm922GPXuOwENosmQ7h5OMZBkwror BAix806JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYV9UHAAKCRAzarMzb2Z/l0crD/ 98Y7My4ygdtVbZdGPeC55Qc402jFwL6y//ATdU8+UhAGxU/p2J/TgOk2jv6Xg4qElyoT7b5oK3gFr9 637AEIqVolCXkLI9jK3G4aqZJYuS2USbDU2OmeVR4bPtnprfTvtAGI7A64bdwETCWE9pFZZHU5SIP4 CfS89t0CJ0pOS7bc8LbGcWs3vVWX1iTTLGKZ0PiRS9mZwCeNKBCSOjiTUFImV6iXAy2HQAti4wwD4J 3o8TvIRaDvUqa5T8HXrdAsgju+wZ09SJgydvZZDeqpFGuKtVl3vSJEjn7WMjyNzcD/JxYbWRbtCBlA NxWtRFG3+TyeXY8gcunuKUlTH11XgesLPaWdy/eSSNZ3PP5A/KM2rwO3PxPcd6DT6iEIENMNG0BhaI 98i1pBmfP8i6Ka40SrJYg5mLUzkJfeadyqokUlC3c46Dpk6fVi3F74J7msSrIhnDMmwfP2SP/QT0ug B0TYqVrmG9xRiVLlyimX6I/3elE2/BJzJXEDbkS9o4e7pbmLVLf9j4njSJSChNxi93CDuWeya+C4I3 LOC2GbWibI88TCWsjcZjvUqykj8djkJJj0EkJGC5C4diaOm9dwtb/PyPF9pusRcpCW72H+CEM6ITQh PVSPW2Nqt3N9HPR7JirzvcN75CSPBipAquWbkBWQ0Ik6x70802kQpsGM+mbA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: The last user of the generic SVC dispatch code
path has been removed, so svc_process_common() can be simplified.
This declutters the hot path so that the by-far most common case
(a dispatch function exists) is made the /only/ path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    5 +---
 net/sunrpc/svc.c           |   51 ++------------------------------------------
 2 files changed, 3 insertions(+), 53 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 6263410c948a..4205a6ef4770 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -443,10 +443,7 @@ struct svc_version {
 	/* Need xprt with congestion control */
 	bool			vs_need_cong_ctrl;
 
-	/* Override dispatch function (e.g. when caching replies).
-	 * A return value of 0 means drop the request. 
-	 * vs_dispatch == NULL means use default dispatcher.
-	 */
+	/* Dispatch function */
 	int			(*vs_dispatch)(struct svc_rqst *, __be32 *);
 };
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 08ca797bb8a4..e0dd6e6a4602 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1186,45 +1186,6 @@ void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...)
 static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
 #endif
 
-static int
-svc_generic_dispatch(struct svc_rqst *rqstp, __be32 *statp)
-{
-	struct kvec *argv = &rqstp->rq_arg.head[0];
-	struct kvec *resv = &rqstp->rq_res.head[0];
-	const struct svc_procedure *procp = rqstp->rq_procinfo;
-
-	/*
-	 * Decode arguments
-	 * XXX: why do we ignore the return value?
-	 */
-	if (procp->pc_decode &&
-	    !procp->pc_decode(rqstp, argv->iov_base)) {
-		*statp = rpc_garbage_args;
-		return 1;
-	}
-
-	*statp = procp->pc_func(rqstp);
-
-	if (*statp == rpc_drop_reply ||
-	    test_bit(RQ_DROPME, &rqstp->rq_flags))
-		return 0;
-
-	if (rqstp->rq_auth_stat != rpc_auth_ok)
-		return 1;
-
-	if (*statp != rpc_success)
-		return 1;
-
-	/* Encode reply */
-	if (procp->pc_encode &&
-	    !procp->pc_encode(rqstp, resv->iov_base + resv->iov_len)) {
-		dprintk("svc: failed to encode reply\n");
-		/* serv->sv_stats->rpcsystemerr++; */
-		*statp = rpc_system_err;
-	}
-	return 1;
-}
-
 __be32
 svc_generic_init_request(struct svc_rqst *rqstp,
 		const struct svc_program *progp,
@@ -1392,16 +1353,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
 
 	/* Call the function that processes the request. */
-	if (!process.dispatch) {
-		if (!svc_generic_dispatch(rqstp, statp))
-			goto release_dropit;
-		if (*statp == rpc_garbage_args)
-			goto err_garbage;
-	} else {
-		dprintk("svc: calling dispatcher\n");
-		if (!process.dispatch(rqstp, statp))
-			goto release_dropit; /* Release reply info */
-	}
+	if (!process.dispatch(rqstp, statp))
+		goto release_dropit;
 
 	if (rqstp->rq_auth_stat != rpc_auth_ok)
 		goto err_release_bad_auth;

