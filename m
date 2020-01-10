Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD91379C2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgAJWfF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:05 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40909 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAJWfF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id i126so1318386ywe.7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DOB6QLf1qY1K4DKpSX2YipNAr81v05rvCURJAx9vk4=;
        b=TUzLeLgDn5ZDyNNcVRZuWrdptQnS+dJbmptfBJml7kSsS2H0HkxzPOIxFjLnjneo3T
         dLe2Os/oDL3aBvHMDxy5Hq0p9345UGGYBwxB8sFqcdtcQOqAhDdaz2jNDxVVAHwmGkcK
         U0AmdOSSLA0TAhCkDa192pRFo6u2N6cXovZ8i6IvhbrE9a8/WqLkgFB2CN0VJmYsHv0n
         /li/f5DGZFaWPGcvw3OZqG0TyyVK9ODtwPFb6pT2N+z4C/b4Cb0kicWxcpdvH/l9fCgE
         r57ACrQTW2BNHGz0WQB1eEZqCa6kr+mlSaeGr4bec5x8IbOsy2m/+yt9EZcT1cPYt6EO
         Ya+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9DOB6QLf1qY1K4DKpSX2YipNAr81v05rvCURJAx9vk4=;
        b=dji5IWWv4LMIaaR/JAuQp3pcoAYV29M1RlOX1xSQsPebJSI1OO24srnSlo9duKg7No
         cxB/IbDGyiW4xcBxLs+J4dSBJLxkwKmGA9EUlFKtFOitwm/jbotbmARlClGeISSmxJCZ
         xnT/jcDVD70qxxla59D9K8tXtW6j/chuek7t93cO4AXZwiKQ2BtdagOqqqbC+2xJ4Sbv
         kUKHfenOE482iFnluN+Zdw0q0EDe7deyzi4oyafw88JpileMNUPiqtUE6tjUnC9MGqWG
         VeVPETAdzKLWDcTN+AIq+Od6x2wCkMgN4IImHe40GVoEkYrTVgxyOac5ThuZOKvw85XE
         I43Q==
X-Gm-Message-State: APjAAAVTcdk27hDlyL0f5mcz1WsxAxy6zWlNwh4OTfAA5X7L0gBSQnzo
        LYJeJk9IeG4I/RUvvHrgsT3SxCYb0mE=
X-Google-Smtp-Source: APXvYqxIpgooEP48TqjkIVjlwGu+wQ1zYgTkzu//oamuRcYgtfQ9nq8EGqfhj2OXwVJa9XcEEpUKBw==
X-Received: by 2002:a81:844f:: with SMTP id u76mr4357390ywf.99.1578695704276;
        Fri, 10 Jan 2020 14:35:04 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:03 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 5/7] NFS: Add READ_PLUS hole segment decoding
Date:   Fri, 10 Jan 2020 17:34:53 -0500
Message-Id: <20200110223455.528471-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
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
 fs/nfs/nfs42xdr.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index bf118ecabe2c..3407a3cf2e13 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -47,7 +47,7 @@
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
 #define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + 3)
-#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ + \
+#define NFS42_READ_PLUS_SEGMENT_SIZE	(2 /* data_content4 */ + \
 					 2 /* data_info4.di_offset */ + \
 					 2 /* data_info4.di_length */)
 #define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
@@ -771,6 +771,31 @@ static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_re
 	return count;
 }
 
+static uint32_t decode_read_plus_hole(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				      uint32_t *eof)
+{
+	__be32 *p;
+	uint64_t offset, length;
+	size_t recvd;
+
+	p = xdr_inline_decode(xdr, 8 + 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	p = xdr_decode_hyper(p, &length);
+	if (length == 0)
+		return 0;
+
+	recvd = xdr_expand_hole(xdr, 0, length);
+	if (recvd < length) {
+		*eof = 0;
+		length = recvd;
+	}
+
+	return length;
+}
+
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 {
 	__be32 *p;
@@ -798,7 +823,10 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	if (type == NFS4_CONTENT_DATA)
 		count = decode_read_plus_data(xdr, res, &eof);
 	else
-		return -EINVAL;
+		count = decode_read_plus_hole(xdr, res, &eof);
+
+	if (segments > 1)
+		eof = 0;
 
 	res->eof = eof;
 	res->count = count;
-- 
2.24.1

