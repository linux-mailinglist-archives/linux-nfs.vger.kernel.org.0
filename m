Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54CF27B2C8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgI1RJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1RJb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862DC061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so1331182qtw.5
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rFFPC6YSbh+Yg76JGYrEMjlWJn6VCP0QhRCqwz1dRg=;
        b=B20FmcNwekmUnVJ5FTv7xvaUzDr+yOI5ILfuFpLG3hf6TUS+qGbAukejIqk1pOdrC5
         fbmIIPTGeXJjUOzZ20fOgQZbB9v+ekZ/Zb2ZXLnm8dd0ammJsZ00C/wVmvKHsMntSnmM
         QdK0+diPznke7dwQdeGpEmvcxLMkp+fqQYGGAnizk6cqHn/X7Lh476qThATvTzg8/t5e
         bpivH5y7MiV6S5OAHemMbev2MzWnWQZSvMB9YXRR6CO1oK+geKmvqQjF4D0zQhkU2J/b
         Kn3AH3HQbbi9AQtCRRU7qhwM2gOG2M2LOKFK1Viqk1+UN7wuZfSx4sUSxwKVMp+owNyZ
         Akow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2rFFPC6YSbh+Yg76JGYrEMjlWJn6VCP0QhRCqwz1dRg=;
        b=JmChj/D1AetRek+l8+odlKnc6ucYuWcKd8+Sgk8ASADsChXPgNQvsqKToDNh/8YyU1
         niEAirmBVXLdSETwKCGAVBiAeFJCi19NDahfnoZbixcyF8fvmSrPMkreEJMhydKhc7w+
         C6lRn5wgSf31nMFEn4PrmHSaOUXBVqiBn8+qvWL245Wm26WpYBpfJHycP5E/xFrf4nGz
         HDbDoCxubac9NAAaR4yhDaqqX9R+0v8ys4cRjnynsaYs9/er2wroL7FiFQhfZQS/SJE/
         1+yENTq6ja0Qeof9RuLrfSPV9CJyTbZJvaVj9jkvt8xuoiZxC7jZn+oMFrVLQJ7sbxWh
         eMFA==
X-Gm-Message-State: AOAM5338gaHQ2mXaDj1TRWXiu2/Rh3voHi2g5zEWjor4PtVkJCYX2TGk
        oUZrLn6lLhgvquCtBsUmACUVWcz/Xyo=
X-Google-Smtp-Source: ABdhPJxPToJMwpGXwgZdM+tip84FBBv+Wi43Jx759wyuv4UFBd4Wq7OuaD1rhxTyeDgrJMSsOS2zMw==
X-Received: by 2002:ac8:22f6:: with SMTP id g51mr2586635qta.282.1601312970570;
        Mon, 28 Sep 2020 10:09:30 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:30 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 09/10] SUNRPC: Add an xdr_align_data() function
Date:   Mon, 28 Sep 2020 13:09:18 -0400
Message-Id: <20200928170919.707641-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

