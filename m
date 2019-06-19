Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF74BBA8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFSOdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:33:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44937 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbfFSOdd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:33:33 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so38541386iob.11;
        Wed, 19 Jun 2019 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=lx+gZi0hCi77gDEna59Uw5RKupM7icgeutfSKa5j5AEsNqYUp5SmI0rWQCY9aVEaWz
         /tywZ95U63sp4OKo0LAcqw1dfXNxVOreJxf4r8EUzvwnMmutFUvcss+3pjySXu6YXZJQ
         qV9sys4o1Z5ZWRMGYkw85c66b9Cz9LySs9aXKugu7CxyqxyRhMzIqjKgZkFLAGjEFqIz
         6LO2GYtXMVpcAXHZ1kiYaftWG7uzbai7VVBqGWu0zhapYr6SxO11buNIcDMoFahyf9o+
         MqFUR02N6pefAc4olEBHHRS7GzpiB+DYkSEa8GKeeWYtDrUzfQmhVhpt0YQq58bX15eb
         Zhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y5KfP+82Q2G+FSMMy0+NWol6P6fdC5jPKgFtk+jfHFo=;
        b=oEdafJnL0L3PBkhoh2NmU2cLsA0y7o7OaYEawnkTda6BATnASwXyV8bRpIrcbNF/P0
         oOzX3tOAsqMvEUR4AiGI5wPWA8xjw5nXeMKUoJRgAmtm4R3OaPHC77fVWek/EWZLkTt2
         SmIvYcFCqfJxeY/2gYC6FyARMJk/9LRsErNHN2Rf+M5+QlJOcPWrQKAkY+o4HCsocqpI
         lkSGBYxbwrj0SPy2xe5jbiyv9HC84nyFzCcltjN5dgiOq5jYr8MR6MQFI0BuD4etaINa
         tbZ7Zg7f5fx/z7iB3IYzkBbumvkExvB8EdQpXRy6iRVU4yXS90X4HV5KlPfChAa2Wc9U
         AgfA==
X-Gm-Message-State: APjAAAUSP0rwUf6Zs/pWuCBOojPRgJP2Tj347qDrsScXL61LqHRFNGNk
        4ONfdOWagYKAtbKrWd5Ljgr7b05w
X-Google-Smtp-Source: APXvYqyrqD0BeBBPAb8cytoWjBxzL6SOtha0giNExKpqfb0PLlxl7lO3Uy8yICtdNLo+VTiPLnL/oQ==
X-Received: by 2002:a02:b90e:: with SMTP id v14mr64522008jan.122.1560954812659;
        Wed, 19 Jun 2019 07:33:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h19sm14990283iol.65.2019.06.19.07.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:32 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXVO5004527;
        Wed, 19 Jun 2019 14:33:31 GMT
Subject: [PATCH v4 12/19] xprtrdma: Refactor chunk encoding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:31 -0400
Message-ID: <20190619143331.3826.54911.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
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
 

