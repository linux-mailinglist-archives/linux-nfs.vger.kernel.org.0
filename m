Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D653C23AB32
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHCRA1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgHCRA0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F3C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q75so31088142iod.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGONlmzroZFZ4wFhQmr90OCGCMV8PUtcRW90Y70RUIw=;
        b=uDrVzWZkLEeyPlRHoKQQGMHu2QPBeYqSHF8W0c96t+x0W7MswhzAffs3L6d97UZefl
         tTt6w8Xr56Hdq114LRLDXidkrKC7AYkNAZXuSD4pmWXO2vfs58Wgh3aKmZEkeAYFnYQM
         nmYiY3i17RaJPcuaUNAyU0DLvDZ37jGpXKNHRc8+sl222jpIp3dSTw+6ceSQcAg62Z9M
         oBxXFhB43wUg4tB90dK+6ii8fAhczE3HeczlvHTmrqpDY5lVgqtr2O+KVIv9QuCbhlpS
         jFO0JfZOpO/FNedC+4Z1rJXnnyP7aEb3B/i1GgTDHVBJT3Tk3UlYWtwFCad+yPpeaJnw
         3lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bGONlmzroZFZ4wFhQmr90OCGCMV8PUtcRW90Y70RUIw=;
        b=eQF3Q1ROiNYJGV1rI2hsDk2HXE1skRGwd7j2Zq52nHpqgnwa4xNafS71g0XAaXIOiO
         zfwpWa1FVnld02GarfqiDdxHPB6dNlOQMxb2VOGg5U2EdcqqhGaoX11VMUrGXDX3/Sv/
         Au57q5vVVDgpfkQByEcMmbeNtHcxoJsQUjRiPmrKoXDAdyZGcXCmivwNqJXT0/enx/To
         DtIObDZzfWC8TVxy7Eq0UTDiM7yNeocCZChJLFj5wptN5YzPpl4QHI8jURjrRxQM0g4P
         xWE2JFR/7UYfv2xlAupPNzK1mrf5ZYDHTz5qR0BjbGnKAsOGK5IvxK+lll27qjtWkWCR
         7VnA==
X-Gm-Message-State: AOAM530UX+c7YdxnYZz4RuFE8nKFEC+AdNvZ4i+XrGNN7d7MXNzA9Jbt
        3XSSWgjGbuIPLb7MpRf3p+DCuKTt
X-Google-Smtp-Source: ABdhPJx6Ytiki2aRrjq0dG5uDZR0aUzRQz2FajmgWy2m3sOzRNkQFEsR3tfa6iRKmoQ4txuQSOtI4g==
X-Received: by 2002:a05:6602:2503:: with SMTP id i3mr758016ioe.165.1596474025678;
        Mon, 03 Aug 2020 10:00:25 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:24 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 10/10] NFS: Decode a full READ_PLUS reply
Date:   Mon,  3 Aug 2020 13:00:13 -0400
Message-Id: <20200803170013.1348350-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803170013.1348350-1-Anna.Schumaker@Netapp.com>
References: <20200803170013.1348350-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Decode multiple hole and data segments sent by the server, placing
everything directly where they need to go in the xdr pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 791e90353bc2..c31c6fadee19 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -756,16 +756,15 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_align_data(xdr, res->count, count);
 	if (count > recvd) {
 		dprintk("NFS: server cheating in read reply: "
 				"count %u > recvd %u\n", count, recvd);
-		count = recvd;
 		*eof = 0;
 	}
 
-	res->count += count;
-	return 0;
+	res->count += recvd;
+	return count - recvd;
 }
 
 static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
@@ -780,21 +779,18 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
-
-	recvd = xdr_expand_hole(xdr, 0, length);
-	if (recvd < length) {
+	recvd = xdr_expand_hole(xdr, res->count, length);
+	if (recvd < length)
 		*eof = 0;
-		length = recvd;
-	}
 
-	res->count += length;
-	return 0;
+	res->count += recvd;
+	return length - recvd;
 }
 
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
-	int status;
+	int status, i;
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -810,22 +806,24 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (segments == 0)
 		goto out;
 
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
+	for (i = 0; i < segments; i++) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
 
-	type = be32_to_cpup(p++);
-	if (type == NFS4_CONTENT_DATA)
-		status = decode_read_plus_data(xdr, res, &eof);
-	else if (type == NFS4_CONTENT_HOLE)
-		status = decode_read_plus_hole(xdr, res, &eof);
-	else
-		return -EINVAL;
+		type = be32_to_cpup(p++);
+		if (type == NFS4_CONTENT_DATA)
+			status = decode_read_plus_data(xdr, res, &eof);
+		else if (type == NFS4_CONTENT_HOLE)
+			status = decode_read_plus_hole(xdr, res, &eof);
+		else
+			return -EINVAL;
 
-	if (status)
-		return status;
-	if (segments > 1)
-		eof = 0;
+		if (status < 0)
+			return status;
+		if (status > 0)
+			break;
+	}
 
 out:
 	res->eof = eof;
-- 
2.27.0

