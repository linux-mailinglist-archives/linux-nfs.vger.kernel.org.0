Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762B4835DF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfHFPyh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41533 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so93685794ota.8;
        Tue, 06 Aug 2019 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Q8M+QTopchKexUTh9SVNA/1Pd4YjmWytnWlQnNZ1x4=;
        b=R57Tot1Pfr1OJvBz65Qm4TpQj4GRW32A6Z5wsVi08nbtW1Sw/c3Zb80RGoUS59/iqc
         mjCQ6vi7IRJMdV77qTdegxk/MNq84ffxPaAjvFF6lzYrNbpS/7k11i/MIr0t9dzIF+TX
         rvyTr8p72fJwY3G/cp0XWmyriRughzk2OXthXj7h1aa88iM3QVrTs3PrRZQPCnR9St54
         0B2vAvmOVPEsSaEy4/pcIDNVo1MeqnVFoJ9paW3+PKF8YE5YBTQPf6NkUiNx+thPT0k8
         vAMYpN+rzEXxMLdPzDsRHFgXPR+XSbc3dwYIFzOYeo8uLAYp1J1MDLADr2tEIbwqNIIs
         E09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=5Q8M+QTopchKexUTh9SVNA/1Pd4YjmWytnWlQnNZ1x4=;
        b=n0avs7/SN9Ukx+OPQvJ6fBWkUGDhdZYrETjXlHnd2VnX7virKpondKyzZlEyHr4q88
         NcpErAb26IOkotYCQ4QFqEUUQfbeM+C6w4sjNeKPnwu49RVGypnVA2Hg6Z8cG5Oz5itl
         uKB5FfL5xnZsd5vAB95EpWjLBwzp6vLRIBDO9p1PJMODhq9TJRFdFkqetrgsE/Ta9lM2
         VNrnCocgfTMNQpNfEE551LeJcSMuT2r0v2vzkZbC4J3VYxA79E9BV+/KBi1GMRg4AKPO
         nXsMh17Eza7NTu6OlDke8UlXpCXzEZN7eI09wpN22AhhfrJ0Yluml0gVFZ1auTFRyCEi
         sE5A==
X-Gm-Message-State: APjAAAW2HpilMOEnVO0jg8h315VnQvUEPzgxvBuUg/5MrCWkIneMdf1P
        xFsJDzHWWMI48XN5h4oMpaAOvknZ
X-Google-Smtp-Source: APXvYqz3+qfd6e0kHDRn8BL1YBwR1jHlcEQQPpBww+XiSOPwX9Ll3DM8Kbkw1+XfiX6pTf6aNa/y/w==
X-Received: by 2002:a6b:7208:: with SMTP id n8mr3044169ioc.151.1565106875297;
        Tue, 06 Aug 2019 08:54:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c11sm48893566ioi.72.2019.08.06.08.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:34 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsYv4011538;
        Tue, 6 Aug 2019 15:54:34 GMT
Subject: [PATCH v1 09/18] xprtrdma: Combine rpcrdma_mr_put and
 rpcrdma_mr_unmap_and_put
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:34 -0400
Message-ID: <20190806155434.9529.25157.stgit@manet.1015granger.net>
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

Clean up. There is only one remaining rpcrdma_mr_put call site, and
it can be directly replaced with unmap_and_put because mr->mr_dir is
set to DMA_NONE just before the call.

Now all the call sites do a DMA unmap, and we can just rename
mr_unmap_and_put to mr_put, which nicely matches mr_get.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |    6 +++---
 net/sunrpc/xprtrdma/verbs.c     |   32 ++++++++------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 -
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index d7e763f..97e1804 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -129,7 +129,7 @@ void frwr_reset(struct rpcrdma_req *req)
 	struct rpcrdma_mr *mr;
 
 	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
-		rpcrdma_mr_unmap_and_put(mr);
+		rpcrdma_mr_put(mr);
 }
 
 /**
@@ -453,7 +453,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
 			trace_xprtrdma_mr_remoteinv(mr);
-			rpcrdma_mr_unmap_and_put(mr);
+			rpcrdma_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}
 }
@@ -463,7 +463,7 @@ static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr *mr)
 	if (wc->status != IB_WC_SUCCESS)
 		rpcrdma_mr_recycle(mr);
 	else
-		rpcrdma_mr_unmap_and_put(mr);
+		rpcrdma_mr_put(mr);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index dd5692c..107116b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1225,34 +1225,15 @@ struct rpcrdma_mr *
 	return NULL;
 }
 
-static void
-__rpcrdma_mr_put(struct rpcrdma_buffer *buf, struct rpcrdma_mr *mr)
-{
-	spin_lock(&buf->rb_mrlock);
-	rpcrdma_mr_push(mr, &buf->rb_mrs);
-	spin_unlock(&buf->rb_mrlock);
-}
-
-/**
- * rpcrdma_mr_put - Release an rpcrdma_mr object
- * @mr: object to release
- *
- */
-void
-rpcrdma_mr_put(struct rpcrdma_mr *mr)
-{
-	__rpcrdma_mr_put(&mr->mr_xprt->rx_buf, mr);
-}
-
 /**
- * rpcrdma_mr_unmap_and_put - DMA unmap an MR and release it
- * @mr: object to release
+ * rpcrdma_mr_put - DMA unmap an MR and release it
+ * @mr: MR to release
  *
  */
-void
-rpcrdma_mr_unmap_and_put(struct rpcrdma_mr *mr)
+void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 
 	if (mr->mr_dir != DMA_NONE) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -1260,7 +1241,10 @@ struct rpcrdma_mr *
 				mr->mr_sg, mr->mr_nents, mr->mr_dir);
 		mr->mr_dir = DMA_NONE;
 	}
-	__rpcrdma_mr_put(&r_xprt->rx_buf, mr);
+
+	spin_lock(&buf->rb_mrlock);
+	rpcrdma_mr_push(mr, &buf->rb_mrs);
+	spin_unlock(&buf->rb_mrlock);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 54e6d88..345158b 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -490,7 +490,6 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 
 struct rpcrdma_mr *rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_mr_put(struct rpcrdma_mr *mr);
-void rpcrdma_mr_unmap_and_put(struct rpcrdma_mr *mr);
 
 static inline void
 rpcrdma_mr_recycle(struct rpcrdma_mr *mr)

