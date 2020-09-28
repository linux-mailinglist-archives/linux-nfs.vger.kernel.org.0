Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099C227B2C5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1RJ3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgI1RJ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA77BC061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id f11so826878qvw.3
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=h8FzGESx18UfpAGrmm6E5iD3H2nQ6XEnfHNfMYQFwQRZlaDND6Jektvv93VeNdZyNJ
         N3lTanuhJYOed1X9UpIKfY4heAMT+Ec1u5LW3OABb3pAHnvLy2M6+hXAJUO0AMipP50Y
         DaSHpj6/9XNEQt9ar28Uk+AyLN9QrcUItM5zmY9YtQBhWSTdO59Dqs0BSAZ9nYT5w5eP
         CTDPr48OhzYxHDY3kZZQv2ckCLXcFrkmfGABB9zOWDN1eL0MdekwpZlnW5scgaEtCHvv
         levlYmjRt7wVzRzGkgxz/5248tLfdTGjiKf2QbHoxAnOLGwSc9ms+9UaMBJOrscu6CPD
         KIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=Xzt/j8CcgmKq+yI08senczxZen9j2VyWTAY5ar9TgaBo8LDXyr+O+dJIcRwskpYA/7
         E5F6+ujqrcYNk9rb5Cm9oJzqSvE0UkZG7p7xKnfIQl55kBZT2usNyBUYconds6oZl2An
         xlz0GM51CaXmVak+FERbSp+B1u0t8YSvPFv07gCJZWYVI+buceQssxZwiIB4St6yyupO
         DlIxUKTNDPlGfWsI0h+UvlroXkSJ4wWEGIrjOUMaC5yQdmRDDFsrFI5piJ0c0LaNqYXL
         +R8yfwxMR64w7jUsbXwP69awOYBomzI42XuWg1KtxXxWZ3CNus9aqHeDhVck1zEo8LPp
         atuw==
X-Gm-Message-State: AOAM532Z3F/KXPyOb//x8EHzbHEUUfemP7Mw4tvpSgqKw7iIzs/eEZ4P
        bCsCior9LlgEoY8x3dpGu+G0q5FcsZk=
X-Google-Smtp-Source: ABdhPJxpuCnWLkGOFsPwB3P1TJu8MD99m0iFK/lHq5D3Fi0NRbyPSJN8j57oAvyGFYuNETZ2AGRyKA==
X-Received: by 2002:a0c:c709:: with SMTP id w9mr558168qvi.26.1601312967648;
        Mon, 28 Sep 2020 10:09:27 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:27 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 06/10] SUNRPC: Split out _shift_data_right_tail()
Date:   Mon, 28 Sep 2020 13:09:15 -0400
Message-Id: <20200928170919.707641-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
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

