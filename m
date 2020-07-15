Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6D22136C
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgGORQC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgGORQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 13:16:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B9C061755
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 10:16:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d18so3074976ion.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2020 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8E8Irs4EfExQlnoW2eepok7SNZHnLdzi0517m2JCpYI=;
        b=Nt31fKbsDMEgRCT8jL5ijguxZZETQEeTIp3tbEIJswxrk/2zzmGn+BcHuu38Scxpdh
         /qwab56zMCaNdTQsF7HbhWCYie/AimsKH+c+mIQhrwZy4QNXFAMQs8BVgwzd7ak7uSSk
         YNkiXJ9wFjRe2b9U7+BnIe+AxzorYPl4dgWgmqrjKOw5mMFw2NlWrzl7IhkVZtn/ZQVt
         bw30JmRbp11mSRrldFrTdD7ndOWIuFNq7cskDKM0PVyH5wXchihjMijoeZeUzr+7R/tU
         7PgkLAdwwW06tk4UaoavUSCHLAdropwU0WuPa8C9/kW99dN3V9G6EXa9BJ/lVLYEWI6l
         mfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8E8Irs4EfExQlnoW2eepok7SNZHnLdzi0517m2JCpYI=;
        b=QQAeNVDhx6VmUJRg6OeJnGpgpfNcflqTANPWGUYcqXaJJvVD5GKCbqJywODiG6CuW3
         xWGCL8smC6hs4Gtyw7na2CTxC9ikbGcIYiHxoK+eY+0DfrnfU2SpFQ2kVVlKNqZ+p9bp
         Rv390KluiWk9volhVKnQMUSF4jL71G5D//j+VR0CcD7D9XbFATLg4iOvPoRkHg99j2k0
         FCW5n7xls2kFJN3JwPM5VGlSb8EmxM0tqk681VxeUDttPNf4eWbihhF/Zv4ivwgkgfr1
         rj0i8ENOO7l7c1qiv86XPmSsBHClsOyJJCUZy3gY6AedgLL+KJR/j3zZqXhrw7qcP2Rf
         lIHg==
X-Gm-Message-State: AOAM532s5WmAZsD0txwwTb0vBsGMyWYGyC2IKjvlPzx5EJ672GymDw7Z
        ng8cqNES7Z+h3pZwMHTiXm0=
X-Google-Smtp-Source: ABdhPJx19sCRVf3ElAOf1+LRv4Nhq7myO8ZXXyK2EZZ0n3WJDg0YZ762Fm7gh8Mzi9gxEnZENslp6A==
X-Received: by 2002:a05:6602:1610:: with SMTP id x16mr327933iow.68.1594833360641;
        Wed, 15 Jul 2020 10:16:00 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p11sm1376912ilb.55.2020.07.15.10.15.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Jul 2020 10:15:59 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] SUNRPC dont update timeout value on connection reset
Date:   Wed, 15 Jul 2020 13:17:52 -0400
Message-Id: <20200715171752.94224-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Current behaviour: every time a v3 operation is re-sent to the server
we update (double) the timeout. There is no distinction between whether
or not the previous timer had expired before the re-sent happened.

Here's the scenario:
1. Client sends a v3 operation
2. Server RST-s the connection (prior to the timeout) (eg., connection
is immediately reset)
3. Client re-sends a v3 operation but the timeout is now 120sec.

As a result, an application sees 2mins pause before a retry in case
server again does not reply.

Instead, this patch proposes to keep track off when the minor timeout
should happen and if it didn't, then don't update the new timeout.
Value is updated based on the previous value to make timeouts
predictable.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h | 1 +
 net/sunrpc/xprt.c           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index e64bd82..a603d48 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -101,6 +101,7 @@ struct rpc_rqst {
 							 * used in the softirq.
 							 */
 	unsigned long		rq_majortimeo;	/* major timeout alarm */
+	unsigned long		rq_minortimeo;	/* minor timeout alarm */
 	unsigned long		rq_timeout;	/* Current timeout value */
 	ktime_t			rq_rtt;		/* round-trip time */
 	unsigned int		rq_retries;	/* # of retries */
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d5cc5db..6ba9d58 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -607,6 +607,11 @@ static void xprt_reset_majortimeo(struct rpc_rqst *req)
 	req->rq_majortimeo += xprt_calc_majortimeo(req);
 }
 
+static void xprt_reset_minortimeo(struct rpc_rqst *req)
+{
+	req->rq_minortimeo += req->rq_timeout;
+}
+
 static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
 {
 	unsigned long time_init;
@@ -618,6 +623,7 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
 		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
 	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
 	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
+	req->rq_minortimeo = time_init + req->rq_timeout;
 }
 
 /**
@@ -631,6 +637,8 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
 	int status = 0;
 
+	if (time_before(jiffies, req->rq_minortimeo))
+		return status;
 	if (time_before(jiffies, req->rq_majortimeo)) {
 		if (to->to_exponential)
 			req->rq_timeout <<= 1;
@@ -649,6 +657,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 		spin_unlock(&xprt->transport_lock);
 		status = -ETIMEDOUT;
 	}
+	xprt_reset_minortimeo(req);
 
 	if (req->rq_timeout == 0) {
 		printk(KERN_WARNING "xprt_adjust_timeout: rq_timeout = 0!\n");
-- 
1.8.3.1

