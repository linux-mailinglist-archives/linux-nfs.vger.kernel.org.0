Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61F2C3546
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 01:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKYAPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 19:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgKYAPW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 19:15:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F3C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 16:15:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so1346227qkb.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sZl4sBzNeDguTPghqRriwFRwqZhZHUkrmcAeW2hMHas=;
        b=hbPAikLuULhUWypcc9b+7tP+lcEIerO2GXy3CGnr7/hGQPDvZ1bKkcjVgUuG4mw6/C
         edYVmbfH5qCvi6CNu1Oa3dany3S3u8jQWMODHBsOFO5QYVdf2Spq6s10GZTA5z+JwrBf
         z12M7ymg1SQVkG54PJJm8By6bPjp7oqWoArTM0mhGB87OzmgG0PGnUCmjli5M8Dp2T5P
         u/mJUBX8NXQxS6i/1h4RJIUmpPKz6gPXIh3ZlyDsdmaIaRt0feGDDyxH9Hv1fSftGVSR
         oQrsDmxxf1kt4QFcCvUJmfaf5SQo9/0lo0/dsEIdUFyiYjfP0vqpBzgngev8lzFkouGf
         uzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sZl4sBzNeDguTPghqRriwFRwqZhZHUkrmcAeW2hMHas=;
        b=gyuMcJGBz/Tf/G5vE781/OVbdIidtRLUutBuJfJqtr4eof6z1lRMk+0QD7CnM6wIKk
         5VeVt8sCpY2Eh7Onujz0m+c9BKkjKSnpKgl9eNVDafrrYxgH8bRxA/xPbSoUiSmgIwKw
         ScHnmgvb1jbyA3rGxmkJnqqlCobxJdo0QvVwi++NV+AFxLS8SvRkdlpb+eQkHZm9V6x1
         ehQkv+GhOZ+tqpoLa/JCS0PSWUeHWihXmO4yNFjgV8dsCoYfnwZUlM0f7ZmCHcjIgFkK
         W5SBTC3Ha3E+fHOvRBRQ667II5YplgPC8v5nxX1ySmpHyYzku6aM1qBz6e8miO4AMdnj
         wOYA==
X-Gm-Message-State: AOAM530QonVWoCzDTKSK7HuDCVBEkkUDuUB1UMi3FAgkxQADiQG6gp7O
        dVw9wPT4+sGdp4PNn9j1wKA7C10P6hM=
X-Google-Smtp-Source: ABdhPJyP+4UDXEHD92GgbmaPABo7tCgWp+cPZ7joZZP9TrLk+Iejst/taML0wsa8kYT/6a/TAJ3ZhQ==
X-Received: by 2002:a37:c4d:: with SMTP id 74mr918936qkm.161.1606263321417;
        Tue, 24 Nov 2020 16:15:21 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g9sm672144qti.86.2020.11.24.16.15.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 16:15:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AP0FIkS013640;
        Wed, 25 Nov 2020 00:15:19 GMT
Subject: [PATCH v3] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 24 Nov 2020 19:15:18 -0500
Message-ID: <160626327581.1030838.17345495464569858084.stgit@manet.1015granger.net>
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
 fs/nfs/nfs42proc.c |   21 +++++++++++++--------
 fs/nfs/nfs42xdr.c  |    1 -
 2 files changed, 13 insertions(+), 9 deletions(-)

Changes since v2:
- On error, unwind the memory allocations correctly

Changes since v1:
- Added a Fixes: tag
- Added Reviewed-by:, etc tags
- Clarified the patch description

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 2b2211d1234e..4fc61e3d098d 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1241,12 +1241,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 		.rpc_resp	= &res,
 	};
 	u32 xdrlen;
-	int ret, np;
+	int ret, np, i;
 
 
+	ret = -ENOMEM;
 	res.scratch = alloc_page(GFP_KERNEL);
 	if (!res.scratch)
-		return -ENOMEM;
+		goto out;
 
 	xdrlen = nfs42_listxattr_xdrsize(buflen);
 	if (xdrlen > server->lxasize)
@@ -1254,9 +1255,12 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 	np = xdrlen / PAGE_SIZE + 1;
 
 	pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
-	if (pages == NULL) {
-		__free_page(res.scratch);
-		return -ENOMEM;
+	if (!pages)
+		goto out_free_scratch;
+	for (i = 0; i < np; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		if (!pages[i])
+			goto out_free_pages;
 	}
 
 	arg.xattr_pages = pages;
@@ -1271,14 +1275,15 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 		*eofp = res.eof;
 	}
 
+out_free_pages:
 	while (--np >= 0) {
 		if (pages[np])
 			__free_page(pages[np]);
 	}
-
-	__free_page(res.scratch);
 	kfree(pages);
-
+out_free_scratch:
+	__free_page(res.scratch);
+out:
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


