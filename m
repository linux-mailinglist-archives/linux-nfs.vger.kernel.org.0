Return-Path: <linux-nfs+bounces-248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68636801505
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 22:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A5B1F21049
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Dec 2023 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2874D59157;
	Fri,  1 Dec 2023 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t16spEbu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379F58ADC
	for <linux-nfs@vger.kernel.org>; Fri,  1 Dec 2023 21:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FBC433CB;
	Fri,  1 Dec 2023 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701465351;
	bh=OY5q+/v9cOSsro/mtxg63h3ZNCHQXLTP7DYLvH2gptw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t16spEbuVRu4XmIQNuuRi6W3KyGDu00AffkzvxLVe9+yf8K5zupzdjaoqZmu75Zba
	 +RWWI64Pzc9uEzAaUtr3fjogDGFiqn1rRnvhfMAqI8sGL6LCstB695sAh4gWobcLY0
	 WmXeoRbbiPYOkYv2fTx3ncKO1ZPjwWNLIJuCkFT+5oPKOcFqgk94TiIvZz0bjTmzkk
	 E7hfWmz7pYCMa3jfqaa+J3Qy/otQjHbFI1EeES/ye5hieUpX9dX3A9ICBda9sTadxv
	 Io3uotXjtWVazlCje8cPY20tr18J5iuLIRwYeRxueN2I0fJ01cf+iPl/2WX6UABm4Q
	 7RrIXDlpS4XmQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 1/4] SUNRPC: Clean up unused variable in rpc_xprt_probe_trunked()
Date: Fri,  1 Dec 2023 16:15:46 -0500
Message-ID: <20231201211549.126941-2-anna@kernel.org>
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

We don't use the rpc_xprt_switch anywhere in this function, so let's not
take an extra reference to in unnecessarily.

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


