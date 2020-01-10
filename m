Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C31379C0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgAJWfD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:03 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40045 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJWfD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:03 -0500
Received: by mail-yb1-f194.google.com with SMTP id a2so1369977ybr.7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJAMBzd0CbZgEWxhF4EyEF9/gedk9FYBS1Ahvh4ZpUQ=;
        b=Vs0q/JcHPVt2YUTrvyHD3pyxbm3Bj2yuZdSlm5VdcoR1bIOQSLfIt8ghOvN+SByxoK
         EP58eaiZmJY+948U95B1y9uiyB6EQztzSt2VI0ZVOoeYjj28MWb9GVHSMnc2BnUGpNT0
         /bLa7Bj5W86h4FeCMzzpBNiGjMHPiExDtPcSP9s3kIg1trZbONayrE5GgzV4q+ax7nyK
         t1gBfLVJjGqPlXPoS4kocz1qG6cNJvRY9cXZyJU8NWJsEA07NX5PGp7/FKckkflWuCcr
         wYVZNvoPhBsFYHn4SkSj6foeDuE8agXLuzIvwd9k+rNBeJB6QEbW9M2EmSX8bA+UCc2H
         VEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bJAMBzd0CbZgEWxhF4EyEF9/gedk9FYBS1Ahvh4ZpUQ=;
        b=Jkq231dc6Qna4BuhUm71qjZBwXavYZULj0NnEci0gvbtGgTY7y60zsTEXX9x2jKzBH
         7ETlafivyc76bMq+uO18PoW1bK9ke/MKhyOth2fKjje2y4sf/u5qVhFAh7Xr2193QJWz
         z799xQAKrUBPnGY4LzC3LVUgwnwcAZRcaGWbBSyXpntpRLDdQA87VrzcZANbcXYobqTL
         6Qk1HM6YpU5iP3UC9OzPlQPblLYIuEUyZCSk78+XMmVJo4xzeP5yGkjWg5XWbqhMQDqv
         pFWShJlEBhWdD9sEFBO7RtONEb2sFSPNkXrhGzmEN9bNPGa6tlO2WpXCkSj2T1Zu4fh6
         UTUg==
X-Gm-Message-State: APjAAAU18Ccbds+y1nEc1SRTBVbLkFwq57GDkV9fh8v/DqL81bXKvpJw
        e6aocA5wLbqYTYjQzL0Pkvk=
X-Google-Smtp-Source: APXvYqxc16Kg/oHPk6WI6Umi10q1bhZO4PTV76znoCJtRnNSY1o8RMlYQ0E6Lns5eac/0cQQZ7aWsA==
X-Received: by 2002:a25:dcc8:: with SMTP id y191mr3298837ybe.103.1578695701938;
        Fri, 10 Jan 2020 14:35:01 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:00 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/7] SUNRPC: Add the ability to shift data to a specific offset
Date:   Fri, 10 Jan 2020 17:34:51 -0500
Message-Id: <20200110223455.528471-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Expanding holes tends to put the data content a few bytes to the right
of where we want it.  This patch implements a left-shift operation to
line everything up properly.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |   1 +
 net/sunrpc/xdr.c           | 135 +++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 81a79099ed3b..90abf732c8ee 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -264,6 +264,7 @@ extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern size_t xdr_expand_hole(struct xdr_stream *, size_t, uint64_t);
+extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint64_t);
 
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index bc9b9b0945f5..a857c2308ee1 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -19,6 +19,9 @@
 #include <linux/bvec.h>
 #include <trace/events/sunrpc.h>
 
+static void _copy_to_pages(struct page **, size_t, const char *, size_t);
+
+
 /*
  * XDR functions for basic NFS types
  */
@@ -300,6 +303,117 @@ _shift_data_right(struct xdr_buf *buf, size_t to, size_t from, size_t len)
 				shift);
 }
 
