Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13023AB2D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHCRAW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgHCRAV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EEFC06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so31686402iln.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWE2v2TtY926P32fJL/hsJ0GYyCK7TK30XUImatQbe8=;
        b=I5KKBU9bUJNQDtsNrSVYO3tOetfZpOuB2YHhH7k4Kn9L49+VnT4A/UWweWsL6x6SnH
         bx0fJnS/WpNphxdumJTSFBugqIDb/MC6dtut3oNzSgpHLOdOABXxL2OXyGobxq64JdLN
         w6Gao/ASv2NZt17l9oqYk+uMstyVuHc3gNlaa1B8HAci7KwyTR2lWydZ70kDrVIWBn4h
         lyu1qi0iGzLppGI8RayxGd33nwGyfN3gzhhrqe3t3XudJl0bCIW+7iPm25ChuP7HBYuY
         JDwk2O9o05CXP9pj4ndPuGMoxhd3jJRFkyvPPi+4humpZXB91sbw9UM3l1DUPWpmXLvL
         W9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AWE2v2TtY926P32fJL/hsJ0GYyCK7TK30XUImatQbe8=;
        b=NXVzSOzdNHK8zQr0Y0MGsm+wjM/34Co7JwYNOs8xqcXE5cdYShktDceDzKYFGrjGf6
         uw2oacZIs8ErjlEl04NBH/i+3KGSRYw98zIu4UkNKASSilu+oDxaCAhpDvgMXqnhfHJn
         8GpyVaDokPs+yr8WhuQ24dF6LN7AIezrBUO/iiPvDgWSb1li3Rg7ecvVVM5u6woVqCLs
         PURzklhA08ehIwNS7+AK3vkWnuKynwQYtSnzz7IyqmmG644rwiF/+rjIwQmvkQK38mF6
         DjKIpCFJamIKCU+o6+orIo6jIn4uKIneL4xjaqP2x+1XedtXG/h91iO9E/w8ZBAeiRme
         u0Fg==
X-Gm-Message-State: AOAM533Yzgx46Fh78EZcSUjH0pns+40YiCSYtshTeJCluOVuyK4YSaZR
        7zUNKYhsqlqwapPHYkYKU9N0cbyv
X-Google-Smtp-Source: ABdhPJxPQQ9mdg1sd0xAUiJR7U4hIPdOX85hB3AT8Kd5x972tfsOsrooJGvHXnIdwDZ5aGC3r0CDYg==
X-Received: by 2002:a05:6e02:e10:: with SMTP id a16mr332165ilk.204.1596474020559;
        Mon, 03 Aug 2020 10:00:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:19 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 05/10] SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
Date:   Mon,  3 Aug 2020 13:00:08 -0400
Message-Id: <20200803170013.1348350-6-Anna.Schumaker@Netapp.com>
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
2.27.0

