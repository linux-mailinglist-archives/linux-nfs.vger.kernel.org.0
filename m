Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E4727B2C7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgI1RJb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1RJa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 13:09:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571CC061755
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so1636671qki.6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Sep 2020 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wp5SKBozu7cWhnGG7XLzLGXTHYmhOkgCPiKlw5Gsgd0=;
        b=gigoVyK4rNgYaZmVJOlhm3zucWr75KVmGFHuE0PQqYGFCv6ycvKYTs4VleDd8pznkE
         x/LKDhyokdezCz1nF0HJhAowi3Rp7G1vhR2LO9jR2kKzW7HQOlYrJwctmafwyrP5DoyT
         McyhYR8Qx0sC37JR5cMveKPk1NGkaQ9owEon9EOlOy1lrzLfZt9X7bZ+28GUrEofx0bq
         ljaIMPP26JCEwN8kQCSBZf7M/hJeBbPXCjU0KJXoBV/ZOpLlehMpSbQksQxFfShSMPoG
         pK7MYRrfx+l3QzkpncoHHoi/GzLapiiT7AW+z1eoPjoFXfYD1c86rKaW/GDkp1uVRpSe
         A51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wp5SKBozu7cWhnGG7XLzLGXTHYmhOkgCPiKlw5Gsgd0=;
        b=BKqxeJK4wqYDqDDonHXVrWBjOrPCEyG8B2SffmLmzW+4wfF4I3RHWLAVgv9tEhoGJQ
         KMOPrfDbYtTRULtn/zZU3TwRhGgXmsXBWYB1p0dNNd4xp83cXoN4l9N3DNY4ALmCBr5h
         lswvkC5Yk15hRrYLsk8e7z5a6Rg40tsEW0/mJ+rbpRSJHFvwOarreTbCK19NEeixVd74
         23rJzvmTF2tiT0pazCPOybuuP5kuwqG+uYr/3D9AEwDMbol4m3YiPpE6HTtmhk46s3Sa
         D+XOuPP0HTVo5xxWUtEpCIv/3T62OfHB3gWtkAMnwdVKxtTuUbj6+PhhgpzcKTYUSL9j
         5pRg==
X-Gm-Message-State: AOAM530lRMfJC+CDj4smteF/FOojHI+f/YnRaHaFi9Zq2bAw5xIImTCf
        XAIN6q2Fw1OptbZd/YQ0V4OLQLSN9Oc=
X-Google-Smtp-Source: ABdhPJygd+whpcIcGYTnIukgELTnJM3++lLJCBkUMxAmtw+uyLbM862scfPyP7iZKWIGmo0yGMPDuQ==
X-Received: by 2002:a37:b55:: with SMTP id 82mr482747qkl.40.1601312969639;
        Mon, 28 Sep 2020 10:09:29 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 201sm1556862qkf.103.2020.09.28.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:09:29 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 08/10] NFS: Add READ_PLUS hole segment decoding
Date:   Mon, 28 Sep 2020 13:09:17 -0400
Message-Id: <20200928170919.707641-9-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We keep things simple for now by only decoding a single hole or data
segment returned by the server, even if they returned more to us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 930b4ca212c1..9720fedd2e57 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -53,7 +53,7 @@
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
 					 1 /* rpr_eof */ + \
 					 1 /* rpr_contents count */ + \
-					 NFS42_READ_PLUS_SEGMENT_SIZE)
+					 2 * NFS42_READ_PLUS_SEGMENT_SIZE)
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
@@ -1045,6 +1045,28 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
 	return 0;
 }
 
+static int decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				 uint32_t *eof)
+{
+	uint64_t offset, length, recvd;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, 8 + 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	p = xdr_decode_hyper(p, &length);
+	recvd = xdr_expand_hole(xdr, 0, length);
+	res->count += recvd;
+
+	if (recvd < length) {
+		*eof = 0;
+		return 1;
+	}
+	return 0;
+}
+
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
@@ -1071,6 +1093,8 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	type = be32_to_cpup(p++);
 	if (type == NFS4_CONTENT_DATA)
 		status = decode_read_plus_data(xdr, res, &eof);
+	else if (type == NFS4_CONTENT_HOLE)
+		status = decode_read_plus_hole(xdr, res, &eof);
 	else
 		return -EINVAL;
 
-- 
2.28.0

