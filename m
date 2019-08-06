Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5869E835D8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbfHFPyV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41456 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so93683558ota.8;
        Tue, 06 Aug 2019 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/slgN6YQnkgtMzeBensO8h3fPxZv7hozEG4vjJwfxNg=;
        b=HUj3NNrLyazQvAA1cPvHezlxILxCoLZlRL5covYdt2uIPdPafBxIXo5qQmr8NwE+jS
         uluc7PGsebUORT60g/DbxQFmp/RLymANp7qdGw75bq/U9uCx/yFAHdZZVjyF1GGNmaln
         BpH+c1ln69a/hmK268QXfZIT+ZalbAK6d64VhWLVMHw8W/st42cRRG4E9a18Up9rc+00
         H7RYXWeRjYPMYKvBQIeVdkHT2U19xTND4Qcv9t/rDRkAnUA2IcpiQ9wFvDCVGvvCMaAE
         zNyhIIImdomw9voElD4/FEhhNiCLf9/kK04QMDxgecdah0OswUsj1JYClzwaNb5tB7/Q
         3AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/slgN6YQnkgtMzeBensO8h3fPxZv7hozEG4vjJwfxNg=;
        b=Pu+btYHez2SI64YqfOswUx1v6yixbLzdINOMUUkAgkSY8EOxwotXl429qR+TIiQ05l
         yawWB0AW5GXHDgP09e7bZepMicf7X3H8TPbX7sL4yxyDfdxqtz/plR4ciVDeToHvHTYn
         6Q+XMm8oiwMf6fskUvn8IKwzit9rspOi52Ptyg5/JPqHPElxcfQHMONg7gunNRmfmCSr
         eGwYBDONYO4CRYUQGdkgcSKeSTVVjBukhef+oBLmN1cycZkGoEejSdPyYeDMlm9GtJOm
         WJAvRbzOV4kilpaGvnicaLCK1Bc5DTerZBGuTGaBLp24oXKCgSjZ3OoAgwwpPO98iA0F
         mh3w==
X-Gm-Message-State: APjAAAUnow+VRw/r3D7pFygjM92ZVjx7IFMectoXJ/su9j3srdw2uDun
        OQSa+uH6hJQLjJT0NC6KYs5O2R/O
X-Google-Smtp-Source: APXvYqw71C46Tsf9YD6s3TeMTs7AD6vT6IO9rn24iLh20qLhpjfSTldAzkYW8BgKCE1ssvTm9xgS1A==
X-Received: by 2002:a05:6602:144:: with SMTP id v4mr4239610iot.202.1565106859456;
        Tue, 06 Aug 2019 08:54:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p63sm84800330iof.45.2019.08.06.08.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:19 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsI9O011529;
        Tue, 6 Aug 2019 15:54:18 GMT
Subject: [PATCH v1 06/18] xprtrdma: Rename rpcrdma_buffer::rb_all
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:18 -0400
Message-ID: <20190806155418.9529.82559.stgit@manet.1015granger.net>
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

Clean up: There are other "all" list heads. For code clarity
distinguish this one as for use only for MRs by renaming it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   26 ++++++++------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 902cc82..bf7a7cf 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -942,8 +942,6 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	unsigned int count;
-	LIST_HEAD(free);
-	LIST_HEAD(all);
 
 	for (count = 0; count < ia->ri_max_segs; count++) {
 		struct rpcrdma_mr *mr;
@@ -961,15 +959,13 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 
 		mr->mr_xprt = r_xprt;
 
-		list_add(&mr->mr_list, &free);
-		list_add(&mr->mr_all, &all);
+		spin_lock(&buf->rb_mrlock);
+		list_add(&mr->mr_list, &buf->rb_mrs);
+		list_add(&mr->mr_all, &buf->rb_all_mrs);
+		spin_unlock(&buf->rb_mrlock);
 	}
 
-	spin_lock(&buf->rb_mrlock);
-	list_splice(&free, &buf->rb_mrs);
-	list_splice(&all, &buf->rb_all);
 	r_xprt->rx_stats.mrs_allocated += count;
-	spin_unlock(&buf->rb_mrlock);
 	trace_xprtrdma_createmrs(r_xprt, count);
 }
 
@@ -1081,7 +1077,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	spin_lock_init(&buf->rb_mrlock);
 	spin_lock_init(&buf->rb_lock);
 	INIT_LIST_HEAD(&buf->rb_mrs);
-	INIT_LIST_HEAD(&buf->rb_all);
+	INIT_LIST_HEAD(&buf->rb_all_mrs);
 	INIT_DELAYED_WORK(&buf->rb_refresh_worker,
 			  rpcrdma_mr_refresh_worker);
 
@@ -1148,24 +1144,18 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
 
 	count = 0;
 	spin_lock(&buf->rb_mrlock);
-	while (!list_empty(&buf->rb_all)) {
-		mr = list_entry(buf->rb_all.next, struct rpcrdma_mr, mr_all);
+	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
+					      struct rpcrdma_mr,
+					      mr_all)) != NULL) {
 		list_del(&mr->mr_all);
-
 		spin_unlock(&buf->rb_mrlock);
 
-		/* Ensure MW is not on any rl_registered list */
-		if (!list_empty(&mr->mr_list))
-			list_del(&mr->mr_list);
-
 		frwr_release_mr(mr);
 		count++;
 		spin_lock(&buf->rb_mrlock);
 	}
 	spin_unlock(&buf->rb_mrlock);
 	r_xprt->rx_stats.mrs_allocated = 0;
-
-	dprintk("RPC:       %s: released %u MRs\n", __func__, count);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index f9071fb..f90643d 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -365,7 +365,7 @@ struct rpcrdma_req {
 struct rpcrdma_buffer {
 	spinlock_t		rb_mrlock;	/* protect rb_mrs list */
 	struct list_head	rb_mrs;
-	struct list_head	rb_all;
+	struct list_head	rb_all_mrs;
 
 	unsigned long		rb_sc_head;
 	unsigned long		rb_sc_tail;

