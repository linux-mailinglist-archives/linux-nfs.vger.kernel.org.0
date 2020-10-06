Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D65A284FDB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJFQ3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQ3i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A44C061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s7so11399018qkh.11
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFAcWwkwBH/MPmTConCfEFlMusYV11YzKheHc40qdek=;
        b=RCigsbLtdrfgPEaRVy8P8/ruqU84e/Zv4uuLKqExMeC9YE485B6CrMo5EBYNiN4uPm
         pWL1u51jhKwUs3aj9M/7agqAA0hGAOFCyBzpyJexBGmAQcRAnKhae2HAiXTzIsqBbeFj
         XYfo6t/gp0cIaD/djOKrJoGxFTksj0AfT1RrLXPI3rNL4MrRT/RdJBu/wBpnDdejFpGO
         pnUcLmiFDj2f0pN31cn7rF43qAqu8cS6NGInoE+IY5hMUNJMR1iGBC6X4G3V2V8uJVe+
         xW5dyLImTCv1ddRi6MeEuLBsZ224Eig4fKQn+HZL5B49HF7ojyVHb0dulw9CSuOmkCfC
         k0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uFAcWwkwBH/MPmTConCfEFlMusYV11YzKheHc40qdek=;
        b=gta7Bzstx6q9kN9k6neYu+3oIkVorrwKB2EpCD/VI2nF9csIaDWz19SNZywZPuUIZB
         FWFJMV4X7JyhR7iuoGrlFq89/fsPNr8YKjJfYN16wlHHOR8eJbWjO8T07A+8UyLs7jT/
         p8NfhS3UPhCDtVVjA+Y5OwEWjTaPITxQJr65ov6x4FwPn5IJhtYNeBLanZxw7bcnjBn4
         G9gY4C8n9ULYJRgKk3O+keRyelwC0409w607fGXAC49F2vpYoj/47pjxpdAlUcBtKos4
         ZGJbIeBHOVxkJOJr4Q8F8ivo8+Od8D6m2YRAtGZ6R64MX6h7USadsA1fiNWt2UR64+F2
         9L6w==
X-Gm-Message-State: AOAM530FtXC9pgAlegNULunIH56P+QwwEmJOG47RzCDGVANQiu0EiFU9
        kbjFfMYgnCUyGOWojh63qQ0NW6LSahfqXA==
X-Google-Smtp-Source: ABdhPJxlDSYrL9Jlh1EgZaN64RhOwHeOuJJZhj8fNz0KxxqN/MbGV3gr3ykgKgrHZQuIN5ijNMb/og==
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr5827914qka.421.1602001777054;
        Tue, 06 Oct 2020 09:29:37 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:36 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 09/10] SUNRPC: Add an xdr_align_data() function
Date:   Tue,  6 Oct 2020 12:29:24 -0400
Message-Id: <20201006162925.1331781-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
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
index 3a168bd54c87..eedb6d7300d2 100644
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
@@ -1173,6 +1258,42 @@ unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len)
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

