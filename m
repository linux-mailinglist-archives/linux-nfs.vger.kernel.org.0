Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9253227B2C9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1RJd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1RJc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88447C061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c2so1631460qkf.10
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=bVg/ZV2VwDmjNQNJvs0UwPKunkLjs4m3sq29Bfea4c4s7+dsh4ee60got0pIgHha4c
         HYV7drreqsUjq8Sd5+NNt/CwvozbeLTRQJrJXW5kv/pA2xe5kfW6XDt9W8LB08Eqh+RD
         icTR3e1rM29Z/J83EGN533Hb4U4A0WLJsn9+QfZ/KMDEnHtdZ4JV62OAHdWvpG8AksGW
         q5DHv9xPSL6hy23WMecULg7X0Hx9W/uqaqiEptAYR4QmGDj364KUhpXvoy2S3A0qrc1Z
         G09T5O4ehu+ojQWJ9yGBQ11HoaN03kxFNC+NCXu6baRzrmG7BBBY2MJ8dTS9JM3ZInAm
         mFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=McNZrU0EDFV6A3TZqivdfUIZNz6mK+EHHnD6g+nLLJ8=;
        b=TB6x/VvFGSmYTLK+jJ+qtSOPft4yC0Lte0x0z5DAR1mKpG+JZtksx9eDJTTiEBmCR5
         xxqMRcYChsqAGCD+RIY6cRDhPhL/syLUG4EXz2VqIUScXVB538sbtoULVMp6kW4hZdIB
         6XmGL7WwV1/zleFU8+R5gOljIaHugKhvpSJpXuCksdIw2cyFqU0wk4+tcAhnePFo22/q
         vk/6Scto6kyf21sEHM/ym/d5UqexddHdjTQ4lPPu4wzLpREGi8selJSk+jcYf4hAVnQ+
         Sf7OLXKPiRUgqgd2SdHPErth7Vw2Zkdiup3qDVGXpLD/0kagwb1mFZPmrLH9Am77KTSu
         Ge5A==
X-Gm-Message-State: AOAM533CviSpSfOkTJDz/71bMjSXOw9u4ijT7xZ2I0RVxQJsouZ9C1C7
        FeIxi5znsvwrgFZr5yeFdcD98vYCGLY=
X-Google-Smtp-Source: ABdhPJw4lYZFEXcZbiuYbIfTqLcQIn4Y3txOjrjjquLvPNtsVx5st05wFXKCK+GBI2vHqjOcFoeNJw==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr458526qke.26.1601312971495;
        Mon, 28 Sep 2020 10:09:31 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:31 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 10/10] NFS: Decode a full READ_PLUS reply
Date:   Mon, 28 Sep 2020 13:09:19 -0400
Message-Id: <20200928170919.707641-11-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Decode multiple hole and data segments sent by the server, placing
everything directly where they need to go in the xdr pages.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9720fedd2e57..0dc31ad2362e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1032,7 +1032,7 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_align_data(xdr, res->count, count);
 	res->count += recvd;
 
 	if (count > recvd) {
@@ -1057,7 +1057,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 
 	p = xdr_decode_hyper(p, &offset);
 	p = xdr_decode_hyper(p, &length);
-	recvd = xdr_expand_hole(xdr, 0, length);
+	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
 	if (recvd < length) {
@@ -1070,7 +1070,7 @@ static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *re
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
-	int status;
+	int status, i;
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1086,22 +1086,24 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
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
2.28.0

