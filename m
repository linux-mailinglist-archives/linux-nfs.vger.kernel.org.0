Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC0100818
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKRPYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 10:24:05 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37782 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRPYF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 10:24:05 -0500
Received: by mail-yw1-f68.google.com with SMTP id v84so5990517ywc.4
        for <linux-nfs@vger.kernel.org>; Mon, 18 Nov 2019 07:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oTH6n80QwdCPAV1kGAoC8+FWlddC/DwtbOGp6xTF6Sg=;
        b=DFdsPsRgvxWTft85jHb7qu5a5EWJMB50YDV4JfxShdR+wn/GB1W7kpF0VJw0pH/9rs
         UvC5fteZmPtrVLV0ng5jFO3xfDl4j0nTegCEnyDyLiTccnt0Zvsm2mky3JT20mV/V6h8
         T+5ZNx+EqgAjx5wrubef+vYO+TESq/PxP1vEaIQmr9afHimhRBYjM3JKjFcIHBt5NBFT
         OjN9eYJHw+Wz1eiGAXBjKtSKTusgXJAYcipb+tQMr+ll8RBapzQMZXHbrhRwaKFtxsh2
         K2bK3xdN1GF0FWRd+mWhU+2TJy8kJunAlv57m7+BX3TG8ftlyK7UKQwYy49scPX8HHOw
         4yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oTH6n80QwdCPAV1kGAoC8+FWlddC/DwtbOGp6xTF6Sg=;
        b=Dcd5Ki70GjbMfjLYxS70NL+OPKBnlnRKPdu9x7MRvKeWM1w1V20pcLhOy7Ts5mF2Yx
         iSA/zi699ViWhkOCwTpaIqM+BLQMyhSug4ficx4P7xg77p4XC2ku3sfJ4lrXKYCgdmV7
         QrJRxnJIzbYwrCUL7VR4R4EjXGgNQjE1MTqbSx5GN4fBNvcJi+CJ6lbTPnnuH9e96IED
         LVYAPoEOD+2AXMIUNIiNiBjCKoIRMd6fdRXP0PTlIek2+4WR468OPfbfvFZ7ALhJ13DV
         oHFhZA2V8zd6rVyE/xcnouFfIQQoaTxhtQDQoa6TbuYg2CaDG+GzUn1wI7iOzD5hZvpS
         NRIQ==
X-Gm-Message-State: APjAAAVbMIWkl+W8qQ/kuEl9J9q8wJRX8PS8HAPtxF+sb9ajPF3r+iJO
        gdg5PR+kcMPKRndDSW+E2zw=
X-Google-Smtp-Source: APXvYqwZXYSRZDxgK0DA6w1BUX++8xbqtxPWGnDkkjCjR92hix5uVKzIwH/BQ8GnEobqRQtKI4K8gQ==
X-Received: by 2002:a81:3154:: with SMTP id x81mr21421755ywx.164.1574090644112;
        Mon, 18 Nov 2019 07:24:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v5sm8396045ywi.95.2019.11.18.07.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:24:03 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAIFO1AF010550;
        Mon, 18 Nov 2019 15:24:02 GMT
Subject: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 18 Nov 2019 10:24:01 -0500
Message-ID: <20191118152315.32316.21324.stgit@manet.1015granger.net>
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
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xdr.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Hi Anna-

Just wanted to make sure you have this patch for the upcoming
merge window for v5.5.

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

