Return-Path: <linux-nfs+bounces-3723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3EE906308
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66BE28498D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3F132126;
	Thu, 13 Jun 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVKFrkTl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089E13211A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252274; cv=none; b=TL8qPkl2BxCJMRu400IopxniEVToplBn/bFTfDrjQ6jrDWlPh7XQf/HVxZ473eY2Ufsx3zTB5hhmtZntMxuaXlr9aBJI+Tzq0nedZZqbEUlw4Ns9NU0UoQkquwk/mmkRStwVDScl+74muxjneaV6X021TVr58Qdc/cKY3ZnDHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252274; c=relaxed/simple;
	bh=07FslQxfhRuiCT1lzSE6hQIMVSjuNpT3IZmEsf/J2dE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpDiWnXWXfKnmz3icyVZzWO4J/uPMhYk8Ns/3jYTNCLtKQ4SWG26MZoDwQlVrRtN+l35NyZYLZ+zdvhGcbavdCZ8KoVloeOsistd+s2IKlFtsejRT+b9M9kUATmaY0yUxVdNXswgpxUjNoxDUgGGoAyJnXJCcbO3IjGQuSq8Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVKFrkTl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44056295c8cso2949251cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252271; x=1718857071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/ilMGruigntXB9Npx/yb7IkeGQuex+cB4H78QdlVs8=;
        b=NVKFrkTldPtNKdBd86q1EvtOi5TtMw+MtJPsJcpyq7DbmJuNGGS4wdd5FIPGVn60bD
         car0vORPOTkmzlpcnR2dy9cH7TSEKwLd4y8s41Sniuma384tTjUyeh3qe4uqp1JXAYYI
         kHS8cEzCkvjfiS7X44uQZ8MV4MXV/lstI1IdCzOH5H9BXisEZ3Wv2eRKfpn7liTIFxB6
         Dd0sLfzSDimzyg6rT4MMswGs6NwcZxI4XvDeYaJKfJWiKMnVdVGWunRAhih8rEOU+8K6
         klJyal4hFmaLnqdWK7bOkHVXkyNsy8SIOuuRMfd+Jto8UtZZou81mQO00OO1nQWwvHp8
         PUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252271; x=1718857071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/ilMGruigntXB9Npx/yb7IkeGQuex+cB4H78QdlVs8=;
        b=uBE23ibyXik7vfgOhvUn1FHUIWehd3bhZD1IBnbBT5LeQ0iRU1vR1VeRk64j7qVPUA
         JKP1QUPpzgj3ueKTE86b/DiQETriFlG/CCeLyiUVhXjGYqTu0msIMsEdo9kuMjt+kcZG
         QT8Ig4LSijR5ruwPjB0offuZSeZ6skPMH5XMgNadRNwcJvDPf57/ZLss5a/2bEPlmS0x
         zmU5o4ZudL6hbN13sHxBeLTRBNfWDHXtKsW09w8+k1YQE+QfnfCg2JDFD5wUJcP8h0qn
         uIEHpV1np7QIV0IL4UmjgtISQ10D0Kmym0kUUxcFXT9qF9y3+C+sp3vup4RjuUdUI2Uc
         xkZQ==
X-Gm-Message-State: AOJu0Yx/tkroFGxILStHSbjdfkHEhGU5lqRbk7xDa0o/luM9Ok2DS/ba
	mH2NnBmWEm5t2tekBsxVDLVublFNGfazoVAvJNH70r4zpA8YJfeRcpNO
X-Google-Smtp-Source: AGHT+IFD1bKxrAJzwodjb7tPCLoyX91MEU/gkpsLOFgiNsiJgnrOR2KU3ltMCgwwBNlCEy20BfJBKw==
X-Received: by 2002:a05:6214:468a:b0:6b0:75bd:7fb with SMTP id 6a1803df08f44-6b1a731b50fmr52742996d6.40.1718252271385;
        Wed, 12 Jun 2024 21:17:51 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:50 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 14/19] NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS attribute
Date: Thu, 13 Jun 2024 00:11:31 -0400
Message-ID: <20240613041136.506908-15-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-14-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
 <20240613041136.506908-14-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Query the server for the OPEN arguments that it supports so that
we can figure out which extensions we can use.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 20 ++++++++++++++++++--
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 include/linux/nfs4.h    |  2 ++
 include/linux/nfs_xdr.h |  9 +++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 512268c732a1..ca2c115b6545 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3885,11 +3885,14 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_TIME_DELEG_MODIFY - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_OPEN_ARGUMENTS - 1UL)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
