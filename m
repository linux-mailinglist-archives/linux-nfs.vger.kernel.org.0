Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3C2C33CB
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgKXWVw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbgKXWVw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 17:21:52 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED474C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 14:21:51 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id v11so245937qtq.12
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uflZTNZ655VnjdYJV7v5m6DZgn6sj0JFozBHUkBGz8A=;
        b=m9sY7QirQxjE1XExJuCsf1HqpiUq7iy1Ml1Ybz98l9x3ND9kUEd20kafZKPQmW5qo5
         QxM8L1eHV2vj2gfzJLkEHsTf8ig04oeoeJOQIm2pk1BYbir11+Gn7lqMtwRmtqrV5TPE
         2X0cTARePBLtS2GdKBDhv9wecahokvq8h4bfuPCLn1xSSuOHxDmQ3pZuVzH5+6WnoHRv
         W7AhLZkFPqk41O1MhU+jFE9N7Jfqq2+dp1mMTtYs1aqljMGUpWK0kEXTqQkZrESEm9+H
         /4JFMihIH50NG3YgyR7azkCFU/g/65dmT+LIaMGUwxwPWXXq66m4J/+WKU5B3TMdfbPZ
         RTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uflZTNZ655VnjdYJV7v5m6DZgn6sj0JFozBHUkBGz8A=;
        b=Q6YgihLVRWD0InMLpXgU3sSUeRZQQr3Y8AQE5HlrYwjsvALsGQ/mXo42WyyUhu+aNx
         Q4M1kx9NiBfkQlqhGgAZkLY6YFULSJxMygf8L/s/Du1AaSAc8cpCvKxLg8gVYQHUzzc9
         Lni5UUBgoPs1j7lXC6kYOQnqpA6oVHwe/4UGdYIL3l2P0YBc/J/u3ZWaZE83Hdq3Xxhq
         ITR3aCRIQ0bsSTAnUm7P0YYow6JRq2MmE0zqFxk4WKIwFIps50bJPJCIDW0IBYeyLBCq
         8N8KzaVTRo914ObhYwp95ss8dBG7j7ZigRHvzy2JYLxejX+ulSlKP0mvScaPt86Rkg0L
         563g==
X-Gm-Message-State: AOAM531sGv+dSAo4KvM2WE0Yi9fHQjuYRN3ucfqNAh+vDs1Q8f+KZGNA
        c+4YLT+naFAoJjH4dCA6vi1tp9dVg98=
X-Google-Smtp-Source: ABdhPJzUcK7o3UhGdYqqIfC69HyOEbapiCMNMrHCckFqYZqGvjBibPu1BlukGdnr4Ss2jjdbSOmsjA==
X-Received: by 2002:ac8:75da:: with SMTP id z26mr328650qtq.36.1606256511227;
        Tue, 24 Nov 2020 14:21:51 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b186sm552489qkc.111.2020.11.24.14.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 14:21:50 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AOMLl27013438;
        Tue, 24 Nov 2020 22:21:48 GMT
Subject: [PATCH v2] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 24 Nov 2020 17:21:47 -0500
Message-ID: <160625644245.1700.17147462039179289248.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By switching to an XFS-backed export, I am able to reproduce the
ibcomp worker crash on my client with xfstests generic/013.

For the failing LISTXATTRS operation, xdr_inline_pages() is called
with page_len=12 and buflen=128.

- When ->send_request() is called, rpcrdma_marshal_req() does not
  set up a Reply chunk because buflen is smaller than the inline
  threshold. Thus rpcrdma_convert_iovs() does not get invoked at
  all and the transport's XDRBUF_SPARSE_PAGES logic is not invoked
  on the receive buffer.

- During reply processing, rpcrdma_inline_fixup() tries to copy
  received data into rq_rcv_buf->pages because page_len is positive.
  But there are no receive pages because rpcrdma_marshal_req() never
  allocated them.

The result is that the ibcomp worker faults and dies. Sometimes that
causes a visible crash, and sometimes it results in a transport hang
without other symptoms.

RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
should eventually be fixed or replaced. However, my preference is
that upper-layer operations should explicitly allocate their receive
buffers (using GFP_KERNEL) when possible, rather than relying on
XDRBUF_SPARSE_PAGES.

Reported-by: Olga kornievskaia <kolga@netapp.com>
Suggested-by: Olga kornievskaia <kolga@netapp.com>
Fixes: c10a75145feb ("NFSv4.2: add the extended attribute proc functions.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Olga kornievskaia <kolga@netapp.com>
Reviewed-by: Frank van der Linden <fllinden@amazon.com>
Tested-by: Olga kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c |   17 ++++++++++-------
 fs/nfs/nfs42xdr.c  |    1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

Changes since v1:
- Added a Fixes: tag
- Added Reviewed-by:, etc tags
- Clarified the patch description


diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 2b2211d1234e..24810305ec1c 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 		.rpc_resp	= &res,
 	};
 	u32 xdrlen;
-	int ret, np;
+	int ret, np, i;
 
 
 	res.scratch = alloc_page(GFP_KERNEL);
@@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 		xdrlen = server->lxasize;
 	np = xdrlen / PAGE_SIZE + 1;
 
+	ret = -ENOMEM;
 	pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
-	if (pages == NULL) {
-		__free_page(res.scratch);
-		return -ENOMEM;
+	if (pages == NULL)
+		goto out_free;
+	for (i = 0; i < np; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		if (!pages[i])
+			goto out_free;
 	}
 
 	arg.xattr_pages = pages;
@@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 		*eofp = res.eof;
 	}
 
+out_free:
 	while (--np >= 0) {
 		if (pages[np])
 			__free_page(pages[np]);
 	}
-
-	__free_page(res.scratch);
 	kfree(pages);
-
+	__free_page(res.scratch);
 	return ret;
 
 }
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..8432bd6b95f0 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
 
 	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
 	    hdr.replen);
-	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
 
 	encode_nops(&hdr);
 }


