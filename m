Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4123AB29
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHCRAS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHCRAR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE87C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w12so25634985iom.4
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewpr7C8nUE1GUfbEkZpsIogGbR/+S4RvmagXfpj3OZk=;
        b=H2Y17dPuU52KEH4r/nNQd3o7ScCthv+G6hu8rAf2H7ludPaUuYhe6RTvI1RSXInZjr
         q5Y/kEFhtdNLzLsTpJNbDFqOeH17LhfKjtm+/uo//DHfJqRZDV229jCzwL7UO4AmS36v
         aif3CnMAEox/Yd8bksRK1s4n3OStpjsZlsg3Ub0RAebenvViRxhIsbvE3hZ8VPsjOJGf
         Ni5WEoA0HFJDTWRuLX/ln1QfAiVOjayhLgyrwe7K6t5HJQFun3eHBAThIb5zP4cJoikK
         spQ3dPjh5219hU5pNYBWpXdrXIAx2DjX0Un15J7M8NwfBORPN42Ytkul7xhejaX2onFq
         nntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ewpr7C8nUE1GUfbEkZpsIogGbR/+S4RvmagXfpj3OZk=;
        b=XEXfZKcBShQLIOztodH3jeNKtNp5fFRWgepfCMykHVXkBjpz6363k+vTRYOaur5I7i
         eFol6qhxplYTVxz2kriYTujHmlzqklt6Yhs71tPxYRUXYlrmXv6dBwt3sSvBWrg2tYNE
         dOxSVSF4ym62jsODwMoQ6zsAg1QnDf+uwZVTC9jeYWVUUeMTOK9dl0qBwD6t0CSrWysB
         YzjCMVZ3trt7+nQl/Mr0uyN7uoPjZq71khA+/agP0Cy4Khn7bogHheu9JFWwtEKJMTJP
         j4oC+69BCNyCcXrAYXjOcR3+0Z94IH5v832yeGBYsmIQtM/DR7XDViavoKZVYZCM0WYH
         WUCg==
X-Gm-Message-State: AOAM532hdeH9klhjznTr9wi1RvICS37u28y3/hgvedUv2/V3iZ7TlqN9
        HoLbiOWaKR0tDmZVlrPCUIMzOiTx
X-Google-Smtp-Source: ABdhPJxg8lsMrN0oW1Tpyj5bmXPe12ilZQo9r2w0UCGkT1hGNRdV8yMt4oVemzSFp3C0UU2hpLyfSg==
X-Received: by 2002:a02:70c3:: with SMTP id f186mr656932jac.118.1596474016484;
        Mon, 03 Aug 2020 10:00:16 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:15 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 01/10] SUNRPC: Split out a function for setting current page
Date:   Mon,  3 Aug 2020 13:00:04 -0400
Message-Id: <20200803170013.1348350-2-Anna.Schumaker@Netapp.com>
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
2.27.0

