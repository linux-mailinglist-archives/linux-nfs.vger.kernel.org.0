Return-Path: <linux-nfs+bounces-3714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAA9062FF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999A81F216A0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209AD132804;
	Thu, 13 Jun 2024 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npL0HhkW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B04084E
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252267; cv=none; b=MjI60OjvJ7d3D54KY0dP0DXThUxi0Gk3qwNtw1u1tPBRqlp0PAPZKQcpzMuhhrGBjHbVjel4rPqGIVKC6wc69Ax1OTwZD0XMoS5cmSaYzOWcExN61jV2pDgNneALOS9CUmK1zRTbLd8MJYTGQVXoqYRyacNhKJrtGhcEqZsrRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252267; c=relaxed/simple;
	bh=Zir1trA8aA0mdOMcxTqe6KNFw64sqlwAtuGb9oZl+vo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7StJt7krHFTNVCxwAPwuagrPNCjI2jLFz+ydTMVnXfQULSIHANrYhip/Z18tWGEMgAKsCuZEUG1KJwuGHz6kz0zgOdG0+7Ov1rQRrlxkXGweHFTjv0JWDYpup1ej+ad6KcW04Nl7N1Jh6o5PCUdbGBbK+pHZdJq2/BeAHCndTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npL0HhkW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so2772286d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252264; x=1718857064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HpetJNYjrXkHtczPdfKK2xFtaKCa5qOKIfYi3lbXsA=;
        b=npL0HhkWjapejYYLEbYRJx0m89NK3EEvurN5hv5WUbqT488MfDpJs+5DhPggOgVbGh
         l4BQ79lTOAFBDc0e6lHB9lYZgxln9dsLi4PehjYgbgOLQ/TufUjnxXglYzttnM0Tl83v
         SkCzeSwmWbNyIj0zdI6Xlex+hR3gCPbBTro285iskFFWbiwXemMFzQnI4Mt1DbSZUHx6
         m0yzRhi27dKnINBoxZnJrrSJSl97KJNt4j6rUjFkzp3p64vjKToIZfTizb7r1kLXA6Z/
         pBjamTBjLGazGtAXiN1RiLzE6qYuk+monubakDf9JrQf7pcPYDO17JJig/qf7/unjPEq
         epjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252264; x=1718857064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HpetJNYjrXkHtczPdfKK2xFtaKCa5qOKIfYi3lbXsA=;
        b=sjjHnxft7v3cxwQYLsSwWlD2WX8gvqX+d26Iq9YtM43ZQFDD/Y2qIgm/Ggn4vrXk8V
         1TcnglX7GkMzBJrVrCIrX27pPfQYO/SNBgKbSlTBxCYuVDWGxzHoFxImXisFLTnXgrqb
         KB6Rv7dTW0IOrWcgRmrOawD5UzaP1bMgZxmMEAkkG4AN9ZubF5ZUntSJY+ze0NPjhA8d
         OSrkeVSMXxx8ulGH8DrETJZ2Yr6MiR7SfOgo/gHIM8SebWMPc4X9XRPr0QLeVH3lCtyS
         KEhW1SqAdjhlxgMqgD4rzA+dRsKJjpj5WZoyyuOOXUZSwTsEX/9GbQLWSWnb8WcvroPJ
         +gEA==
X-Gm-Message-State: AOJu0YyCmol5IAoljoYE6e7ZWjYqyHQeuJoctxpiaMWLFNwPWLh6y2JF
	wo8WouYC+eQzVJvBr2pV5YkCrRmJAJnh8P7D4cTXUWLf5cfUWOelLAyi
X-Google-Smtp-Source: AGHT+IGdtBe/uKKTL06QGz8yaZErBoQMeHbYMtJzbPdy6XMo2cDLA4P1l3M5W3uldgKmoepnJg5MFw==
X-Received: by 2002:a05:6214:5544:b0:6b0:92f4:7ca5 with SMTP id 6a1803df08f44-6b1a712e064mr38579026d6.54.1718252263695;
        Wed, 12 Jun 2024 21:17:43 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:43 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 05/19] NFSv4: Add CB_GETATTR support for delegated attributes
