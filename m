Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8412CE85
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfE1SVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:21:51 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37213 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfE1SVv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:21:51 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so537370ita.2;
        Tue, 28 May 2019 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=m9Pkw4CV2aVA90rqOBAJOqo5SGoCQ+VOLkxHnhH2bO0=;
        b=F+pKe2tRjOAstateAoDOmO5RRgQxDA7PraZVKTdDusHf98TVJs8r0BnogvdF4D5HbD
         JlpLJEeU8o6+SI+skUb+TCd0dV4Pue/XaKXKxJxhBpoIXhS4ynik/rKNxgpuSP1+dYOH
         n4wOne0soQcpFnimDZbwGug+IsDoVLGw0Dp/goErt0InaS6FR/NRBI06fzxnZvncxGZi
         EXueY6SKvWBEHf2RDlewls3JPgEzvamAwo3kHr0VJ4RTYpkO/vucP1vz0fyoZj5MAIW2
         PSSURKUFVUzYvtukEYcZUVMxj+1LrS1KxaVCM5E5Jd6UvkpBzCl4HrlH39oE/jB57wI3
         rJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=m9Pkw4CV2aVA90rqOBAJOqo5SGoCQ+VOLkxHnhH2bO0=;
        b=abjdChhMpVhxuI9rWmG32hZFsnWNIY7zVNB0e3lGf642OlPAmGvI8qIHCHwfXSbOv6
         /4QaTQFz2hJLpG23QaCvqNwQXVqC0megMvzUQZ3WVafaCeoPw/4M2quezIYNn1Exupq5
         wTFQbKLRvIPQ5tHEKzSQX+eVc4Q4Q73MKxtQkzwdk6UuApUFkpVlqIuBwkK+GmEEAmge
         arWuZnwgPehecnQF7ZasXT8GJ1hfcVJVZ5O9SEQLzYguEsg+UBNtkKiZcgH4xi8WF5Ej
         lkcJlJ0SxIEHLHepyo5W4CUH8xDhNjLVtlqgf12EokHFgj5o9X90TSfZAenMpANntGT0
         ry1A==
X-Gm-Message-State: APjAAAVa051XA6gS7pklyvjHzFq2VYu14bz0jsDxjh0XArVYD0j8B5Ua
        JaknmlcVUnAxikGTpItnD1f9mouJ
X-Google-Smtp-Source: APXvYqzqrGkWs3q7V9VB9LDnEm1zFKjOYkH9v4aUA4eO7W+OuysarCbJ0q6L8Lulf5vmMQiOnAjeTg==
X-Received: by 2002:a24:4794:: with SMTP id t142mr4239355itb.121.1559067709965;
        Tue, 28 May 2019 11:21:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm1530028itk.21.2019.05.28.11.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:21:49 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SILmaJ014546;
        Tue, 28 May 2019 18:21:48 GMT
Subject: [PATCH RFC 11/12] xprtrdma: Refactor chunk encoding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:21:48 -0400
Message-ID: <20190528182148.19012.78763.stgit@manet.1015granger.net>
In-Reply-To: <20190528181018.19012.61210.stgit@manet.1015granger.net>
References: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Move the "not present" case into the individual chunk encoders. This
improves code organization and readability.

The reason for the original organization was to optimize for the
case where there there are no chunks. The optimization turned out to
be inconsequential.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 6de90d4..310614f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -366,6 +366,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	unsigned int pos;
 	int nsegs;
 
+	if (rtype == rpcrdma_noch)
+		goto done;
+
 	pos = rqst->rq_snd_buf.head[0].iov_len;
 	if (rtype == rpcrdma_areadch)
 		pos = 0;
@@ -389,7 +392,8 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 		nsegs -= mr->mr_nents;
 	} while (nsegs);
 
-	return 0;
+done:
+	return encode_item_not_present(xdr);
 }
 
 /* Register and XDR encode the Write list. Supports encoding a list
@@ -417,6 +421,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	int nsegs, nchunks;
 	__be32 *segcount;
 
+	if (wtype != rpcrdma_writech)
+		goto done;
+
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf,
 				     rqst->rq_rcv_buf.head[0].iov_len,
@@ -451,7 +458,8 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	/* Update count of segments in this Write chunk */
 	*segcount = cpu_to_be32(nchunks);
 
-	return 0;
+done:
+	return encode_item_not_present(xdr);
 }
 
 /* Register and XDR encode the Reply chunk. Supports encoding an array
@@ -476,6 +484,9 @@ static bool rpcrdma_results_inline(struct rpcrdma_xprt *r_xprt,
 	int nsegs, nchunks;
 	__be32 *segcount;
 
+	if (wtype != rpcrdma_replych)
+		return encode_item_not_present(xdr);
+
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf, 0, wtype, seg);
 	if (nsegs < 0)
@@ -859,28 +870,13 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 	 * send a Call message with a Position Zero Read chunk and a
 	 * regular Read chunk at the same time.
 	 */
-	if (rtype != rpcrdma_noch) {
-		ret = rpcrdma_encode_read_list(r_xprt, req, rqst, rtype);
-		if (ret)
-			goto out_err;
-	}
-	ret = encode_item_not_present(xdr);
+	ret = rpcrdma_encode_read_list(r_xprt, req, rqst, rtype);
 	if (ret)
 		goto out_err;
-
-	if (wtype == rpcrdma_writech) {
-		ret = rpcrdma_encode_write_list(r_xprt, req, rqst, wtype);
-		if (ret)
-			goto out_err;
-	}
-	ret = encode_item_not_present(xdr);
+	ret = rpcrdma_encode_write_list(r_xprt, req, rqst, wtype);
 	if (ret)
 		goto out_err;
-
-	if (wtype != rpcrdma_replych)
-		ret = encode_item_not_present(xdr);
-	else
-		ret = rpcrdma_encode_reply_chunk(r_xprt, req, rqst, wtype);
+	ret = rpcrdma_encode_reply_chunk(r_xprt, req, rqst, wtype);
 	if (ret)
 		goto out_err;
 

