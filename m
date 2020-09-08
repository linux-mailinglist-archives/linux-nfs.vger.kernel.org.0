Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D072926148E
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgIHQ0T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgIHQZj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE1EC061796
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w5so8048460ilo.5
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1kCKc3IoQZq6eAPMW1QAyP6Judd54FV+ny15Qj8+pI=;
        b=Mx2paZxAVj0R2QtYQItw6wTx3pDZ9HAs9Nra5RSUb8Icp/KtaWd3eKX9G0X59+P9h5
         SV/L5sKaQwdyHrF2fYFhBPQgeIdLaG+i0N5fDaAMbLNeO8AZhD3wNcXf1MnkJMgScim/
         n0YhiOxBHbD/A3M8LhBDmL8qPBom7WjNXi46m4RcR/ibHif94DyydMF7EH7dLkerd59E
         96YUYMiCATT7YZNzFNQn/9HOdrzS1if33tPrgBJP3eKXu8li5GvhX3rfXrsAxgRtIrsb
         MaSEwaLmBekK70jzER51cpJHtmKZCh5Zw+/KDcMFH0vaBQ17g3lEHyqVT37UzerqprHm
         LWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q1kCKc3IoQZq6eAPMW1QAyP6Judd54FV+ny15Qj8+pI=;
        b=GGZgS2JjBjq5V0AmQKS83lvFaui4/FxP41Hz7OweCJP7ZMgLCbDOkO1C7leUgAU4m1
         WIQfRXKPMCOvbXjZSp8amQoFYvyNNElfcJDMo0e8t/S5DLEn6d2iMZi2N4mp7LdtRTiQ
         fHjX6tYDc0aAGLa2JUZ7HDgxHeKPtMRtCTXqbm9Ct1SwaazQxfnVcPT6GEaDr2KJdF4c
         ITIK3dmwmaX4gnz65oBYyT//p/J1SA8xA/0V61xSwRSgnIER753+qWdYHUBvAH4aFWOD
         fhQLv1svISdklXYBrjJtiHtZFsIMM5IOwZjBKEZbqmxdS83Ek9UMv0RDI7hLrkD69knU
         +6zQ==
X-Gm-Message-State: AOAM531LcWRnr7aMUARp4SU5QCL5AT+zYhkEKjy8X5Ou3dcr7+DWJwKv
        4iUo6DZIKrN4snK43xvkw1RJdTjLJ7M=
X-Google-Smtp-Source: ABdhPJxdepruYnVTvoMEiD8b8t+KaTBdcRqAC2jHTLMcXXkuQ8Y3Xo4uQkuFwLSlumgUjP0m5cJBNQ==
X-Received: by 2002:a92:d08e:: with SMTP id h14mr24365623ilh.1.1599582321661;
        Tue, 08 Sep 2020 09:25:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:21 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 07/10] SUNRPC: Add the ability to expand holes in data pages
Date:   Tue,  8 Sep 2020 12:25:10 -0400
Message-Id: <20200908162513.508991-8-Anna.Schumaker@Netapp.com>
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

