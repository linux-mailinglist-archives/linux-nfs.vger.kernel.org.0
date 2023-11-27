Return-Path: <linux-nfs+bounces-94-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B97FA67D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A10B1C20B83
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71ED34CEA;
	Mon, 27 Nov 2023 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRnllNng"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620837156;
	Mon, 27 Nov 2023 16:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F7C433C7;
	Mon, 27 Nov 2023 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102805;
	bh=auOVN/6eo+7yifu9BNxyrMOcRTbDXMD0quxKm4nvEfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NRnllNngkBcVu9eqadZ4EstGo2aNMmPSqOuti2jCUaO9STxNgHvDxjr4M5Z2Vr+Xu
	 tu7OMu0+RyUZroisVd2eBJB8wbLIv6+sjRm1rusaRCHpWRNP7BO3E1UE2nnNykb3ZD
	 C/TnnbUF6BNh2hlvOR2TfctNUkUyVBreX5v4kdsFGq5sqro5fivf9Mhj4Y3clul9nf
	 3gyzv6+aNg1IQ5s1TIpLVrXY72T0a4MmhnL6d4qbh6yk0JwsvJsGcfk2cod5KPjAYv
	 xkfZSP2dJXTywVZbmb/waHeb+vf5Uvw0KAgqnnLP5DwFRgSZttlTOlc6mNHjxZcdae
	 X8z4Cx8eCPI9A==
Subject: [PATCH v1 1/5] svcrdma: Add lockdep class keys for transport locks
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Mon, 27 Nov 2023 11:33:24 -0500
Message-ID: 
 <170110280401.49524.10461585339296704465.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170110267835.49524.14512830016966273991.stgit@bazille.1015granger.net>
References: 
 <170110267835.49524.14512830016966273991.stgit@bazille.1015granger.net>
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

Two svcrdma-related transport locks can become quite contended.
Collate their use and make them easy to find in /proc/lock_stat for
better observability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c046916df007..3826da1c15f3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -125,6 +125,9 @@ static void qp_event_handler(struct ib_event *event, void *context)
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net, int node)
 {
+	static struct lock_class_key svcrdma_rwctx_lock;
+	static struct lock_class_key svcrdma_sctx_lock;
+	static struct lock_class_key svcrdma_dto_lock;
 	struct svcxprt_rdma *cma_xprt;
 
 	cma_xprt = kzalloc_node(sizeof(*cma_xprt), GFP_KERNEL, node);
@@ -141,8 +144,11 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 
 	spin_lock_init(&cma_xprt->sc_lock);
 	spin_lock_init(&cma_xprt->sc_rq_dto_lock);
+	lockdep_set_class(&cma_xprt->sc_rq_dto_lock, &svcrdma_dto_lock);
 	spin_lock_init(&cma_xprt->sc_send_lock);
+	lockdep_set_class(&cma_xprt->sc_send_lock, &svcrdma_sctx_lock);
 	spin_lock_init(&cma_xprt->sc_rw_ctxt_lock);
+	lockdep_set_class(&cma_xprt->sc_rw_ctxt_lock, &svcrdma_rwctx_lock);
 
 	/*
 	 * Note that this implies that the underlying transport support



