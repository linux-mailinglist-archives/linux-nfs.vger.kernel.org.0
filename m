Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0A23AB30
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHCRAZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgHCRAY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 13:00:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59500C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  3 Aug 2020 10:00:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so30319296iob.3
        for <linux-nfs@vger.kernel.org>; Mon, 03 Aug 2020 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XKKgP0H0vf+KZtXz13oZQXMZRxws2V9QHF/uSVmIjA=;
        b=EsJnnXbNOatiZBi1Z7DIp4IYrYgDQ/9O6ADdLFsh3IjIZIdpyvzcnU0jQxcU5astmW
         jVBIUy7XYnPZDGvlE4XSg58dav63awhr0ADTHwkQSM0UBVa0goBVddhipmRcO2qx+nPK
         xdSlNPA3P0D3G3ZWzcpx68S8DN/uhCXozC0e8aZqV1+i0rv3R/jIyQIcoYo2HElURWwj
         S61AUELtFPRktPOtv835WgBfmJB/8EBYOKgpM7jSZmVnVjpwiKuQafC041DgwP+/RlLM
         x7Ewf79Y9nNT43ZnQwEUnyucs9FoFEdyKZGUn1ohKNFDRvIaeuNhEmZCz5W8GPWtdzja
         OGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3XKKgP0H0vf+KZtXz13oZQXMZRxws2V9QHF/uSVmIjA=;
        b=WuwPda5YNAnkV3UICjkya8eM0b2KPTMo6hXqOAdjLupGZCGVxJnmt7S78b2cGoLa7h
         +9PFBSnHoWc8b1Osjsdu7mfnvOvyo83PHdQbvEu9NzgrlJI6yCn3gdGDs0dI07PajvUP
         e8irqnA5qo2HwG+W//HanGeunTHxXjQFTKC5hc5i6pxy8nadAmwcEBwx2o2rUojNcZq4
         M39C4vLid+sWhLzp2K/W3CZPlVbpnXVPqwKXV2hISB8p6uWgHkv0kz6e1QyOkTz/TXV/
         5g1E3L+SaRPNlRK6JQ5z67FhZDV4fsXbu6oqxSnIQuv37MumhmeF119wM7LGkulSpJn4
         XB2w==
X-Gm-Message-State: AOAM530wXiWtpS4ri9qssd8Ctg/5QZxwVSNoaLNXsGfhGxlf6iZUAjmj
        6Wo6KodQUgNM/HpYhlOZuHqYCt4c
X-Google-Smtp-Source: ABdhPJyf1ACQRf/PP2RyJ0Lqp0pQNC6kzldKP9ZXsIYAXz7kJVB22jbxAhq1eVN3EERh9OZJAEO0ag==
X-Received: by 2002:a5e:8408:: with SMTP id h8mr757269ioj.137.1596474023466;
        Mon, 03 Aug 2020 10:00:23 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a6sm10498040ioo.44.2020.08.03.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:00:22 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 08/10] NFS: Add READ_PLUS hole segment decoding
Date:   Mon,  3 Aug 2020 13:00:11 -0400
Message-Id: <20200803170013.1348350-9-Anna.Schumaker@Netapp.com>
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

We keep things simple for now by only decoding a single hole or data
segment returned by the server, even if they returned more to us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9a1e18295e55..791e90353bc2 100644
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
@@ -768,6 +768,29 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
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
+
+	recvd = xdr_expand_hole(xdr, 0, length);
+	if (recvd < length) {
+		*eof = 0;
+		length = recvd;
+	}
+
+	res->count += length;
+	return 0;
+}
+
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	uint32_t eof, segments, type;
@@ -794,6 +817,8 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	type = be32_to_cpup(p++);
 	if (type == NFS4_CONTENT_DATA)
 		status = decode_read_plus_data(xdr, res, &eof);
+	else if (type == NFS4_CONTENT_HOLE)
+		status = decode_read_plus_hole(xdr, res, &eof);
 	else
 		return -EINVAL;
 
-- 
2.27.0

