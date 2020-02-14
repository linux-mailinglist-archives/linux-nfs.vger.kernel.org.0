Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35A015F881
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgBNVMc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45957 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388783AbgBNVMc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:32 -0500
Received: by mail-yw1-f68.google.com with SMTP id a125so4860580ywe.12
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HwZzRb8kfAIfGOyJ8K3y1FUu20TYSwp6DTuTITtZxM=;
        b=bt3z0tuc63nLVS1R97+qe5FCBTWzRBF1loaln7WdVyICMxWh5rTmcHwUq9O350UnS1
         VWb2eHHX5ym7gULOHK6sv4sB4RYY9/luQiH7hIfD023KTGUjFV9QKfLcr2QKK/r5PA5q
         ZUW+GquokN8dgNV17q8ELRceHNP6Ydegcf02fdWNaqqgiIrc1w4WazCI5edxmExopFuk
         iPs4lQAUx45kfoeiGc50/ItRjEqUUGRGtfyAO3uS2g5ZudFCG4wrGXTfdg7XbybNsepF
         PlnFyCT60sdalajAMOC4xmNDC2fHCc7PTg+tEVVnAQ1Ll9iaM+u2QjdB3bEj7cng/N6I
         mcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/HwZzRb8kfAIfGOyJ8K3y1FUu20TYSwp6DTuTITtZxM=;
        b=PMNT1KO6jfK5eegSJhTr1JpJuHnUiCkbh7C0KBrpHC/DjA41uv4Tdrijq2MMa2qdy/
         oEZwAOBfbvZSkfqaP4at/gYInANVFFufAQY++s6w5t8tssEeq/rPpK+t1ZP5k81x4zv6
         ra+Oe3MYCtl1Jgf319Uy6XhCM731Wq8vo8whtIVhJsUwQYj3gAGdZtlNv8NcmYeJm/FV
         pFq4lwB6jjSw6hoW/IBjmoxSNg3mcfmrnZhRTmtmoRO/uMRN0nMguk8nfB4J1ddhLZ1L
         u1LNKRtKGOLl7BQH3un/UKX/6EQ8fWy3xAQNt3b4xHcnewwTcnHXvIuAYtH36CHXo0+D
         c9WQ==
X-Gm-Message-State: APjAAAW2e1AAGNG5rocgSfm82PnXIVyjUftSGHfM0tmi0YwLe/mL+WpN
        8SyTX4ncsKWNgBbjV7EKIzI=
X-Google-Smtp-Source: APXvYqysDkMJBlbJTQKN+UoD6rb1RONe6CVlG7OXViD9rxydD8bPtFnBmRsFs9VzR0Hov1o0PA7VGQ==
X-Received: by 2002:a81:1ad5:: with SMTP id a204mr3982321ywa.486.1581714751112;
        Fri, 14 Feb 2020 13:12:31 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:30 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/6] SUNRPC: Add the ability to expand holes in data pages
Date:   Fri, 14 Feb 2020 16:12:23 -0500
Message-Id: <20200214211227.407836-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
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
 include/linux/sunrpc/xdr.h |   1 +
 net/sunrpc/xdr.c           | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b41f34977995..81a79099ed3b 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -263,6 +263,7 @@ extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
+extern size_t xdr_expand_hole(struct xdr_stream *, size_t, uint64_t);
 
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8bed0ec21563..bc9b9b0945f5 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -266,6 +266,40 @@ _shift_data_right_pages(struct page **pages, size_t pgto_base,
 	} while ((len -= copy) != 0);
 }
 
+static void
+_shift_data_right_tail(struct xdr_buf *buf, size_t pgfrom_base, size_t len)
+{
+	struct kvec *tail = buf->tail;
+
+	/* Make room for new data. */
+	if (tail->iov_len > 0)
+		memmove((char *)tail->iov_base + len, tail->iov_base, len);
+
+	_copy_from_pages((char *)tail->iov_base,
+			 buf->pages,
+			 buf->page_base + pgfrom_base,
+			 len);
+
+	tail->iov_len += len;
+}
+
+static void
+_shift_data_right(struct xdr_buf *buf, size_t to, size_t from, size_t len)
+{
+	size_t shift = len;
+
+	if ((to + len) > buf->page_len) {
+		shift = (to + len) - buf->page_len;
+		_shift_data_right_tail(buf, (from + len) - shift, shift);
+		shift = len - shift;
+	}
+
+	_shift_data_right_pages(buf->pages,
+				buf->page_base + to,
+				buf->page_base + from,
+				shift);
+}
+
 /**
  * _copy_to_pages
  * @pages: array of pages
@@ -350,6 +384,33 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
 }
 EXPORT_SYMBOL_GPL(_copy_from_pages);
 
+/**
+ * _zero_data_pages
+ * @pages: array of pages
+ * @pgbase: beginning page vector address
+ * @len: length
+ */
+static void
+_zero_data_pages(struct page **pages, size_t pgbase, size_t len)
+{
+	struct page **page;
+	size_t zero;
+
+	page = pages + (pgbase >> PAGE_SHIFT);
+	pgbase &= ~PAGE_MASK;
+
+	do {
+		zero = len;
+		if (pgbase + zero > PAGE_SIZE)
+			zero = PAGE_SIZE - pgbase;
+
+		zero_user_segment(*page, pgbase, pgbase + zero);
+		page++;
+		pgbase = 0;
+
+	} while ((len -= zero) != 0);
+}
+
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
@@ -505,6 +566,24 @@ unsigned int xdr_stream_pos(const struct xdr_stream *xdr)
 }
 EXPORT_SYMBOL_GPL(xdr_stream_pos);
 
+/**
+ * xdr_page_pos - Return the current offset from the start of the xdr->buf->pages
+ * @xdr: pointer to struct xdr_stream
+ */
+static size_t xdr_page_pos(const struct xdr_stream *xdr)
+{
+	unsigned int offset;
+	unsigned int base = xdr->buf->page_len;
+	void *kaddr = xdr->buf->tail->iov_base;;
+
+	if (xdr->page_ptr) {
+		base   = (xdr->page_ptr - xdr->buf->pages) * PAGE_SIZE;
+		kaddr  = page_address(*xdr->page_ptr);
+	}
+	offset = xdr->p - (__be32 *)kaddr;
+	return base + (offset * sizeof(__be32));
+}
+
 /**
  * xdr_init_encode - Initialize a struct xdr_stream for sending data.
  * @xdr: pointer to xdr_stream struct
@@ -1062,6 +1141,27 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_read_pages);
 
+size_t xdr_expand_hole(struct xdr_stream *xdr, size_t offset, uint64_t length)
+{
+	struct xdr_buf *buf = xdr->buf;
+	size_t from = 0;
+
+	if ((offset + length) < offset ||
+	    (offset + length) > buf->page_len)
+		length = buf->page_len - offset;
+
+	if (offset == 0)
+		xdr_align_pages(xdr, xdr->nwords << 2);
+	else
+		from = xdr_page_pos(xdr);
+
+	_shift_data_right(buf, offset + length, from, xdr->nwords << 2);
+	_zero_data_pages(buf->pages, buf->page_base + offset, length);
+	xdr_set_page(xdr, offset + length);
+	return length;
+}
+EXPORT_SYMBOL_GPL(xdr_expand_hole);
+
 /**
  * xdr_enter_page - decode data from the XDR page
  * @xdr: pointer to xdr_stream struct
-- 
2.25.0

