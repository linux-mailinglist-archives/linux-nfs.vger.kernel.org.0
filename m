Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451202D7CDD
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbgLKR1u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395226AbgLKR0o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:44 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/15] SUNRPC: When expanding the buffer, we may need grow the sparse pages
Date:   Fri, 11 Dec 2020 12:25:14 -0500
Message-Id: <20201211172521.5567-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-8-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
 <20201211172521.5567-7-trondmy@kernel.org>
 <20201211172521.5567-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're shifting the page data to the right, and this happens to be a
sparse page array, then we may need to allocate new pages in order to
receive the data.

Reported-by: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 2e91fbd70f11..60d4442c5273 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -478,16 +478,47 @@ static void xdr_buf_pages_zero(const struct xdr_buf *buf, unsigned int pgbase,
 	} while ((len -= zero) != 0);
 }
 
+static unsigned int xdr_buf_pages_fill_sparse(const struct xdr_buf *buf,
+					      unsigned int buflen, gfp_t gfp)
+{
+	unsigned int i, npages, pagelen;
+
+	if (!(buf->flags & XDRBUF_SPARSE_PAGES))
+		return buflen;
+	if (buflen <= buf->head->iov_len)
+		return buflen;
+	pagelen = buflen - buf->head->iov_len;
+	if (pagelen > buf->page_len)
+		pagelen = buf->page_len;
+	npages = (pagelen + buf->page_base + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	for (i = 0; i < npages; i++) {
+		if (!buf->pages[i])
+			continue;
+		buf->pages[i] = alloc_page(gfp);
+		if (likely(buf->pages[i]))
+			continue;
+		buflen -= pagelen;
+		pagelen = i << PAGE_SHIFT;
+		if (pagelen > buf->page_base)
+			buflen += pagelen - buf->page_base;
+		break;
+	}
+	return buflen;
+}
+
 static void xdr_buf_try_expand(struct xdr_buf *buf, unsigned int len)
 {
 	struct kvec *head = buf->head;
 	struct kvec *tail = buf->tail;
 	unsigned int sum = head->iov_len + buf->page_len + tail->iov_len;
-	unsigned int free_space;
+	unsigned int free_space, newlen;
 
 	if (sum > buf->len) {
 		free_space = min_t(unsigned int, sum - buf->len, len);
-		buf->len += free_space;
+		newlen = xdr_buf_pages_fill_sparse(buf, buf->len + free_space,
+						   GFP_KERNEL);
+		free_space = newlen - buf->len;
+		buf->len = newlen;
 		len -= free_space;
 		if (!len)
 			return;
-- 
2.29.2

