Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4499A26148F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgIHQ0U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbgIHQZj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5FC061795
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g128so17667178iof.11
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=lDitmVQQUIZFMIff8iQvtOMv1mypPvgkLpB+V6uxR6jxk3UpH0MEFXmPssQGLOQ9qy
         vkaiaHW3f5EE5CV2D5ztvxtwDYpWFdIKpX8zt/9N2jdv9R/vKTTE1Rfhjxwcny61/GeO
         Wrhq8CMyGJEWo54MXeaMC+q9W7fqZ3gCoc3OQ3JAr/hMZcsMA+QPjyG4ku+6pocrbu1d
         6IpeSFUoI/GF2M+Yx+C8cYev0pevfCGm33SSS3kLY4N+Z5jSpe7Gl6SNl7iGwbuLEBUb
         2Kf7iZMySh8rFvgVzJDUhwo1Tm9AkPPUzCebwYHVwy9W78qMcirwQ091/2kZBSnzO+Rc
         xFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=FGWF8OT1dsyG8ZFRo+ij9axp43R5Jakhy2+F5EPMAe3ayUomv9mcPxPYy+XVWoBYAm
         YpW9at+M9mmcsjqWX7bfPVkRVze+wcxwnkAteN2C/A6M/Mn7hOTrsjgjAtL9jEvVrPCS
         s00sCaZwTfEmSb6zxxVACH1NrC2ms8NSlxCqL/zPZZMaEMlEwAlLNVi1BZWlqFjAzT6B
         zwfjIY5SAR8LWey6VlrjeFcjrh6PjVqrWqZkh5O4tKLnYas5D8/x3LtE9KlkYTIrtKQ9
         53xMOzx8vB1wo41E9DusPPbmqxg0VE6kfU+hKQF7oAS8Vyuy7WOior5hcu0/+idnjqF5
         ts2g==
X-Gm-Message-State: AOAM531YB0KM9JJPgDXV68JF4Jja81+k4OTcWbzKd1xus3F9U///M6qx
        yL5XLFpurE4tklPjuaaCjfmw7Kw8Gn0=
X-Google-Smtp-Source: ABdhPJxSvvE6fYwGNQcOu8v00KOuGwcFYtNnz1Sq8j0uwInbLxzOatbyUh3b4xBcGdsK74Mc5CaGoQ==
X-Received: by 2002:a6b:f801:: with SMTP id o1mr21526403ioh.43.1599582320665;
        Tue, 08 Sep 2020 09:25:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:20 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 06/10] SUNRPC: Split out _shift_data_right_tail()
Date:   Tue,  8 Sep 2020 12:25:09 -0400
Message-Id: <20200908162513.508991-7-Anna.Schumaker@Netapp.com>
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

