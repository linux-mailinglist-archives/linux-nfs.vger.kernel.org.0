Return-Path: <linux-nfs+bounces-19802-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLNgAwaaqWlJAwEAu9opvQ
	(envelope-from <linux-nfs+bounces-19802-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A9D214005
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D64531D4DA4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9C3ACA54;
	Thu,  5 Mar 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG6HfFIY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078973A9D96;
	Thu,  5 Mar 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722270; cv=none; b=iJRzL2+KAQrB8TW+vSIvgEsGk6E6/iZcqjLU9Jk4hr2CSwIJU0a7xUDUIrgFSoJ2C91L8vpz7Ses5Gfz/61s0mhHKH4yjODRCZ1UwcVrqYrO9a+KxITHmJgkHFQKRk/+4L3srZD6WdBsE3hxV1oLiYB3uDJR35RgI+RJ+Fy/5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722270; c=relaxed/simple;
	bh=TyOiju2Wf7J6YXRzAafEYDEFmmJy56IWDlPHutamhog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFVYBVJQTp0ssvJB3U7rFnNJMWRICTVCEW3bhu/BtJOE/f2ReoOIMUn3qBbI3WrQWldzGumbwBkYQra4mFwB5PMPQ0I3eJBEB96c9FrLKaHBnckkgSfiRoqitkw1kyMKRIX0DJ9GunvrmfMCVcoUYDCHkb5Hbq7z/zeGwvJL6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG6HfFIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775DDC2BC9E;
	Thu,  5 Mar 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722269;
	bh=TyOiju2Wf7J6YXRzAafEYDEFmmJy56IWDlPHutamhog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MG6HfFIYF8a1KNbJqVbvGLKIYFX8Hbb5TJJ0aeIV4iFvHPCqyy2S6oSNJolC0I37e
	 D2DT3syw0hxsZfTBd25SmAWutjTSDXTARYBLH6EgBOrsCT540dR5cWTrWK9V1HHT4h
	 fa8ivSAYl5LOnFidy6YrxnyZbP9T2h4ZfsVkNdOBssWDWcLGY8Xp5N3FCcKBLKruh5
	 eEqgpoXiQtSBJ2kjreEucrgg7d12ZmGbaitJFperwEkmgfa9ya7EXXImasrSPcmKh6
	 C9S3k81laef64xvts2iL4WyarpY29qVEbfyNp3WBI/ezK5l4OavEyFfSRHqONdvoV/
	 6Xqoyx7wY6+vw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/8] xprtrdma: Close lost-wakeup race in xprt_rdma_alloc_slot
Date: Thu,  5 Mar 2026 09:50:59 -0500
Message-ID: <20260305145054.7096-14-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3733; i=chuck.lever@oracle.com; h=from:subject; bh=3v1qbCp1Drc/F/QuuTenhJQlhYXMoTVhIUgDkFZxhbw=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpqZhW5Y1/78DzqNVzi56DHudgZXfJPYZmtRISI 9jL+BtH5aWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaamYVgAKCRAzarMzb2Z/ l3ldEAC/lKRxl0VkzBNw2qaNibvvcqYJ4LWrjHNnlalzhbUx2/GoRhwxDhcCJJ9Z/UOUH4I++ok LfKXuZCM3HQ3HTsJyv6vubocz5qz2+xadtwMRKYKJVEtRA/HpmWHhXQ/MNqu25ljMJyfu48pKUp N7wv7O9jpI268Log1+L8aCpBu8rS+t3WidvsNKYBtAUx9DLhy3yZ0qD/XdnAggcoi1y/2Fdy/HM W2EAevcdZ99jpxzDogeknWEDpHyVezhp5e9XNCJaheWkOO9yjeep2PurhkqBPlQB/wpWsWtmJXd YxVzoskIOco4PR/JH3OG0dXxzFYzne8A1h4rRyjFrsAedzrERjIctTEqb4G5OWrq/iTxVGv5Amu QkcsStqlfjubW2xv09SHqNEgaV7OKB4Rgkc58XO3gEg4f9PEK7tBNIo7XQkhnHybHEkGNJJSgoX JFS6MCzM4rrR0/cfOIOh3Pmzj+gAE1SPSJj72KI92V6PUue7tmWOIphQnrlQ0DhEYYcmWFGJWQE Pqqpd2ynGgOTJfzT9M0jIG16QSG3uYYGc+IA6dYyZe8gegxmfOtyNoWO5tblfqeRfOBpVgAaW7K vVcBfI6MFwq0roxpIc8TATAmfXkgcEfX8lMlStMdYyF07GGyafDaYGMQ0iIadTJtVck9w6qG+fC 5nx/vNmk+4ELg8A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9A9D214005
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19802-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

