Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960E3708D2
	for <lists+linux-nfs@lfdr.de>; Sat,  1 May 2021 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEATkI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 May 2021 15:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhEATkF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 1 May 2021 15:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64F72613CD;
        Sat,  1 May 2021 19:38:03 +0000 (UTC)
Subject: [PATCH] xprtrdma: Fix a NULL dereference in frwr_unmap_sync()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Sat, 01 May 2021 15:38:02 -0400
Message-ID: <161989777022.1772.5943251585208443632.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The normal mechanism that invalidates and unmaps MRs is
frwr_unmap_async(). frwr_unmap_sync() is used only when an RPC
Reply bearing Write or Reply chunks has been lost (ie, almost
never).

Coverity found that after commit 9a301cafc861 ("xprtrdma: Move
fr_linv_done field to struct rpcrdma_mr"), the while() loop in
frwr_unmap_sync() exits only once @mr is NULL, unconditionally
causing dereferences of @mr to Oops.

I've tested this fix by creating a client that skips invoking
frwr_unmap_async() when RPC Replies complete. That forces all
invalidation tasks to fall upon frwr_unmap_sync(). Simple workloads
with this fix applied to the adulterated client work as designed.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1504556 ("Null pointer dereferences")
Fixes: 9a301cafc861 ("xprtrdma: Move fr_linv_done field to struct rpcrdma_mr")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    1 +
 1 file changed, 1 insertion(+)

Trond Note: you may need to update the commit ID for 9a301cafc861
as needed to properly reference the final commit ID for ("xprtrdma:
Move fr_linv_done field to struct rpcrdma_mr").

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 285d73246fc2..229fcc9a9064 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -530,6 +530,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		*prev = last;
 		prev = &last->next;
 	}
+	mr = container_of(last, struct rpcrdma_mr, mr_invwr);
 
 	/* Strong send queue ordering guarantees that when the
 	 * last WR in the chain completes, all WRs in the chain


