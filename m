Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5F95129
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfHSWvZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:51:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41424 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWvZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:51:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so3247357ota.8;
        Mon, 19 Aug 2019 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TcWcDgT7uZqe+BWiSZ2azCfOJ01Li7gzQpK20RYlSx0=;
        b=nAmIvl5qLMEXHFzq2uP7oJfc5F2YZ0cbB95CmlQGTM6KRYIcoSC/W4UCWePPwZp4aC
         sWNJaEa2QhbbUo41uuX79q2MPwraDRvVF0AlLIGMa00yV+E99Tf9ozrN6v7fHKUc/Y81
         7bTT3vkKBI3UKvC1PkI3SPhDgrJKLkBIBfvbzIK1HV1ezB7YidMd1ftf4Vz5IlGjOHYp
         4SppFQQMez18ZLclzGmHS7o3XZI7NOX69xSc8l9PLE5VIG8f2s1PNf7Jr5EpJAVEKFvX
         zm8wNzNRqOT5LvzXnbEv4M569BtWeybN+MHYSmcIq2ya5fde+l+strdi+preZn5Vno0e
         bfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TcWcDgT7uZqe+BWiSZ2azCfOJ01Li7gzQpK20RYlSx0=;
        b=NA+g1nMBMv/FfGwBJCqaOq+oMCrVvocThPc8OFysXq8PNDiOJ8xGc1JGlw9zVUgAkG
         L/FPUxIK0R65WQbxRIZ8RG8BBWSnXOI7lOYuzEHnVySblSYgipR4CiaBVP7Pi5r4u+ER
         4RA1p4ZbjjHuOKZTPRLCrexccvJ7d7OnUL0EOCxlx2Yosjqjystksi96/M9b5XPx65EG
         Used0C0B/kLP68Rq7BHoEhnirIDthjMM2yM9wmjgwDxRke4U42ToYSfu9nFUQYzyd5RZ
         3ScZf4b8HQWGQzs5gTe58slC5UU+zDgu+c4TA6LXP7Q12XnAz5TuC+Y7D1Una4Sjlli6
         AWvA==
X-Gm-Message-State: APjAAAVB9kueE9pmu6ov5sH3bJCZcYeNnyPNHU32toDLPr0SlLDZ4w/q
        rIV5HqbrpW6zEWCGMeI/LGVutssr
X-Google-Smtp-Source: APXvYqzC+p51PdJUZBXU6NStGNEpikVwuLpk21NTHt6doi40No7awd5HwPDUwFetKCPZSFPHoF1Lnw==
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr2314616otf.138.1566255084702;
        Mon, 19 Aug 2019 15:51:24 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id d22sm4763839oig.38.2019.08.19.15.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:51:24 -0700 (PDT)
Subject: [PATCH v2 20/21] xprtrdma: Inline XDR chunk encoder functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:51:03 -0400
Message-ID: <156625504326.8161.3307243638540897095.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Micro-optimization: Save the cost of three function calls during
transport header encoding.

These were "noinline" before to generate more meaningful call stacks
during debugging, but this code is now pretty stable.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index ffeb4dfebd46..67e1684aee6d 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -382,9 +382,10 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
  *
  * Only a single @pos value is currently supported.
  */
-static noinline int
-rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			 struct rpc_rqst *rqst, enum rpcrdma_chunktype rtype)
+static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
+				    struct rpcrdma_req *req,
+				    struct rpc_rqst *rqst,
+				    enum rpcrdma_chunktype rtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;
@@ -436,9 +437,10 @@ rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
  *
  * Only a single Write chunk is currently supported.
  */
-static noinline int
-rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			  struct rpc_rqst *rqst, enum rpcrdma_chunktype wtype)
+static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
+				     struct rpcrdma_req *req,
+				     struct rpc_rqst *rqst,
+				     enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;
@@ -498,9 +500,10 @@ rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
  * Returns zero on success, or a negative errno if a failure occurred.
  * @xdr is advanced to the next position in the stream.
  */
-static noinline int
-rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req,
-			   struct rpc_rqst *rqst, enum rpcrdma_chunktype wtype)
+static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
+				      struct rpcrdma_req *req,
+				      struct rpc_rqst *rqst,
+				      enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_mr_seg *seg;

