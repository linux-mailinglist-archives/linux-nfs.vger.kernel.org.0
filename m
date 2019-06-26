Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFA57207
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2019 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZTuJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jun 2019 15:50:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZTuI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Jun 2019 15:50:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC3353081252;
        Wed, 26 Jun 2019 19:50:08 +0000 (UTC)
Received: from dwysocha.rdu.csb (dhcp-12-212-173.gsslab.rdu.redhat.com [10.12.212.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69DB15D9D6;
        Wed, 26 Jun 2019 19:50:07 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix possible autodisconnect during connect due to stale last_used
Date:   Wed, 26 Jun 2019 15:50:06 -0400
Message-Id: <1561578606-24602-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 26 Jun 2019 19:50:08 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a connection is successful ensure last_used is updated before calling
xprt_schedule_autodisconnect inside xprt_unlock_connect.  This avoids a
possible xprt_autoclose firing immediately after connect sequence due to
an old value of last_used given to mod_timer in xprt_schedule_autodisconnect.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 net/sunrpc/xprt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index f6c82b1..fceaede 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -800,6 +800,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 		goto out;
 	xprt->snd_task =NULL;
 	xprt->ops->release_xprt(xprt, NULL);
+	xprt->last_used = jiffies;
 	xprt_schedule_autodisconnect(xprt);
 out:
 	spin_unlock_bh(&xprt->transport_lock);
-- 
1.8.3.1

