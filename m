Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10281246E8E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgHQRd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389118AbgHQQxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA156C06134C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so18395540iom.0
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=hIrYT2wcbwDRZRDEKO7xEanYpmsQibj04HCDulj2CEXm0ZfjG6A+drNfykW7wG52Vz
         dUyw7sMqIadhtkdenDGeW1OlqYPyoPmXRGtnbvD5l+ur/c5MO+PvXFwFG6ov89jcZ4Gk
         ErXYcVyY/QAqZ5G+210SFMY8G0bP0zyFPulytodVJ9iNSp54bV6Hq4IDC504VUVI9kdo
         ri/0tCgQcLy6O+Cy95gsVRO5b0s5Q4b1DJtkdZLyoRy0HdF3vKY+BdMwNHizlogKjPPi
         JeXZ2Ii+kkFh1q6sLmZs6IBsB5zLH1fsdf16tGrx4NJZTGIo3iGUBC6uJ07wLw3X7ilx
         ng8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=kl4FS8R55sjClH3H9CsBduX0mIhNo66BUS1s7zKYAdLDgtbH6/JyJX006Z+shDwe8S
         NsEEaklR21uuwHmhGdEh0gOcRQN/hAL4PNuud72Em7cY+sJGJpXE3rqPXUzxi7klzBBx
         pTaP3i0TAyT/aR2z1XGetL5tfofj1AVh67EcN6iZLpiYU62kUSmnXKLxnoJjaDjxT4AY
         bwBKh9WH+321TXbAmS+zZNslM2Lok9nRBdznj+axLUfzKD5yoi99n6dzdYC/fABDAy/Y
         9hddcmseejNg97seAnRWa2sXlJYuBnkaWmXtbmGCDLszYTyPEEU8F1YYGjHUKZ4S3XsS
         YXzg==
X-Gm-Message-State: AOAM532wMqAcAswLIXBVerCBkGnDMEmWxlsBcRa34Vuf5VUCvE1Dy304
        YE300dZYCBL7TUTJN3ZBJrGvKB0IBTI=
X-Google-Smtp-Source: ABdhPJx3zB2ZNxMF0tlb/2pcwOsfE8Y/ct0NFGCsEQuT7INzGWGA+R9wVAw1UgMqNw/9M5QHwP2a9g==
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr15169379jat.109.1597683210029;
        Mon, 17 Aug 2020 09:53:30 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:29 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 01/10] SUNRPC: Split out a function for setting current page
Date:   Mon, 17 Aug 2020 12:53:18 -0400
Message-Id: <20200817165327.354181-2-Anna.Schumaker@Netapp.com>
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

