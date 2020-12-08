Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0772D36E8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgLHX3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 18:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbgLHX3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 18:29:46 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0760C0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  8 Dec 2020 15:29:05 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so87375qtp.7
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 15:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Jmb0gSG/43+BZJiQw2//f4H8QSVAD2TC/ZjKOe2CY0k=;
        b=Ol9xOo+wfCNEyRpGZzPL9UG23xzfHgv7u+8UeztFHtvGJvABi5C9xPinn3nTiKwUHt
         JJKcdl6k0KalnEVigjh5o1sgFyNluotKCg5TmVJDg+3zIaMGEyVuq2GvbJgo0ttd3buy
         a/N8trje/Tqb3TW+vY0Xn99il+ja63C7rsGymbKrkv8IGiByN0wzNdBa9p3iIiGdEWzl
         Nj1t78MVHdIlw4sJ19ZOWAmhSixG0MSQxwGzWQJ9y0mBb5k16WqkVL+j7JtmQm+D4a3U
         RsrcQQdI6BAE0vxytiC6sB8vZ2T3ap4JAMjt3667BPKqomhxfiLWIdMDOndYSyIbWqZA
         gZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Jmb0gSG/43+BZJiQw2//f4H8QSVAD2TC/ZjKOe2CY0k=;
        b=Qw9bQDajS0c+21T7P9p755Ld6nai2NCApB5K0wlPvXKOxDENx+YxiEvV3UcWekzlY9
         fH52rY4MV6taJU/kp6hLNPQWD5cVPu00q2U/JdoxLQcjjG/G1P/bdKiFtxGIfdC0xndD
         nFWD97tMKtEqS8lDgUT42hBLnOJWq9N7JXK/vsJAyFIorc9FLZkka9LW2qPY4CIyQsTU
         YhOgwLRBt7AIstnnnd79jvWE7grV5We2HVP+WpwFr79hxtwaUE5nNk20BsNirrrV6L6D
         GlGExl3aIAH8cl/9ROkVAOIWVMidLeK7s2BAe2CHFazB15hsmjaIK6XHC5jdp6gXTmuF
         6HcQ==
X-Gm-Message-State: AOAM533GHR/WJHRRsjL0aBuL5G5MnboFY5ZI7iN/sDV4JT3/NN2N/mUD
        raoFAU/tzYnZceqNKxXIxNRW7m+T5go=
X-Google-Smtp-Source: ABdhPJwaI5lmWTKmVhwByEdEKY571N75wyVCu64YSl8OKaFwWQ/yNvcicA4/OUHA3ysM3bhts84UXA==
X-Received: by 2002:ac8:6bd8:: with SMTP id b24mr552028qtt.261.1607470144793;
        Tue, 08 Dec 2020 15:29:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 60sm230964qth.14.2020.12.08.15.29.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 15:29:03 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0B8NT2m6018876
        for <linux-nfs@vger.kernel.org>; Tue, 8 Dec 2020 23:29:02 GMT
Subject: [PATCH v5] xprtrdma: Fix XDRBUF_SPARSE_PAGES support
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 08 Dec 2020 18:29:02 -0500
Message-ID: <160746979784.1926.1490061321200284214.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga K. observed that rpcrdma_marsh_req() allocates sparse pages
only when it has determined that a Reply chunk is necessary. There
are plenty of cases where no Reply chunk is needed, but the
XDRBUF_SPARSE_PAGES flag is set. The result would be a crash in
rpcrdma_inline_fixup() when it tries to copy parts of the received
Reply into a missing page.

To avoid crashing, handle sparse page allocation up front.

Until XATTR support was added, this issue did not appear often
because the only SPARSE_PAGES consumer always expected a reply large
enough to always require a Reply chunk.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |   40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

Hi-

v4 had a bug, which I've fixed. This version has been tested.

In kernels before 5.10-rc5, there are still problems with the way
LISTXATTRS and GETXATTR deal with the tail / XDR pad for the page
content that this patch does not address. So backporting this fix
alone is not enough to get those working again -- more surgery would
be required.

Since none of the other SPARSE_PAGES users have a problem, let's
leave this one on the cutting room floor. It's here in the mail
archive if anyone needs it.


Changes since v4:
- xdr_buf_pagecount() was simply the wrong thing to use.

Changes since v3:
- I swear I am not drunk. I forgot to commit the change before mailing it.

Changes since v2:
- Actually fix the xdr_buf_pagecount() problem

Changes since RFC:
- Ensure xdr_buf_pagecount() is defined in rpc_rdma.c
- noinline the sparse page allocator -- it's an uncommon path

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 0f5120c7668f..c48536f2121f 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -179,6 +179,31 @@ rpcrdma_nonpayload_inline(const struct rpcrdma_xprt *r_xprt,
 		r_xprt->rx_ep->re_max_inline_recv;
 }
 
+/* ACL likes to be lazy in allocating pages. For TCP, these
+ * pages can be allocated during receive processing. Not true
+ * for RDMA, which must always provision receive buffers
+ * up front.
+ */
+static noinline int
+rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
+{
+	struct page **ppages;
+	int len;
+
+	len = buf->page_len;
+	ppages = buf->pages + (buf->page_base >> PAGE_SHIFT);
+	while (len > 0) {
+		if (!*ppages)
+			*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
+		if (!*ppages)
+			return -ENOBUFS;
+		ppages++;
+		len -= PAGE_SIZE;
+	}
+
+	return 0;
+}
+
 /* Split @vec on page boundaries into SGEs. FMR registers pages, not
  * a byte range. Other modes coalesce these SGEs into a single MR
  * when they can.
@@ -233,15 +258,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 	ppages = xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
 	page_base = offset_in_page(xdrbuf->page_base);
 	while (len) {
-		/* ACL likes to be lazy in allocating pages - ACLs
-		 * are small by default but can get huge.
-		 */
-		if (unlikely(xdrbuf->flags & XDRBUF_SPARSE_PAGES)) {
-			if (!*ppages)
-				*ppages = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
-			if (!*ppages)
-				return -ENOBUFS;
-		}
 		seg->mr_page = *ppages;
 		seg->mr_offset = (char *)page_base;
 		seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
@@ -867,6 +883,12 @@ rpcrdma_marshal_req(struct rpcrdma_xprt *r_xprt, struct rpc_rqst *rqst)
 	__be32 *p;
 	int ret;
 
+	if (unlikely(rqst->rq_rcv_buf.flags & XDRBUF_SPARSE_PAGES)) {
+		ret = rpcrdma_alloc_sparse_pages(&rqst->rq_rcv_buf);
+		if (ret)
+			return ret;
+	}
+
 	rpcrdma_set_xdrlen(&req->rl_hdrbuf, 0);
 	xdr_init_encode(xdr, &req->rl_hdrbuf, rdmab_data(req->rl_rdmabuf),
 			rqst);


