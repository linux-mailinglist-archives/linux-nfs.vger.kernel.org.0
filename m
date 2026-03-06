Return-Path: <linux-nfs+bounces-19850-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJIzAZxNq2lZcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19850-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:56:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D18228211
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C79F301730F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BBE3EDADC;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHmBoGpH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F14349B02;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834194; cv=none; b=J3ujhNc5Cb7H6T7alqW8UmHj32obWr131bVm/BmppXSEhjDr6sURVjozyrXuZl7p7RkFaH2zOUJRQCpEOgtLKW3k7Vbb3mBNVyW69TZgrfvwJmRtQ+go6lv3abShV2yloFefjE2KYNHVhp6ouEo1pCgfUsmUFH6jQa20Lgabrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834194; c=relaxed/simple;
	bh=TyOiju2Wf7J6YXRzAafEYDEFmmJy56IWDlPHutamhog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJPE/8uoQ0wKTHOVzIeOegtlIbP/LMBK/oKrVgZx0MqFccECuzCKhxpw3O3UI/Bay3js3vYsdpIWh8AFay7WLFsc5aluG1ieIOtvP28mv06Qjmj99FeuNcK/zWCQrk+Vu+iQ/JaRMWrALyBdFgvHVSjxZYHWKBF4n7uTeqvFHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHmBoGpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A1BC2BC86;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834194;
	bh=TyOiju2Wf7J6YXRzAafEYDEFmmJy56IWDlPHutamhog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHmBoGpH2M2d7k0efA4Kuz7B6h7NStlWy8uOxIf5Os9crHm/0OzwaTl81O/6a8foC
	 BOiOKtP8pO18VowAP2aYcjXmn3R5M7L9nbJ2QN18KGKbyINjN0vvDcROfGPBLPqOK1
	 EBj63GoG5cVIdn9iqqH5bj+u/kfXH60WgY5jAQFXsWzdkPxc337wcqCqYi5dCC22G/
	 kpDV6Q4OqF7qFfGdhef4UzBs99NIXAQWcGQg8FuQx+WNsHm5qWkdhrklC5AVElgk2c
	 992OrAeNxDgInm3eV3u3LE3cEMwEFHrkXEe+pQQl9Yg4eu/JnhYOP3TsqNoRwx278e
	 P7XqRMcaToo5Q==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 3/7] xprtrdma: Close lost-wakeup race in xprt_rdma_alloc_slot
Date: Fri,  6 Mar 2026 16:56:24 -0500
Message-ID: <20260306215620.3668-12-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3733; i=chuck.lever@oracle.com; h=from:subject; bh=3v1qbCp1Drc/F/QuuTenhJQlhYXMoTVhIUgDkFZxhbw=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02N5Y1/78DzqNVzi56DHudgZXfJPYZmtRISI 9jL+BtH5aWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjQAKCRAzarMzb2Z/ l+ZTD/0SlktINlJYLB24A4I6faBxJ7budJucUUMadfkzhcTSIKUylsxhJLU7FhnXsa/g1b+iUcR HvNwSlOT4tf+FjFBbHKzbXqGBT2kvo4jU8TfpWyM4+9lYxDtaw8buyEC27hVXfaGA7xF/jc1jnX aRZG9E1S1atDasIPLycWMKaWZ23MW/QWG/9oJayB2ORjmtywqbwoZqo0XBKPkr9AmjKrUS9ae+g HLuChNdVH1lJbxEbyFmrD6AoSebSyLVfTr4l1+9NyFTzlKJPk0Qlldlc6dINLzhg3uoCCNosfFO V1wntcBNqxY7uhrBEzoHzju5qfCvVnZ580Q+JvcSG8fJ3PGESABMGsDA2l/upCKAX7+JDbS2rg9 ebWGiEIOQUh85dae4BjMujEmqhAkNXqOypF84B9DY1ks+LzD+TEg984fXejixtJ7r0HWgDMMBOJ iOVmfwp+2I0euimpSrYnwEjCp/f76tmjm5D8ZXBe55I1OYfLNKsq6a0numafQUTElzHkeVWeaHf Tgr3Rvj43TMjesmybHUHms2qr3zieum6kqmo/lBBl9w23Q2dY7a18yN6Y5tic5MXOpeC1pXG1fU t8YuVR4pK4IslKtunqb8J9G+Cdsiw9AQoh1ZX5PxEG41tx4kHgStru/huOABPdsxeURuz8PJVaz Vra+4hvWTPkaJQQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07D18228211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19850-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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


