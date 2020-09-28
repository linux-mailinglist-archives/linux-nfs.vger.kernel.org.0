Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947627B2C4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1RJ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgI1RJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB35C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x201so1253200qkb.11
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=ik6Tf1sqR+mUChedyUAeezbTX/bd5l5okjGXLXx7KXsNCGZs/CXrv3OGN/4mXU74KO
         4rTTX4N3zrDdDG1HYUwbvLXqgps6mI+uKxZuL2SYCGER1TKE5oC4d7gw1fTSznlS1SW2
         Lq8lZKttvzRBqOIqSKcrZuOfyBqzmFG4ljO4RAro0vkTAVOaDxRJ1RYBdu8IMG/CznxO
         DNKYxCZjDwmVddCVCsAHKu7coSKeYir/BuJiEwuZ5uJO0YfuS2BR26eV76pCZmv49jNs
         10OcCYRSnKtb3QKvd4CaZGYFqyrakwtA2ovtdAQZeRzVhnu/6tZAnZCxa1Jr3kEL7cWU
         Y3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=LQwf6Vbluin+KodCN7TE1F5N1uKcTM7ZE1trTzGFWUSSF6QYGtoGFrDuDuksle6e8u
         Ut9UvFBp9pTAiO5PH+R+4127tGD4/KmmI2BI0IeXsNQumlBWVze5zWxqXO37NkIEijic
         3vMP9SF9jlQpdSM4LZVbZvKKC1oMch/nV/ckpcnkeWqh2zcU9F75xOZL+n2/HanJrWap
         wg3nQ1VZmPTAc+2k9QChnDQNt5Awptwd5TgqvMpge8FuAZFOin+nPHo2FlKf9KRaTYMb
         ox6PEgQrGHDUqTjtpT/mqb/lst9f9yW1YBvvBgmu5uaT+ChzCoKlQpd6Os70PB4Vrpw8
         srMQ==
X-Gm-Message-State: AOAM531H9NC8bw1Fo8TlVM2oJADPHwS6UD4mJ2WVrCH64AvsxQbVu6r5
        MPueL+lAF4lvgW+6eDZyJAvUmkJmkXs=
X-Google-Smtp-Source: ABdhPJyi5q+EBDsxI61+6cM95cWTeOsnJrNN3DVEOCGrSqE1oESIEYdWBVe5BXOrkYaN+JOoqzEGkQ==
X-Received: by 2002:a37:a207:: with SMTP id l7mr481217qke.64.1601312966697;
        Mon, 28 Sep 2020 10:09:26 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:25 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 05/10] SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
Date:   Mon, 28 Sep 2020 13:09:14 -0400
Message-Id: <20200928170919.707641-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

