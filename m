Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72E246E8B
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbgHQRdX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389125AbgHQQx6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52453C061357
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:38 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g14so18395976iom.0
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jiNvJbnLFGgDOvphREdkVCoh+Aoc1PwcHuuikbxvtvM=;
        b=PKCmSD0u+1OB7yGIvhgxaoAXWcCXHciNbRUTA50UZEgU9T842djtrj0kR9AceStDO8
         cCh6G1OaC0qqbtQXH1ILkd69C3Eu/tX7exWx/Ahthsi847sPivZQN+21tAsU4unE2nJ3
         QfNNlfet7XKDDsCpB/aRAE9/xea9RSmXOnrHGfdJOXNxLc7dViwUZVXprLySdTx329B5
         mQPhmmobm+zcSYMFJKWUo+L7ecJ+TTXxHrugyulHcrbwzarYjjKyMSZjXuFnLM7hzgXe
         vZqGUcLuiCsvlR4OzuxjZZd3B4SEUgmZsxM0cTx7UrPCcCgwoepTrX/ONpN4vTCvRWTn
         qV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jiNvJbnLFGgDOvphREdkVCoh+Aoc1PwcHuuikbxvtvM=;
        b=Xha01SLaDfoF7UzslyPvGh+8Tg08hyZsVVRnYdME9Z/EohK6VgF0jU4R2PXa8fNnDh
         dsWp25xj/AISAaLm6DURhaGj4lT6dKZyZbLBJSloEB0Ukx9/Rt/el5QI9Dp2ctxART4B
         SQMhxRJJQzpc/E5aPWhox8KWCQMA5Rygv2L0OrraAmC1KbBgMOTXSfD7dPvMJV7z0Rif
         Kb/64sG0OyUHul+wL6dDCCEmsRza3+KVpq40xX1fF5rS2xBUdKyEHBLHi7Y9yHW/ZWeF
         sdUNgqvUBYdV2CX3r7S2w+YYgRokxeiR2BBEZFxxktBDBXSOK7L2A+LusKDxsUkOsozZ
         TeOw==
X-Gm-Message-State: AOAM530pNQ6VbD2rdt4bf5ocRzK+0+uojBLGrA6uGzmOcxFO3B5LcToh
        4iKWR+nk675+bDLlgLo/MbH35hKW8vU=
X-Google-Smtp-Source: ABdhPJw1jUBAHMMkuLCEweP3RqdPV0wVdHk614L8Rak/fPmR2ZKtHTWOMr60mciCyQNctL8RRnRjcw==
X-Received: by 2002:a5d:9701:: with SMTP id h1mr12963037iol.36.1597683217412;
        Mon, 17 Aug 2020 09:53:37 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:36 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 08/10] NFS: Add READ_PLUS hole segment decoding
Date:   Mon, 17 Aug 2020 12:53:25 -0400
Message-Id: <20200817165327.354181-9-Anna.Schumaker@Netapp.com>
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

We keep things simple for now by only decoding a single hole or data
segment returned by the server, even if they returned more to us.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 055a944d043d..90f415944b90 100644
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
@@ -769,6 +769,28 @@ static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *re
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
@@ -795,6 +817,8 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	type = be32_to_cpup(p++);
 	if (type == NFS4_CONTENT_DATA)
 		status = decode_read_plus_data(xdr, res, &eof);
+	else if (type == NFS4_CONTENT_HOLE)
+		status = decode_read_plus_hole(xdr, res, &eof);
 	else
 		return -EINVAL;
 
-- 
2.28.0

