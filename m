Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2402C28AF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388589AbgKXNua (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388575AbgKXNua (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:30 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A52920888
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225829;
        bh=vVr7Ctb2zm7C6qsRF0nmjqqjxOoMzfEA86nB2IOr9+4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m3rDKXO3E9NcyWiQgZgsRaEiBMnYweeysBKoNLUXz2DADTVyE9NbGUDwYHgsFvUan
         1YHUoaPbDRXxHEpZpo4qypJY0XMXJ4pY2QGQ21FpNfg137heKLgUtaItsYsjhUAQwz
         7tIP62XTW67zI5bv63COgFy2G+En1XRWCqxmeIaQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/9] SUNRPC: Fix up xdr_read_pages() to take arbitrary object lengths
Date:   Tue, 24 Nov 2020 08:50:20 -0500
Message-Id: <20201124135025.1097571-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-4-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
 <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org>
 <20201124135025.1097571-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix up xdr_read_pages() so that it can handle object lengths that are
larger than the page length, by simply aligning to the next object in
the buffer tail.
The function will continue to return the length of the truncate object
data that actually fit into the pages.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 394297ec1cb9..3ce0a5daa9eb 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1219,44 +1219,33 @@ static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 }
 
 /**
- * xdr_read_pages - Ensure page-based XDR data to decode is aligned at current pointer position
+ * xdr_read_pages - align page-based XDR data to current pointer position
  * @xdr: pointer to xdr_stream struct
  * @len: number of bytes of page data
  *
  * Moves data beyond the current pointer position from the XDR head[] buffer
- * into the page list. Any data that lies beyond current position + "len"
- * bytes is moved into the XDR tail[].
+ * into the page list. Any data that lies beyond current position + @len
+ * bytes is moved into the XDR tail[]. The xdr_stream current position is
+ * then advanced past that data to align to the next XDR object in the tail.
  *
  * Returns the number of XDR encoded bytes now contained in the pages
  */
 unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 {
-	struct xdr_buf *buf = xdr->buf;
-	struct kvec *iov;
-	unsigned int nwords;
-	unsigned int end;
-	unsigned int padding;
+	unsigned int nwords = XDR_QUADLEN(len);
+	unsigned int base, end, pglen;
 
-	len = xdr_align_pages(xdr, len);
-	if (len == 0)
+	pglen = xdr_align_pages(xdr, nwords << 2);
+	if (pglen == 0)
 		return 0;
-	nwords = XDR_QUADLEN(len);
-	padding = (nwords << 2) - len;
-	xdr->iov = iov = buf->tail;
-	/* Compute remaining message length.  */
-	end = ((xdr->nwords - nwords) << 2) + padding;
-	if (end > iov->iov_len)
-		end = iov->iov_len;
 
-	/*
-	 * Position current pointer at beginning of tail, and
-	 * set remaining message length.
-	 */
-	xdr->p = (__be32 *)((char *)iov->iov_base + padding);
-	xdr->end = (__be32 *)((char *)iov->iov_base + end);
-	xdr->page_ptr = NULL;
-	xdr->nwords = XDR_QUADLEN(end - padding);
-	return len;
+	xdr->nwords -= nwords;
+	base = (nwords << 2) - pglen;
+	end = xdr_stream_remaining(xdr) - pglen;
+
+	if (xdr_set_iov(xdr, xdr->buf->tail, base, end) == 0)
+		xdr->nwords = 0;
+	return len <= pglen ? len : pglen;
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
-- 
2.28.0

