Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3B2615B5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgIHQyw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbgIHQZj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D7C061786
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so17743692ioo.1
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=HOLklOHDaXSue2oS/yvN0cog/e17ni3Nx9Ru6EZkYGMY4Jj2IfS48QyxFCRGN0NnlW
         Crryms6NtZtgmY9aFdCWx/oA2Ljsvz4x89OqCc9dmiklV9s3eNyy+9Fe2XXZByxRLyO3
         53567BVKYi+ys9MDqKvE4wfimNt1Tf5vGTsDIRD/HA53argidru+zJuW/4EEWCTeIHdh
         D6KnxFLCdAJxcb0unkJojeD1knjKVM+Kn6RajMp8FtqVSTXV5whmfOvEZx15Qnhja3/1
         pPXr2Ura71xvWmRJVH7YZNYwoihTk3clrBshmJm/xUM9MNH3bdpQ2U05dU311LC1Mq8T
         ic9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=a3Yq+Ds071Ei48DAm6CJtMpruB3Dg6MlmXW6WGQ6RE1tS8tyiosga/jESDCuEoI1ZX
         0L5yAWo0hEtNaT+p9FnTNzLXfWtDTscdNS4JhwEuI6Wb0mFc2C1NHaGhbjD6G9QFVkW9
         cP1rcPb70lOr3PIXggw+WqGt7TeIN1QSpsvGDnCGnjKztZn3N8klU4X72a0wHYsvOy3t
         eD4W3rUJrg/BiSfgc2zc/liTqIlIdAm3+KFSZTwyxSfai2Gp5ElcMByoLukLZWKSTt3e
         j/GOwO/MwEx3pCaHKcYg9TrrarzcSWoinNTRLpcrnLtlzQMvC2NtOObnUlcOW5LlBbDK
         4XSw==
X-Gm-Message-State: AOAM533Uslyna/QTqSlAMiOJ7Bxp5J+d0axlnBnIzgKZYkYFL4OBXNTP
        fA/H0AHg6uGZBRkigqxJDvGR7CEiloQ=
X-Google-Smtp-Source: ABdhPJzptgY1BptD2n/IZzNLzenaRcFIRIHPKOjNb8sWwH1xhbL5/ku/g45qff8dvQHVW2mRIAAn8A==
X-Received: by 2002:a6b:d908:: with SMTP id r8mr21727951ioc.21.1599582319516;
        Tue, 08 Sep 2020 09:25:19 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:18 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 05/10] SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
Date:   Tue,  8 Sep 2020 12:25:08 -0400
Message-Id: <20200908162513.508991-6-Anna.Schumaker@Netapp.com>
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

