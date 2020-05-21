Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD01DCFCF
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEUOeI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgEUOeI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:08 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F8C061A0E;
        Thu, 21 May 2020 07:34:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so6274234iow.7;
        Thu, 21 May 2020 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=HVYT2wvie3C+0WeFPfJ8dkFADwjmF5oiVVWl+xB8/qIFAfuXYd4JB7dDCzTC9NrDd/
         Iv7LLEDXx8yU0NFWRljKWptDUY7hRhiTgF7e7/6DblYnK7HDSZnUfnXBcQCQYrwSYdju
         we9SlgenPuGxTCOzJfjvJ5WZ6EZR6JJpMoz1B84mmPiOg0gFovXHfZLpxRmQ/qpuKGSo
         nW/eN8FPcInA016RdmEG9x9H4yYaEGAIfHm5qkXgrkwf+ge321dHaj2Eg4A8A8jWtCoJ
         1ROvTEoXb3d67yDtCSwv8PemY/r6ZF6uciSZcU0ovZYJahYXnvTwTB2fDb3TXC/uu5Vx
         BMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SK3QJDZhRtOH7x7kVsqSB1LJX7VwQFBUigHKiDxq+fw=;
        b=kvXwT+jXr5PUac7uAMWQBn3YxWlHcVz87+SQbBzOutjUGVDyVhPyOG3iYuUi4kyM0T
         VDF89gZZ2gOllAayjpezSpQ01f21h0aOYfl+hiuC/kuwrnKyshGwSumXwux+NtWEQbxP
         HWU16N9JO1X0QLSdvaBVKQKMZx5fMmsrDbyR6zrx+PMEmUywOGQXrcQEacJF9GL+uyL1
         fId4iaKm0mzxzkQfziYu2DIEXUwrTACfe4sKFQeCsefjhykwqgObnXTo9+5plKF9R203
         08a2NFoIHlvd8wLvU5jO6EEyU52VDEcNHWa0Usha75frjLdIB8JKYk1XkHWzWmN3EieB
         ViFA==
X-Gm-Message-State: AOAM530nYzahamWuNQyF5RqmKQt1t1UR5E1s5hq8FrLsDMVylRsmv/Te
        edOcahbvqvzsYHMreswSUrr0LUUn
X-Google-Smtp-Source: ABdhPJyL9dUOIZ0/wp2PslIVtNWoRZp6x0SBmgPvciqVULhpNN2oeqgW7NTmic+UBQKX2nKU6MOZ5w==
X-Received: by 2002:a6b:7841:: with SMTP id h1mr7924265iop.101.1590071646041;
        Thu, 21 May 2020 07:34:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p3sm2443401iog.31.2020.05.21.07.34.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:05 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEY4Nr000815;
        Thu, 21 May 2020 14:34:04 GMT
Subject: [PATCH v3 04/32] svcrdma: Trace page overruns when constructing
 RDMA Reads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:04 -0400
Message-ID: <20200521143404.3557.9716.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Replace a dprintk call site with a tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |   28 ++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index aca9d0f3d769..d6da6b8d521d 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1637,6 +1637,34 @@ TRACE_EVENT(svcrdma_no_rwctx_err,
 	)
 );
 
+TRACE_EVENT(svcrdma_page_overrun_err,
+	TP_PROTO(
+		const struct svcxprt_rdma *rdma,
+		const struct svc_rqst *rqst,
+		unsigned int pageno
+	),
+
+	TP_ARGS(rdma, rqst, pageno),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, pageno)
+		__field(u32, xid)
+		__string(device, rdma->sc_cm_id->device->name)
+		__string(addr, rdma->sc_xprt.xpt_remotebuf)
+	),
+
+	TP_fast_assign(
+		__entry->pageno = pageno;
+		__entry->xid = __be32_to_cpu(rqst->rq_xid);
+		__assign_str(device, rdma->sc_cm_id->device->name);
+		__assign_str(addr, rdma->sc_xprt.xpt_remotebuf);
+	),
+
+	TP_printk("addr=%s device=%s xid=0x%08x pageno=%u", __get_str(addr),
+		__get_str(device), __entry->xid, __entry->pageno
+	)
+);
+
 TRACE_EVENT(svcrdma_send_pullup,
 	TP_PROTO(
 		unsigned int len
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c2d49f607cfe..17098a11d2ad 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -676,7 +676,7 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return 0;
 
 out_overrun:
-	dprintk("svcrdma: request overruns rq_pages\n");
+	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, info->ri_pageno);
 	return -EINVAL;
 }
 

