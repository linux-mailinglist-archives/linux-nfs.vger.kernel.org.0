Return-Path: <linux-nfs+bounces-17-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D37F3409
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848B282744
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86235495DC;
	Tue, 21 Nov 2023 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ks28JN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E048CD2;
	Tue, 21 Nov 2023 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40347C433C9;
	Tue, 21 Nov 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584847;
	bh=sY0QBw/CFVc90IX3+9inmZeJI9yFyDQM40EBsVYTdLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L9ks28JNYLMfIBdKEzRYSWrv6gzfryB1JO9su922nrT2632MdjpUNeBpY50cvfpvg
	 R3vUD/Y7rIhIuYMjHWgFGPjjqUXPSgoSEQK3i4E75R5IBUM2cRCijauaIHoPhAZkWp
	 yHg53P2qv/aUPPB0N9nxE+eN5rzz6bTWh9ALwNv0BT+Nfp0PQpvHNNwpatNZGe7BW8
	 zNhBZIJmy8s+Xv+7BST3Rhpl741p/KJVQQv86YaOc3s/XLKCNN01vX9XXYKy3dyuNw
	 WUuIlEzYs/G+Q4w69mQhFywNP06/8BReHA0bNimDqyhekdBpuv9N+RtEZmLP3qyPaI
	 lpo65Hfvl9tBg==
Subject: [PATCH v2 6/6] svcrdma: Clean up locking
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:46 -0500
Message-ID: 
 <170058484626.4504.11730967527703634448.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
References: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
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

There's no need to protect llist_entry() with a spin lock.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 22c39ba923d2..09f5d0570bc9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -201,10 +201,11 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 
 	spin_lock(&rdma->sc_send_lock);
 	node = llist_del_first(&rdma->sc_send_ctxts);
+	spin_unlock(&rdma->sc_send_lock);
 	if (!node)
 		goto out_empty;
+
 	ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
-	spin_unlock(&rdma->sc_send_lock);
 
 out:
 	rpcrdma_set_xdrlen(&ctxt->sc_hdrbuf, 0);
@@ -217,7 +218,6 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	return ctxt;
 
 out_empty:
-	spin_unlock(&rdma->sc_send_lock);
 	ctxt = svc_rdma_send_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;



