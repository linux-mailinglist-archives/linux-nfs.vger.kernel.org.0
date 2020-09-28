Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32D627B2C2
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1RJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgI1RJZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E299C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so1637915qkd.9
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=i0Pa6pUK+ngPXPw+vA3OOd5WVIxMZ41n093yv5aNwVBqrLOB99FktVf8Ehw6Nf/vW6
         zb2yvMxMchTO3XgtoB0LGu5wBJcW82gknv/CMxEZT+OsGo44kZMJB+3sslCW8Zm21yqy
         hYrWKKYZuQ12hk6WmqfURSl2+nX66l2WYJ1QxSe60S7NcGJPomTiu5rUQIING0m+hiQf
         kxD9AIePXSESt2qg08leu2I4Krv6HpAuT0lFPDX/8YUKebCrny0S7t+hh2ucoXP6hlRQ
         Zd6GaUpdITDhu54eP+XIIW/DA4YZFth+fUUi5EdrUNURHV3LA2/oP/E1dtkvOtBViAju
         Hj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=gKr/TtvTeBpjmf9rUp5y6gObdJsGsWSSbcUTDcIC/PuQD31xS1X0Ik89ShGXELv7WD
         vw8FpOdpMEnA5SuJwOa4pC1mpJ7XAs9CDwkKA/33m1kWcpAF3ZAnJnq7KM8FxDKLLsUr
         RQ8mYZQj1IXtFyZqhJL9AyOtuqlDL8TVMLFzlRUJbRjRY8DttbZAC6TGJUTEvmGSKD8a
         cLZZ19kfX8txxmTfoaWspaTc/+yhrdXYgT6iwoDF6wlveNMhq5pdjETPHKoI2iN5Xkjg
         va569s+wkP7cE9IJagwFv838oKmIUmCKBslzA3oBv3M51fOaWT8v/xuWg8SfBwVg6LjX
         BiMw==
X-Gm-Message-State: AOAM5321uto5QFNJGb9YWiCuHDy7ACcV6A2cjzG2Mywh2Yuh+MSnJ4Vb
        h/L6n57ShXfqZcNrpeAzIwqlXZ1fP0M=
X-Google-Smtp-Source: ABdhPJxFy8x8HMK839+7v4q1P6ge1NhRafTGeMgZpEdloEV0FnnQzDQQhHNA1s1WcD4kWznde1tcKQ==
X-Received: by 2002:a37:51d5:: with SMTP id f204mr406137qkb.145.1601312964304;
        Mon, 28 Sep 2020 10:09:24 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:23 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 03/10] NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
Date:   Mon, 28 Sep 2020 13:09:12 -0400
Message-Id: <20200928170919.707641-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4xdr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 0b3510f62623..3336ea3407a0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5308,7 +5308,6 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 	uint32_t attrlen,
 		 bitmap[3] = {0};
 	int status;
-	unsigned int pg_offset;
 
 	res->acl_len = 0;
 	if ((status = decode_op_hdr(xdr, OP_GETATTR)) != 0)
@@ -5316,9 +5315,6 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 
 	xdr_enter_page(xdr, xdr->buf->page_len);
 
-	/* Calculate the offset of the page data */
-	pg_offset = xdr->buf->head[0].iov_len;
-
 	if ((status = decode_attr_bitmap(xdr, bitmap)) != 0)
 		goto out;
 	if ((status = decode_attr_length(xdr, &attrlen, &savep)) != 0)
@@ -5331,7 +5327,7 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 		/* The bitmap (xdr len + bitmaps) and the attr xdr len words
 		 * are stored with the acl data to handle the problem of
 		 * variable length bitmaps.*/
-		res->acl_data_offset = xdr_stream_pos(xdr) - pg_offset;
+		res->acl_data_offset = xdr_page_pos(xdr);
 		res->acl_len = attrlen;
 
 		/* Check for receive buffer overflow */
-- 
2.28.0

