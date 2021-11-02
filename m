Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7567D443602
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 19:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBSvj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 14:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhKBSvi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 14:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635878943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uKI7LqT1/BPNiy+4ZFolEqhCJtFWB6Y54yXh+bAugos=;
        b=f7KoGSwG4uWgBJcPgnr+wJ/q5DyBDqth3TTDbTFNqPD8YCef2GhlfMACS+yzqBVwK600U2
        0RRMceUYcVB9McBaQu1T8HpamK/RT1vIkS561Y6WPvj/y8ECE0WpFkAN3QT4JWZwPcDMcJ
        QXLCaaguLiC8hJkWTOMAdhCyt9isdUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DUMYOB8_M6KSxftLKp5g9Q-1; Tue, 02 Nov 2021 14:49:01 -0400
X-MC-Unique: DUMYOB8_M6KSxftLKp5g9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A539A100C612;
        Tue,  2 Nov 2021 18:49:00 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70D2BE2C4;
        Tue,  2 Nov 2021 18:49:00 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id E542F10C30F0; Tue,  2 Nov 2021 14:48:59 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] xprtrdma: Fix a maybe-uninitialized compiler warning
Date:   Tue,  2 Nov 2021 14:48:59 -0400
Message-Id: <ecf7a06938de33cccc8e435929ba4c373eda3639.1635878734.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This minor fix-up keeps GCC from complaining that "last' may be used
uninitialized", which breaks some build workflows that have been running
with all warnings treated as errors.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index f700b34a5bfd..f88d3139b1a2 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -515,8 +515,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * a single ib_post_send() call.
 	 */
 	prev = &first;
-	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
-
+	mr = rpcrdma_mr_pop(&req->rl_registered);
+	do {
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
@@ -533,7 +533,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		*prev = last;
 		prev = &last->next;
-	}
+	} while ((mr = rpcrdma_mr_pop(&req->rl_registered)));
+
 	mr = container_of(last, struct rpcrdma_mr, mr_invwr);
 
 	/* Strong send queue ordering guarantees that when the
@@ -617,8 +618,8 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * a single ib_post_send() call.
 	 */
 	prev = &first;
-	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
-
+	mr = rpcrdma_mr_pop(&req->rl_registered);
+	do {
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
@@ -635,7 +636,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		*prev = last;
 		prev = &last->next;
-	}
+	} while ((mr = rpcrdma_mr_pop(&req->rl_registered)));
 
 	/* Strong send queue ordering guarantees that when the
 	 * last WR in the chain completes, all WRs in the chain
-- 
2.31.1

