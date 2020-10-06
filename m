Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8224284FD8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJFQ3g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgJFQ3g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB5C0613D1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a23so140923qkg.13
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=MCHzf3kljfn3ikJyn+Jv6w3oT6fNaNlxwZeE9n2bB6i3GITeYnbZ+GjVgjcFMceKYQ
         IfgIjotq061TMWjWC9jVB/BF7/tiUVKD7N4ojRYBJU6sZTFv8zvyqKODKrdVh9/j19Hd
         TR080+43TKs7Df+zQEQcuSNZs4DloU0gkwQA1W2xJs2wlycP6bZpXwHweUMm450H77Jj
         ir1dzXIZm4QvTnG0lQYhCwFP7o+/MVK6Aw7mXDbbwJ5dzTionZ3ZdixpTaVwTro5LQ6I
         h0ohlvdCVULNP9qryK2NDlDjQkoh8J8S8x9IgnM/7r/MPl62CDNLPdcwT2BfbIGmobES
         C/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=HX5VAre8NDm0M31yv5QLQstJicvq8eYJkNxPYjC9YLT9NYTRE8gzDVXFvPJ4XOnykN
         Krbf10G01oG6uxqyB+g3nfJrZ9nH0flKA7Nr2G2kL0FpoUevWC8/YYXABQHT5OUm6bqC
         xoFKusDjQf5kdlAPa7J28WG5qmePH62pLdYvm9HqJx214IQpY9jmcJDz/P4qv5FbIGVl
         6NXGhSiALzB9v19vBm9DrMY+gufbGjacBpqhPdQm6LlQMHp8pXYqNrU7bqS61dPSTNuY
         hwXcbul9ZF68PN2Pk03gsvYS5vxr8XtO+8eiud7EVGNytTpGUjCwKddmdBVoRWlFg6UE
         MH4A==
X-Gm-Message-State: AOAM533+M9SRqXE6xmoNglj1QA9oAHdbI2k8Co8wYbe1jzU/UIXdbQB3
        xarPQPDQZxYdlTv6CPMqJJVzA0RsJkuS5A==
X-Google-Smtp-Source: ABdhPJzaT/pd4iL8VRdAs3mq1puB3I7xtq+oY7VHW/JMpoCQh4b1KGx3fM1ACirHCkJEcKGOzOFY6w==
X-Received: by 2002:a37:6792:: with SMTP id b140mr5942973qkc.67.1602001773598;
        Tue, 06 Oct 2020 09:29:33 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:33 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 06/10] SUNRPC: Split out _shift_data_right_tail()
Date:   Tue,  6 Oct 2020 12:29:21 -0400
Message-Id: <20201006162925.1331781-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.28.0

