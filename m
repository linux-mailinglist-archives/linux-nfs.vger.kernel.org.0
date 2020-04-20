Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFF1AFF13
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDTADN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgDTADN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 20:03:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857FC061A0C;
        Sun, 19 Apr 2020 17:03:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so7156988qtv.3;
        Sun, 19 Apr 2020 17:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0W2mBwo/aBMrh7K/c/cKr1aNbLZU2A1Qz0rlYtVDZfM=;
        b=r3ioTpsyBGKxFZJXjk0ka/Onr0CMv6f/JBIPG4v6ERy1FGTw3bhW2XWUDFC+nRf4Dr
         2smN6g5u4Qq5f0+CpT8uPl8YDpP0s59kxiqqLFWg0rvM3+KH4t8lMb/Gh+rmGCfzLkYt
         6/lwGv5WNeZOl+K4QocsBqbHeauoJm1avT1N4Nle09SIg2Ki0Kwt8KEiXQjGuiG2fWVY
         18jo0ZaZvJjXzwGF/f867ZJ0rO7mQu9Fz28hyGOh7/PZXFE9W97VDm2D1vjzokw02vVF
         0GxvdRK3Z4Q645fa7wnlZ5CwcdN+Vcx9AhDY5rYNKvXNLwCIupfig56W1yvimtQkazY4
         E75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0W2mBwo/aBMrh7K/c/cKr1aNbLZU2A1Qz0rlYtVDZfM=;
        b=iYgAyzhOI/KzNDdP5d0c9nbATnX75kSt5RUpgg9isu+PUwJNFmNYTj9yC5S3lklwbv
         Oy0f0PTFg1NCvJ262tIPnAl+hU2gE045bXIzEZmY2zM7q57I02Lsl0iVvRhZal3ssvzv
         pQCNg/WuaRjp7H9oAbZs0/fsGn7Xy82KMwdVvkB6iyzWU2J43HsX3dZnKB6e2Ix2wd/j
         gzG1W60e8DBSEXzPeSJ3TeR2aoCMwuhAH6TvH5f9TMqoTMzQwXxOElY+MndDlzh6ULZc
         e1bBUP0Zg5CM26i5C/T6+xE6ukDCQRAcUOovivw4fyot8KaXDT6mj+p+FLV+WbXdPfwV
         RFGg==
X-Gm-Message-State: AGi0PuYPPUW+nZ7O4C5IIWjK9UeJUG70FJ79GJQkfcjZMS69lSv6Bue1
        3auViweXm9DA20FbIonNfDKU2teu
X-Google-Smtp-Source: APiQypKQi3HY9J5tyqYLlCr9KX3QjLth5Oxh41XwpAMMimhbJ9IZOAVVfK6U4qf+pB+8fWL2V6P2wA==
X-Received: by 2002:ac8:7606:: with SMTP id t6mr12653236qtq.331.1587340992438;
        Sun, 19 Apr 2020 17:03:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j14sm22405527qtv.27.2020.04.19.17.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:03:12 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K03AaK016699;
        Mon, 20 Apr 2020 00:03:10 GMT
Subject: [PATCH 3/3] xprtrdma: Fix use of xdr_stream_encode_item_{present,
 absent}
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 20:03:10 -0400
Message-ID: <20200420000310.6417.22816.stgit@manet.1015granger.net>
In-Reply-To: <20200420000223.6417.32126.stgit@manet.1015granger.net>
References: <20200420000223.6417.32126.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These new helpers do not return 0 on success, they return the
encoded size. Thus they are not a drop-in replacement for the
old helpers.

Fixes: 5c266df52701 ("SUNRPC: Add encoders for list item discriminators")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 4a81e6995d3e..3c627dc685cc 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -388,7 +388,9 @@ static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
 	} while (nsegs);
 
 done:
-	return xdr_stream_encode_item_absent(xdr);
+	if (xdr_stream_encode_item_absent(xdr) < 0)
+		return -EMSGSIZE;
+	return 0;
 }
 
 /* Register and XDR encode the Write list. Supports encoding a list
@@ -454,7 +456,9 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 	*segcount = cpu_to_be32(nchunks);
 
 done:
-	return xdr_stream_encode_item_absent(xdr);
+	if (xdr_stream_encode_item_absent(xdr) < 0)
+		return -EMSGSIZE;
+	return 0;
 }
 
 /* Register and XDR encode the Reply chunk. Supports encoding an array
@@ -480,8 +484,11 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 	int nsegs, nchunks;
 	__be32 *segcount;
 
-	if (wtype != rpcrdma_replych)
-		return xdr_stream_encode_item_absent(xdr);
+	if (wtype != rpcrdma_replych) {
+		if (xdr_stream_encode_item_absent(xdr) < 0)
+			return -EMSGSIZE;
+		return 0;
+	}
 
 	seg = req->rl_segments;
 	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf, 0, wtype, seg);

