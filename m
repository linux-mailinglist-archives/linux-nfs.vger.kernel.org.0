Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18DBD14ED
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfJIRHp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43545 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:45 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so6615632iob.10;
        Wed, 09 Oct 2019 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=G6n8CniltSB2k/H07ucx+zOK4rEf38iNpHeH0fwJg4Y=;
        b=uj/eT2QiKDv8uCEK4jTvHhS3mHGzMsw6x8CC3QmC7us0DtF+jTMHjzgWVx8rK4LTCu
         Ado8494thV4CN5NndddFWifD/8B/eW5p22q8+UH0DQ87mCc6zDR+ITIFQYH7SlWyHjjD
         U6zXmzaN22X/nOPjrMuPHHeLajlYd/tTOe5a6y+EOYLS3REh9zQdU6ivDtLb3Wv4LCDe
         HAfRrwS06bumTVtxjYAZo7gXgmA57eitOfGEmFL04QrqzeOiupUCZh5N7pEwK0yCwI3j
         b7tgrdSAYAILtk82lXy+iCeR+Nepu7YQD/QIlWjqjFNTxD3Z065b/wP2ZnbNmveKTdfD
         E9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=G6n8CniltSB2k/H07ucx+zOK4rEf38iNpHeH0fwJg4Y=;
        b=FZRK8lRAJ7FZETInSjo5/2ykf+0O2KeE6uYsF6q2K+BYcZJBGBR2T1EbP4X5f7SauE
         t5L57OIEToARXO/0Hg1EaZI44vlvecUNChvtuhIB1OY3Q8bxGUsZfjb13+f5WD2Lz0xX
         GZVWQnoNQRpsixp/vBDyHfn3NrSNqEs6MF8MpASq40MKjZFDG4XGedZsqRp0SI/PNr9J
         TQT7o0iG4WV17R6//hggTrFNVOty/9x7ddaCgobto9PlMiWETaNREbQ3VeUzRu7cUhr2
         88dhs8dSZu0IWxO4IaffHcB4aHlALCwjGe6cRPhOkHIPq1cDQDMX2qOwQUFECWpfCt5P
         eWvg==
X-Gm-Message-State: APjAAAXgdXqmF0w4aPbS/63j/93Bee2y9PMW2UVrBh2fNrdjp+JolcBQ
        9ku2Y6G3YoVXzuWo7rqL9IYZiyc9
X-Google-Smtp-Source: APXvYqzv29ZoVWuAMcca83s4uJM2BEUQ1OgUnYBatNROgnwlLR7h92nZIVywRMKvnG2wq8dhtITGGA==
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr4759547ioq.236.1570640864649;
        Wed, 09 Oct 2019 10:07:44 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a26sm1357396iot.46.2019.10.09.10.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:44 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7hRo001501;
        Wed, 9 Oct 2019 17:07:43 GMT
Subject: [PATCH v1 5/6] xprtrdma: Fix MR list handling
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:43 -0400
Message-ID: <20191009170743.2978.11370.stgit@manet.1015granger.net>
In-Reply-To: <20191009170721.2978.128.stgit@manet.1015granger.net>
References: <20191009170721.2978.128.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Close some holes introduced by commit 6dc6ec9e04c4 ("xprtrdma: Cache
free MRs in each rpcrdma_req") that could result in list corruption.

In addition, the result that is tabulated in @count is no longer
used, so @count is removed.

Fixes: 6dc6ec9e04c4 ("xprtrdma: Cache free MRs in each rpcrdma_req")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3a1a31c..82361e7 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -79,7 +79,6 @@
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
-static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -966,7 +965,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 		mr->mr_xprt = r_xprt;
 
 		spin_lock(&buf->rb_lock);
-		list_add(&mr->mr_list, &buf->rb_mrs);
+		rpcrdma_mr_push(mr, &buf->rb_mrs);
 		list_add(&mr->mr_all, &buf->rb_all_mrs);
 		spin_unlock(&buf->rb_lock);
 	}
@@ -1183,10 +1182,19 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
  */
 void rpcrdma_req_destroy(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	list_del(&req->rl_all);
 
-	while (!list_empty(&req->rl_free_mrs))
-		rpcrdma_mr_free(rpcrdma_mr_pop(&req->rl_free_mrs));
+	while ((mr = rpcrdma_mr_pop(&req->rl_free_mrs))) {
+		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+
+		spin_lock(&buf->rb_lock);
+		list_del(&mr->mr_all);
+		spin_unlock(&buf->rb_lock);
+
+		frwr_release_mr(mr);
+	}
 
 	rpcrdma_regbuf_free(req->rl_recvbuf);
 	rpcrdma_regbuf_free(req->rl_sendbuf);
@@ -1194,24 +1202,28 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 	kfree(req);
 }
 
-static void
-rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
+/**
+ * rpcrdma_mrs_destroy - Release all of a transport's MRs
+ * @buf: controlling buffer instance
+ *
+ * Relies on caller holding the transport send lock to protect
+ * removing mr->mr_list from req->rl_free_mrs safely.
+ */
+static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 {
 	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
 						   rx_buf);
 	struct rpcrdma_mr *mr;
-	unsigned int count;
 
-	count = 0;
 	spin_lock(&buf->rb_lock);
 	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
 					      struct rpcrdma_mr,
 					      mr_all)) != NULL) {
+		list_del(&mr->mr_list);
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
 		frwr_release_mr(mr);
-		count++;
 		spin_lock(&buf->rb_lock);
 	}
 	spin_unlock(&buf->rb_lock);
@@ -1284,17 +1296,6 @@ void rpcrdma_mr_put(struct rpcrdma_mr *mr)
 	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
 }
 
-static void rpcrdma_mr_free(struct rpcrdma_mr *mr)
-{
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-
-	mr->mr_req = NULL;
-	spin_lock(&buf->rb_lock);
-	rpcrdma_mr_push(mr, &buf->rb_mrs);
-	spin_unlock(&buf->rb_lock);
-}
-
 /**
  * rpcrdma_buffer_get - Get a request buffer
  * @buffers: Buffer pool from which to obtain a buffer

