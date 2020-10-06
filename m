Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560EB284FD5
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFQ3e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJFQ3e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F85C0613D1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cy2so8286320qvb.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=HzZLKGDljsESr2mXusBTBkv3rxT/x2TWIFCjmE6VRZrCkmVNWyOhOYxMt3jKO9Fff1
         hmouwbAuFe2CrZdx5NjQf+3bqJz45z265/R58vkYRlX0szlqN6LLGy9G4jCppgIvpoaM
         g9l/Bjm0B9Tukf4On9OZjNBqYYHVBMA4RvA8wNN192q0ICTt/7E9mlqRvmWTJq1lsw9I
         hAqHZhr966n6RQkhPXMq+DJdcHhlhTqOK0OxfXQNa7/c+yTtDz74vGqXunEfJ0c4Xlyc
         M0XSK3OrGKDz/xVPFZlesdRymZtjdPEPNTPYH1kKPt2HyrXgwdc6wTAHW2i7mhmhL11e
         boZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sDycQp4p8QqjhUNfybr06rjLzMrYS09sHrxbwDXOUcI=;
        b=GILHhkSFjJWJZPYD73pTQr74/BzPvaulgCeGmni7pHkOEUyKsSW2zPxvfo8NY4kSJt
         b77v9RWgVmay92ik0yX/9BlcEepjkk4hg3LHCTb4ikkrGMdHKF5JMgao0KaC5OdCVSYE
         h53ItWwAx28ng94OwihEcJhGeBhfgScbckf9Sq5jK7BCdz2YYEmMDwOL2gizEPbISpay
         9D8fNUq5krV67Wmnwn2pdFU3xRQazz3Pv9GKR1iP/tcuDmjiTWd8U1qexnd7sL4S4V6R
         V+EbdWjHgb2FCa/gr7dsAJmF5Euu9OheZmPd1SWoc02up42k7PdbfGYHPk9I08K/ylj5
         m5WA==
X-Gm-Message-State: AOAM530MxRhDfguHLQ28OKQFeYqqQGHViMGxzta1WE6B/X/Syre4qPbj
        uGj6npoTDwJnZmGCzAL6Md8JU3T5Mm9Sgg==
X-Google-Smtp-Source: ABdhPJwFhq6XirALuuwjzuOKa6m+CtbdG3JoWoXhqIIub7nKI0kec54rKTQDpj6B7JR+FlVceK80aw==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr5740346qvb.0.1602001772627;
        Tue, 06 Oct 2020 09:29:32 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:32 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 05/10] SUNRPC: Split out xdr_realign_pages() from xdr_align_pages()
Date:   Tue,  6 Oct 2020 12:29:20 -0400
Message-Id: <20201006162925.1331781-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
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

