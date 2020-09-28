Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED06027B2B7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1RJG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1RJG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B4C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x201so1251839qkb.11
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRSuIdkk6ALMTWDJIFlzdvg+Fc3EiYObmZAafS+1zAY=;
        b=L4YjAAyWUj9M5gFdNwv7whH2YtgoXq2qAp+G7A9mRWS6NpWwPPvCjrWEX1F42jWmHL
         JBdO7vhM4cXgGQnlwn9tXvBDR6jN6+S+lp5gv9JAYPZocXpbfl3tO/SnOEgmQY957fvW
         +IlpvaBhe+OYuHEsJ1aqgWAHeF5VfTTG7nxDwBWBaoCMJtOn0MkuxakZBt7QRXwJXGrj
         cQ7jzynhpx/TOkJAOvTEs8ACDLwgFUarQ921Fb8tDyPSwQ50eBeRZxI1fZhQtK7AHs4U
         dElse7B/sBa0n5Z7D1kJ1n4iUlbl4TSANAUBbhWjL8jG5XCkUAxDRiXm6pLNaxcUO0I9
         uHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FRSuIdkk6ALMTWDJIFlzdvg+Fc3EiYObmZAafS+1zAY=;
        b=Q4EWvVBWK+b/JSOF+eTqZzOrb/0Aa56xoSzefQSl9c36NHIKPIYY4QRpL6DjkLhKa7
         uEmCYxmf+2oXevX0tamjUazDrARxysJKUr46rQjfIgfhMEC/gJ07rDvd2nMe1Y9T25+r
         6EVwM4AbGOMd3t8oZV02T0mrIbEmLSDUhm07Rx08DqF9aaJ53pXqNTBHBM5Hp5YJl86K
         aFPvN6SOnzUPgLL1TkXQf6gUYUyK1MGAtxwu4xcLXZ3krmBjFwD3xygABK555YgbqIqU
         81X53a5+F/wIkoa7RWdp01Yl41aIEZSgz4XFqulX1pDkmeZZTGQNHVmNv7l2ehQlrSJJ
         rGsw==
X-Gm-Message-State: AOAM530QeVv4U7Yt2fH8qnvml3A0yT0n7dFM+QuxC+3fanmR2Dq4SYPp
        54uyNDyuyb5mioY46+tvYd4=
X-Google-Smtp-Source: ABdhPJzQqUrysQVS/FUNetrYTVr3P1lGeHYgtL3+QM3Ai7YEQiDH1nophDXEMJGXFKElregykXetIw==
X-Received: by 2002:a37:7687:: with SMTP id r129mr454691qkc.264.1601312944812;
        Mon, 28 Sep 2020 10:09:04 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k20sm2011631qtb.34.2020.09.28.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:04 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 1/5] SUNRPC/NFSD: Implement xdr_reserve_space_vec()
Date:   Mon, 28 Sep 2020 13:08:57 -0400
Message-Id: <20200928170901.707554-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
References: <20200928170901.707554-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Reserving space for a large READ payload requires special handling when
reserving space in the xdr buffer pages. One problem we can have is use
of the scratch buffer, which is used to get a pointer to a contiguous
region of data up to PAGE_SIZE. When using the scratch buffer, calls to
xdr_commit_encode() shift the data to it's proper alignment in the xdr
buffer. If we've reserved several pages in a vector, then this could
potentially invalidate earlier pointers and result in incorrect READ
data being sent to the client.

I get around this by looking at the amount of space left in the current
page, and never reserve more than that for each entry in the read
vector. This lets us place data directly where it needs to go in the
buffer pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c          | 28 +++---------------------
 include/linux/sunrpc/xdr.h |  2 ++
 net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 259d5ad0e3f4..0be194de4888 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3814,36 +3814,14 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	u32 eof;
-	int v;
 	int starting_len = xdr->buf->len - 8;
-	long len;
-	int thislen;
 	__be32 nfserr;
 	__be32 tmp;
-	__be32 *p;
 	int pad;
 
-	/*
-	 * svcrdma requires every READ payload to start somewhere
-	 * in xdr->pages.
-	 */
-	if (xdr->iov == xdr->buf->head) {
-		xdr->iov = NULL;
-		xdr->end = xdr->p;
-	}
-
-	len = maxcount;
-	v = 0;
-	while (len) {
-		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, thislen);
-		WARN_ON_ONCE(!p);
-		resp->rqstp->rq_vec[v].iov_base = p;
-		resp->rqstp->rq_vec[v].iov_len = thislen;
-		v++;
-		len -= thislen;
-	}
-	read->rd_vlen = v;
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	if (read->rd_vlen < 0)
+		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 5a6a81b7cd9f..6613d96a3029 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -234,6 +234,8 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
+extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
+		size_t nbytes);
 extern void xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
 extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index be11d672b5b9..6dfe5dc8b35f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -648,6 +648,51 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space);
 
+
+/**
+ * xdr_reserve_space_vec - Reserves a large amount of buffer space for sending
+ * @xdr: pointer to xdr_stream
+ * @vec: pointer to a kvec array
+ * @nbytes: number of bytes to reserve
+ *
+ * Reserves enough buffer space to encode 'nbytes' of data and stores the
+ * pointers in 'vec'. The size argument passed to xdr_reserve_space() is
+ * determined based on the number of bytes remaining in the current page to
+ * avoid invalidating iov_base pointers when xdr_commit_encode() is called.
+ */
+int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbytes)
+{
+	int thislen;
+	int v = 0;
+	__be32 *p;
+
+	/*
+	 * svcrdma requires every READ payload to start somewhere
+	 * in xdr->pages.
+	 */
+	if (xdr->iov == xdr->buf->head) {
+		xdr->iov = NULL;
+		xdr->end = xdr->p;
+	}
+
+	while (nbytes) {
+		thislen = xdr->buf->page_len % PAGE_SIZE;
+		thislen = min_t(size_t, nbytes, PAGE_SIZE - thislen);
+
+		p = xdr_reserve_space(xdr, thislen);
+		if (!p)
+			return -EIO;
+
+		vec[v].iov_base = p;
+		vec[v].iov_len = thislen;
+		v++;
+		nbytes -= thislen;
+	}
+
+	return v;
+}
+EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
+
 /**
  * xdr_truncate_encode - truncate an encode buffer
  * @xdr: pointer to xdr_stream
-- 
2.28.0

