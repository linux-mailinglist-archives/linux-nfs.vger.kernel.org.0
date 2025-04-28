Return-Path: <linux-nfs+bounces-11324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50777A9F9B6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED211A85EA6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635B2973D2;
	Mon, 28 Apr 2025 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/cAORBB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53E2973BA;
	Mon, 28 Apr 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869036; cv=none; b=FESOO15//d7n7gqhm4nb4iCu3a+RvmIdKG88ylwMUUi2jo7S9sWhD/+gURHbmQjqz1aLPfPP/rNppcsXdpw+Ec/JsfCWm7Z2tJi7UZ98Gh3ftgJxrai3PJyoS9iXi7Dy0IM+P2ZDHdDev4WuywJ+bbem/pz4/RlwYnfas7cvoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869036; c=relaxed/simple;
	bh=T4zwhb8s1Gh6sSl1ewC9XNq+lNCNMEa/AoUsRYEhkL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWpYMu34neiWk6HfmNJKc+SCw4xpr8Od5Ru7Fv3lrn3Ir17Ay/7IHuzWmgndO0lV3g97fC8XBtQCrtUQ+qLUGDaDCAN75NLfqtGTM47nGC5K1Js4QXRsedzuTOQ/Y/rbKHwMszsNitD6ZMzlIaDM8BMhHrLaeD6Rch+QXbugdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/cAORBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64155C4CEED;
	Mon, 28 Apr 2025 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869034;
	bh=T4zwhb8s1Gh6sSl1ewC9XNq+lNCNMEa/AoUsRYEhkL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/cAORBBxwLKdrqSYKHwn42IaF8WoJ3StLDIXRj0dUoqU02uelr66iBwy/kwnXhyq
	 ATy3ZrvFClzpQV4FSjDsGloUb9HZvKsvp+qgnficSqZaQN2yxe8Of5TWJlPWKyNCQO
	 u1oHpZLBMZUSQQ6vnJnVWKeUcVK4fhz/qv5hd/d62pIuczDE1IRaDy1jdQoS430foc
	 JMtzT4rQ0vn9RApm0abhrW960fyLVQl+4vnkxaBkP528Im71MkCjUJ5TTKeczOpEaU
	 XFtkJOdo2Q03n1V6JCB8lsOD/3cr5SxCd1NaVuGgkQSj2q3lZBteDKnVB2XH/tdLWz
	 Lmqhk1AocKuMg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 08/14] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Mon, 28 Apr 2025 15:36:56 -0400
Message-ID: <20250428193702.5186-9-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Allow allocation of more entries in the rc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 619fc0bd837a..1016f2feddc4 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -202,7 +202,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	unsigned long		rc_maxpages;
+	struct page		*rc_pages[] __counted_by(rc_maxpages);
 };
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 292022f0976e..e7e4a39ca6c6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -120,12 +120,16 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kzalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
+	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
+			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail1;
@@ -497,7 +501,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.49.0


