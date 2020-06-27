Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80E720C31B
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgF0QfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Jun 2020 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QfW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Jun 2020 12:35:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3EEC061794;
        Sat, 27 Jun 2020 09:35:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so11651597qkn.11;
        Sat, 27 Jun 2020 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vxYvbaNdmWPDmCOW0aLfaDFq5b3bewpbHDAgyiKlBzg=;
        b=mSRcYDsgUwpiljSYk1KFxXZEPwwgRvmH1SwnRI66mimp0+9j1A6LVk/GqwZem1hZ/u
         5QBL3KnNP/B5T9jbYiXrFX0PaaynrONSnK+lM4NWPZQdFEnYwJ2nQLAbD/qbACdF1IzW
         wkS0HL6yi5k5twQEEIVNooqo/F3i3khmuvTz1KveaqTCCzgKvkuPsXhp/Cijxrml+Wws
         F6svvjj1maDSbB/e4GUYvwTIILK7WZ+Tq5eAdDZFUHl8yOVUGqZlYYO67WqCdlGzB/2W
         //A6T5d0USJpFRy7CtueF2mDfPxqPj21vIdUrGu004TNPsoiEBpR1nMnq8mOUyuhtXEX
         pABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vxYvbaNdmWPDmCOW0aLfaDFq5b3bewpbHDAgyiKlBzg=;
        b=H8LazghC2zdoUhE7/dh8M2tmqBX2OW/3kKf/KnDo7qfogXjiJE9T49sfQtKaWEq+1U
         W4vd09eyZo4LLmXXBkqA//si9YH9GAcxriN/iBUTrbMNxLCqmxdzDWEoIPwzlPR2zehV
         3Ua+NyOJKot0AP3B2SctAewLGbEr5mcpyCIhilcb7yFIVjwJaX7Z3mkpIN87j2G28MWx
         2/1EXCL4GSk8zWWym0dW2ySvEHhdd616YHZeIn3yUxXcjy2INTqHkri6TUx3odwpVULY
         6DSzOXWjsRjjyFziAzfh+x2fIM588srF/CBQJvzQIrSzVQCQ5fOKvXyYblz9cKua9rHj
         LRxQ==
X-Gm-Message-State: AOAM531ch1s4wwD58xOVf42M2UUyw1KdO4WvshUvqy+/mMNstmrjBZ3d
        iPGx0noe2UZyFe/pRYTxQadtJOaZ
X-Google-Smtp-Source: ABdhPJzZpKD40ROEsrFi6O3S/5KO0T02JNye6USsQSTGCnJBIUGa41uioaKRDzhPp4j65B5miZPA6g==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr8019775qkc.259.1593275721922;
        Sat, 27 Jun 2020 09:35:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f3sm12760119qta.44.2020.06.27.09.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:35:21 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05RGZKx1003767;
        Sat, 27 Jun 2020 16:35:20 GMT
Subject: [PATCH v1 4/4] xprtrdma: Fix handling of connect errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     dan@kernelim.com
Date:   Sat, 27 Jun 2020 12:35:20 -0400
Message-ID: <20200627163520.22826.73749.stgit@manet.1015granger.net>
In-Reply-To: <20200627162911.22826.34426.stgit@manet.1015granger.net>
References: <20200627162911.22826.34426.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that the connect worker is awoken if an attempt to establish
a connection is unsuccessful. Otherwise the worker waits forever
and the transport workload hangs.

Connect errors should not attempt to destroy the ep, since the
connect worker continues to use it after the handler runs, so these
errors are now handled independently of DISCONNECTED events.

Reported-by: Dan Aloni <dan@kernelim.com>
Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 13d671dccfd8..75c646743df3 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -281,17 +281,19 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		break;
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		ep->re_connect_status = -ENOTCONN;
-		goto disconnected;
+		goto wake_connect_worker;
 	case RDMA_CM_EVENT_UNREACHABLE:
 		ep->re_connect_status = -ENETUNREACH;
-		goto disconnected;
+		goto wake_connect_worker;
 	case RDMA_CM_EVENT_REJECTED:
 		dprintk("rpcrdma: connection to %pISpc rejected: %s\n",
 			sap, rdma_reject_msg(id, event->status));
 		ep->re_connect_status = -ECONNREFUSED;
 		if (event->status == IB_CM_REJ_STALE_CONN)
 			ep->re_connect_status = -ENOTCONN;
-		goto disconnected;
+wake_connect_worker:
+		wake_up_all(&ep->re_connect_wait);
+		return 0;
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:

