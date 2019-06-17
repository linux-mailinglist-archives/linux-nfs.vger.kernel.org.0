Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B524B48738
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfFQPcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38637 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPcJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:09 -0400
Received: by mail-io1-f67.google.com with SMTP id d12so14130326iod.5;
        Mon, 17 Jun 2019 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jbIoowb+8m/ceP4RUgItw0GvJrUe1POm98tpREApTk4=;
        b=bVGrW63ohDsESU/U1OEZTLYy3p/+7q63n0bCd01/RrzsPmzOvYrvIYac7hfjNrlOE9
         jGpYru0DSnB0yb7RZ1YNuQhaL8+MEmvPOqECX7lk/l90bP9aPEcNNHiqO+xaVAgtt9sP
         GoviEtwxWD8/IH+w2c5HRNbEVl9pqIlVcSpdoQQbUuCe6wCbsXZQy6VCbNPJwneFDCXw
         KMOJZnsXxYYSQC4Pcy2cp6hkeIxQK3NvwDw4tDLLmewDKDkNtzrTSQVyA1DFq+2AWSgY
         jFCIKCqelk1RR9AGKfB7rzz2dpQv4GHwzdKH4JtCjLuqP4cxckZYJLYrYwWkWOcxKX4e
         VwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jbIoowb+8m/ceP4RUgItw0GvJrUe1POm98tpREApTk4=;
        b=ZNyNJdaie4zdPga6tgJ8Uy+IaMbnXaguovDIqCOIpeeIqtur3kDEtkYLedJ7zaiYFt
         1lUxjme7JvjAOGjHm+41prylhpBp5NkBTi+ZkpP1cKnGhe5MdiAV2fcobXqKaB0tWFjI
         G2r4LX/KQSj4qxXbvFgyF3MM3ZlIZw8trLN4qBaOE1Lt2aiRXIjN8Vk5DGs95C2FJL6T
         J1isn2+yQ02eJgEULynd9pu4gRmQjAacirqc8LBSLjZD2URCiQ+Q6GeA1wfetbymta/7
         q02BcBfpiZxS+DS3c02cTI6ygNW5lnryRVEQJnZpHiFgEBzUGqvSO5Zyf3rX0Bb1EStm
         2D2Q==
X-Gm-Message-State: APjAAAXAIT1Ku2Lc8erLzT8V8bRgGA5R9bds5uvpkjC3QGeagAsq+Pbp
        a1fCKRqytcblDc5+RLt8tgOoGf5l
X-Google-Smtp-Source: APXvYqyNbQFtV4yLav/5LPxC/JbXpQb5Yxvt9o43LyLAM5yZna9I3VhgXM1gJbDBeuY5/Cf3Tzd02g==
X-Received: by 2002:a6b:b790:: with SMTP id h138mr30581939iof.64.1560785528201;
        Mon, 17 Jun 2019 08:32:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i23sm8618543ioj.24.2019.06.17.08.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:07 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFW66N031206;
        Mon, 17 Jun 2019 15:32:06 GMT
Subject: [PATCH v3 07/19] xprtrdma: Add mechanism to place MRs back on the
 free list
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:06 -0400
Message-ID: <20190617153206.12090.95040.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
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

