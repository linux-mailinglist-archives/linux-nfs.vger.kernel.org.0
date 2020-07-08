Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6592191EB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgGHVDa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVDa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 17:03:30 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334AC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 14:03:30 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so82529iox.2
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0hyCbSYUzDYRgPqmNjXDnCwOvXX2hj4wIzjqjnahHEw=;
        b=jhiSEIkkamkbzIYEmWPe2amuKNghFeXLFGTqldWGgeN8fqtArSgxV1X1Z+6lFcGm7h
         cyDxA89GpnRQzYwtMUFpvPqG6Wszez49XguDJmNlYsVnvmjn98AnuACe33XL9w8Uzc3A
         yNvKJOFRzb8bWdjElp+t8HWABgshHMEM5hnk5Cy5TcYrb21NMB5yPnXN2PapUPxI3/ou
         P/Jh+BVKSSMcrUW5+9paxf/5ne6vgHfi5s26z0oYsBuC3FPTj48rX0zA4it3feA6x5WI
         cPffQ9cD6OSSG9E9yTBJfHB09jV1CfIX0jASCJDvJHEQ3N68Q65DgYFro4IR/QFvxZ1r
         i1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0hyCbSYUzDYRgPqmNjXDnCwOvXX2hj4wIzjqjnahHEw=;
        b=LzQrDkAnq8nXM22tGf4Dtl5G50Mhkdmh9OGLg23HCJR0cCOkuN3ApMKW8eVG0ibrLv
         D+uVBww/JZlkXlne/MKkkLPqB9kBURLrVcMRrWE3kEx8e4IyCA0+89txAejvaTOXZVVw
         xbkTqvL3A65Ys54jr/suCUf/WfKW4uhd75wuntvcggYEF9KBO9NVBEtotGuS4U8EOHTx
         ncLa3pN2CQLId2c/7N17S8QBrGzPT9z95SiOaZg6uo4PU6SRU1l7N4sicsalOP8ZGyzA
         wNWXYaZHqLYMr0sfq5OiJB6p3548mD5G93oFdtVXYGz+RLp8hG/QeBCJc45pbRvfwuRf
         2g2A==
X-Gm-Message-State: AOAM533dMGsXAck/ge4fyjndzsmBiIGHARU+0ovIQ+LjGGds26r9pWLR
        Bqh8NoqW1/TKuy+U5a0mZLvN4m4E
X-Google-Smtp-Source: ABdhPJwt8d2tsRpd2b1Rb6aTDR9v62J1x9sFyLmUjzDdZT22tQFDWl2RsDzdNMFSfWE5km9MqePfYQ==
X-Received: by 2002:a02:840e:: with SMTP id k14mr5072730jah.133.1594242209338;
        Wed, 08 Jul 2020 14:03:29 -0700 (PDT)
Received: from Olgas-MBP-286.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id t14sm655375ilk.17.2020.07.08.14.03.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 08 Jul 2020 14:03:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Date:   Wed,  8 Jul 2020 17:05:14 -0400
Message-Id: <20200708210514.84671-1-olga.kornievskaia@gmail.com>
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

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/xprt.c           | 11 +++++++++++
 2 files changed, 12 insertions(+)

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
index d5cc5db..c0ce232 100644
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
@@ -631,6 +637,10 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
 	int status = 0;
 
+	if (time_before(jiffies, req->rq_minortimeo)) {
+		xprt_reset_minortimeo(req);
+		return status;
+	}
 	if (time_before(jiffies, req->rq_majortimeo)) {
 		if (to->to_exponential)
 			req->rq_timeout <<= 1;
@@ -638,6 +648,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 			req->rq_timeout += to->to_increment;
 		if (to->to_maxval && req->rq_timeout >= to->to_maxval)
 			req->rq_timeout = to->to_maxval;
+		xprt_reset_minortimeo(req);
 		req->rq_retries++;
 	} else {
 		req->rq_timeout = to->to_initval;
-- 
1.8.3.1

