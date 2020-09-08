Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A212615B7
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbgIHQzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbgIHQZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:25:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F9C061757
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:25:18 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so17655044iod.12
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=BxTdTOY8+wr+TMS6hFAMDiXzC8CHZaP6WWdg2KDbbycf3k6mog7Tmpx0RDAnqmlS9O
         5dKVVW5NRkDozzbBRuucVcc02J1XX7ag02U1ZwX24QDXKwRKjrahja8kqA1Jym3HyCQu
         wu/Y8UcF4T6sUGevBUcaSjZ1P/mS0rmbD6PDUXRbyJh6KHyJanQvGnonWUBtnr9X/iOt
         iASXapcHUREsu7H+xuU63JfLGPCCb/DewjMDF09gB2kPpXIhQQS3B6tlISQVRozsCl24
         VaY9HhiMCyhfD4pcI214forYi9ETXFTMI44rCzE/gk1Mi1tMC1kuGQzyoZqoDgO4B03b
         X8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=DjHuBDRXKxf4UhCcERrzqszitWoAFiUd5vM2yy52lPMmG8vT+9iEMZNQAefXhf/GM0
         Y9qBkqy2iCfF7m46D/bG/DX50WSMetq7CZxUmGi4zDSKrieUmzmZiL5SBfXOKKQcEK6A
         Bgeh4BhpYNAqXM+KtsN5Vtu0VKy3eJH1MVrDoUW/lkgGaO+JCjm38sD3vM9eRvH5zXmM
         0raM9d43wg0+fYrQGdLH8Vp5Xbc7xxSDXShtxriATZCYiWXjX8L1RkXiXOM3aUbF2FIV
         YJAm+k2BdXSRRfepmexjQjl86YSDXAN2BIY4og9NuLf51bGPP9S16BDSIJnZMvuVmAhC
         FgXQ==
X-Gm-Message-State: AOAM531K5Dj9lzNrR/+Ndnt1gp1iKeRavBxdf/Rzi/qwlGXGFkqQSTaG
        0l9LRRVlNb0XCEbm++57ca2A3xLvO+w=
X-Google-Smtp-Source: ABdhPJyc9sgSzNRGJWddhtimVm1yxnClmdGV5dh1DH7edtPHaI4r/h7vk+hkXfL10AjjvP4YkgkgZg==
X-Received: by 2002:a5e:d716:: with SMTP id v22mr21605129iom.121.1599582317340;
        Tue, 08 Sep 2020 09:25:17 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 2sm10291375ilj.24.2020.09.08.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:25:16 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 03/10] NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
Date:   Tue,  8 Sep 2020 12:25:06 -0400
Message-Id: <20200908162513.508991-4-Anna.Schumaker@Netapp.com>
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

