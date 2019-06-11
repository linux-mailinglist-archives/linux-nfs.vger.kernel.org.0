Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0A3D04B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfFKPIh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:37 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55324 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391700AbfFKPIh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:37 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so5472637ita.5;
        Tue, 11 Jun 2019 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jbIoowb+8m/ceP4RUgItw0GvJrUe1POm98tpREApTk4=;
        b=Phs3Qf/PydpM/QdZNUtrnBGpbXHqPJEt3MoHeVxHOzQ2Wb+2O+0b7OR0jovDuwoz1R
         08nlw2/IN8QV5+kMHgh/iafBdCLS5OgyoH063ID9rbdDzzKkClycPLLJxHP+i08mywnY
         7z2mmdFwbYRXWuyY+BCoELh+bxwsoES4pEYp1rWTamHhSJWXop/YFqhWFodNSRNs+N10
         vtlNAcguo7xdLLrvC8u8ECJxjj4AeIxAxh6tJSEUlRhESXOh7/TXGi5cKnlixbiIB93X
         PVxlwjNwMWPTN40gEWbBX2jkC2/vIzeEYCyOKBCpCA7tn7WG5dRZWGpivohgR7csZyD4
         bDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jbIoowb+8m/ceP4RUgItw0GvJrUe1POm98tpREApTk4=;
        b=fuJzA8HmO04/BcdcOKA13hSGrhJJDAw8xRsQnHrT9zFAXl/gzuq6hll5V1Px9CR9mM
         2yeSntYGzPTRpnJEtiZvrBEOF2xcrC8/XCBfRUGLgN4p1jXhbxY6zWouUqz7eHlaMFH6
         ZOPl3F9fAbMPNUAiYPulZj+OEFt4bG17IX71DeuadIRWu4LdUchTx8at0XIsCzHGXPEN
         cciB0Ska3yTDk9Y5RXncnW8I27sMaSyUlZHAJEC8JY+vk2+RIjsb9m6QXWCc9XdYrtgG
         NUtsNvv7CEvDjlMslprur79TY2PUFUyFxEmf4xaz/GEqCKJ5Ok7BKA5g94h80CpMgwKc
         j08w==
X-Gm-Message-State: APjAAAXM0SnYzUTkRD9t6NvkdZIgp9rWyEF9RMArCvAdb7fHw3E7gJnt
        iJ0N/UpKkVhDj/GdVgP5GZKmlfE2
X-Google-Smtp-Source: APXvYqzeXUyHKXw6EQmfa2YDn6dQP3f0KWplcZMx2oC3WR2FhDOZLVvlskCVuGlBhR8UCtQ/xOLbSQ==
X-Received: by 2002:a02:a493:: with SMTP id d19mr47483070jam.22.1560265716636;
        Tue, 11 Jun 2019 08:08:36 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 3sm1384122itm.25.2019.06.11.08.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:08:36 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF8ZB4021746;
        Tue, 11 Jun 2019 15:08:35 GMT
Subject: [PATCH v2 07/19] xprtrdma: Add mechanism to place MRs back on the
 free list
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:08:35 -0400
Message-ID: <20190611150835.2877.66642.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a marshal operation fails, any MRs that were already set up for
that request are recycled. Recycling releases MRs and creates new
ones, which is expensive.

Since commit f2877623082b ("xprtrdma: Chain Send to FastReg WRs")
was merged, recycling FRWRs is unnecessary. This is because before
that commit, frwr_map had already posted FAST_REG Work Requests,
so ownership of the MRs had already been passed to the NIC and thus
dealing with them had to be delayed until they completed.

Since that commit, however, FAST_REG WRs are posted at the same time
as the Send WR. This means that if marshaling fails, we are certain
the MRs are safe to simply unmap and place back on the free list
because neither the Send nor the FAST_REG WRs have been posted yet.
The kernel still has ownership of the MRs at this point.

This reduces the total number of MRs that the xprt has to create
under heavy workloads and makes the marshaling logic less brittle.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   20 ++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  |    1 +
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 3 files changed, 22 insertions(+)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index dae2caa..5b7ff75 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -144,6 +144,26 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 	frwr_release_mr(mr);
 }
 
+/* frwr_reset - Place MRs back on the free list
+ * @req: request to reset
+ *
+ * Used after a failed marshal. For FRWR, this means the MRs
+ * don't have to be fully released and recreated.
+ *
+ * NB: This is safe only as long as none of @req's MRs are
+ * involved with an ongoing asynchronous FAST_REG or LOCAL_INV
+ * Work Request.
+ */
+void frwr_reset(struct rpcrdma_req *req)
+{
+	while (!list_empty(&req->rl_registered)) {
+		struct rpcrdma_mr *mr;
+
+		mr = rpcrdma_mr_pop(&req->rl_registered);
+		rpcrdma_mr_unmap_and_put(mr);
+	}
+}
+
 /**
  * frwr_init_mr - Initialize one MR
  * @ia: interface adapter
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index f23450b..67d72d6 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -884,6 +884,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 out_err:
 	trace_xprtrdma_marshal_failed(rqst, ret);
 	r_xprt->rx_stats.failed_marshal_count++;
+	frwr_reset(req);
 	return ret;
 }
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index a9de116..a396528 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -549,6 +549,7 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
 bool frwr_is_supported(struct ib_device *device);
+void frwr_reset(struct rpcrdma_req *req);
 int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);
 void frwr_release_mr(struct rpcrdma_mr *mr);

