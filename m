Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC35413BDD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 23:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhIUVCe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 17:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234700AbhIUVC2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Sep 2021 17:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABEDB61178;
        Tue, 21 Sep 2021 21:00:58 +0000 (UTC)
Subject: [PATCH v3 2/2] xprtrdma: Remove rpcrdma_ep::re_implicit_roundup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 21 Sep 2021 17:00:58 -0400
Message-ID: <163225805799.9206.2956915964743321103.stgit@morisot.1015granger.net>
In-Reply-To: <163225796153.9206.3736108080135006227.stgit@morisot.1015granger.net>
References: <163225796153.9206.3736108080135006227.stgit@morisot.1015granger.net>
User-Agent: StGit/1.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: this field is no longer used.

xprt_rdma_pad_optimize is also no longer used, but is left in place
because it is part of the kernel/userspace API.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |    2 --
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 2 files changed, 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c3784b7b6855..3d3673ba9e1e 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -205,14 +205,12 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 	unsigned int rsize, wsize;
 
 	/* Default settings for RPC-over-RDMA Version One */
-	ep->re_implicit_roundup = xprt_rdma_pad_optimize;
 	rsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 	wsize = RPCRDMA_V1_DEF_INLINE_SIZE;
 
 	if (pmsg &&
 	    pmsg->cp_magic == rpcrdma_cmp_magic &&
 	    pmsg->cp_version == RPCRDMA_CMP_VERSION) {
-		ep->re_implicit_roundup = true;
 		rsize = rpcrdma_decode_buffer_size(pmsg->cp_send_size);
 		wsize = rpcrdma_decode_buffer_size(pmsg->cp_recv_size);
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index b6d8b3e6356c..c79f92eeda76 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -76,7 +76,6 @@ struct rpcrdma_ep {
 	unsigned int		re_max_rdma_segs;
 	unsigned int		re_max_fr_depth;
 	struct rpcrdma_mr	*re_write_pad_mr;
-	bool			re_implicit_roundup;
 	enum ib_mr_type		re_mrtype;
 	struct completion	re_done;
 	unsigned int		re_send_count;


