Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846713D056
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfFKPJF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbfFKPJE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:09:04 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so10161116ios.10;
        Tue, 11 Jun 2019 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=BK23Pn6fabLgy7yI8usgdi24GmJUMayjC0c4pXmNkcxqB2Sh2VOMbPKKIhio7gyhHz
         OGOhzKmuUI57skkq/JxdhUwlrvUJSizlSMt1AwqPsJPPrshVAx2lfLJxs5lTFUmckCuW
         mpC91Z4XNMVm+07GYkjYvaNJxR2a5aAtg+/+HA8IJF53MPXFyZjsPEb5w3a9tfeDm2h0
         pjlEhm/ooqMsMen4t/Qsze0oC3e31SiZe5ljpQ5wBOUvsPsiwX/x1H4LHzYoafFxi33P
         3ckq3TUND2xcuGTcclQwbc/40Sj90dWsqyEDfk4+lQyx020I1vNmrYUya2u1sinHiczL
         aG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=hY6zcllujwoSvDjGV6Ut57/OM3oHgOydl/YQbsqlCZJ4yF2TfOCW1wdwDAw1/nGYj0
         4ni+sGBru/8N14jFRkBIKqYuI7RuXgc1RcyfK7yw9yR9E6K0nN/96mUYyohKfmyZRmHe
         8CDZvzSowCSAPTKK1P/phPJXZHJDMduoYoX3qSyNHlEYQ36nYP0lZTwGh3J1dAe2gho8
         C/nWJb0blldJ5UMm58al8aLIVNxpYuVDD7S5z6QdEhHQALIFJ+PbVqoa37pcndiNhkqD
         KjZV9WSK7RYXyPj+DbyBsD9y2NCO7lpm+4bWzXh+xi5YD5e8QE4X4bOQ1YEng8uUCip3
         DYMg==
X-Gm-Message-State: APjAAAU7k6TwlEYoKBWgwxLURAQUHiio6RahAV6+lmNZDbZFLoDPCZTS
        Lz5Uu4oHJJlMV05x8zhVElPmtPIG
X-Google-Smtp-Source: APXvYqxZvED4kGA0EZzO6krPFDuuIZPJ8L0/7HZrgPF7jcbU30LTNBDRcB48I9DT7Cc18bG30fFf6A==
X-Received: by 2002:a6b:5812:: with SMTP id m18mr7947426iob.13.1560265743631;
        Tue, 11 Jun 2019 08:09:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z202sm1705460itb.2.2019.06.11.08.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:03 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF92oq021761;
        Tue, 11 Jun 2019 15:09:02 GMT
Subject: [PATCH v2 12/19] xprtrdma: Refactor chunk encoding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:02 -0400
Message-ID: <20190611150902.2877.63929.stgit@manet.1015granger.net>
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

Clean up.

Move the "not present" case into the individual chunk encoders. This
improves code organization and readability.

The reason for the original organization was to optimize for the
case where there there are no chunks. The optimization turned out to
be inconsequential, so let's err on the side of code readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index caf0b19..d3515d3 100644
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
 

