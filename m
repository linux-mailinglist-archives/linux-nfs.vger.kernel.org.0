Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB2D14E3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfJIRHY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36825 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:24 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so6697769iof.3;
        Wed, 09 Oct 2019 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Lz9tMIsumw5i1GzZW4l3sduzzds0vLRRwfuvTlZdP90=;
        b=Q953NcmU0SegOoVdWGIXN43J0tyeRlM+susb+7kbwlBiuILW/PpBNO95m4xqIBw9+k
         9gJso4vPvt9aK9FIrCMlS7t68bWbjiv/PtJrsNhw0fSWvN0MlRLUS6sBfdYz7+gIaxwg
         6xaL4F9EJgy4Ag+WyBxLCeJNCuy31GJuTjsJwIfE5fg0uH7CNsN8zI6+SKAtJagxxdT1
         egb6dAhMFw/fprrKYMXGb1LuUM2NIZLF0Qi4posL1egWv9bvLKlHf89Vokoo0F3JqI3c
         wuOCrgqEptRrfCdWw57yjvkp26KbiyP//C2h6TPTyW4MyCV5tiugE4OEd1vtW9F2Lzwd
         +KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Lz9tMIsumw5i1GzZW4l3sduzzds0vLRRwfuvTlZdP90=;
        b=MCir1xzBDHZFBqLNXXpqv+Vnn5UAjwTqfEvSplshsb6F4MNcUsN4YD0x+I018BvPM2
         Q/hsWQpxTsl5CuEoLoeGHKdKB2cnn7SlMt2nJ5PZxHBNtO1iBXei00ctHI2kt8H/km2H
         V3NSP20c80rA55zO1Rq0lHR6sXhzPHm1IMC2WjpHRcLXSNesKvhSMQHb0fpELI0Rzk9s
         RIG/HzpElT0SKbMDAykgLlfOzDCcfNsNArI+2UXzuSNKISF8warjz6mQFbnGiRQAqn9M
         2rZtkjOCouiSKZN/2jp/D3nQqmIwxil6oY4zhrNvEU8BeZBvpj/k6eyjXxAZ7McwCLyG
         ad1g==
X-Gm-Message-State: APjAAAWP+iKax86UQXFQ5Ff8e3l0XrsTfmoV+cy5WvNMKgYHMwmrUMS0
        icYoofxwJwCkpiJQkodGo16YvPlN
X-Google-Smtp-Source: APXvYqxOdmfG9QGtulQdviHiihmGJZT+CItHkjiqq/PFDINYoktC5xAl6KMnLc3vr5Q65KdUR9MYbQ==
X-Received: by 2002:a02:6508:: with SMTP id u8mr4367752jab.28.1570640843216;
        Wed, 09 Oct 2019 10:07:23 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x12sm1479581ioh.76.2019.10.09.10.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:22 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7LoH001489;
        Wed, 9 Oct 2019 17:07:21 GMT
Subject: [PATCH v1 1/6] xprtrdma: Add unique trace points for posting Local
 Invalidate WRs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:21 -0400
Message-ID: <20191009170721.2978.128.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When adding frwr_unmap_async way back when, I re-used the existing
trace_xprtrdma_post_send() trace point to record the return code
of ib_post_send.

Unfortunately there are some cases where re-using that trace point
causes a crash. Instead, construct a trace point specific to posting
Local Invalidate WRs that will always be safe to use in that context,
and will act as a trace log eye-catcher for Local Invalidation.

Fixes: 847568942f93 ("xprtrdma: Remove fr_state")
Fixes: d8099feda483 ("xprtrdma: Reduce context switching due ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Bill Baker <bill.baker@oracle.com>
---
 include/trace/events/rpcrdma.h |   25 +++++++++++++++++++++++++
 net/sunrpc/xprtrdma/frwr_ops.c |    4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9dd7680..31681cb 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -735,6 +735,31 @@
 	)
 );
 
+TRACE_EVENT(xprtrdma_post_linv,
+	TP_PROTO(
+		const struct rpcrdma_req *req,
+		int status
+	),
+
+	TP_ARGS(req, status),
+
+	TP_STRUCT__entry(
+		__field(const void *, req)
+		__field(int, status)
+		__field(u32, xid)
+	),
+
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->status = status;
+		__entry->xid = be32_to_cpu(req->rl_slot.rq_xid);
+	),
+
+	TP_printk("req=%p xid=0x%08x status=%d",
+		__entry->req, __entry->xid, __entry->status
+	)
+);
+
 /**
  ** Completion events
  **/
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 30065a2..9901a81 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -570,7 +570,6 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 */
 	bad_wr = NULL;
 	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
-	trace_xprtrdma_post_send(req, rc);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
@@ -583,6 +582,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
 	 */
+	trace_xprtrdma_post_linv(req, rc);
 	while (bad_wr) {
 		frwr = container_of(bad_wr, struct rpcrdma_frwr,
 				    fr_invwr);
@@ -673,12 +673,12 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 */
 	bad_wr = NULL;
 	rc = ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
-	trace_xprtrdma_post_send(req, rc);
 	if (!rc)
 		return;
 
 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
 	 */
+	trace_xprtrdma_post_linv(req, rc);
 	while (bad_wr) {
 		frwr = container_of(bad_wr, struct rpcrdma_frwr, fr_invwr);
 		mr = container_of(frwr, struct rpcrdma_mr, frwr);

