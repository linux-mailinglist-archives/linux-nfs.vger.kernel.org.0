Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBE261489
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgIHQZl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbgIHQZS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447C1C061756
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b17so15996515ilh.4
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=ut8yCrtjH0mpCteKDmc31/qTjayhnDmpGU3VIXdOKeoD+pbovHil2TOFM6juvawtOS
         p10u4y/sRI7tNmCF0Z+7g3AUgoa9tE3+BCU5byTHD7nTNOp0Yp3ffPtkkyFZibwrRAS2
         CLD/L9EAugXGfIUl2HHoMRUNKqhyA5YD0XU2mBpjE4YaTdeHZiDDUqH4Hr3B9ktDxebf
         yAcqMtERtiWzKrbvSCfh7Vxzu80R71C2wmHNAT+MbEhaSI5VDRrd6bUBqjwHh1G2LSpG
         rxxfOLUr+N+2mTsZNg1ixhe54I5wKqxjpTepPQefOaHeqSNGRHXsTOsTV3dfDRfIHg4T
         ITbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FifsME1ATOsJkuZC/VYkpO0dbUrlMefaE25nRi/x3mQ=;
        b=nKnb46X69cQPTPwmYaHAqnvY8/wxymx1+m+icyrNukuK8I4XPPn2Hy+LHBvr5OXZ5n
         Te52XrlZI28SK0w/Q+2g7m+Q7xdgSRJ+6JunBdRFfol95FZmsQbNtia6mPv8CRdaKKpR
         A/W2e/hWNEFUncnccZrY5MqsZICNc5/btZIDjQRc6KPPpXzclQFYDJtox31mKHjtupOw
         9DzuUQvLMzf5V7u3Bu9t5Kbo4UJ/CZQUDXz2mMJFOP5wIWm1jxtMYyXZv1YCgLRwDClp
         DO1kQ/ok3eptap4edi75JFCZn7Ahki0AdEDWSyqfSjrKQFa7+oNyBEcU/++mIupdOvLe
         Zoqg==
X-Gm-Message-State: AOAM531i5auvMU79LS2IqjPIsdoxzNlsBZT95y5yJKW1+7Tnlqd08B6J
        mBfKU6bJdZrd2PLSxmFA0WtO4eNy02Q=
X-Google-Smtp-Source: ABdhPJz96WU0zuehnhnFLMOBoj8dvRw165BXx9BTP3+FU9iBwRNjTKUX6RT1f/myCbzV8y9bb0hxjA==
X-Received: by 2002:a92:5e84:: with SMTP id f4mr24267582ilg.104.1599582316389;
        Tue, 08 Sep 2020 09:25:16 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:15 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 02/10] SUNRPC: Implement a xdr_page_pos() function
Date:   Tue,  8 Sep 2020 12:25:05 -0400
Message-Id: <20200908162513.508991-3-Anna.Schumaker@Netapp.com>
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

I'll need this for READ_PLUS to help figure out the offset where page
data is stored at, but it might also be useful for other things.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/xdr.h |  1 +
 net/sunrpc/xdr.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 6613d96a3029..026edbd041d5 100644
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
2.28.0

