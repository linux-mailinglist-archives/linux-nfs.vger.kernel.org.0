Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844C423AB2F
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHCRAY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgHCRAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA6EC061756
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so19897002ils.8
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbZF6jnu0ZG8YLg6LT7LD13tiLDKfqf0DCerycyJsGI=;
        b=WeYrAbpgBQQsvTGxBCFLOHE9j3kiWJh3qI8tFpxvtVPCfu2ughPT6a8h92oyYyfxFi
         COl0blyXcR8QTzmEwE+nLiVxag2VBfA351KGw+umng539EtqsOZLIJdUF0M7EfAq6kGR
         bh/kv+b5aqQP69n/Q4ZPKAYa42rRUyuPOpF9ENPflpHjMWXK00n9h+ejcDsP3WbERyaY
         OFWmdRdGK++skhsGsA1/8U+E/MNEbKhGpTDtAaIB1s3iUjfxqFdfv9pYSOcT05s0GYo5
         ONUvnTSifTERbCuEkTROkOIfGHvB6ioubAfx8EOmUo7M0uT9A3l5aRV6xL1Xnavs5kv0
         XNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TbZF6jnu0ZG8YLg6LT7LD13tiLDKfqf0DCerycyJsGI=;
        b=JRCPzD6E7w0p3JRsN85TAVmClH4l+wid7j8lC5ihEUBnevMFJhLVVoJr0o/tjb2Xw4
         bOk+ZXMF4dR/GIQ8sZS4dPvMpf54oh9VtzL9yx5CYqu3qKl50bwx0DPgUlS5opwpxtT7
         YB7T59FrKaLd6vAhoj8GQrGBOhPntI8Yip0qllUodmjtRDaljLcJfru3P6Z0wubqfzoy
         d8Itx6Q8GdnKrb2iFs3lN9GrrapFGpdKvI7FdtxqCDQh/hmR/nAJWMSFNTRAOPqDa1hU
         jXQ8k5s/HhZbkSp6Ftu7dAtsJx38W46mLT3iSgZO3YSxc/CGKbS2FZlEafpOFBBzs0wJ
         1W+A==
X-Gm-Message-State: AOAM530CvkthINBEE07CUZ/bVJktDc//9UeypvzZvRvoJ3mN1CjkIzyU
        m4yjkMOgUaKhAvMlNUYC+WQyVHst
X-Google-Smtp-Source: ABdhPJxNcCUY7VUuzXMKCsssFZQaNz2n21uRp5qjMPDMv43lgvoepBHNpK6Yva9TQuZtZ7z0uYt+PA==
X-Received: by 2002:a92:d5ca:: with SMTP id d10mr314123ilq.216.1596474022493;
        Mon, 03 Aug 2020 10:00:22 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:21 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 07/10] SUNRPC: Add the ability to expand holes in data pages
Date:   Mon,  3 Aug 2020 13:00:10 -0400
Message-Id: <20200803170013.1348350-8-Anna.Schumaker@Netapp.com>
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
index 40318ff97c83..de1f301f4864 100644
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
2.27.0

