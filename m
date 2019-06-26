Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D25729A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZUab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 16:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZUab (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Jun 2019 16:30:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A648C308794D;
        Wed, 26 Jun 2019 20:30:26 +0000 (UTC)
Received: from dwysocha.rdu.csb (dhcp-12-212-173.gsslab.rdu.redhat.com [10.12.212.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B37260BE5;
        Wed, 26 Jun 2019 20:30:25 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix possible autodisconnect during connect due to old last_used
Date:   Wed, 26 Jun 2019 16:30:24 -0400
Message-Id: <1561581024-28238-1-git-send-email-dwysocha@redhat.com>
In-Reply-To: <566e3eb7b501d48a2989461c316b66c03c56b129.camel@hammerspace.com>
References: <566e3eb7b501d48a2989461c316b66c03c56b129.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Jun 2019 20:30:31 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure last_used is updated before calling mod_timer inside
xprt_schedule_autodisconnect.  This avoids a possible xprt_autoclose
firing immediately after a successful connect when xprt_unlock_connect
calls xprt_schedule_autodisconnect with an old value of last_used.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 net/sunrpc/xprt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index f6c82b1..871b904 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -750,6 +750,7 @@ void xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie)
 xprt_schedule_autodisconnect(struct rpc_xprt *xprt)
 	__must_hold(&xprt->transport_lock)
 {
+	xprt->last_used = jiffies;
 	if (RB_EMPTY_ROOT(&xprt->recv_queue) && xprt_has_timer(xprt))
 		mod_timer(&xprt->timer, xprt->last_used + xprt->idle_timeout);
 }
@@ -1774,7 +1775,6 @@ void xprt_release(struct rpc_task *task)
 	xprt->ops->release_xprt(xprt, task);
 	if (xprt->ops->release_request)
 		xprt->ops->release_request(task);
-	xprt->last_used = jiffies;
 	xprt_schedule_autodisconnect(xprt);
 	spin_unlock_bh(&xprt->transport_lock);
 	if (req->rq_buffer)
-- 
1.8.3.1

