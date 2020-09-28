Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40927B2BF
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1RJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1RJY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CFC061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so1627440qke.12
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=RQ44dFuDTB4NHpx2ocnxAkBzdnvKl/Qg+Dg27CgSgJWj4ny/OdHgYDapJHOFvGCx2O
         00l7s/KI9mHpKGLZ1drPfBG8jSDOTSRGe6DDuAaH54DOP/zWfoWRArpvYuSlXL5OZ1rY
         BCZqJLRCeyjOOoB0USepyQ7DGWtdpEchpzefNT6Kn20p0Xg5J/upOSSS/2UfmJmgPUIH
         juK1PngmaFbZQGCDsC90s5vs20RAVTzA6WyoCF6CU/k/L252RgAJGisdZVpPlFZ3JIYN
         cKp2m5xmDzLYsN8djXpgGcwtpDkZFkXL17QY21EpSV6Ak/A+wf/X0LcAvidycfERRWRT
         u4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yIJ1AoId/iaH9uX+tiP3R4juFL9vJPxpeCdCSjsOFHw=;
        b=IJnhr6MRoBhREhfkGKQSyerdmy1NC3WMCYC5yKWR4OXFE4BZosfXDuQyL1/mTBC0vc
         wZ23iopCU02xkHr22rTTWE+AdmRIMSHrYhF/Dm0FxTgxcvXJchTCYVGGT6ZG79d1wAAQ
         bCoaspmlCSBlh0QDmTmdnDa9flGZSEW8dryAFVT+PPiivi6ldbKTwCBN9NF3kJElO6X8
         WDYjeqIMCHGgGQK0rEpuONwMCx4KClkSXhj9BgU63A5eU91zq4gOWhN3ZQMj2cuKXHW3
         BCUkaGYDT8iAl328AQor1HDiQ0mHTm6XFGaVCQBMm1SSEZ20YJNx414KAB4LrBvZ4S/L
         LxNg==
X-Gm-Message-State: AOAM531ku6MVT9UNBCcKSav079iGWJr1psCQ8+BtqNIVDec8vQhClVLj
        QZYoVFdO5xiPUcq0hQ3IGK14vH2GpU0=
X-Google-Smtp-Source: ABdhPJxYgDn9/kurpV37H4cpt0gHrkUkl6LfOCQ4uerlzCrDXVl3K/GOrWPlojszZtijy9Uh3iO8Zg==
X-Received: by 2002:a37:8ac2:: with SMTP id m185mr467323qkd.84.1601312961694;
        Mon, 28 Sep 2020 10:09:21 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:21 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 01/10] SUNRPC: Split out a function for setting current page
Date:   Mon, 28 Sep 2020 13:09:10 -0400
Message-Id: <20200928170919.707641-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
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