xprt_rdma_alloc_slot() and xprt_rdma_free_slot() lack serialization
between the buffer pool and the backlog queue.  A buffer freed
after rpcrdma_buffer_get() finds the pool empty but before
rpc_sleep_on() places the task on the backlog is returned to the
pool with no waiter to wake, leaving the task stuck on the backlog
indefinitely.

After joining the backlog, re-check the pool and route any
recovered buffer through xprt_wake_up_backlog(), whose queue lock
serializes with concurrent wakeups and avoids double-assignment
of slots.

Because xprt_rdma_free_slot() does not hold reserve_lock, the
XPRT_CONGESTED double-check in xprt_throttle_congested() is
ineffective: a task can join the backlog through that path after
free_slot has already found it empty and cleared the bit.  Avoid
this by using xprt_add_backlog_noncongested(), which queues the
task without setting XPRT_CONGESTED, so every allocation reaches
xprt_rdma_alloc_slot() and its post-sleep re-check.

Fixes: edb41e61a54e ("xprtrdma: Make rpc_rqst part of rpcrdma_req")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprt.h     |  2 ++
 net/sunrpc/xprt.c               | 16 ++++++++++++++++
 net/sunrpc/xprtrdma/transport.c | 15 ++++++++++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f46d1fb8f71a..a82045804d34 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -404,6 +404,8 @@ struct rpc_xprt *	xprt_alloc(struct net *net, size_t size,
 				unsigned int max_req);
 void			xprt_free(struct rpc_xprt *);
 void			xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task);
+void			xprt_add_backlog_noncongested(struct rpc_xprt *xprt,
+					struct rpc_task *task);
 bool			xprt_wake_up_backlog(struct rpc_xprt *xprt, struct rpc_rqst *req);
 void			xprt_cleanup_ids(void);
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 4fbb57a29704..48a3618cbb29 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1663,6 +1663,22 @@ void xprt_add_backlog(struct rpc_xprt *xprt, struct rpc_task *task)
 }
 EXPORT_SYMBOL_GPL(xprt_add_backlog);
 
+/**
+ * xprt_add_backlog_noncongested - queue task on backlog
+ * @xprt: transport whose backlog queue receives the task
+ * @task: task to queue
+ *
+ * Like xprt_add_backlog, but does not set XPRT_CONGESTED.
+ * For transports whose free_slot path does not synchronize
+ * with xprt_throttle_congested via reserve_lock.
+ */
+void xprt_add_backlog_noncongested(struct rpc_xprt *xprt,
+				   struct rpc_task *task)
+{
+	rpc_sleep_on(&xprt->backlog, task, xprt_complete_request_init);
+}
+EXPORT_SYMBOL_GPL(xprt_add_backlog_noncongested);
+
 static bool __xprt_set_rq(struct rpc_task *task, void *data)
 {
 	struct rpc_rqst *req = data;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index ca079439f9cc..61706df5e485 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -511,7 +511,20 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 
 out_sleep:
 	task->tk_status = -EAGAIN;
-	xprt_add_backlog(xprt, task);
+	xprt_add_backlog_noncongested(xprt, task);
+	/* A buffer freed between buffer_get and rpc_sleep_on
+	 * goes back to the pool with no waiter to wake.
+	 * Re-check after joining the backlog to close that gap.
+	 */
+	req = rpcrdma_buffer_get(&r_xprt->rx_buf);
+	if (req) {
+		struct rpc_rqst *rqst = &req->rl_slot;
+
+		if (!xprt_wake_up_backlog(xprt, rqst)) {
+			memset(rqst, 0, sizeof(*rqst));
+			rpcrdma_buffer_put(&r_xprt->rx_buf, req);
+		}
+	}
 }
 
 /**
-- 
2.53.0


