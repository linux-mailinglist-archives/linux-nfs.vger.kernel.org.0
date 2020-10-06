Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F813284FD9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFQ3g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQ3g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB0C061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c23so6394798qtp.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSNY5rs/LPqHq45LaVf0JSFPkxQWNjnF02QzT07AF1c=;
        b=EFZhIHKzaKP1x8QtaQUh295bpzcfv4jQiQXRbvRUjotcPpaeCmM7ilBwnDTq3zhKnv
         iEC9jjE+dMvcDss9iiZ3Bwj9eLvM92WHR01j2PSPechMhzfIFbXF3PaJ3O3UhZ9OH1YQ
         DJqv1RdK6+HRT7aBdDWVsdbfk5RE1HIujpaTuShJnB7PH8MqZyNBpaNRtxTJzV0QhEVI
         H0kWs6r5d1PqDgmQrvZIXWBey7APFbrYCObYL6KhhdRQI8N1Nl+9566uXfr0r+wWgc8o
         E6Ylj95OLQCIf+hC34vlLHTtQFAJoZ1jmUMSlwWCr47SwRw9Ku51aaxSvpI22Bfrh7El
         Pieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xSNY5rs/LPqHq45LaVf0JSFPkxQWNjnF02QzT07AF1c=;
        b=hJ96EahEy5ywCufoa5OiNa13xB7yczmQC3GMUjaBdAgZAOnbh2eJ04aohQnrqGXEfS
         RLeugqnQXtrW5d457lkEVeXjT3kKPvWrBzCOTJ+9W7QoTImK7g+GitbWCoInu80KjjiN
         KxMgqcvufue+wrhgiPMY9rqvbxH3JVuESCeGWP8LccDhFZ9dX9I8xustOputciH9nZ/K
         prUSfnSqWddIcz3nbnReX2wcHkb7u6z18NgPWume3IXQMhSIUiNGmjuMWGP5ilPYu7cW
         9aIyf47woMCyRBHSd2wvzWG1TDJcn6XqQLSY7DrOiSZBPI8YNhrGsom++hXBEOsrEyHQ
         F/+A==
X-Gm-Message-State: AOAM530EzI6VJj8dHHUaLOHPtFMQWlRYwgDIYuxMdzytQo6BA68Mel+E
        nOUhAhOqFeFRtSfSBSbAf6W++KutnmNnoQ==
X-Google-Smtp-Source: ABdhPJwrBBM6fZUeoCRrHgwbV25YjBwgTwcLZ0mbkGCNLqDe+o/6AMkOLWqPTT13Y+F+kJboKygB8g==
X-Received: by 2002:ac8:1935:: with SMTP id t50mr5909546qtj.74.1602001774734;
        Tue, 06 Oct 2020 09:29:34 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:34 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 07/10] SUNRPC: Add the ability to expand holes in data pages
Date:   Tue,  6 Oct 2020 12:29:22 -0400
Message-Id: <20201006162925.1331781-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
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
- v7: Clean up _zero_pages() to remove an unnecessary conditional
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 69 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

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
index d8c9555c6f2b..3a168bd54c87 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -390,6 +390,38 @@ _copy_from_pages(char *p, struct page **pages, size_t pgbase, size_t len)
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
+		flush_dcache_page(*page);
+		pgbase = 0;
+		page++;
+
+	} while ((len -= zero) != 0);
+}
+
 /**
  * xdr_shrink_bufhead
  * @buf: xdr_buf
@@ -1141,6 +1173,43 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
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

