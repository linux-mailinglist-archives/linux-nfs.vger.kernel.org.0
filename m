Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB1835CC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfHFPxy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:53:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38186 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPxy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:53:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so93759098oth.5;
        Tue, 06 Aug 2019 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lwkqc/IxzTy8UN8BIHHenscLGiwOm5ZzdBQIxTQoADU=;
        b=ikN1qESuWSLj0R12xegzRPgVEwbEaNiTF1SmgI89pqQTcss6DMiML/tpRztflC9PHB
         6k6WhPQZQna8L3NMqhvFrmLaQQkPQpHe1ixlZwQYPXnNorNoUIgarxxcB09Yc+genkVX
         dpvAUrdf/rp+JzM2lYTTjmjR8NdnAEbToJdXVfvWJ3EfXscSsnSV0F0JFQXvAfDcA38b
         pBRs+FiGwq0zCk7RMucp5ZsQRKApzntJZiTDS9O2E0WxvsIVMJaGQzGBzCkWFaXd4i6B
         WkgtxoHhgIkBY1UD5YUT0cuMh+8Kyxh8a4x5SusA2GKcOHVoYbpjaWITc5HPsvrdDQ4H
         1u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lwkqc/IxzTy8UN8BIHHenscLGiwOm5ZzdBQIxTQoADU=;
        b=EtVmUHu1yOJERZHu953KZ9ga1ztmyqwx7JLGWXmyuWmdO01X6oF1JfBN3Mk87HgW1s
         IMlS9pRC9w7int4dAEPIZZGXWLNWjrAoMg6lDbb+GgcUqJwZVx/wrIKRuYqaZ+Sk9RlU
         QjJPosqek9zQqwG/sHg0Zp4jRGcwTJp4rnhYozzj9V69JX/cZ/CWdOg3u0SieUTbhYsU
         jAXsH814nXO+nvjARThX8B9RVsCYHeQeg50MTLCAEWaYfrmb59lQHiIVzpP18Zr70yi2
         svazFYlCfGL0leZmm6RsT5LBNhnpowlurCLMbgstdzWQuJFPjjXy6yraWmtQ/dItFZhq
         QjJg==
X-Gm-Message-State: APjAAAWiE3JN6DgUhjIxZXGIah55PNns5PBGAqf1G0MuX3v7JtUESxH0
        z3UvmZLA43VWLDOrcVPOitGXMTi+
X-Google-Smtp-Source: APXvYqwITe3gFzMMBfd+31utgoK/DFoC+ysDfBbDdzK8c+G8pONrTKPl2/fnISMY24JBZIiwPX47RA==
X-Received: by 2002:a5d:9642:: with SMTP id d2mr4135106ios.278.1565106832879;
        Tue, 06 Aug 2019 08:53:52 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y5sm92305251ioc.86.2019.08.06.08.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:53:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Frp1F011514;
        Tue, 6 Aug 2019 15:53:51 GMT
Subject: [PATCH v1 01/18] xprtrdma: Refresh the documenting comment in
 frwr_ops.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:53:51 -0400
Message-ID: <20190806155351.9529.96877.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Things have changed since this comment was written. In particular,
the reworking of connection closing, on-demand creation of MRs, and
the removal of fr_state all mean that deferring MR recovery to
frwr_map is no longer needed. The description is obsolete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |   66 +++++++++++-----------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 0b6dad7..a30f2ae 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -7,67 +7,37 @@
 /* Lightweight memory registration using Fast Registration Work
  * Requests (FRWR).
  *
- * FRWR features ordered asynchronous registration and deregistration
- * of arbitrarily sized memory regions. This is the fastest and safest
+ * FRWR features ordered asynchronous registration and invalidation
+ * of arbitrarily-sized memory regions. This is the fastest and safest
  * but most complex memory registration mode.
  */
 
 /* Normal operation
  *
- * A Memory Region is prepared for RDMA READ or WRITE using a FAST_REG
+ * A Memory Region is prepared for RDMA Read or Write using a FAST_REG
  * Work Request (frwr_map). When the RDMA operation is finished, this
  * Memory Region is invalidated using a LOCAL_INV Work Request
- * (frwr_unmap_sync).
+ * (frwr_unmap_async and frwr_unmap_sync).
  *
- * Typically these Work Requests are not signaled, and neither are RDMA
- * SEND Work Requests (with the exception of signaling occasionally to
- * prevent provider work queue overflows). This greatly reduces HCA
+ * Typically FAST_REG Work Requests are not signaled, and neither are
+ * RDMA Send Work Requests (with the exception of signaling occasionally
+ * to prevent provider work queue overflows). This greatly reduces HCA
  * interrupt workload.
- *
- * As an optimization, frwr_unmap marks MRs INVALID before the
- * LOCAL_INV WR is posted. If posting succeeds, the MR is placed on
- * rb_mrs immediately so that no work (like managing a linked list
- * under a spinlock) is needed in the completion upcall.
- *
- * But this means that frwr_map() can occasionally encounter an MR
- * that is INVALID but the LOCAL_INV WR has not completed. Work Queue
- * ordering prevents a subsequent FAST_REG WR from executing against
- * that MR while it is still being invalidated.
  */
 
 /* Transport recovery
  *
- * ->op_map and the transport connect worker cannot run at the same
- * time, but ->op_unmap can fire while the transport connect worker
- * is running. Thus MR recovery is handled in ->op_map, to guarantee
- * that recovered MRs are owned by a sending RPC, and not one where
- * ->op_unmap could fire at the same time transport reconnect is
- * being done.
- *
- * When the underlying transport disconnects, MRs are left in one of
- * four states:
- *
- * INVALID:	The MR was not in use before the QP entered ERROR state.
- *
- * VALID:	The MR was registered before the QP entered ERROR state.
- *
- * FLUSHED_FR:	The MR was being registered when the QP entered ERROR
- *		state, and the pending WR was flushed.
- *
- * FLUSHED_LI:	The MR was being invalidated when the QP entered ERROR
- *		state, and the pending WR was flushed.
- *
- * When frwr_map encounters FLUSHED and VALID MRs, they are recovered
- * with ib_dereg_mr and then are re-initialized. Because MR recovery
- * allocates fresh resources, it is deferred to a workqueue, and the
- * recovered MRs are placed back on the rb_mrs list when recovery is
- * complete. frwr_map allocates another MR for the current RPC while
- * the broken MR is reset.
- *
- * To ensure that frwr_map doesn't encounter an MR that is marked
- * INVALID but that is about to be flushed due to a previous transport
- * disconnect, the transport connect worker attempts to drain all
- * pending send queue WRs before the transport is reconnected.
+ * frwr_map and frwr_unmap_* cannot run at the same time the transport
+ * connect worker is running. The connect worker holds the transport
+ * send lock, just as ->send_request does. This prevents frwr_map and
+ * the connect worker from running concurrently. When a connection is
+ * closed, the Receive completion queue is drained before the allowing
+ * the connect worker to get control. This prevents frwr_unmap and the
+ * connect worker from running concurrently.
+ *
+ * When the underlying transport disconnects, MRs that are in flight
+ * are flushed and are likely unusable. Thus all flushed MRs are
+ * destroyed. New MRs are created on demand.
  */
 
 #include <linux/sunrpc/rpc_rdma.h>

