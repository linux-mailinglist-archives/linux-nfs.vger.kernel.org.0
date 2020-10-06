Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF52284FD2
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJFQ3a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJFQ33 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:29 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D0C0613D1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:29 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so8259548qvb.8
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=BYSBxzsTbG71eBhTww+w7tEcq5Rrb3WMLOanINlQeUqURMWSBxhDvRkbMPuJX04A9S
         cwNVSa/UJNUyXOhxPaHg9sFqemzf9ZfQ1NWHrI2G1p8dBCoar3MxJV40bw8f1n/O2EMo
         /34sd/azs/8NyHfMsyWwQzIfJtHk75khdVDDS3EW7HnInGu5/6TomAh3xk6qqni/5Cv+
         xTS2FL0ISHwoG2CQGhfIQt/PutBT5AerlbA8j0AYi9uLFar47sbVs4FozqICJ/MKCulb
         HaXkpBdT3il/0W4YLnCPQV4sWYjUMZ7PYcxdBOJI/tgbpkdRnte28op3+OVDyRAnkVeY
         yyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=aaG9QVfIwfidmXXuNEoF64S2Hq7tRmlFKNAMjHR0qRFMOy3iEQ2FHiLI6WpH6Fdoqt
         F8EPcHc17R+bXBH8t0oY3BYEgrgPPpL3N4xh1dhj9k7lbvjs3bCGottVX02WIebCBHOM
         6/rTRmQDZkcVSQuwOZhLfX4q8sfqwdCK2wW/2ZLFFRas3S92mNncmRLWYc93RuRBriaM
         fVYvq7J13Mtssgt06FAbBDpYvv6V1S+lOxCEhaHX2eol4V6ZmLvCArBbwoo+8KEWhVqE
         MQyTpu2s6XPhtDme3zGg/9zviZ3XHYUp4Ex6RDNQMKF7GBFNsAscFqo7yAf0C+VQZHon
         LsMg==
X-Gm-Message-State: AOAM532p0i2kO+fy37rfUS9Og98LtEzzcPLED7Wcu3iTuce89lV1JHjm
        a6+5XRW1W7I3cduhlX2ldO6PUC42KutOog==
X-Google-Smtp-Source: ABdhPJyn36BXQYwk/F7Z/UQwnuBkQMHcUfbQtfVM+KXOsfQD3AKwBl5qrGVNVe4ylowH3c7ZxsYgzg==
X-Received: by 2002:a0c:e904:: with SMTP id a4mr5641058qvo.28.1602001768488;
        Tue, 06 Oct 2020 09:29:28 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:27 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 01/10] SUNRPC: Split out a function for setting current page
Date:   Tue,  6 Oct 2020 12:29:16 -0400
Message-Id: <20201006162925.1331781-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I'm going to need this bit of code in a few places for READ_PLUS
decoding, so let's make it a helper function.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 6dfe5dc8b35f..c62b0882c0d8 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -870,6 +870,13 @@ static int xdr_set_page_base(struct xdr_stream *xdr,
 	return 0;
 }
 
+static void xdr_set_page(struct xdr_stream *xdr, unsigned int base,
+			 unsigned int len)
+{
+	if (xdr_set_page_base(xdr, base, len) < 0)
+		xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+}
+
 static void xdr_set_next_page(struct xdr_stream *xdr)
 {
 	unsigned int newbase;
@@ -877,8 +884,7 @@ static void xdr_set_next_page(struct xdr_stream *xdr)
 	newbase = (1 + xdr->page_ptr - xdr->buf->pages) << PAGE_SHIFT;
 	newbase -= xdr->buf->page_base;
 
-	if (xdr_set_page_base(xdr, newbase, PAGE_SIZE) < 0)
-		xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+	xdr_set_page(xdr, newbase, PAGE_SIZE);
 }
 
 static bool xdr_set_next_buffer(struct xdr_stream *xdr)
@@ -886,8 +892,7 @@ static bool xdr_set_next_buffer(struct xdr_stream *xdr)
 	if (xdr->page_ptr != NULL)
 		xdr_set_next_page(xdr);
 	else if (xdr->iov == xdr->buf->head) {
-		if (xdr_set_page_base(xdr, 0, PAGE_SIZE) < 0)
-			xdr_set_iov(xdr, xdr->buf->tail, xdr->nwords << 2);
+		xdr_set_page(xdr, 0, PAGE_SIZE);
 	}
 	return xdr->p != xdr->end;
 }
-- 
2.28.0

