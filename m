Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497827B2C6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgI1RJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgI1RJ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:29 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4347C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:29 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so806676qvb.12
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1kCKc3IoQZq6eAPMW1QAyP6Judd54FV+ny15Qj8+pI=;
        b=MhyUYvOOShYk+ElnJbooF3oon3yVMzPKIUDYYYHeFCTXgBQq8aD+o1oSuZ68GFEmmA
         OYWzU0XZd/DR7eU855S2ekx6GWPT1LLAnyCwnfLuUIRp8OvHy+/hmLA2ugj3oYmAcKaK
         y+IcwR3zwlhT74N7Aov8J4KIbzB+oJFh7H7qvquT3eFgo7caWRdexRxQiQFUZXiSeKkd
         SIiF9obI3nnsxp2XNf9+by8SqdOsRA4jRVVKx6n88Nm7spjD/PiSeCOSqyrXJdgv+JJM
         049hJOEY3rquLT9CHL0fIrqC7VjdA/ub0oehQmeow8EO/FKU9dAFthKRpH/RNOl94oaS
         QZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q1kCKc3IoQZq6eAPMW1QAyP6Judd54FV+ny15Qj8+pI=;
        b=jHm+yP+V/IL14iTFuR6NuCcNmiE456ZceZA3IVWwO92hpa7ABb5UgmZxNmk0da/bkq
         613WzUL6yVUHgEYqU0KTc7vKIJu1rk+Z+jRZzvJEfOzI+q6MkdSb7j3FsElF8XPgIsRl
         obl7OtwA0veP0a1lkz3CF+bnWZbdqb4fpJMVvvKCH4WK/iUPO10KFJs5JMuPSidbmNDg
         8IbzMuQxmyWc1walaXy9lmWdiaG3fE0u56YaxDt1X6O2RF25AywSFVhHg+3nIzDXP+11
         cUkRM2hp7X2s76XT219kpGLEvqWIWdpBRoPnmvfYFsftTxbt7wuZFvZQ9zxepoqEoGjI
         bJwA==
X-Gm-Message-State: AOAM533f0CUS4yYhknez02g4UZ2NnQfSidDCmaAOzSXtV9Oj2MAZsoWG
        VXYxmBqFDKwOLhOG5EAcKA8zaPFBWeU=
X-Google-Smtp-Source: ABdhPJx1bUnZW5F3ZYkC4kA4RH36u8yb8ClHp0+yYY9P/JLlDRg1+BQE7kueq/jLkSuAv3MM/2UGdA==
X-Received: by 2002:a0c:b31c:: with SMTP id s28mr419064qve.17.1601312968682;
        Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 07/10] SUNRPC: Add the ability to expand holes in data pages
Date:   Mon, 28 Sep 2020 13:09:16 -0400
Message-Id: <20200928170919.707641-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This patch adds the ability to "read a hole" into a set of XDR data
pages by taking the following steps:

1) Shift all data after the current xdr->p to the right, possibly into
   the tail,
2) Zero the specified range, and
3) Update xdr->p to point beyond the hole.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 73 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 026edbd041d5..36a81c29542e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -252,6 +252,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index d8c9555c6f2b..24baf052e6e6 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -390,6 +390,42 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 }
 EXPORT_SYMBOL_GPL(_copy_from_pages);
 
+/**
+ * _zero_pages
+ * @pages: array of pages
+ * @pgbase: beginning page vector address
+ * @len: length
+ */
+static void
+_zero_pages(struct page **pages, size_t pgbase, size_t len)
+{
+	struct page **page;
+	char *vpage;
+	size_t zero;
+
+	page = pages + (pgbase >> PAGE_SHIFT);
+	pgbase &= ~PAGE_MASK;
+
+	do {
+		zero = PAGE_SIZE - pgbase;
+		if (zero > len)
+			zero = len;
+
+		vpage = kmap_atomic(*page);
+		memset(vpage + pgbase, 0, zero);
+		kunmap_atomic(vpage);
+
+		pgbase += zero;
+		if (pgbase == PAGE_SIZE) {
+			flush_dcache_page(*page);
+			pgbase = 0;
+			page++;
+		}
+
+	} while ((len -= zero) != 0);
+	flush_dcache_page(*page);
+}
+
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
@@ -1141,6 +1177,43 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
+uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t length)
+{
+	struct xdr_buf *buf = xdr->buf;
+	unsigned int bytes;
+	unsigned int from;
+	unsigned int truncated = 0;
+
+	if ((offset + length) < offset ||
+	    (offset + length) > buf->page_len)
+		length = buf->page_len - offset;
+
+	xdr_realign_pages(xdr);
+	from = xdr_page_pos(xdr);
+	bytes = xdr->nwords << 2;
+
+	if (offset + length + bytes > buf->page_len) {
+		unsigned int shift = (offset + length + bytes) - buf->page_len;
+		unsigned int res = _shift_data_right_tail(buf, from + bytes - shift, shift);
+		truncated = shift - res;
+		xdr->nwords -= XDR_QUADLEN(truncated);
+		bytes -= shift;
+	}
+
+	/* Now move the page data over and zero pages */
+	if (bytes > 0)
+		_shift_data_right_pages(buf->pages,
+					buf->page_base + offset + length,
+					buf->page_base + from,
+					bytes);
+	_zero_pages(buf->pages, buf->page_base + offset, length);
+
+	buf->len += length - (from - offset) - truncated;
+	xdr_set_page(xdr, offset + length, PAGE_SIZE);
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_expand_hole);
+
 /**
  * xdr_enter_page - decode data from the XDR page
  * @xdr: pointer to xdr_stream struct
-- 
2.28.0

