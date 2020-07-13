Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69721DB6E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGMQQ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMQQ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jul 2020 12:16:56 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF4C061755
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2020 09:16:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so14044214ion.13
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2020 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wnl0KuhQwSN1Jzmw0ylojj/H134rUOpRLKmYlnoi8MA=;
        b=YePnjcS/SS8ntgy/McBIv5ZzCLQdTa52TXsPiBASxkaoXpLAsqGfmnQi0+m/TcOtPp
         aU8w5uYNxBlzTK0GPYZDDqRbElMSoLvW93aey+VgY5hxgr8apcMMf3ShUlLsS49iIRVY
         XPrw84owt49XR/ytqzONWJxiDT6EOj++50oZB9vsuhiN2XcW8QB8jiwMdoFYpFMyXmVi
         s2YsxiJKkVMtOgW/4hcRFVab6AV+Pz6WTjVLiiSm+HuWq7O2gXbQS+s/iI/IJDd2+ifJ
         ylZcNQm7FLeBFF2YZ9FX9xWMKg0U9OgTdnHtDM1/Y7T0eU2qhPIib9Yi6T8EiXSl/tRz
         l+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wnl0KuhQwSN1Jzmw0ylojj/H134rUOpRLKmYlnoi8MA=;
        b=TSO4QI3rzF+Sl1KO5dOlxEAoNoiF44T0q0R+QDFwLTL6yrvdO8Llm5lfMgo73IIaLo
         3ugkXg3qrx4XddrT1ig725ndUk0VmsJcxW48DGKbt8FWJuHJTmJhVlhxnHFLOamFQSVe
         5UfWFih3pGS6YsCH9zJXyubwHtBFGfdyNlrC4EtOK9ZOb90l8jutuYY4n0SOB4ebMFSa
         1IwHdrrBD4LuVC5RQDUY6cFKRjAsPnIBgPaLzSlXj/3DiHdCi7APN4+jrOp8oWsNYO0p
         PtNW6mU9aZaNDL3lHKR82jrHl7LkNiZ9Ku98CRzA2W9lFcnqfWsB5qK0+a3hdy3su569
         mfNg==
X-Gm-Message-State: AOAM531sQKYAbM+euCv1uTLXmVoSyJZ6WczAPe2hIzu1B2AgxYrdnWw8
        yRBqtTEKji2UtJpsNDPE1tJsIIre
X-Google-Smtp-Source: ABdhPJyMHDVbbVPTa79fCcEsb7sEZMcrFZ8e/WCBCNl9A7nhIMg4pr3xuYrecxIy9JuReSdWAi9wiA==
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr856650jaj.77.1594657015213;
        Mon, 13 Jul 2020 09:16:55 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id u5sm8805995ili.33.2020.07.13.09.16.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Jul 2020 09:16:53 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] SUNRPC dont update timeout value on connection reset
Date:   Mon, 13 Jul 2020 12:18:42 -0400
Message-Id: <20200713161842.90553-1-olga.kornievskaia@gmail.com>
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

v2: using the suggested approach by Trond Myklebust and not use the 
sliding timeout. 

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
index d5cc5db..92fc9fd 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -607,6 +607,11 @@ static void xprt_reset_majortimeo(struct rpc_rqst *req)
 	req->rq_majortimeo += xprt_calc_majortimeo(req);
 }
 
+static void xprt_reset_minortimeo(struct rpc_rqst *req)
+{
+	req->rq_minortimeo = jiffies + req->rq_timeout;
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

