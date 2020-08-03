Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DB23AB2A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHCRAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHCRAS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E33C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so21489623ilh.3
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V20Cu/t2uiQPOxahL/wJ2ptpkQOkYsv7J8Dr+lPXmTA=;
        b=D2XjCbULq5phGzXdQG8jSB8QCEOvbUF0HxgTFPNqjkB7JwzymWCYmK5anYk83x3NPe
         yWz/CxFIiZvvxp1SY6OYu8/iVBWr97iV4Yrwkvd/kKca+vfarkDWNrC3Abjup+A7LMwx
         T+4oQPNG9adKtO4rgL2NU3djz+ZZO7tTA3RBjpXJb7jp2h61bGBdJleltiEP1WyCX4vi
         Mg7hQ1LGfr/0L52W8/APZmzN7HlpzBGl9KAZMc+Z/pFO3gbiC8pP4jOZKGLouP3buJ+u
         BifjZnCyRbLx1Gi1deSfQFi+Z0hlVpNY1YE7M8qOyJDPg4CtpgXmCityHhE34ac87UbL
         GwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=V20Cu/t2uiQPOxahL/wJ2ptpkQOkYsv7J8Dr+lPXmTA=;
        b=jecel3+ZL1VQdtj9t8isiPyhU5qR7arM65dOBZNWk5wjs42c/pw7G0cMw/Dq9EUCwT
         rh0DtpyaamBhCzJgplMegN563VqbJGuBIQxdhd3NVPqxxPCUS/XvMtFihhgI2BeTXmbi
         MWM14WpEn7wBZ6uNZHMQNFHxWdI6yx9KdQdV2B/MskQYsGiGQ80sp6hMmlKMal+ZZMPI
         DtCZSM8LGZ5327DEP4yf8uH9m/wI+fnm13fJmVFPm5S5gR759Wljd1N/2Xj8NzOGJzXW
         kUzZbO3ZzXXiEL3/mf2hkOdqvuW0kHJiKTEE1S8+Z7J+tHAYX+6cP3QKuhBdZ+zk+Bbk
         vNOw==
X-Gm-Message-State: AOAM5324LzZhuVlKgNBuwsj1xewrywA8ieqPju0EZtVb5HyuFfcK8u25
        M5sn1q2ORO9GeBGFDm/2lu/y4yc7
X-Google-Smtp-Source: ABdhPJwevi+JMoMTajEAF5E3+lGTVjL7W1usRxU6RIgOQJNYLASdzskqNRk6xXeIAvS+pCXJF4gljw==
X-Received: by 2002:a05:6e02:e82:: with SMTP id t2mr297880ilj.161.1596474017525;
        Mon, 03 Aug 2020 10:00:17 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:16 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 02/10] SUNRPC: Implement a xdr_page_pos() function
Date:   Mon,  3 Aug 2020 13:00:05 -0400
Message-Id: <20200803170013.1348350-3-Anna.Schumaker@Netapp.com>
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

I'll need this for READ_PLUS to help figure out the offset where page
data is stored at, but it might also be useful for other things.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index bac459584dd0..40318ff97c83 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -242,6 +242,7 @@ extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
 extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
 		unsigned int base, unsigned int len);
 extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
+extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
 extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c62b0882c0d8..8d29450fdce5 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -505,6 +505,19 @@ unsigned int xdr_stream_pos(const struct xdr_stream *xdr)
 }
 EXPORT_SYMBOL_GPL(xdr_stream_pos);
 
+/**
+ * xdr_page_pos - Return the current offset from the start of the xdr pages
+ * @xdr: pointer to struct xdr_stream
+ */
+unsigned int xdr_page_pos(const struct xdr_stream *xdr)
+{
+	unsigned int pos = xdr_stream_pos(xdr);
+
+	WARN_ON(pos < xdr->buf->head[0].iov_len);
+	return pos - xdr->buf->head[0].iov_len;
+}
+EXPORT_SYMBOL_GPL(xdr_page_pos);
+
 /**
  * xdr_init_encode - Initialize a struct xdr_stream for sending data.
  * @xdr: pointer to xdr_stream struct
-- 
2.27.0

