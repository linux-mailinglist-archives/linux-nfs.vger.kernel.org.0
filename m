Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A2181C30
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgCKPVQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 11:21:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45939 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKPVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 11:21:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id d206so2303017ywa.12
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jw35QgMW7MwJGusg//NZzr2ZGt36eAHRBQXR/pHxX2g=;
        b=OOthlHc9D1JI8Xg68DEKAW0PtUVC5wJ7otp55LB4+gVZUhWHnN8Qkr8YJABUIUt33U
         f4px8L+O1UegsZCcRbh8NdlDS23ox3RgGdvT54ePyjsKiecgkDrTPPp4nMfugBTE7+13
         xAq2I0ClgQNO24tGpMYJeWclxdt7nr8P9C+YBfnzhL2Gy2slK8bGCqnkTgF4F5XSEi0a
         OwzWd/F+Zi+B0C3xRly5/joMZPBAmdQ3lSLYSbeEGGK1f6SKFCZ4+G9Pvlm+0r4CmAXw
         0yrDyJsCrCFjbzcNHZ4IcsUewDUHptXEi0jk/mH5+zMWuXqvjMeaXSvtbUNM9aO0cIk5
         ZJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jw35QgMW7MwJGusg//NZzr2ZGt36eAHRBQXR/pHxX2g=;
        b=mOloRhLGKDfctZbQWu3MPKwBsySGvYPBAYuUqGRZho8mzYTxdAYOmcACxOW+tvuhcf
         iErq8utWHnVzs2KxZodQ0TyQx9DBt4niZU4qg9VJp4Con9ryxfl9Z76UEcvipSNkUY+g
         Dr4MJHs3oUZQcjJUmo16Ic3tyBua71oVmwEszAH2CmV/Y9W5OoOpr4Tbi3X3Q2wVUs2L
         exJqlXea/XBsedo7GuIu5IM/46V1ThGm3uuww5Q7KzgtQ6e4QRyF11jubT6H1qPb3Vpx
         RxiWqc3xY1L4xWhCOlKTlGjDfYZcYJZVx8BYcueWqu/b//E/otbtImbEu9vp3/W7Kudg
         O4ig==
X-Gm-Message-State: ANhLgQ02esfl74dXrN0PzORj6FzqiQk5EWCWgyBggIgEb6F9C5t/wpxV
        /RHPUJf/1rU1zvO5xXx0X4/mm7Ll4nc=
X-Google-Smtp-Source: ADFU+vvXeF8fegZO9QzAUIXaHyvsXY6tvf3nV8EblrsLWjU8pIIwLx4gG32s7EOkmBFZ0tYfDIrKhQ==
X-Received: by 2002:a25:dcb:: with SMTP id 194mr3584119ybn.304.1583940073872;
        Wed, 11 Mar 2020 08:21:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r12sm9465857ywa.78.2020.03.11.08.21.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:21:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 02BFLCU4014820
        for <linux-nfs@vger.kernel.org>; Wed, 11 Mar 2020 15:21:12 GMT
Subject: [PATCH v3 2/3] SUNRPC: Remove xdr_buf_read_mic()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Mar 2020 11:21:12 -0400
Message-ID: <20200311152112.24642.43983.stgit@manet.1015granger.net>
In-Reply-To: <20200311151853.24642.92772.stgit@manet.1015granger.net>
References: <20200311151853.24642.92772.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: this function is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/sunrpc/xdr.h |    1 -
 net/sunrpc/xdr.c           |   55 --------------------------------------------
 2 files changed, 56 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a1264b19b34c..f0f0abef1a6e 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -184,7 +184,6 @@ static inline void xdr_netobj_dup(struct xdr_netobj *dst,
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
-extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e5497dc2475b..15b58c5144f9 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1235,61 +1235,6 @@ int write_bytes_to_xdr_buf(struct xdr_buf *buf, unsigned int base, void *obj, un
 }
 EXPORT_SYMBOL_GPL(xdr_encode_word);
 
-/**
- * xdr_buf_read_mic() - obtain the address of the GSS mic from xdr buf
- * @buf: pointer to buffer containing a mic
- * @mic: on success, returns the address of the mic
- * @offset: the offset in buf where mic may be found
- *
- * This function may modify the xdr buf if the mic is found to be straddling
- * a boundary between head, pages, and tail.  On success the mic can be read
- * from the address returned.  There is no need to free the mic.
- *
- * Return: Success returns 0, otherwise an integer error.
- */
-int xdr_buf_read_mic(struct xdr_buf *buf, struct xdr_netobj *mic, unsigned int offset)
-{
-	struct xdr_buf subbuf;
-	unsigned int boundary;
-
-	if (xdr_decode_word(buf, offset, &mic->len))
-		return -EFAULT;
-	offset += 4;
-
-	/* Is the mic partially in the head? */
-	boundary = buf->head[0].iov_len;
-	if (offset < boundary && (offset + mic->len) > boundary)
-		xdr_shift_buf(buf, boundary - offset);
-
-	/* Is the mic partially in the pages? */
-	boundary += buf->page_len;
-	if (offset < boundary && (offset + mic->len) > boundary)
-		xdr_shrink_pagelen(buf, boundary - offset);
-
-	if (xdr_buf_subsegment(buf, &subbuf, offset, mic->len))
-		return -EFAULT;
-
-	/* Is the mic contained entirely in the head? */
-	mic->data = subbuf.head[0].iov_base;
-	if (subbuf.head[0].iov_len == mic->len)
-		return 0;
-	/* ..or is the mic contained entirely in the tail? */
-	mic->data = subbuf.tail[0].iov_base;
-	if (subbuf.tail[0].iov_len == mic->len)
-		return 0;
-
-	/* Find a contiguous area in @buf to hold all of @mic */
-	if (mic->len > buf->buflen - buf->len)
-		return -ENOMEM;
-	if (buf->tail[0].iov_len != 0)
-		mic->data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	else
-		mic->data = buf->head[0].iov_base + buf->head[0].iov_len;
-	__read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xdr_buf_read_mic);
-
 /* Returns 0 on success, or else a negative error code. */
 static int
 xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,

