Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DD261550
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgIHQrJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE5C061798
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w8so15978124ilj.8
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rFFPC6YSbh+Yg76JGYrEMjlWJn6VCP0QhRCqwz1dRg=;
        b=VhEc2vA5JOlYONpG/ZHqQHhV26zKREdw17EUFXH1PEkRI7luvmNHA+a80U94nPG9Kj
         jUfF3wKW76/5ttCxaJyADBKiWRiV7DyrMcAM/DnfU5WsVp+cgj5RB6gJVwoSvYmYYDG7
         YAf5wFKHmvBpQ/RriFncvunSJEu4O9SeYxEi4x4/KaDZj96gew3/6iukMOZ1YOP9wjEO
         dm7fOt9uJKwAlcfAIsjOovkHG9u7QF+Z+zIxcOHa3vI673pvU9fT1sNBBtHoyFQ8tOOf
         jpACBnfz9lHmeQsJH0t92Omvt9xw081neh3kEeikjEkKM0N+y6fcbU4g5YpFSaG6mfk2
         Nn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2rFFPC6YSbh+Yg76JGYrEMjlWJn6VCP0QhRCqwz1dRg=;
        b=IQeQ0/PqOG/3iqeCkwfw773KdaxZaVbZ+R0mLWtGjzkZnEyR85m3Zr/3JKPiFQHCUF
         CHY977QHPFWmlDXv9cT/HyVkCZO4GdLRvUNYCP3aAxlKkCTNqbiq8MD11XTMAcRHy8Qa
         xOX4ChPfyNpK2qJqPv2INND3lY7mE+FkuYH1sLXWDrEjSc4pj4Uzmyy4Z++9cN4XQyne
         H3k4qC1PUVbwH7B2kSMB17YsgjJF1/DhhXy9LLMPmhaSnrTVSoo2tlIYlDE+N42syCXE
         FUtKuKR5A1pWfkhOtiRMegZEXqMHa3D6KyUHK0MIIu0tOWvEagUjkoqPRrLQkz5LgyjD
         zBsg==
X-Gm-Message-State: AOAM531G1MM2bjv8qn+1t+VMvJw4M1L14dubnvmSR6iQTPuhgX5lxeRX
        3W0v87cJ5gVf98kkLxP5yqOFIqYnmtA=
X-Google-Smtp-Source: ABdhPJyc/y089o0+LVFu2CFb/UuRjezqyx1O9opRGNQ3EU8vR6VGG9NGFwqg+g+j6SyZJ7XHWfXFxg==
X-Received: by 2002:a92:1a48:: with SMTP id z8mr17417327ill.95.1599582323611;
        Tue, 08 Sep 2020 09:25:23 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:23 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 09/10] SUNRPC: Add an xdr_align_data() function
Date:   Tue,  8 Sep 2020 12:25:12 -0400
Message-Id: <20200908162513.508991-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162513.508991-1-Anna.Schumaker@Netapp.com>
References: <20200908162513.508991-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

For now, this function simply aligns the data at the beginning of the
pages. This can eventually be expanded to shift data to the correct
offsets when we're ready.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |   1 +
 net/sunrpc/xdr.c           | 121 +++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 36a81c29542e..9548d075e06d 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -252,6 +252,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
 /**
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 24baf052e6e6..e799cbfe6b5a 100644
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
@@ -201,6 +204,88 @@ EXPORT_SYMBOL_GPL(xdr_inline_pages);
  * Helper routines for doing 'memmove' like operations on a struct xdr_buf
  */
 
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
+	pgto_base &= ~PAGE_MASK;
+	pgfrom_base &= ~PAGE_MASK;
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
+_shift_data_left_tail(struct xdr_buf *buf, unsigned int pgto, size_t len)
+{
+	struct kvec *tail = buf->tail;
+
+	if (len > tail->iov_len)
+		len = tail->iov_len;
+
+	_copy_to_pages(buf->pages,
+		       buf->page_base + pgto,
+		       (char *)tail->iov_base,
+		       len);
+	tail->iov_len -= len;
+
+	if (tail->iov_len > 0)
+		memmove((char *)tail->iov_base,
+				tail->iov_base + len,
+				tail->iov_len);
+}
+
 /**
  * _shift_data_right_pages
  * @pages: vector of pages containing both the source and dest memory area.
@@ -1177,6 +1262,42 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
+uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint32_t length)
+{
+	struct xdr_buf *buf = xdr->buf;
+	unsigned int from, bytes;
+	unsigned int shift = 0;
+
+	if ((offset + length) < offset ||
+	    (offset + length) > buf->page_len)
+		length = buf->page_len - offset;
+
+	xdr_realign_pages(xdr);
+	from = xdr_page_pos(xdr);
+	bytes = xdr->nwords << 2;
+	if (length < bytes)
+		bytes = length;
+
+	/* Move page data to the left */
+	if (from > offset) {
+		shift = min_t(unsigned int, bytes, buf->page_len - from);
+		_shift_data_left_pages(buf->pages,
+				       buf->page_base + offset,
+				       buf->page_base + from,
+				       shift);
+		bytes -= shift;
+
+		/* Move tail data into the pages, if necessary */
+		if (bytes > 0)
+			_shift_data_left_tail(buf, offset + shift, bytes);
+	}
+
+	xdr->nwords -= XDR_QUADLEN(length);
+	xdr_set_page(xdr, from + length, PAGE_SIZE);
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_align_data);
+
 uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t length)
 {
 	struct xdr_buf *buf = xdr->buf;
-- 
2.28.0

