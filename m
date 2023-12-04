Return-Path: <linux-nfs+bounces-309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371AD803F38
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF0A28127A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2334CF0;
	Mon,  4 Dec 2023 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHZPYj/B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40934196
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 20:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C240C433C9;
	Mon,  4 Dec 2023 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721515;
	bh=irUZhZ42IrQH8Et+sietGUtb3Ty5NSU38pZwwlDTXuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHZPYj/ByJ5DOaUTe8Zm5JIf5KhcycizIxYF44/iGOuyKy0HSlzqumhLnrupwithq
	 0j5uCkt+5vvZVOqYSIlXI6lmmdPLH3JZPxh5Xzeu4pEHON2uz0ttSXPgUuMv9R8e1E
	 vm4dCxX/UjpvngapL9MMRK9V+oHCw2jZ4+XIykBoEtGTw5PG+r094Gk/JtvALpGuxQ
	 gYhVJSE8rOAJwJY/aaO2/Lqw35olyefqVEwiPwqXKoZ6H3roTlUIaipZoGwWkO1qZv
	 +apaGq4zgOYQDZNZhVpXBnCh32E0DfSeD8MbXOkZ+zjWI/kObQkMON/8uBCiWUl4ey
	 c0M7q1eg2Ap5g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 2/4] SUNRPC: Remove unused function rpc_clnt_xprt_switch_put()
Date: Mon,  4 Dec 2023 15:25:10 -0500
Message-ID: <20231204202512.108047-3-anna@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204202512.108047-1-anna@kernel.org>
References: <20231204202512.108047-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


