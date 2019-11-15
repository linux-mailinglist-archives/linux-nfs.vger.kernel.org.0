Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3D7FDF13
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 14:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKONjM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 08:39:12 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39213 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONjL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 08:39:11 -0500
Received: by mail-yb1-f196.google.com with SMTP id q18so3999363ybq.6
        for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2019 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F2vKi7O29y3vzWm17oplTR0BplBi8AB0aKFIYgZZVt0=;
        b=I9wgieH0HLwOdy704EttagDTG1iVucvVxXlFmUG64MnTf1jD2Xi6kNW0e3EXMGGVAq
         yNBVRefNxWxdgjsHr6Iv4RrPyYg67dKVvAkmUxg3pU+wVIdQT7vevRyVBufF0fIvL/Vd
         iR9yPptJv2OBzNMG903nEkI7SO0lB79k9KdLs52gom/J8iDWh0563M5COI+QCr+yEPyn
         rf+OQCG6Dmzg+/c2pWyfCDG8R8oQwyvSNOweTDtINn+KrAjlhJLedIy7UEDvpNJ1cTPa
         RXo0lalsjgCWj66CHbn6n2xx929H4KU8va+m8DQBlmt5VGiu1it3yGj24wiEjCk5TFDS
         zYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F2vKi7O29y3vzWm17oplTR0BplBi8AB0aKFIYgZZVt0=;
        b=Om92gnazd8lBYt2CZ6Kh2AtCb+rvqD/oLwrgNsfdDtfhc20B2NzTpRR+XuDPA0+5+c
         7QqUgOgZQbTbKBJma/H8xsYsn3cQdtHEGOfd9fHnUxknBaLwkyytKUGCKsSL5NIVx3Ui
         WtSBYsmWiA7f2JTXAtEmNmHp40nVNUNFTj6o6sLTEpzH5X0v/leR8GHqEOA7voJVgRUY
         iQQjGncUMYAE2GWwoxlCYyw+eB9hqt4Qa/Cg766s6h2G82WMKXZx+hr0B+UCq63xSjL1
         2NSDNqSQaY4gRwWcSv/Tsumwwt5sVjQdiT7uXn7AlJF/RdrgWvytPOy+fovWmouw9pJP
         UfSw==
X-Gm-Message-State: APjAAAV5+Pl1PC/TDOaPa5Gd2H3BPUVOJ0NkyAngms+ORWXxp2XQBkDE
        LnEjGziRaVHSZArmofwEmPs=
X-Google-Smtp-Source: APXvYqwFOfcV/jCzfUdNnKj+jidm0IR3gx4FJCXi+SQb6yfkCNlrtEIjtVh1Y30Y2IOARBAzEFh07w==
X-Received: by 2002:a25:c7cf:: with SMTP id w198mr11336681ybe.507.1573825150723;
        Fri, 15 Nov 2019 05:39:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z11sm4013103ywk.12.2019.11.15.05.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 05:39:10 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAFDd7jC016715;
        Fri, 15 Nov 2019 13:39:08 GMT
Subject: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     bcodding@redhat.com, linux-nfs@vger.kernel.org
Date:   Fri, 15 Nov 2019 08:39:07 -0500
Message-ID: <20191115133907.15900.51854.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
This can happen when xdr_buf_read_mic() is given an xdr_buf with
a small page array (like, only a few bytes).

Instead, just cap the number of bytes that xdr_shrink_pagelen()
will move.

Fixes: 5f1bc39979d ("SUNRPC: Fix buffer handling of GSS MIC ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 14ba9e72a204..f3104be8ff5d 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -436,13 +436,12 @@ __be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int nbytes)
 }
 
 /**
- * xdr_shrink_pagelen
+ * xdr_shrink_pagelen - shrinks buf->pages by up to @len bytes
  * @buf: xdr_buf
  * @len: bytes to remove from buf->pages
  *
- * Shrinks XDR buffer's page array buf->pages by
- * 'len' bytes. The extra data is not lost, but is instead
- * moved into the tail.
+ * The extra data is not lost, but is instead moved into buf->tail.
+ * Returns the actual number of bytes moved.
  */
 static unsigned int
 xdr_shrink_pagelen(struct xdr_buf *buf, size_t len)
@@ -455,8 +454,8 @@ __be32 *xdr_encode_opaque(__be32 *p, const void *ptr, unsigned int nbytes)
 
 	result = 0;
 	tail = buf->tail;
-	BUG_ON (len > pglen);
-
+	if (len > buf->page_len)
+		len = buf-> page_len;
 	tailbuf_len = buf->buflen - buf->head->iov_len - buf->page_len;
 
 	/* Shift the tail first */

