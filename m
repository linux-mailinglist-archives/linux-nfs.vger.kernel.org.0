Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD323AB2E
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgHCRAX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgHCRAW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FCC06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l17so21493689ilq.13
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcJit/hiUG/fNeS1TuFDMVteA3MrVX7lYqy+y8dtUCs=;
        b=kbiY+Oif8u2zJTQ1eEheAQ76n3pLlLGniCytei543TFctArLNSLb8L3UfFFYZOnzA1
         dXacct2yTHR3vBrbJ/yDudnLdV/CnJ+XdfLAduJJIU4lwkN7Rf+lQJ/fz+PFfGRlN7eC
         A2HJO8fQY7tYY1RGe07Jil7/kGrrCPkGq+GWuRJOiGGaNeImFQsZaFnOY8lLhD0bPbBy
         ntsdhtrfpRCN+tI+13UyenF4j+U8fm4Xef3GJctkzutmL22tRwfSzJFA9Jv3ak8loMb8
         cqHa4S5+NHFh4OO4R2raE/WA/99Anx7sn/1qLpfZRY/jUQIFOH2qOegmS8rpzk2UfePx
         TxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FcJit/hiUG/fNeS1TuFDMVteA3MrVX7lYqy+y8dtUCs=;
        b=odthLQqE9kBov1BKZ2QsPZXSvh+PCx/TfSk9XiVSqJy+eNZh7k8E18UYaaaDa6vZKE
         Mxd7JxmBjV4N7/eV/rPmTxeEMJZceCP5WaBV52P1FP0uDuoLsiQvkm+Z9a+BFw4nJhF7
         Cs4g8Wa9+DGj3+Dj6hHSlrEbI3x3NlWvgJKLNu8Nw1b2QXdseXd0yrYWUZB4750hcVgc
         aJWIeYuhe9isgOI0ftc+PgWMyfU24m0p/YltOv0xOgR35XWbIvOL0HL5wDWRV/FOPC1L
         5vX2S1QB/RZiDEh82erpfZtT2P8TlV+WOz7YZFGWYzRoWcUZqRhHaHJsH6k1YNmdCi9W
         eptg==
X-Gm-Message-State: AOAM533zZKvrIBJUkRVp04etzTNE1fB1pv6ZBgU3CnmYVlQnHNAkmLkd
        X4a3KwSUzW5SHTSEsEoXAFUaGc+2
X-Google-Smtp-Source: ABdhPJyd6THXr25Z3vf0QnbsOMJL1/OxIpDrdtDwJnfWKd/vO6yBye9lwZdlyAufUrIYZUEiPD970w==
X-Received: by 2002:a05:6e02:f07:: with SMTP id x7mr363117ilj.40.1596474021510;
        Mon, 03 Aug 2020 10:00:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:20 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 06/10] SUNRPC: Split out _shift_data_right_tail()
Date:   Mon,  3 Aug 2020 13:00:09 -0400
Message-Id: <20200803170013.1348350-7-Anna.Schumaker@Netapp.com>
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

xdr_shrink_pagelen() is very similar to what we need for hole expansion,
so split out the common code into its own function that can be used by
both functions.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 68 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 70efb35c119e..d8c9555c6f2b 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -266,6 +266,46 @@ _shift_data_right_pages(struct page **pages, size_t pgto_base,
 	} while ((len -= copy) != 0);
 }
 
+static unsigned int
+_shift_data_right_tail(struct xdr_buf *buf, unsigned int pgfrom, size_t len)
+{
+	struct kvec *tail = buf->tail;
+	unsigned int tailbuf_len;
+	unsigned int result = 0;
+	size_t copy;
+
+	tailbuf_len = buf->buflen - buf->head->iov_len - buf->page_len;
+
+	/* Shift the tail first */
+	if (tailbuf_len != 0) {
+		unsigned int free_space = tailbuf_len - tail->iov_len;
+
+		if (len < free_space)
+			free_space = len;
+		if (len > free_space)
+			len = free_space;
+
+		tail->iov_len += free_space;
+		copy = len;
+
+		if (tail->iov_len > len) {
+			char *p = (char *)tail->iov_base + len;
+			memmove(p, tail->iov_base, tail->iov_len - free_space);
+			result += tail->iov_len - free_space;
+		} else
+			copy = tail->iov_len;
+
+		/* Copy from the inlined pages into the tail */
+		_copy_from_pages((char *)tail->iov_base,
+					 buf->pages,
+					 buf->page_base + pgfrom,
+					 copy);
+		result += copy;
+	}
+
+	return result;
+}
+
 /**
  * _copy_to_pages
  * @pages: array of pages
@@ -446,39 +486,13 @@ xdr_shrink_bufhead(struct xdr_buf *buf, size_t len)
 static unsigned int
 xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
 {
-	struct kvec *tail;
-	size_t copy;
 	unsigned int pglen = buf->page_len;
-	unsigned int tailbuf_len;
 	unsigned int result;
 
-	result = 0;
-	tail = buf->tail;
 	if (len > buf->page_len)
 		len = buf-> page_len;
-	tailbuf_len = buf->buflen - buf->head->iov_len - buf->page_len;
 
-	/* Shift the tail first */
-	if (tailbuf_len != 0) {
-		unsigned int free_space = tailbuf_len - tail->iov_len;
-
-		if (len < free_space)
-			free_space = len;
-		tail->iov_len += free_space;
-
-		copy = len;
-		if (tail->iov_len > len) {
-			char *p = (char *)tail->iov_base + len;
-			memmove(p, tail->iov_base, tail->iov_len - len);
-			result += tail->iov_len - len;
-		} else
-			copy = tail->iov_len;
-		/* Copy from the inlined pages into the tail */
-		_copy_from_pages((char *)tail->iov_base,
-				buf->pages, buf->page_base + pglen - len,
-				copy);
-		result += copy;
-	}
+	result = _shift_data_right_tail(buf, pglen - len, len);
 	buf->page_len -= len;
 	buf->buflen -= len;
 	/* Have we truncated the message? */
-- 
2.27.0

