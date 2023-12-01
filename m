Return-Path: <linux-nfs+bounces-250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8C801507
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 22:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E310280F08
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE659B47;
	Fri,  1 Dec 2023 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICoGPh2W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85C59B41
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 21:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD418C433C9;
	Fri,  1 Dec 2023 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465353;
	bh=ZFjQglqDPa+oOcjhea4lYL1NwInOUj+DzYR+JnNotvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICoGPh2WQgNo3mao9evuMukDKQkohQYx47WdQNh2pxHf7WDxQ5zKMgIml71ztCvv9
	 tfsKftowb0+q2ql12giUaFK4mV2rsmjHLK5r5czxJ/0qAvSYWZ9vf0zFcwA8qA3RVc
	 R7OVZiMTsMWLn/uHyqGq7q2OQGm48KBolgKUaxZbt9snHJAfuLIgvT879Cbs1Vohv1
	 2bz/fzF0CQFaEVrhdHvV06ZGfiyuAqSCIsvS6ah6IDkRptxU6TDPgbrLWlA5IouQWB
	 5mgyWRbF9xqVW/Heu8ecquP+ccHJVn+npj/pjnVsxHLhoC9MP/5SO/OnoPqwcE9+Yq
	 mB7vxvAnaApQg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 3/4] SUNRPC: Create a helper function for accessing the rpc_clnt's xprt_switch
Date: Fri,  1 Dec 2023 16:15:48 -0500
Message-ID: <20231201211549.126941-4-anna@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201211549.126941-1-anna@kernel.org>
References: <20231201211549.126941-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This function takes the necessary rcu read lock to dereference the
client's rpc_xprt_switch and bump the reference count so it doesn't
disappear underneath us before returning. This does mean that callers
are responsible for calling xprt_switch_put() on the returned object
when they are done with it.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/clnt.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8df944444e9b..0b2c4b5484f5 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -797,15 +797,24 @@ int rpc_switch_client_transport(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_switch_client_transport);
 
+static struct rpc_xprt_switch *rpc_clnt_xprt_switch_get(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt_switch *xps;
+
+	rcu_read_lock();
+	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
+	rcu_read_unlock();
+
+	return xps;
+}
+
 static
 int _rpc_clnt_xprt_iter_init(struct rpc_clnt *clnt, struct rpc_xprt_iter *xpi,
 			     void func(struct rpc_xprt_iter *xpi, struct rpc_xprt_switch *xps))
 {
 	struct rpc_xprt_switch *xps;
 
-	rcu_read_lock();
-	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
-	rcu_read_unlock();
+	xps = rpc_clnt_xprt_switch_get(clnt);
 	if (xps == NULL)
 		return -EAGAIN;
 	func(xpi, xps);
@@ -2206,9 +2215,7 @@ call_connect_status(struct rpc_task *task)
 			struct rpc_xprt *saved = task->tk_xprt;
 			struct rpc_xprt_switch *xps;
 
-			rcu_read_lock();
-			xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
-			rcu_read_unlock();
+			xps = rpc_clnt_xprt_switch_get(clnt);
 			if (xps->xps_nxprts > 1) {
 				long value;
 
@@ -3251,22 +3258,23 @@ void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
 	struct rpc_xprt_switch *xps;
 
-	rcu_read_lock();
-	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
-	rcu_read_unlock();
+	xps = rpc_clnt_xprt_switch_get(clnt);
 	xprt_set_online_locked(xprt, xps);
+	xprt_switch_put(xps);
 }
 
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
+	struct rpc_xprt_switch *xps;
+
 	if (rpc_clnt_xprt_switch_has_addr(clnt,
 		(const struct sockaddr *)&xprt->addr)) {
 		return rpc_clnt_xprt_set_online(clnt, xprt);
 	}
-	rcu_read_lock();
-	rpc_xprt_switch_add_xprt(rcu_dereference(clnt->cl_xpi.xpi_xpswitch),
-				 xprt);
-	rcu_read_unlock();
+
+	xps = rpc_clnt_xprt_switch_get(clnt);
+	rpc_xprt_switch_add_xprt(xps, xprt);
+	xprt_switch_put(xps);
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_add_xprt);
 
-- 
2.43.0


