Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E517D567
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Mar 2020 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHSPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Mar 2020 14:15:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41290 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHSPL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Mar 2020 14:15:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id p124so7843778ywc.8
        for <linux-nfs@vger.kernel.org>; Sun, 08 Mar 2020 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=c7q1TVrakNSr8Hp0Qov+6knvu2ojMNneY+lqdYOxbDI=;
        b=RSUwAKXuBy+aFp/CpBlLeHevseG2uKoMGTwlkJF8rFvc4YKlzL+HPQUHTwjwp/IUED
         L/M8ao83Xrdidw/GN+/04/YA1lF8Ac8xPOsPPE7mjFytU3PQNvV8NU+Khs6j2Og0Esvq
         jGPWo65Z4S1q23KZ8OXnqghg9XtXcjwZg2RsD1xPChLkVSk1FJ2Ex9K3EnhdfjKkGpuj
         DODaV45TeSFL162Zs5e4+v1nGMYU5zj71LMdLtjClb/qQeLmcf07zn0iJpe+z7v0mJ8s
         Zl1gi6P/msfpH6FoQ1AwdnURuQmODj6tkmgWKmvWmoIwuYOptJqjTfV7cEzfyme3Ehdy
         CT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=c7q1TVrakNSr8Hp0Qov+6knvu2ojMNneY+lqdYOxbDI=;
        b=k7qAvLe3lAreJf2a9yJ0PZZP5jdoJ+veVqrEF6dq3ZaEC9zLjF+3f8VTKVq/Xgp/WA
         YmZt9HHjRTWJ5FePHG8K0x9Yb3HyHGhnVfyFDICv2P/QqkNJSSu9iAKAT/ZyuqLwJN00
         MtkWhLyD9bKuoLPAwhgT+k38UG4Fh7Kbw+qkTCYqhWjDgBvhx5l+x1Ws+nZkVq3zgQb7
         gMz0JTJ0iU2PRJEKJo8DlFTLdGJKtxvy/yeM0Nzf96dEmppf308K0HNK+MIRfZ2kYKTW
         4s5HZ7j7YwKOWkWNefelZZKHxwgdJJ710qyJrqnXq6pCUmCxYlD0bR1nN0qdVKd9/ZW5
         ppVg==
X-Gm-Message-State: ANhLgQ2X5Kkh+Ef/Vq3QPc+EgSyIFrnDUeFZ27p+q/r/mW+4gJy5HYj4
        nt7TaSw4djrS8vTcxLTBzWk=
X-Google-Smtp-Source: ADFU+vsRGVsaQkGvhFMJGqcsEInJfu+/ro3nf0yIRzcqm7wdU3NPK0GP8Hxgke0BOWnW2xEwpkkw+w==
X-Received: by 2002:a81:25cb:: with SMTP id l194mr13718942ywl.379.1583691310691;
        Sun, 08 Mar 2020 11:15:10 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o13sm15426987ywl.9.2020.03.08.11.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 11:15:10 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 028IF9A5004529;
        Sun, 8 Mar 2020 18:15:09 GMT
Subject: [PATCH v1 2/2] SUNRPC: Remove xdr_buf_read_mic()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     bcodding@redhat.com
Date:   Sun, 08 Mar 2020 14:15:09 -0400
Message-ID: <20200308181509.14148.58149.stgit@manet.1015granger.net>
In-Reply-To: <20200308181503.14148.29579.stgit@manet.1015granger.net>
References: <20200308181503.14148.29579.stgit@manet.1015granger.net>
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