-	u32 bitmask[3] = {}, minorversion = server->nfs_client->cl_minorversion;
+	u32 minorversion = server->nfs_client->cl_minorversion;
+	u32 bitmask[3] = {
+		[0] = FATTR4_WORD0_SUPPORTED_ATTRS,
+	};
 	struct nfs4_server_caps_arg args = {
 		.fhandle = fhandle,
 		.bitmask = bitmask,
@@ -3915,6 +3918,14 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
+		bitmask[0] = (FATTR4_WORD0_SUPPORTED_ATTRS |
+			      FATTR4_WORD0_FH_EXPIRE_TYPE |
+			      FATTR4_WORD0_LINK_SUPPORT |
+			      FATTR4_WORD0_SYMLINK_SUPPORT |
+			      FATTR4_WORD0_ACLSUPPORT |
+			      FATTR4_WORD0_CASE_INSENSITIVE |
+			      FATTR4_WORD0_CASE_PRESERVING) &
+			     res.attr_bitmask[0];
 		/* Sanity check the server answers */
 		switch (minorversion) {
 		case 0:
@@ -3923,9 +3934,14 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			break;
 		case 1:
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS41_MASK;
+			bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT &
+				     res.attr_bitmask[2];
 			break;
 		case 2:
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
+			bitmask[2] = (FATTR4_WORD2_SUPPATTR_EXCLCREAT |
+				      FATTR4_WORD2_OPEN_ARGUMENTS) &
+				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e160a275ad4a..98aab2c324c9 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4337,6 +4337,28 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_open_arguments(struct xdr_stream *xdr, uint32_t *bitmap,
+		struct nfs4_open_caps *res)
+{
+	memset(res, 0, sizeof(*res));
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_OPEN_ARGUMENTS - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_OPEN_ARGUMENTS)) {
+		if (decode_bitmap4(xdr, res->oa_share_access, ARRAY_SIZE(res->oa_share_access)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_share_deny, ARRAY_SIZE(res->oa_share_deny)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_share_access_want, ARRAY_SIZE(res->oa_share_access_want)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_open_claim, ARRAY_SIZE(res->oa_open_claim)) < 0)
+			return -EIO;
+		if (decode_bitmap4(xdr, res->oa_createmode, ARRAY_SIZE(res->oa_createmode)) < 0)
+			return -EIO;
+		bitmap[2] &= ~FATTR4_WORD2_OPEN_ARGUMENTS;
+	}
+	return 0;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4511,6 +4533,8 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
+	if ((status = decode_attr_open_arguments(xdr, bitmap, &res->open_caps)) != 0)
+		goto xdr_error;
 	status = verify_attr_len(xdr, savep, attrlen);
 xdr_error:
 	dprintk("%s: xdr returned %d!\n", __func__, -status);
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index bc13d7f04e8d..79b23ad674c8 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -512,6 +512,7 @@ enum {
 enum {
 	FATTR4_TIME_DELEG_ACCESS	= 84,
 	FATTR4_TIME_DELEG_MODIFY	= 85,
+	FATTR4_OPEN_ARGUMENTS		= 86,
 };
 
 /*
@@ -595,6 +596,7 @@ enum {
 #define FATTR4_WORD2_XATTR_SUPPORT	BIT(FATTR4_XATTR_SUPPORT - 64)
 #define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
 #define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
+#define FATTR4_WORD2_OPEN_ARGUMENTS	BIT(FATTR4_OPEN_ARGUMENTS - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d8cfa956d24c..af510a7ec46a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1213,6 +1213,14 @@ struct nfs4_statfs_res {
 	struct nfs_fsstat	       *fsstat;
 };
 
+struct nfs4_open_caps {
+	u32				oa_share_access[1];
+	u32				oa_share_deny[1];
+	u32				oa_share_access_want[1];
+	u32				oa_open_claim[1];
+	u32				oa_createmode[1];
+};
+
 struct nfs4_server_caps_arg {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh		       *fhandle;
@@ -1229,6 +1237,7 @@ struct nfs4_server_caps_res {
 	u32				fh_expire_type;
 	u32				case_insensitive;
 	u32				case_preserving;
+	struct nfs4_open_caps		open_caps;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.45.2