+
+/**
+ * _shift_data_left_pages
+ * @pages: vector of pages containing both the source and dest memory area.
+ * @pgto_base: page vector address of destination
+ * @pgfrom_base: page vector address of source
+ * @len: number of bytes to copy
+ *
+ * Note: the addresses pgto_base and pgfrom_base are both calculated in
+ *       the same way:
+ *            if a memory area starts at byte 'base' in page 'pages[i]',
+ *            then its address is given as (i << PAGE_CACHE_SHIFT) + base
+ * Alse note: pgto_base must be < pgfrom_base, but the memory areas
+ * 	they point to may overlap.
+ */
+static void
+_shift_data_left_pages(struct page **pages, size_t pgto_base,
+			size_t pgfrom_base, size_t len)
+{
+	struct page **pgfrom, **pgto;
+	char *vfrom, *vto;
+	size_t copy;
+
+	BUG_ON(pgfrom_base <= pgto_base);
+
+	pgto = pages + (pgto_base >> PAGE_SHIFT);
+	pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
+
+	pgto_base = pgto_base % PAGE_SIZE;
+	pgfrom_base = pgfrom_base % PAGE_SIZE;
+
+	do {
+		if (pgto_base >= PAGE_SIZE) {
+			pgto_base = 0;
+			pgto++;
+		}
+		if (pgfrom_base >= PAGE_SIZE){
+			pgfrom_base = 0;
+			pgfrom++;
+		}
+
+		copy = len;
+		if (copy > (PAGE_SIZE - pgto_base))
+			copy = PAGE_SIZE - pgto_base;
+		if (copy > (PAGE_SIZE - pgfrom_base))
+			copy = PAGE_SIZE - pgfrom_base;
+
+		if (pgto_base == 131056)
+			break;
+
+		vto = kmap_atomic(*pgto);
+		if (*pgto != *pgfrom) {
+			vfrom = kmap_atomic(*pgfrom);
+			memcpy(vto + pgto_base, vfrom + pgfrom_base, copy);
+			kunmap_atomic(vfrom);
+		} else
+			memmove(vto + pgto_base, vto + pgfrom_base, copy);
+		flush_dcache_page(*pgto);
+		kunmap_atomic(vto);
+
+		pgto_base += copy;
+		pgfrom_base += copy;
+
+	} while ((len -= copy) != 0);
+}
+
+static void
+_shift_data_left_tail(struct xdr_buf *buf, size_t pgto_base,
+		      size_t tail_from, size_t len)
+{
+	struct kvec *tail = buf->tail;
+	size_t shift = len;
+
+	if (len == 0)
+		return;
+	if (pgto_base + len > buf->page_len)
+		shift = buf->page_len - pgto_base;
+
+	_copy_to_pages(buf->pages,
+			buf->page_base + pgto_base,
+			(char *)(tail->iov_base + tail_from),
+			shift);
+
+	memmove((char *)tail->iov_base, tail->iov_base + tail_from + shift, shift);
+	tail->iov_len -= (tail_from + shift);
+}
+
+static void
+_shift_data_left(struct xdr_buf *buf, size_t to, size_t from, size_t len)
+{
+	size_t shift = len;
+
+	if (from < buf->page_len) {
+		shift = min(len, buf->page_len - from);
+		_shift_data_left_pages(buf->pages,
+					buf->page_base + to,
+					buf->page_base + from,
+					shift);
+		to += shift;
+		from += shift;
+		shift = len - shift;
+	}
+
+	if (shift == 0)
+		return;
+	if (from >= buf->page_len)
+		from -= buf->page_len;
+
+	_shift_data_left_tail(buf, to, from, shift);
+}
+
 /**
  * _copy_to_pages
  * @pages: array of pages
@@ -1162,6 +1276,27 @@ size_t xdr_expand_hole(struct xdr_stream *xdr, size_t offset, uint64_t length)
 }
 EXPORT_SYMBOL_GPL(xdr_expand_hole);
 
+uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint64_t length)
+{
+	struct xdr_buf *buf = xdr->buf;
+	size_t from = offset;
+
+	if (offset + length > buf->page_len)
+		length = buf->page_len - offset;
+
+	if (offset == 0)
+		xdr_align_pages(xdr, xdr->nwords << 2);
+	else {
+		from = xdr_page_pos(xdr);
+		_shift_data_left(buf, offset, from, length);
+	}
+
+	xdr->nwords -= XDR_QUADLEN(length);
+	xdr_set_page(xdr, from + length);
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_align_data);
+
 /**
  * xdr_enter_page - decode data from the XDR page
  * @xdr: pointer to xdr_stream struct
-- 
2.24.1

