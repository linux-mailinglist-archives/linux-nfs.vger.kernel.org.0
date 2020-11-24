Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7B2C2E7B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbgKXR0i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390825AbgKXR0h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 12:26:37 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A555C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 09:26:36 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so10948860qvt.12
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FoYL/EEkbVFQiXWBPZxKXa/v5a5hPltOgFYCHAn3kqg=;
        b=o0wMRljeE6A/ihGmtyIaqAGAa6loi/qNei47Ct8cE5H3ZaLgud6bWnmcNivlAKUJlM
         abDbZRLPPoHPybfPP8ppwPlMe1lkJ7WImXhwCvqqjMpKTwBBP04wAaekURmelCQmNCWw
         Ab1/MuMdg1PI7yrjcGkZJdJOuu3VlTw3ubYkZd136JlzNagAcqEnbUO4FH8YnC+/6qHf
         +LxFBh+d1+Z/OSkdigW7slzVpoZx5f14CfhS4bZNd89zK0vKECxKpDVd4CpVMmiKQPBA
         Ic7oAPlAnDjodaro830ebT7XfrSKnkZvxnkuGcxcDkicehHxg9n6QDwkX7ubSJBAc1wp
         s2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FoYL/EEkbVFQiXWBPZxKXa/v5a5hPltOgFYCHAn3kqg=;
        b=LKmWhXjDMeA5NWxzBrACxYU1qAPACR1tEroDSHHQg5FLkSijBeml5JyLJPRQQkJtrF
         mja4FL0cTQbvGEmzcYlYRvkAYjX1BmSDP/cTHs21tWuj/o0AMZ4sweYIxpnBFkBnF2xj
         6ZlywBuR7lRj1vkN8uA+wAVX/6y3Y+BmhXQmcLMS+5LqyoBFIpovIas1IoHkmsmBbyOc
         d4kmIALUW2Agb2lkvNj4lDFLp/zS7XdSCs4gEt2YUG2Dk41wWwAGbTrOOWfuL4DWksrT
         1sFARrh4cNfW+9a72LWmZlznYzsMXeTqsVrGjIWXtCQpqWW+EACaifqtjtovuI+gtkz/
         a5LQ==
X-Gm-Message-State: AOAM533Q1kuYODQsz1Th39cL5Hq9LMbX2gJv4q0Ir3+WO7XQQAHesJAK
        yvJUaWhoZdj+Nmw6F82k0sgvQbvw94Y=
X-Google-Smtp-Source: ABdhPJwkzf+CL5hM8olAL5RI9hd+PRktUzQrIG+/UsUGYzPRXEtSCOBVkqtsf8upJGqpAghVxqaBgg==
X-Received: by 2002:ad4:4051:: with SMTP id r17mr5717109qvp.39.1606238795242;
        Tue, 24 Nov 2020 09:26:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o9sm13716055qte.35.2020.11.24.09.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:26:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AOHQWXF012968;
        Tue, 24 Nov 2020 17:26:32 GMT
Subject: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com, fllinden@amazon.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 24 Nov 2020 12:26:32 -0500
Message-ID: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
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
with page_len=12 and buflen=128. Then:

- Because buflen is small, rpcrdma_marshal_req will not set up a
  Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
  get invoked at all.

- Because page_len is non-zero, rpcrdma_inline_fixup() tries to
  copy received data into rq_rcv_buf->pages, but they're missing.

The result is that the ibcomp worker faults and dies. Sometimes that
causes a visible crash, and sometimes it results in a transport
hang without other symptoms.

RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
should eventually be fixed or replaced. However, my preference is
that upper-layer operations should explicitly allocate their receive
buffers (using GFP_KERNEL) when possible, rather than relying on
XDRBUF_SPARSE_PAGES.

Reported-by: Olga kornievskaia <kolga@netapp.com>
Suggested-by: Olga kornievskaia <kolga@netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |   17 ++++++++++-------
 fs/nfs/nfs42xdr.c  |    1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

Hi-

I like Olga's proposed approach. What do you think of this patch?


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