Date: Thu, 13 Jun 2024 00:11:22 -0400
Message-ID: <20240613041136.506908-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-5-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback.h      |  5 +++--
 fs/nfs/callback_proc.c | 14 +++++++++-----
 fs/nfs/callback_xdr.c  | 39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 650758ee0d5f..154a6ed1299f 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -46,14 +46,15 @@ struct cb_compound_hdr_res {
 
 struct cb_getattrargs {
 	struct nfs_fh fh;
-	uint32_t bitmap[2];
+	uint32_t bitmap[3];
 };
 
 struct cb_getattrres {
 	__be32 status;
-	uint32_t bitmap[2];
+	uint32_t bitmap[3];
 	uint64_t size;
 	uint64_t change_attr;
+	struct timespec64 atime;
 	struct timespec64 ctime;
 	struct timespec64 mtime;
 };
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 76cea34477ae..199c52788640 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -37,7 +37,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	if (!cps->clp) /* Always set for v4.0. Set in cb_sequence for v4.1 */
 		goto out;
 
-	res->bitmap[0] = res->bitmap[1] = 0;
+	memset(res->bitmap, 0, sizeof(res->bitmap));
 	res->status = htonl(NFS4ERR_BADHANDLE);
 
 	dprintk_rcu("NFS: GETATTR callback request from %s\n",
@@ -59,12 +59,16 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
+	res->atime = inode_get_atime(inode);
 	res->ctime = inode_get_ctime(inode);
 	res->mtime = inode_get_mtime(inode);
-	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
-		args->bitmap[0];
-	res->bitmap[1] = (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY) &
-		args->bitmap[1];
+	res->bitmap[0] = (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE) &
+			 args->bitmap[0];
+	res->bitmap[1] = (FATTR4_WORD1_TIME_ACCESS |
+			  FATTR4_WORD1_TIME_METADATA |
+			  FATTR4_WORD1_TIME_MODIFY) & args->bitmap[1];
+	res->bitmap[2] = (FATTR4_WORD2_TIME_DELEG_ACCESS |
+			  FATTR4_WORD2_TIME_DELEG_MODIFY) & args->bitmap[2];
 	res->status = 0;
 out_iput:
 	rcu_read_unlock();
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 9369488f2ed4..29c49a7e5fe1 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -25,8 +25,9 @@
 #define CB_OP_GETATTR_BITMAP_MAXSZ	(4 * 4) // bitmap length, 3 bitmaps
 #define CB_OP_GETATTR_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ + \
 					 CB_OP_GETATTR_BITMAP_MAXSZ + \
-					 /* change, size, ctime, mtime */\
-					 (2 + 2 + 3 + 3) * 4)
+					 /* change, size, atime, ctime,
+					  * mtime, deleg_atime, deleg_mtime */\
+					 (2 + 2 + 3 + 3 + 3 + 3 + 3) * 4)
 #define CB_OP_RECALL_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ)
 
 #if defined(CONFIG_NFS_V4_1)
@@ -635,6 +636,13 @@ static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec64 *
 	return 0;
 }
 
+static __be32 encode_attr_atime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
+{
+	if (!(bitmap[1] & FATTR4_WORD1_TIME_ACCESS))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
 static __be32 encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_METADATA))
@@ -649,6 +657,24 @@ static __be32 encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap,
 	return encode_attr_time(xdr,time);
 }
 
+static __be32 encode_attr_delegatime(struct xdr_stream *xdr,
+				     const uint32_t *bitmap,
+				     const struct timespec64 *time)
+{
+	if (!(bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
+static __be32 encode_attr_delegmtime(struct xdr_stream *xdr,
+				     const uint32_t *bitmap,
+				     const struct timespec64 *time)
+{
+	if (!(bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY))
+		return 0;
+	return encode_attr_time(xdr,time);
+}
+
 static __be32 encode_compound_hdr_res(struct xdr_stream *xdr, struct cb_compound_hdr_res *hdr)
 {
 	__be32 status;
@@ -697,12 +723,21 @@ static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_size(xdr, res->bitmap, res->size);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_atime(xdr, res->bitmap, &res->atime);
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_ctime(xdr, res->bitmap, &res->ctime);
 	if (unlikely(status != 0))
 		goto out;
 	status = encode_attr_mtime(xdr, res->bitmap, &res->mtime);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_delegatime(xdr, res->bitmap, &res->atime);
+	if (unlikely(status != 0))
+		goto out;
+	status = encode_attr_delegmtime(xdr, res->bitmap, &res->mtime);
 	*savep = htonl((unsigned int)((char *)xdr->p - (char *)(savep+1)));
 out:
 	return status;
-- 
2.45.2


