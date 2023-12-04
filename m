Return-Path: <linux-nfs+bounces-308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E086C803F39
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBDCB20ACA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C030F92;
	Mon,  4 Dec 2023 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuIGeQI5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645D34196
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 20:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80386C433CA;
	Mon,  4 Dec 2023 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721514;
	bh=mJmCrf2Zb6Hk+V9yJG0ZUTKvd7Dd7P+Chu6znTBgs6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuIGeQI5rr5iiJYBDqQx1rxTuc+wLk69yBFT3a6fvQQd+Wou7E3hYDHUsvEYw4A2/
	 nh5fg6EGRcnNvjLgpI4AyJDfJoDwSjXk72t4BepYuwI9coajuGYh5BYx1VytfM8GgU
	 eD/UwCXmfnuFT3kBoLnJ4o0rrXXzN219MYHD0+fnStPTwn9WUG2SApSGdQkmPv/b3F
	 kt2835E/6BenH+5uGFHofOWfb9+huiF0/hxeuF6vI94O377bOTU+1vShAePMmaOvst
	 VKqPXxeNS6ZlQ3rvqu0WPmQGJpiwZvPXrb9MEwc7Gbp5d7x1Tx1l0G6H/hM1psH4ST
	 unVg6LNRdouvg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 1/4] SUNRPC: Clean up unused variable in rpc_xprt_probe_trunked()
Date: Mon,  4 Dec 2023 15:25:09 -0500
Message-ID: <20231204202512.108047-2-anna@kernel.org>
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

We don't use the rpc_xprt_switch anywhere in this function, so let's not
take an extra reference to in unnecessarily.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/clnt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index daa9582ec861..4aa838543f79 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3116,7 +3116,6 @@ static int rpc_xprt_probe_trunked(struct rpc_clnt *clnt,
 				  struct rpc_xprt *xprt,
 				  struct rpc_add_xprt_test *data)
 {
-	struct rpc_xprt_switch *xps;
 	struct rpc_xprt *main_xprt;
 	int status = 0;
 
@@ -3124,7 +3123,6 @@ static int rpc_xprt_probe_trunked(struct rpc_clnt *clnt,
 
 	rcu_read_lock();
 	main_xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
-	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
 	status = rpc_cmp_addr_port((struct sockaddr *)&xprt->addr,
 				   (struct sockaddr *)&main_xprt->addr);
 	rcu_read_unlock();
@@ -3135,7 +3133,6 @@ static int rpc_xprt_probe_trunked(struct rpc_clnt *clnt,
 	status = rpc_clnt_add_xprt_helper(clnt, xprt, data);
 out:
 	xprt_put(xprt);
-	xprt_switch_put(xps);
 	return status;
 }
 
-- 
2.43.0


