Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599DB15F882
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbgBNVMd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:33 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43068 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:33 -0500
Received: by mail-yw1-f68.google.com with SMTP id f204so4861961ywc.10
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DU/9mGOna4azTXBZcHD1jvVU7+OrAAyBceq+tZpYVLY=;
        b=HKJGBMW6xuObddKjddHGTJdSK/n8OqGKz+4Xtlwgxf3H9opRt2i8vxtngchkUmJeUT
         wUjmzTJT3vLOxdlmhtA1reJ8fWIlq48kcAlY4zVRDRoK+JxmoRP5YXauI8yNFJt94aMq
         TElDrzWNZan2ssADoIwox2WxybOuORT1JO3SoLoKzjJHiV3ddo9BDCd08FTexwioDLsk
         uuoPtS+/rV8YcsxWvIOS4TeB6sbTch/7d5DbVY8d0O76XJBqMIKkvmXeE/kMEazubU71
         SBi2Lsnrzt7+j2ZQoow1BOmCK9MN+fPhZgtaM5JvpRJd1t4wvWUAC+jCPdHhXwZc4867
         7aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DU/9mGOna4azTXBZcHD1jvVU7+OrAAyBceq+tZpYVLY=;
        b=bb/H0D2XMT4dSrCHDIW0aq6QpVhfej5amEmMPMtwTnazf4pOK5xq0DQvGvLor+CEqJ
         ej5xjcAxdz0yvRfxc5PtwKVDR5jw2FKqStDNDbAsnv4IbqxvpTAAdUM2f5fnPno5txLQ
         apWX9sDUsws9Kd1GMiQiqizuLptbQhkZwYrkRORtvqPTUVwXiNitd0b/V64awYIyFjT4
         sfS1loMiexV3GFFfinP2ViAw4ykX4NVSJH9JZW8eaTSD5cb+xNTEXdycVHMDDelm6Ll+
         HMWziaUFhwpOmZFT1ea16/gZBjZVZb1QDp8j7Ql58eWun6NMw1jbLxMy56ELkOmtRJSg
         jf2w==
X-Gm-Message-State: APjAAAV64ppUKxiB0nx7gs8Aavb8Hq7qmMvsQYIZ5rS/o0ignin4Mw9V
        9KEWSDdWjBzNl4j4+oy3GBk=
X-Google-Smtp-Source: APXvYqyPqafHVqUNUHIQrq3D5nV3qgZ3DsP6vw0kvKdZqe3Q/TF+QnQvx0/uZK/s1uGwumT7uDg05A==
X-Received: by 2002:a81:8785:: with SMTP id x127mr3727369ywf.455.1581714752201;
        Fri, 14 Feb 2020 13:12:32 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:31 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 3/6] SUNRPC: Add the ability to shift data to a specific offset
Date:   Fri, 14 Feb 2020 16:12:24 -0500
Message-Id: <20200214211227.407836-4-Anna.Schumaker@Netapp.com>
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
2.25.0

