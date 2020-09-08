Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095312615B8
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgIHQzZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbgIHQZS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D16C061755
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so17743451ioo.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=Vhtn6Tjjbzd3qt1Jwz/VyiAnGzb4O7fZ7K1FKZB9geKl9gR24UXHoBnlP6SSnYpGRQ
         MPN+rY8iNTxu5wwXvYKG0CG19lON1CEd557qTJMnKH4B+OH2u0iGCJnVdUv0Xqm7qgXg
         /1Xi4J7ZGHU/FxXN8cvvfvIo5mdFgG9A/6rbGhBrn4EKY2ZEoHIo8w1MkrSYITxoKzmj
         u1CgubjjVk+bprazOIzYfAyH/ucXEMsFERuDQ00lRIo2Q048gq41xYFOGBLV0HO2Ifyo
         kQYaPFpY9PeKeC/HT8MPulanxPY/bmyYFo3TUMWgMGx7E8ZguekqIQkreu9YSyc0oCYS
         T+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=MN5Y0HrlIpZ8Otp9FOhvoY/kTM/re3IgXoRJ1hWhaeBSoFPpEEK98kV9Y9v1PNHFuh
         bm1/Hx0AppFkFDcTMU+52Z6y69HknhLq5KCYYTOz5jDBXVnO8a8EcX2EWR0TFPytcmo2
         70jgnyyLvyj6RJ4cbnF1znoGHdjzR68AGq2CxYZAbZ/edMNL3FKcxFEF/0zGRdUhfjjO
         wvyzHmjuMghTnVO8egOsnWqk4ZEirVTOx5i16qAATKgITUM+Zl+O+0tfnGXIbrN94IRD
         HNZG4sas50jGBWPYku5NiDjxUA/Y0A9MUX4zqfcLJneVX1F/aBSasbLDW1kQPF7hX8KZ
         PQgg==
X-Gm-Message-State: AOAM533RwCrKF9qpmtTH9tkMn/IwnEbA8lneJoa6LjFpp0PvgPmfbM7H
        5nxJct0AluM5iojYFiouNsOtnD8xbtQ=
X-Google-Smtp-Source: ABdhPJzscf7SFUywsjW0OP2S/nF0wrkUvip/6bssxJXKp3w0+liBfgpsHCs/TFiA5nUpjyjlNxif0w==
X-Received: by 2002:a6b:8f10:: with SMTP id r16mr21971034iod.165.1599582315418;
        Tue, 08 Sep 2020 09:25:15 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:14 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 01/10] SUNRPC: Split out a function for setting current page
Date:   Tue,  8 Sep 2020 12:25:04 -0400
Message-Id: <20200908162513.508991-2-Anna.Schumaker@Netapp.com>
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

