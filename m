Return-Path: <linux-nfs+bounces-249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3650E801506
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 22:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D37281DFD
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F659B42;
	Fri,  1 Dec 2023 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMBixVUC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59A59B41
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 21:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C281C433CA;
	Fri,  1 Dec 2023 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465352;
	bh=UmS+IHDYkesXD8Si5vJK8UA9GUhxxtROQz3yfbjC5Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMBixVUCe56ZfCA6hxTN/bPD2XUyle0GMVVJSK1Gvpn9dGLaDBD/8WxD8wfeFL0IC
	 ThCko+ntor3WYUmteWzGjsgkXHFlX6zmJDTFR5Rq2YgjXv2Rj+3q2yXQsg5Xmxe7WD
	 eO2kg9WuOSSoNCl/rRQQNQN6nHrrre0AImoaXvlaw7ToFNLtUhUkm0B5vaKRnMoPQF
	 fYIRaVEBz5ged2foCmyqB7z8D5VyD90gh5zkv6DmbtdFq+1EfNx4zfAjks1/aAp3Kx
	 Rqb8tvsk3finhlODr3yWIvslXGMeXtYnpp66uFjWwzeHFEqXbwu2juHztX5bESWWk/
	 oYfaYQwzkK+9w==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 2/4] SUNRPC: Remove unused function rpc_clnt_xprt_switch_put()
Date: Fri,  1 Dec 2023 16:15:47 -0500
Message-ID: <20231201211549.126941-3-anna@kernel.org>
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

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/clnt.h | 1 -
 net/sunrpc/clnt.c           | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index e9d4377d03c6..5e9d1469c6fa 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -252,7 +252,6 @@ void		rpc_clnt_probe_trunked_xprts(struct rpc_clnt *,
 
 const char *rpc_proc_name(const struct rpc_task *task);
 
-void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
 void rpc_clnt_xprt_switch_remove_xprt(struct rpc_clnt *, struct rpc_xprt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 4aa838543f79..8df944444e9b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3247,14 +3247,6 @@ rpc_set_connect_timeout(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_set_connect_timeout);
 
-void rpc_clnt_xprt_switch_put(struct rpc_clnt *clnt)
-{
-	rcu_read_lock();
-	xprt_switch_put(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_put);
-
 void rpc_clnt_xprt_set_online(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
 	struct rpc_xprt_switch *xps;
-- 
2.43.0


