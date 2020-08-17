Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B231246E89
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbgHQRdT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389031AbgHQQx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:59 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405BC061350
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s189so18342886iod.2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=l6tJiV94mBsIvprRfO5B9/2n2RdWmhvF/tW70Z8gHF/htpDCDydIKo9MxYmAeumGAW
         ziCAnHKVorsee0OpROsctkVp2Y3J5NH+yhkXTenvQKWRXO2oPLu4zO48c5inZAZMfxtC
         OujirCLAbXOo9D+tEbuStlebnJ9RqjPgL8gjJmNblUwkUG9rs1oAwmctW4aWWd6WKjXr
         KgNdDeF6TT7GoAMSvYlUs7QcXFrAqkoi5mpSRgF0VgWXL8ufvr9fJ9Qzf+hIeoWHZOhH
         J7Hk9m67qMDLryDg2aNJJQpXC6lJtYI2IS7ShOQYBNba5MTRaneZS8sYxTSES/HTVAt3
         qnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=igtPl6C6Gfbp4gxTezXs9k9ZWoIUbuf9BiavER35twk=;
        b=l06RNM5NShdMBRodeaZSDZBgc+DakMGxWLvkGK6jRbWZMCETptm41hgjuhrliQ5KF3
         2v+B6KB85YFLCg3n7fQQ0xJrTcECTNmoFNIOE1klEzjwJ5ua2RpH5UL/UIwfYpU0ErTr
         Z83ZvLGt/g22rNnQfuJRMRiV4JQbE7/RkPeVObHyUGzIxGmPQbldfA7eqq3OBM7YK9qR
         OT67eST+5j35HY9dYT33SPODPIVw3BWUoPO3Z03YizRHhAnrPiyi3nDKpR9fx6DEWqTG
         nUJPoi25EOK4AyuzmfszW8cb8WeDqq8Q8JmTiKKBZR3Q0LjPUPrV8c+hRSq0OdNW9X5x
         k0Xw==
X-Gm-Message-State: AOAM53221pLzkkyfDTgEkmaygQkZKwzCGXRs3PbqujSKhcqmFc0zPXGM
        URsH/829m72Z9RUZXIG9KhrBIwrxMuk=
X-Google-Smtp-Source: ABdhPJy82GHzJpiF4tn0GQZGqhMUSBTsVgp5E43qh2oxwvrHEqUTav8Y7d1Y9CYxQHf6hD8Lgy4DGg==
X-Received: by 2002:a05:6638:1a7:: with SMTP id b7mr15156618jaq.1.1597683215032;
        Mon, 17 Aug 2020 09:53:35 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:34 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 06/10] SUNRPC: Split out _shift_data_right_tail()
Date:   Mon, 17 Aug 2020 12:53:23 -0400
Message-Id: <20200817165327.354181-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
References: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
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

