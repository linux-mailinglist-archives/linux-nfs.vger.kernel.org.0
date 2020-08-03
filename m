Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699D423AB31
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHCRA1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHCRA0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:26 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88CC06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so23994925iow.11
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCXOKz0tAEqxCMTQI43XB3ts+zVQF3aRh9mgqDaMXZY=;
        b=r2NE3TEHsdr6mCfICLRLfMPtyVGX03+7mzpahYQZJnZ1tkbLcipo5FtJvHs0tYmHZ1
         5rxr//kR8H4egsasyF+7iAYIYUMRw7tkHru9d+2KaeBLY9HXImoNkQurovpb+IncbPLO
         UZQ9KoF0/iOffbASG14dy/AKZddi4XDpHEdUaQHqJdB1WWvZV0/3DY+J0BnenoTbA+YP
         mKWOXxX4A2nqB0Ep6nwjWVg4o2Z5uskbfu6HQdbHsAkTs40kfDHSaSc+NHzVfdStZvev
         G3EdT2Ih65BjX6e5ZlAEF9YyTslEY4K3bLxs4eqMLC/RR90XbO+8yesTVLthb2BlW0UV
         TiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kCXOKz0tAEqxCMTQI43XB3ts+zVQF3aRh9mgqDaMXZY=;
        b=nlLr2Q6ol+wd1S2byUc3hloPNPLM8Ak7A7Z1IXK4f7+Abs5BG4Kv9bFMIlYnhBIxnV
         ShgwiP6/dZeKcdMV0ulxfiZC8jcHco5v2S7tQOmUzwtJ0OI969Hi4ov48EqQs+JCQJvf
         7ZQt2Azn+xgnqnshe1qJU4pOkSSGZL3E0f0f0nUi4qaxZRZ6XCHsGfwP9n+5/0xQpNTM
         YKBXsNh9+QxVu3THZzB4jqF1MqQrlUVOdqUMgjVpc4R+X4g+J5U71LM6DibrNTQGffl9
         H0huT7FJe2JDn7MNedY2ez3qqQg3h0sJbLloh8UomWc0spPv9zDndTSHYfpoyeI2PL+h
         OKCg==
X-Gm-Message-State: AOAM532a0MESdzqnc/CWP1qCK+EbIOh2KGq2647tpNHT5Re98QZMb87o
        ZJ/U4T+CVENXcCGcO33dQl+tASaI
X-Google-Smtp-Source: ABdhPJyoaCLiAFgQsOCYbToAkPQf2a60+2atxCSfrDMPXtDLZiNKVX9cJlzgQXGSwwhjTAxXoiW1Zg==
X-Received: by 2002:a05:6602:2515:: with SMTP id i21mr800974ioe.120.1596474024483;
        Mon, 03 Aug 2020 10:00:24 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:23 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 09/10] SUNRPC: Add an xdr_align_data() function
Date:   Mon,  3 Aug 2020 13:00:12 -0400
Message-Id: <20200803170013.1348350-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803170013.1348350-1-Anna.Schumaker@Netapp.com>
References: <20200803170013.1348350-1-Anna.Schumaker@Netapp.com>
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
 include/linux/sunrpc/xdr.h |   3 +
 net/sunrpc/xdr.c           | 120 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index de1f301f4864..b05a2d6611c5 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -206,6 +206,8 @@ extern int xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
 			     struct xdr_array2_desc *desc);
 extern void _copy_from_pages(char *p, struct page **pages, size_t pgbase,
 			     size_t len);
+extern void _copy_to_pages(struct page **pages, size_t pgbase, const char *p,
+			     size_t len);
 
 /*
  * Provide some simple tools for XDR buffer overflow-checking etc.
@@ -252,6 +254,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
 /**
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 24baf052e6e6..f42da5051f36 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -201,6 +201,88 @@ EXPORT_SYMBOL_GPL(xdr_inline_pages);
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
@@ -316,7 +398,7 @@ _shift_data_right_tail(struct xdr_buf *buf, unsigned int pgfrom, size_t len)
  * Copies data from an arbitrary memory location into an array of pages
  * The copy is assumed to be non-overlapping.
  */
-static void
+void
 _copy_to_pages(struct page **pages, size_t pgbase, const char *p, size_t len)
 {
 	struct page **pgto;
@@ -1177,6 +1259,42 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
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
2.27.0

