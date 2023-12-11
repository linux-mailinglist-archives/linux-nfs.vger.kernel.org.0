Return-Path: <linux-nfs+bounces-485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F35D80CF66
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914421C21287
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252604AF9A;
	Mon, 11 Dec 2023 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOX7TxX8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050593B184;
	Mon, 11 Dec 2023 15:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E3C433C8;
	Mon, 11 Dec 2023 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308262;
	bh=w4I9suP34OK/T9wqgSV5LFh9uj8Gkgnu9+/UaxfsYwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qOX7TxX8tbbI5Gqvq7zJAKcvkyThMAgKUwwtCSD1c5g61NdbVI10gJvbKK0GQJHIp
	 dcchV8c21R5aoYEQ7ZnSPtVg1t/ftdkAX6NU1Nau3TElWuuOjmIUEMdm7zdIPkAggL
	 Ue7JI2L95xLODC4gcFWL5qwzp0W+8M0g91v1IF7M3nLn9pGPvnsTIqnCCfpbM2Hf2k
	 PCnGomzkkyODz2N7Z06PHrO3eilD9rQ+vU/p06jnIU8fxYxCv+o7j9TYK20cLbU8xE
	 I8MYtSkm2Reztc+yIbFb5sI2upjatwNFu2nLHPCc0fKTebMQ2RP09Cbk1Qf1+AtvOp
	 J4PTqXIO6T4vg==
Subject: [PATCH v1 3/8] svcrdma: Remove pointer addresses shown in dprintk()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:21 -0500
Message-ID: 
 <170230826159.90242.7084253882158192266.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

There are a couple of dprintk() call sites in svc_rdma_accept()
that show pointer addresses. These days, displayed pointer addresses
are hashed and thus have little or no diagnostic value, especially
for site administrators.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3826da1c15f3..451814eb12b9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -457,8 +457,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.qp_type = IB_QPT_RC;
 	qp_attr.send_cq = newxprt->sc_sq_cq;
 	qp_attr.recv_cq = newxprt->sc_rq_cq;
-	dprintk("svcrdma: newxprt->sc_cm_id=%p, newxprt->sc_pd=%p\n",
-		newxprt->sc_cm_id, newxprt->sc_pd);
 	dprintk("    cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
 		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
 	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
@@ -512,7 +510,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	}
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-	dprintk("svcrdma: new connection %p accepted:\n", newxprt);
+	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
 	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
 	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
 	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;



