Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834F2284FD7
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Oct 2020 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJFQ3f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Oct 2020 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgJFQ3e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Oct 2020 12:29:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8CC061755
        for <linux-nfs@vger.kernel.org>; Tue,  6 Oct 2020 09:29:33 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d1so13531275qtr.6
        for <linux-nfs@vger.kernel.org>; Tue, 06 Oct 2020 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=j5ubhNrc23x16huwPiM0VcwHu8GvcgmLBcScImwl3yssBHwYwd0L8UbgwwDkqFnX57
         ky7zU4Stm/q9OmoA6G+ksK5nb8WFXCYrAYBHDNXn6sa25BWoSMuX4tE+uhr/uGwgPmYb
         PAjt8mFEAUn4ga83unsnuhcD1hg2Wr44ldAQPJ5E0FGboPrxa7dFKS5UQjur24bzeEb2
         cGTkJ16X4TRCqR85y1rAPqa1VOhszIYbQ2axPLa9Yjb3CEKmBKIdWu9Wde7wVo6BuHtc
         bHbLcK6Hv4YNYsSuxaZGSphblePTX/Tzj5G78gcM2H/r7Mo0LVhIMIVSYVG8U7spBxBI
         7WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oKdjF8WLFZZ+KSDTD6l3iBs66HwWOk9NAZ/Pz47k1uk=;
        b=N3NsT52fvW940VOx4C4wMhe2ELy2h4lmQrnkuirsRPBU8oJFrkxxNON9fSHMpy7jGX
         IhcisNMej0tAlVPXqSVyW0d5vZQuDYq3p+ENsamcTj36n4LH6ObqGEWpuEbR9RKe+Qvf
         BwoHUab+4dny1Vm1hyDOSEMxg8eJo/33dXKXFcUPFCR9j9Aqo0NxnbXP++hUjWHIwTLs
         wRwIFklE0fpG0ozpLu8pshLIp9ll9klji77RUWZNEhX9A6A6uGqIWh0G1A6s28HM46wW
         myIDgmFXCrZHp+n9w5t92QeMt9d7MI6hvsTHDKex5FHh+Ji8vmDXteLyA3b1tHied7jT
         J43w==
X-Gm-Message-State: AOAM533fWZKqIdJEVq/rCHyLv8jCPVavAhvhqOxG8B9Oles/8VgNRR7N
        vtotQ9DuEw6eNlXXZIYWo+SxLST1+TzpjA==
X-Google-Smtp-Source: ABdhPJxuU7uqjQeBTPl7GtNOJJNkhMVVBN9TDR1WprdE1AdA4I6UspQ8nC3MZE3/a4gp3RVAL3rgoQ==
X-Received: by 2002:ac8:5d41:: with SMTP id g1mr5958643qtx.101.1602001770686;
        Tue, 06 Oct 2020 09:29:30 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id q5sm2629984qtn.60.2020.10.06.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:29:30 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 03/10] NFS: Use xdr_page_pos() in NFSv4 decode_getacl()
Date:   Tue,  6 Oct 2020 12:29:18 -0400
Message-Id: <20201006162925.1331781-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
References: <20201006162925.1331781-1-Anna.Schumaker@Netapp.com>
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

