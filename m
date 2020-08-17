Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDF246D5C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbgHQQy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389121AbgHQQxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5EAC061389
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j9so15080122ilc.11
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13EkI7FH7EOEPP7S5oqrHiGwS8jiaTI8LAHREatvZvs=;
        b=GRstMKD8jf06ye5RK0LLhX3X1p/p2jOEROhPz7SUrYoA60zkbfESx+XNxaXvm9+t+h
         f0/8JGNYJCx3FMTrh4rH+q5YNkh/8bDyEr53jeqPaL0lgf+2F4f1KPlhTk1McGP7rHmF
         8oqKeRE6S+XBCk4Ls1K0PpNILTq5wWmpO4+LEXWlfAiXp0gbAjhm2dBmldIZifoc1brS
         kLBDT0J63k4J1znH51HcljZG3ArZOSdaaVFJSHqORvMuWwQZj9126f2Ag/L9pG0mgj4o
         iNddJ+5p/+l5XHuVCl07XocGBa+KfxCFFNXafdtvv7auXhnPWW21s2EXEe/cSL9dmwwF
         6lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=13EkI7FH7EOEPP7S5oqrHiGwS8jiaTI8LAHREatvZvs=;
        b=M1LzBNM6i1EDbw9gmq5jn4+eyYcHj0xPzHC/kFZevngZO4aHIHjTnFJTn7KqvhCaSJ
         67aCC+pupxB9dcvS4juFIoaib4dclc+oxJ76y2QQix1geJdq/3cyec8rVtQYQ2/QTpaf
         9Q81zIvoi3YwECeW46pDvaoHwIppzRAscs9cHH2KTRuVOVyqrDNhMgeR6ZvTwRur1141
         JxSS7v4e4Zic4/vE7WvXdUO++xhHg8GV1FBMLyuzRsjpPdkVpLMk4hzxE2wZYdfKN0NO
         xuBx1QM7CA1AIgPhSMoZ74DIrJA1k/XrU2g1ypE+fGHPWGNCTZ+0GBkUpyHZMs4VTTr0
         1vBQ==
X-Gm-Message-State: AOAM532obhYnUCMIxEtUKpQ4u6hpVOfksblOhz1K8sqbTEQEQJqluoKj
        XfrnA25NIQy7v0i8yGOb8RPzHFUjIQA=
X-Google-Smtp-Source: ABdhPJyei7g5X/2C0HFNQua7SPQ0UT4CgKgwPxN9elyVMc4dQ7y2ov+RB5QbmxWH2rMu5ooIAXAeOw==
X-Received: by 2002:a92:6a07:: with SMTP id f7mr14754550ilc.163.1597683211842;
        Mon, 17 Aug 2020 09:53:31 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:31 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 03/10] NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
Date:   Mon, 17 Aug 2020 12:53:20 -0400
Message-Id: <20200817165327.354181-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
References: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
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
index 47817ef0aadb..6742646d4feb 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5279,7 +5279,6 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 	uint32_t attrlen,
 		 bitmap[3] = {0};
 	int status;
-	unsigned int pg_offset;
 
 	res->acl_len = 0;
 	if ((status = decode_op_hdr(xdr, OP_GETATTR)) != 0)
@@ -5287,9 +5286,6 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 
 	xdr_enter_page(xdr, xdr->buf->page_len);
 
-	/* Calculate the offset of the page data */
-	pg_offset = xdr->buf->head[0].iov_len;
-
 	if ((status = decode_attr_bitmap(xdr, bitmap)) != 0)
 		goto out;
 	if ((status = decode_attr_length(xdr, &attrlen, &savep)) != 0)
@@ -5302,7 +5298,7 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 		/* The bitmap (xdr len + bitmaps) and the attr xdr len words
 		 * are stored with the acl data to handle the problem of
 		 * variable length bitmaps.*/
-		res->acl_data_offset = xdr_stream_pos(xdr) - pg_offset;
+		res->acl_data_offset = xdr_page_pos(xdr);
 		res->acl_len = attrlen;
 
 		/* Check for receive buffer overflow */
-- 
2.28.0

