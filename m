Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117C4246E8C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgHQRdX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbgHQQxs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF87DC06134F
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z6so18302801iow.6
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=Ro8IoZMrcIOtejypptmqXkVsHoRbdE7L+5BTIGTpY7fto2LLM08U0zj1H8pO940mSK
         UIl7EiXhWxrAjx6yKRT4wEVlLUCG5MmlKHypgzHt8OBf8kR7nTBxgWAZiL7Ch90n1AYG
         tvJifIRnBKyBjuDy2r/5if75Efj2wksflHpqCwYir8Mulp0i09oRbrmzKXGXiK7uAHLl
         JT9Pe/Xe8CXv4eNEZQXh45mOoowI+uVg4cUJ+L8H+6kECa+udJrHgjOToyv6PIRpwPGY
         hAVIEAHDD8ORbVzBdKY6to1/Nqhs5ytUdq6WNXf1rWxkvpQXDJYZbfKFm91JXw1KfVBI
         QHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=pEX7pP4hcF0Z6QLPq699lNHY594HATddL7bAGVkdtZM4DTU1pF8Pqu5J6Lgnwj5U2s
         28T6og5klA/F6mFTvjLmdur7dGoseVLRVItCx2WKT3MrgrIj/4+QGuwRfhvvd59PLpt2
         gUwqBMeHlCi0jnBYXFWvvSFxPjNXmYUyKy9f8v13FK0E/HV2ZxnROIMWIhij2xF9ODn5
         JZQH+BiwLjbBKo2PxjS1SKwcCPs9XYRFlgWOVji3h5Q6VFop/o+ZEpBg18k8TGlIFt3g
         VJNJJBjkpZPTRkhJYT64Nbqya2yVYIT2yZELV+ED+4FiVu47IblJoBbFN8lE5LH4JfYY
         lRUw==
X-Gm-Message-State: AOAM5315pFgQFUPtKejUp0AAEzGTlMEwZFI5oCAKv+uPjnsz9Ev9xJ7w
        I/p5leoD4WSdku+WxizFxqgrUVUAb2c=
X-Google-Smtp-Source: ABdhPJyrGUT0zlGOUBj05W41D3H85vHoJClDyT8/Jt4d8wd9bszbNH27aSehrviY1OJFtQHxYZx9Tg==
X-Received: by 2002:a02:3f0d:: with SMTP id d13mr14908711jaa.99.1597683213863;
        Mon, 17 Aug 2020 09:53:33 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:33 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 05/10] SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
Date:   Mon, 17 Aug 2020 12:53:22 -0400
Message-Id: <20200817165327.354181-6-Anna.Schumaker@Netapp.com>
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

I don't need the entire align pages code for READ_PLUS, so split out the
part I do need so I don't need to reimplement anything.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 8d29450fdce5..70efb35c119e 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1042,26 +1042,33 @@ __be32 * xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_inline_decode);
 
-static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
+static void xdr_realign_pages(struct xdr_stream *xdr)
 {
 	struct xdr_buf *buf = xdr->buf;
-	struct kvec *iov;
-	unsigned int nwords = XDR_QUADLEN(len);
+	struct kvec *iov = buf->head;
 	unsigned int cur = xdr_stream_pos(xdr);
 	unsigned int copied, offset;
 
-	if (xdr->nwords == 0)
-		return 0;
-
 	/* Realign pages to current pointer position */
-	iov = buf->head;
 	if (iov->iov_len > cur) {
 		offset = iov->iov_len - cur;
 		copied = xdr_shrink_bufhead(buf, offset);
 		trace_rpc_xdr_alignment(xdr, offset, copied);
 		xdr->nwords = XDR_QUADLEN(buf->len - cur);
 	}
+}
 
+static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
+{
+	struct xdr_buf *buf = xdr->buf;
+	unsigned int nwords = XDR_QUADLEN(len);
+	unsigned int cur = xdr_stream_pos(xdr);
+	unsigned int copied, offset;
+
+	if (xdr->nwords == 0)
+		return 0;
+
+	xdr_realign_pages(xdr);
 	if (nwords > xdr->nwords) {
 		nwords = xdr->nwords;
 		len = nwords << 2;
-- 
2.28.0

