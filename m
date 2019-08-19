Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94118950ED
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHSWkf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:40:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35842 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSWke (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:40:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id k18so3234770otr.3;
        Mon, 19 Aug 2019 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9dF8UwmpXvMDAG/BLxG85Y8rvbTT5sYtQ6wFZaELboE=;
        b=FtJTBZZmI8Jq+d+M/q60vhpV+UBN0W3eoyqsx6k1KIKJp2pTst+TNNdvZaqAWfYvkU
         TyEooNK+A0+I0tI3UmqdQJaecISs7aFscZR3OmzTYwIeCgzTA8PzZ67aSjNndGJRdnZk
         rd4cp6ZX9yCJPl/rqElQEnpJO8pgpWlj6yAkFbRx/KsSolGLAuY+OgeaoPTDQ37b0E5J
         CPRaUAIxoJuL+o1rdaPxXPAaLDRpJnu8OIepgS58pmpTEj3VOPSc5f9V54xVO1uKwaJD
         jFRTFcnVdlbaBjyJ/Ixn0AynVIcJ4AJMFY6xnL8esZI4z3qJSAAGMT5/52TpnYGQ6yZB
         rvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9dF8UwmpXvMDAG/BLxG85Y8rvbTT5sYtQ6wFZaELboE=;
        b=JatNmefujEwtR1IIWwL2iZ77TrVln0nNqANXuEBsd54H+HwE222FHnwy7WlPPY3NUq
         1wNERpLc+EB9T2IjYgGys+UxE4bEh9wCnAo1G1CuToOkp4NaYLmCSF7B92nzZ0B+6mMV
         GltP0sQu/YlQ0pXXhZ1jCHNAl1uvCmD6vcRWN9BIxvMT/5ddLswQcv8G3kqx9xoSoYUW
         KM6sLEQuQMPDrYGtxHUSWM9sHRCFtnYlxeZ1225i3cR+Xdn6Gz26SuF60X1X7IQEox4Z
         08VNL7sNC1hHQIjqmufVmqfztKs3uUl9Sklrg3geyePGD/pOjwkYC5+cPz8u7eV8Auiz
         YevA==
X-Gm-Message-State: APjAAAUOhCSJYTx8xzrJixe9LtcuOCwmOaNbf5uvIItxrPevulrvswVO
        wD1qcXA4lcj459ukIfmDAZf024iu
X-Google-Smtp-Source: APXvYqxJJNNIWge7HF8KHU92k4cinZrR/JqC5xDP8eyZs+Njo1QCxj69YMLRO9wnas2rlgOMsDBgdQ==
X-Received: by 2002:a9d:518e:: with SMTP id y14mr13182679otg.259.1566254433050;
        Mon, 19 Aug 2019 15:40:33 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id t18sm5839587otk.73.2019.08.19.15.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:40:32 -0700 (PDT)
Subject: [PATCH v2 06/21] xprtrdma: Boost maximum transport header size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:40:11 -0400
Message-ID: <156625439150.8161.9923129489297297655.stgit@seurat29.1015granger.net>
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

Although I haven't seen any performance results that justify it,
I've received several complaints that NFS/RDMA no longer supports
a maximum rsize and wsize of 1MB. These days it is somewhat smaller.

To simplify the logic that determines whether a chunk list is
necessary, the implementation uses a fixed maximum size of the
transport header. Currently that maximum size is 256 bytes, one
quarter of the default inline threshold size for RPC/RDMA v1.

Since commit a78868497c2e ("xprtrdma: Reduce max_frwr_depth"), the
size of chunks is also smaller to take advantage of inline page
lists in device internal MR data structures.

The combination of these two design choices has reduced the maximum
NFS rsize and wsize that can be used for most RNIC/HCAs. Increasing
the maximum transport header size and the maximum number of RDMA
segments it can contain increases the negotiated maximum rsize/wsize
on common RNIC/HCAs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |    9 ++++++++-
 net/sunrpc/xprtrdma/xprt_rdma.h |   23 ++++++++++-------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 805b1f35e1ca..e639ea0faf19 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -53,6 +53,7 @@
 #include <linux/slab.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/svc_rdma.h>
+#include <linux/log2.h>
 
 #include <asm-generic/barrier.h>
 #include <asm/bitops.h>
@@ -1000,12 +1001,18 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 	struct rpcrdma_buffer *buffer = &r_xprt->rx_buf;
 	struct rpcrdma_regbuf *rb;
 	struct rpcrdma_req *req;
+	size_t maxhdrsize;
 
 	req = kzalloc(sizeof(*req), flags);
 	if (req == NULL)
 		goto out1;
 
-	rb = rpcrdma_regbuf_alloc(RPCRDMA_HDRBUF_SIZE, DMA_TO_DEVICE, flags);
+	/* Compute maximum header buffer size in bytes */
+	maxhdrsize = rpcrdma_fixed_maxsz + 3 +
+		     r_xprt->rx_ia.ri_max_segs * rpcrdma_readchunk_maxsz;
+	maxhdrsize *= sizeof(__be32);
+	rb = rpcrdma_regbuf_alloc(__roundup_pow_of_two(maxhdrsize),
+				  DMA_TO_DEVICE, flags);
 	if (!rb)
 		goto out2;
 	req->rl_rdmabuf = rb;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 3b2f2041e889..eaf6b907a76e 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -155,25 +155,22 @@ static inline void *rdmab_data(const struct rpcrdma_regbuf *rb)
 
 /* To ensure a transport can always make forward progress,
  * the number of RDMA segments allowed in header chunk lists
- * is capped at 8. This prevents less-capable devices and
- * memory registrations from overrunning the Send buffer
- * while building chunk lists.
+ * is capped at 16. This prevents less-capable devices from
+ * overrunning the Send buffer while building chunk lists.
  *
  * Elements of the Read list take up more room than the
- * Write list or Reply chunk. 8 read segments means the Read
- * list (or Write list or Reply chunk) cannot consume more
- * than
+ * Write list or Reply chunk. 16 read segments means the
+ * chunk lists cannot consume more than
  *
- * ((8 + 2) * read segment size) + 1 XDR words, or 244 bytes.
+ * ((16 + 2) * read segment size) + 1 XDR words,
  *
- * And the fixed part of the header is another 24 bytes.
- *
- * The smallest inline threshold is 1024 bytes, ensuring that
- * at least 750 bytes are available for RPC messages.
+ * or about 400 bytes. The fixed part of the header is
+ * another 24 bytes. Thus when the inline threshold is
+ * 1024 bytes, at least 600 bytes are available for RPC
+ * message bodies.
  */
 enum {
-	RPCRDMA_MAX_HDR_SEGS = 8,
-	RPCRDMA_HDRBUF_SIZE = 256,
+	RPCRDMA_MAX_HDR_SEGS = 16,
 };
 
 /*

