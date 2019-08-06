Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D51835CF
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfHFPyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:04 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33769 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbfHFPyE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:04 -0400
Received: by mail-oi1-f170.google.com with SMTP id u15so67323412oiv.0;
        Tue, 06 Aug 2019 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nZl3ab+1ccpxUAXXiUMhZzXP9wWLX3lENeAHjEhokuE=;
        b=ddUFsnYv/a+Z8V65XIGsbg75yVrpX0Z61GrkwNoRsVlHKdnoh9Lzdo8foWMCnPpdrb
         sFFOkA6SSNlcbzk0mAV7jsDVDkHdKpS98DVZdrnzqJKKHiGGQlxwg7+VFgY3+sZjTQdU
         znOPPMXvOeHei+PbbFyyx17ieoTGSppdzU/TB30lg6mBGPe8/DLEpXOXf6TQ3pZGnOHW
         a6HQXj3AnVkSHCku95YyIXGg5bTM3ZCwIvj7u0v8EftmohoPK3bwOJHp07LiuHCh6Tpu
         81f0WOjwLsM3bQi6K9KW6HG3dDAfSn2G4a+S3/KR0Jx9cmn7m0hj7d67+rpOdsUYrZNd
         4X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nZl3ab+1ccpxUAXXiUMhZzXP9wWLX3lENeAHjEhokuE=;
        b=fwquV2RwHF4WgjGMa6Auar8s+prbNhe/1y0M7kAWs5aZws6Jo1Z5f9DYkPq3jvlpxu
         P0ac0kl3ANuJBQ45eoU7nfeeqIK8lzDcbpD2m7lHavsxLRgKo24IEGi2tiDsfIu9+EmH
         oBGQcaC9Vl7KZ+JgmFhDiqAvsj6ZSyc+muiob+RG2zx3cDfrS8rhhgsbpKuXFX/RLsDt
         xritdkxR+vYEL2GdLwJ2Ez/YIghyK472todg9lJHJJmTwbAVs1q6D4JikFp/MkbhGofz
         Bk4EqFTCYeRG8zI6LGXfF/Y09RVt9cPsaPPqvfJ9QTKiaiTloSn+fNJJYmttGdV2MbD0
         r8pA==
X-Gm-Message-State: APjAAAXU6bsIkmQJzIT3zWYkn7pq9N3MJt7PZuhJb7hItDiHRHExRt1t
        RmzgQbWqfDvIKNM0zc4CwQOMGWqq
X-Google-Smtp-Source: APXvYqxO/iGPTAEN55+bTbIrF1NtcCgbd9hrhylG58ri1OSKw3Be/ppDG2GXT69zD9W6N9krmiikcQ==
X-Received: by 2002:a02:2245:: with SMTP id o66mr5040522jao.53.1565106843771;
        Tue, 06 Aug 2019 08:54:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r7sm63026837ioa.71.2019.08.06.08.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:03 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Fs2dp011520;
        Tue, 6 Aug 2019 15:54:02 GMT
Subject: [PATCH v1 03/18] xprtrdma: Boost maximum transport header size
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:02 -0400
Message-ID: <20190806155402.9529.80840.stgit@manet.1015granger.net>
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

Although I haven't seen any performance results that justify it,
I've received several complaints that NFS/RDMA no longer supports
a maximum rsize and wsize of 1MB. These days it is somewhat smaller.

To simplify the logic that determines whether a chunk list is
necessary, the implementation uses a fixed maximum size of the
transport header. Currently that maximum size is 256 bytes, one
quarter of the default inline threshold size for RPC/RDMA v1.

Since commit a78868497c2e ("xprtrdma: Reduce max_frwr_depth"), the
size of chunks is also smaller to take advantage of inline page
lists in MR data structures.

The combination of these two design choices has reduced the maximum
NFS rsize and wsize that can be used for most RNIC/HCAs. Increasing
the maximum transport header size and the maximum number of RDMA
segments it can contain increases the negotiated maximum rsize/wsize
on common RNIC/HCAs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/xprt_rdma.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 92ce09f..f9071fb 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -158,25 +158,24 @@ static inline void *rdmab_data(const struct rpcrdma_regbuf *rb)
 
 /* To ensure a transport can always make forward progress,
  * the number of RDMA segments allowed in header chunk lists
- * is capped at 8. This prevents less-capable devices and
+ * is capped at 12. This prevents less-capable devices and
  * memory registrations from overrunning the Send buffer
  * while building chunk lists.
  *
  * Elements of the Read list take up more room than the
- * Write list or Reply chunk. 8 read segments means the Read
- * list (or Write list or Reply chunk) cannot consume more
- * than
+ * Write list or Reply chunk. 12 read segments means the
+ * chunk lists cannot consume more than
  *
- * ((8 + 2) * read segment size) + 1 XDR words, or 244 bytes.
+ * ((12 + 2) * read segment size) + 1 XDR words, or 340 bytes.
  *
- * And the fixed part of the header is another 24 bytes.
+ * The fixed part of the header is another 24 bytes.
  *
  * The smallest inline threshold is 1024 bytes, ensuring that
- * at least 750 bytes are available for RPC messages.
+ * at least 650 bytes are available for RPC message bodies.
  */
 enum {
-	RPCRDMA_MAX_HDR_SEGS = 8,
-	RPCRDMA_HDRBUF_SIZE = 256,
+	RPCRDMA_MAX_HDR_SEGS = 12,
+	RPCRDMA_HDRBUF_SIZE = 512,
 };
 
 /*

