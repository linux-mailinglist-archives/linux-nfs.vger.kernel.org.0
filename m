Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899DB2AC521
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgKITjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:40 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4DC0613CF;
        Mon,  9 Nov 2020 11:39:39 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so6871164qtp.7;
        Mon, 09 Nov 2020 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JxQnsVHTLgZB1dpwkyNcwz47s2yUqojEka1kJLGKHng=;
        b=sUxs7RUmRlTWzLxF75ouRAYoLvm9VJTka3Bh3IkDYQhObo68w10RXshQEIf8ihvliM
         HRMp+DN5Bws4VU/GkiGg+/zdlXDOWOWDG0E7/Nb6IXLWN4m4oPCxrbFUOgLt1IwMLKn8
         1lltCFtcPsIRgtWvGlZF90sRKx+gJE4FA9tvg9v+3NrSCLFzkGVsg1QjQArf6zPUvmPw
         YPt5kyZeanHSpnIyvFlyZCoPjZifZZeqbYPXECi1D/gXB2eidXEO3Hl9nyhbmBV9swuU
         YjPvSbsJk9PPbORIBVuAklAPyJ4xRe1LG1CZ//gV2l292BMV1QVzUvLi7f1G8rXquTRu
         y+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JxQnsVHTLgZB1dpwkyNcwz47s2yUqojEka1kJLGKHng=;
        b=U+63DrGmrKSHOXlhfR0h++sleuHdCjrwHqhOxgC7BzzYXFPnoNtmglOXDEXmZoLT79
         rnPJH6gNFiVqD7FJEzGLUqY4jgqW3Fds+pBBuX+xZwdTrstGAdjJoc8iE2eA6WTV0wKg
         oL/pUZTIU5KVuJbOZBIgnqkKaz59iiC2Vr69zeCFUb+McUruSD9ZrhcchOoPb6lUbbSC
         LfrToYKpketu8HmiDe+RGysLHLWZGFkqdphUh2xqeCQZxCB2iwc+6IkqOeMhCrcKMaAK
         BAMvW+mfYjrxGvrDZDKMA4tBhNzS2sZvKwWz0n58DuhEqnkpE3m2sWbMFtAr9TjRNzcl
         yx4A==
X-Gm-Message-State: AOAM532KgEKICQCbhswT6Mx706o78TNkNSmEjLI2EyYyvOX0swxu8seF
        QGLzZZPTHO/ziaQRElLaP3KuaLoNBjE=
X-Google-Smtp-Source: ABdhPJw0/fmjh5BWh25xuup/o2OBf8BsEQ7YVHZf9hDZls/eXgybkEG1B+r0aRW3xxycezeUkKrjIQ==
X-Received: by 2002:ac8:454d:: with SMTP id z13mr12682058qtn.175.1604950778846;
        Mon, 09 Nov 2020 11:39:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r204sm6968266qka.122.2020.11.09.11.39.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:38 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdbHn021804;
        Mon, 9 Nov 2020 19:39:37 GMT
Subject: [PATCH v1 05/13] xprtrdma: Clean up trace_xprtrdma_post_linv
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:37 -0500
Message-ID: <160495077716.2072548.2427574020160558580.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- Replace the display of kernel memory addresses
- Add "_err" to the end of its name to indicate that it's a
  tracepoint that fires only when there's an error

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   16 +++++++++-------
 net/sunrpc/xprtrdma/frwr_ops.c |    4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9e30f8aa3562..b0750c0d2753 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -784,7 +784,7 @@ TRACE_EVENT(xprtrdma_post_recvs,
 	)
 );
 
-TRACE_EVENT(xprtrdma_post_linv,
+TRACE_EVENT(xprtrdma_post_linv_err,
 	TP_PROTO(
 		const struct rpcrdma_req *req,
 		int status
@@ -793,19 +793,21 @@ TRACE_EVENT(xprtrdma_post_linv,
 	TP_ARGS(req, status),
 
 	TP_STRUCT__entry(
-		__field(const void *, req)
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
 		__field(int, status)
-		__field(u32, xid)
 	),
 
 	TP_fast_assign(
-		__entry->req = req;
+		const struct rpc_task *task = req->rl_slot.rq_task;
+
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
 		__entry->status = status;
-		__entry->xid = be32_to_cpu(req->rl_slot.rq_xid);
 	),
 
-	TP_printk("req=%p xid=0x%08x status=%d",
-		__entry->req, __entry->xid, __entry->status
+	TP_printk("task:%u@%u status=%d",
+		__entry->task_id, __entry->client_id, __entry->status
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 2cc6862a52dc..76322b1acf3d 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -560,7 +560,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
 	 */
-	trace_xprtrdma_post_linv(req, rc);
+	trace_xprtrdma_post_linv_err(req, rc);
 	while (bad_wr) {
 		frwr = container_of(bad_wr, struct rpcrdma_frwr,
 				    fr_invwr);
@@ -660,7 +660,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
 	 */
-	trace_xprtrdma_post_linv(req, rc);
+	trace_xprtrdma_post_linv_err(req, rc);
 	while (bad_wr) {
 		frwr = container_of(bad_wr, struct rpcrdma_frwr, fr_invwr);
 		mr = container_of(frwr, struct rpcrdma_mr, frwr);


