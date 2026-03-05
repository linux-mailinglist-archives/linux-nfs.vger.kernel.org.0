Return-Path: <linux-nfs+bounces-19806-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK60DfiZqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19806-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C81213FD8
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805A1308A012
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3B3A9D96;
	Thu,  5 Mar 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWmyCddb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3C3ACA50;
	Thu,  5 Mar 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722272; cv=none; b=SsW0VBWCy6dsY6GWCky0Miyj3sQj2xu9Vhzcar48L0s4fmrpwzZWU96yuWXu/iDIjABraTKX9MYhgPYvwYWGoWEIZGLePm8vYMcKhvdYaVKm9qTTtOXVm9dTpEocVhYAZ0xeWS5+PAehyMeWBhZEiZIOwsvP5UShnS3zkMPsePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722272; c=relaxed/simple;
	bh=mjjJUcF5bBleqSaCQG9nSGl3tie4is26NddLOfzLoZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr2gXM/Q/XqHbQMDKWu0xilpA3MDwRH//Hi87ocFF7flFhl3VtB1ALtVkBrz44siprKgowk6keeRrzAb6C8NTE+IwSgF/HxJlmUwy9ysvaIOesdO5ou9WPVeA94YCqwPW+jU4d0k2t6Ah6hsYe2YLf4LoGoij+yqjuiWc0XIMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWmyCddb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1656BC2BC9E;
	Thu,  5 Mar 2026 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722272;
	bh=mjjJUcF5bBleqSaCQG9nSGl3tie4is26NddLOfzLoZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWmyCddb7oTZ39AllLr7OXZmlkXbtFLjexhfwWIt3tdv0/ZKL74kaQ0dYt9hQB5JR
	 aESHXYOCeLCOMm0BqP/NVlPsERSSEbpmiy8rmms93FKaecpk0asjL5stZvZ67SfjB/
	 oamOV+9V1nZhbGC6kt9rG5JvKNZQIAes8xz9wC261XIqHh5yZBz/ZK5bW1oknc/1ur
	 COSu2SQ3Z3k1UpvP6un55KWuJ8ULkqeGqYSw9XLkKNTLLKT35O+/glkbnGKMQtujSL
	 orraryzh+hBliujpQlcaVWE49fG8qkLhvWFdnvP4bHsDKdWdnmIvVDRxPohYkzS3Vo
	 1tjAQCBH6v/UQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 8/8] xprtrdma: Post receive buffers after RPC completion
Date: Thu,  5 Mar 2026 09:51:03 -0500
Message-ID: <20260305145054.7096-18-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=chuck.lever@oracle.com; h=from:subject; bh=9qylfuFV0+fS15vEIvKOq1nUOavvHEsGbPcyxQq7aF8=; b=kA0DAAoBM2qzM29mf5cByyZiAGmpmFaitUeEOQlpYaEYc2fJJ7yJcvZpkrABo1XHUsbz/sv1g okCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJpqZhWAAoJEDNqszNvZn+X1vcP/0el +uXuZiXWcBSxiXQ+MQ1uoY2X7axzxbAHpplwFDDkKdOP0S3tOs+E8XBhKRHaORj7K2DS/qGQ3CP qYv1l2WdTu/9ZMzbpEk/UjboPbvP8WvwRjScwhyDr4Qc1Yt2ywTpNeh9LVhgykpFlQpwY5mL5e/ VIbPqnVxBRVzff4Lmn3D0E0+BI0H6fHjkPhFY9sfnFIbvQWTXVRvSfTEAmLXW1Ek4wr0ra/qF2x yFj3zm8HLbHW6W7sDnCdUkgLUVUHySnAt/CtJIIXzM92lw8GAK0mTsBPREYTALuIMTeLFLXrLjc gz+Hswiu0DK2rCxFoPS5rg+in1lNA3/NdeUrb2zy3d8I03SNKBro717ajdGyfHdYJqfyVfXf7+6 BLskBv6AhVUegYTO0s9bZ1zeko7WYPg24VRB9LmwU1bKFCysXgraMaQs4y4vHLCDKJtxzarGsmu vbU6KHqWsRQjReBtszijwXsonjJLWJQt+Bx2scB2W6Uonzn5F24+qY1L6Tbr9cZj1ZTcYcTPqzf ifXNxktPoBcOXhgN7nmCqZjbtXdIlRABu8l67riST2QQPCrWd2mJRoPossjc5Et+BblGyRT0Voh tXYx6eqv+VyAs7s4+GdlJUyXGHFDSNPxIOn0KxzIJmZCV0EADRkSSqN9rGc7RpibPoOHcUpzLzf o20sq
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14C81213FD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19806-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

rpcrdma_post_recvs() runs in CQ poll context and its cost
falls on the latency-critical path between polling a Receive
completion and waking the RPC consumer. Every cycle spent
refilling the Receive Queue delays delivery of the reply to
the NFS layer.

Move the rpcrdma_post_recvs() call in rpcrdma_reply_handler()
to after the RPC has been decoded and completed. The larger
batch size from the preceding patch provides sufficient
Receive Queue headroom to absorb the brief delay before
buffers are replenished.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 2ce50e8ce5fd..6cf5194298e4 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1419,7 +1419,6 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_ep->re_max_requests)
 		credits = r_xprt->rx_ep->re_max_requests;
-	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1));
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
 
@@ -1438,15 +1437,20 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		/* LocalInv completion will complete the RPC */
 	else
 		kref_put(&req->rl_kref, rpcrdma_reply_done);
-	return;
 
-out_badversion:
-	trace_xprtrdma_reply_vers_err(rep);
-	goto out;
+out_post:
+	rpcrdma_post_recvs(r_xprt,
+			   credits + (buf->rb_bc_srv_max_requests << 1));
+	return;
 
 out_norqst:
 	spin_unlock(&xprt->queue_lock);
 	trace_xprtrdma_reply_rqst_err(rep);
+	rpcrdma_rep_put(buf, rep);
+	goto out_post;
+
+out_badversion:
+	trace_xprtrdma_reply_vers_err(rep);
 	goto out;
 
 out_shortreply:
-- 
2.53.0


