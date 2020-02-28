Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551B1172D4B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgB1AbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1AbJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id l7so737173pff.6;
        Thu, 27 Feb 2020 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PbIbcAfdrfdUvi7CUhRos30gioh103M9RwWAyygvMH8=;
        b=h1ttOOa5bdr2iNv+pVGTcztbLpy5V604ycxSPtlxq7OUW+ijN6FjbZTvMWvZb/vRM8
         9r1tq/HqhRMYm8F4iEiKPxv9LltaQxawtIMkcMrW4KjH9ndfrFrk2Dtj/N+UVzWuK0rQ
         0LsKyNCriz2QA7Jestgp7Cu5h28o8GGR8CxdQTDQcxDf6X5RDnOej3l7Mk9Ax+9QeCgw
         Et+5FfVqqFQ0wb8XtDZJhW9IcSP7kM3mv4DP42M1wwT3/OmSKJumv45+S2VkLJSLtgbX
         Et6TQvYvI8lNnHng107TZ7BlTByq9ioAWeofQyurJThg2OSodL2T9NUnBRy/v/dEer77
         DsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PbIbcAfdrfdUvi7CUhRos30gioh103M9RwWAyygvMH8=;
        b=YEnHTGX7O2HLhH9hMQVHsveZc94yE6IDSgBJ0ckuWPsEAvIWiKt3k3t0wMt8A+PvXm
         QFjxF6NVQPYo7GSr5iuyp64quY2Yrc4fw/fi/DUuxtqFyn4mzW22PBK+qLVOypIbn3dn
         1uZhVikpZW8YiGpTpGYrdpeDkEGdJmq0qBDd6OFHcuhpzHrzhQnxKdU6QH/8DVKsPCef
         njr9jkHmdZiBEUl4mWFTcpVNhCuNReeUF7x8kpWuL4LCNA9tikrVNqzAByScXcK73ZPs
         lk5KRtTm54IvZMFkIxVwQbvBnJ7IqQOq/732qwRyqGwCIztsJKft+Q2FSIlx6BGtv5LC
         EQEA==
X-Gm-Message-State: APjAAAVvTnU6nL5kqxFyCkviVNhXtwYojbZ/FfcI/tJf9W2uSHTCHkX+
        nK2cHwrsB6NPs7VeRs25v9Q=
X-Google-Smtp-Source: APXvYqzm1HX9Skt6sL8kFZXoAmGRg+okWcpTtb5IzHyUQdv1t7uSUhJzjR9E1TPfv5y7a4uRuh8iZw==
X-Received: by 2002:aa7:947b:: with SMTP id t27mr1750816pfq.212.1582849868538;
        Thu, 27 Feb 2020 16:31:08 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id 188sm4018091pfa.62.2020.02.27.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:08 -0800 (PST)
Subject: [PATCH v1 06/16] svcrdma: Remove svcrdma_cm_event() trace point
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:06 -0500
Message-ID: <158284986689.38468.4218009285915028152.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. This trace point is no longer needed because the RDMA/core
CMA code has an equivalent trace point that was added by commit
ed999f820a6c ("RDMA/cma: Add trace points in RDMA Connection
Manager").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h           |   28 ----------------------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -------
 2 files changed, 35 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..545fe936a0cc 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1813,34 +1813,6 @@ TRACE_EVENT(svcrdma_post_rw,
 DEFINE_SENDCOMP_EVENT(read);
 DEFINE_SENDCOMP_EVENT(write);
 
-TRACE_EVENT(svcrdma_cm_event,
-	TP_PROTO(
-		const struct rdma_cm_event *event,
-		const struct sockaddr *sap
-	),
-
-	TP_ARGS(event, sap),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, event)
-		__field(int, status)
-		__array(__u8, addr, INET6_ADDRSTRLEN + 10)
-	),
-
-	TP_fast_assign(
-		__entry->event = event->event;
-		__entry->status = event->status;
-		snprintf(__entry->addr, sizeof(__entry->addr) - 1,
-			 "%pISpc", sap);
-	),
-
-	TP_printk("addr=%s event=%s (%u/%d)",
-		__entry->addr,
-		rdma_show_cm_event(__entry->event),
-		__entry->event, __entry->status
-	)
-);
-
 TRACE_EVENT(svcrdma_qp_error,
 	TP_PROTO(
 		const struct ib_event *event,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f6aad2798063..8bb99980ae85 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -241,10 +241,6 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 static int rdma_listen_handler(struct rdma_cm_id *cma_id,
 			       struct rdma_cm_event *event)
 {
-	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
-
-	trace_svcrdma_cm_event(event, sap);
-
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
 		dprintk("svcrdma: Connect request on cma_id=%p, xprt = %p, "
@@ -266,12 +262,9 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
 static int rdma_cma_handler(struct rdma_cm_id *cma_id,
 			    struct rdma_cm_event *event)
 {
-	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.dst_addr;
 	struct svcxprt_rdma *rdma = cma_id->context;
 	struct svc_xprt *xprt = &rdma->sc_xprt;
 
-	trace_svcrdma_cm_event(event, sap);
-
 	switch (event->event) {
 	case RDMA_CM_EVENT_ESTABLISHED:
 		/* Accept complete */

