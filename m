Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8A1379BF
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgAJWfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:02 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33486 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgAJWfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:01 -0500
Received: by mail-yb1-f195.google.com with SMTP id n66so1384776ybg.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57QAqPf0t/LbTmyzGx9rgDaeNch3OArcCT1NgmNT0Xw=;
        b=DSWeMBhho7szGs9YHfbq0xDtFWFKx+3hhuDDa2y6n6nvF2SDp/fv4zhjNrfth8JCFH
         ZlrI8ov1z5J4K8H3fJc4sA9oVPfnnZJ3HVDhJOmMtCeAsFB5OlHlkx5eYe58Bzkh2HKn
         6uCluSl0nR6QVmWEt25LjJ6kASDnvkoQlFRgbCK4qiJwOg1aRcvpLYPmXEttlUojL2YP
         Vmiv421ogrrsNqddnaw40RzjE+qDGaZWeKE08ODQM38rje6E25iIlnFyEh7KyiLlmQBw
         /nllE9fEK/5LUX4JaAwYt8BPxyuaNOrtP8YTpPfbofIWdp7CU2zd1qXay89vclDJRkIc
         XNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=57QAqPf0t/LbTmyzGx9rgDaeNch3OArcCT1NgmNT0Xw=;
        b=EVhUuslQZbYDDc9WPQJJao9YRd0gmE65YgSD7weTUzexxpWVSypwQcsP0jQU6w2XiH
         hHLhVd3mx3TulyxBddDz3iPF0shXIMVMfeAU3q04/FpeWfMFI1XXrTTvDtkonWEzVYsI
         YXbGAVj+22QumVseeZtS2yPpW4+/hQ61aXtK1+2wuhDbwCRoB3spMC7oryQ62ddvBCmy
         mcQZ7mv7xe9FSR4TJu087F+Ok4142MPalh0uZ9AFbGwDXQx72GWnGvisvGSRg3qi6T4o
         Wk/Uld6mepadxhmVkMpnit7px/cuFh/zv7+YY5kKCr1oYFwbgaXW8ai9N1JALHwo7l7w
         tsMg==
X-Gm-Message-State: APjAAAUFTKKIUbz5m/T+uREP/oncbaoxXArv9rZat4Zead8SXp0xkOEG
        aOChBaO0edvI0jjXFg0H0iQ=
X-Google-Smtp-Source: APXvYqxTvXuNyfSxQ3fVB5D2P+ZKaKPFzwKRWgOnPLzHFXA2/xXW7ow3zDrckdrxi83f42SMgseYvA==
X-Received: by 2002:a25:6f02:: with SMTP id k2mr4238426ybc.254.1578695700479;
        Fri, 10 Jan 2020 14:35:00 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:34:59 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/7] SUNRPC: Add the ability to expand holes in data pages
Date:   Fri, 10 Jan 2020 17:34:50 -0500
Message-Id: <20200110223455.528471-3-Anna.Schumaker@Netapp.com>
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
2.24.1

