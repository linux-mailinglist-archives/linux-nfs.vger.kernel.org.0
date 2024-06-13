Return-Path: <linux-nfs+bounces-3717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3B906301
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046481C21EDC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F606134409;
	Thu, 13 Jun 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M++5t6h/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A19133402
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252269; cv=none; b=FEL1ZakKN8GAIDPXCqwJw/mJi9hmBBX+IEEcx5lYK2MbdkZor91OwWb6jb+Wyol0fsnbHaQctQBP+si4EH1C31l0gHjmta4plTqjuKZC/mlz/mt+YeOmC0u1cUFs/3QXRteNJZR9aMINcwTxfT7694cX9PYTqzspiJSD/8re7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252269; c=relaxed/simple;
	bh=TAEL7q4hgZcv5YVterdQ6T2z8L4rY3I2ZOHBx4kSLdc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW8ytP9zo7B0jCHZLJWg5kwSNIE0tZoBL4JpECpmiyzjOIL43REpfHGpUyUvO/h9g45lWBMlNeoOlJhN/tMZhwFm+BX57QTOUPJcT//GGBfeIjH0bFw3gRjClRBSjRxL+L5EpvsdaNVZL+bRhbbyz8ceBnAT9ljx5tfYmXk4soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M++5t6h/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b06b78e716so3560156d6.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252266; x=1718857066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL/7LACE4TIP97s7YbulyVv9AoIs+282TFrueNiZnug=;
        b=M++5t6h/r0ZzYxt9Jq0lTfvJVCoo7dgqijTfR56NSswERtZ9Qrtw2CiLD//F2bq9q7
         v6xO9GB8T/6t3iXzAdGi1OfwpCXYKvIzlqxKDd3dVHmID+axHTJrTaoisXQFhUeAMNbV
         uB4fkG0DEaYSpC63KKjNAUOGuvjMPFK8/dMo+SvgnsCKt+i1Q9Jy2Ra+mIUX3fQ1YzNt
         pYoyj3AGmzWdb9exsrh/GUNhvUK55Xv3WB7HdvzfZrHbsIDqk1XN8phHhkFGSs90HC+e
         b63v9p9y/Iy4Cp2txNm46mxwKGKb4DPCW1JxpDtUS9TYj09m1dxzNz72Cd5b+leRZMeW
         V0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252266; x=1718857066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/7LACE4TIP97s7YbulyVv9AoIs+282TFrueNiZnug=;
        b=YiKU/7N+0uHfTXo+sROS9qTrjHzwOFlscnCcwlajag8RP5Sg5zQUjJoRpQIJj6B4rx
         dAt6kb1e43kssyBjwV8jHXVMNfRN0tcPGEZHfy6newgu1XQfFELJC1HX33DKPmKLF7d0
         ezSUIOHmbDG1pTubw0Z5LkN+be49aJnbEK7xcaUPlc4fmJ5kt6LczIplBUJjnpOhXwT1
         thV/DqW4tURRIYBG95zbx8EMDtd/KwJ4sS5f7eTHnja1W9C1Jus0Q6HIJWk34I+OLnHM
         CgCI4YA+boOaOheyt/NN6L2d4KxsrqPWeZ/0ge2nEDa+h1QCKMoW971J1GxMBuK5OUDc
         t77g==
X-Gm-Message-State: AOJu0YzXPOty1Z+LDmcuqQ6AoRV2TE4LVJn8MKMXR0P9IjIZf+p7ZP4P
	fmOi87zXSMmV/VMeyfrnuMJ/g6pIdRYSPDRwi7O/LUmTLwP1ZhApnNVj
X-Google-Smtp-Source: AGHT+IHcv3j2mIJcEQqyiMrdL+xlRtZ/A3nlDDiVPeTpX6AHPmxmjyoJ+Y0Ow5kPaVvuN4lifzxSlQ==
X-Received: by 2002:a05:6214:524a:b0:6b0:6619:20b7 with SMTP id 6a1803df08f44-6b1920287ccmr42843216d6.17.1718252265921;
        Wed, 12 Jun 2024 21:17:45 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:45 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 08/19] NFSv4: Add recovery of attribute delegations
Date: Thu, 13 Jun 2024 00:11:25 -0400
Message-ID: <20240613041136.506908-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-8-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
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
 fs/nfs/nfs4proc.c       | 18 +++++++++++++++---
 fs/nfs/nfs4xdr.c        | 18 ++++++++----------
 include/linux/nfs_xdr.h |  2 +-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 83edbc7a3bcc..b613c11fac09 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2225,7 +2225,7 @@ static int _nfs4_do_open_reclaim(struct nfs_open_context *ctx, struct nfs4_state
 {
 	struct nfs_delegation *delegation;
 	struct nfs4_opendata *opendata;
-	fmode_t delegation_type = 0;
+	u32 delegation_type = NFS4_OPEN_DELEGATE_NONE;
 	int status;
 
 	opendata = nfs4_open_recoverdata_alloc(ctx, state,
@@ -2234,8 +2234,20 @@ static int _nfs4_do_open_reclaim(struct nfs_open_context *ctx, struct nfs4_state
 		return PTR_ERR(opendata);
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(state->inode)->delegation);
-	if (delegation != NULL && test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags) != 0)
-		delegation_type = delegation->type;
+	if (delegation != NULL && test_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags) != 0) {
+		switch(delegation->type) {
+		case FMODE_READ:
+			delegation_type = NFS4_OPEN_DELEGATE_READ;
+			if (test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags))
+				delegation_type = NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG;
+			break;
+		case FMODE_WRITE:
+		case FMODE_READ|FMODE_WRITE:
+			delegation_type = NFS4_OPEN_DELEGATE_WRITE;
+			if (test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags))
+				delegation_type = NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG;
+		}
+	}
 	rcu_read_unlock();
 	opendata->o_arg.u.delegation_type = delegation_type;
 	status = nfs4_open_recover(opendata, state);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 4c22b865b9c9..e160a275ad4a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1475,20 +1475,18 @@ static void encode_opentype(struct xdr_stream *xdr, const struct nfs_openargs *a
 	}
 }
 
-static inline void encode_delegation_type(struct xdr_stream *xdr, fmode_t delegation_type)
+static inline void encode_delegation_type(struct xdr_stream *xdr, u32 delegation_type)
 {
 	__be32 *p;
 
 	p = reserve_space(xdr, 4);
 	switch (delegation_type) {
-	case 0:
-		*p = cpu_to_be32(NFS4_OPEN_DELEGATE_NONE);
-		break;
-	case FMODE_READ:
-		*p = cpu_to_be32(NFS4_OPEN_DELEGATE_READ);
-		break;
-	case FMODE_WRITE|FMODE_READ:
-		*p = cpu_to_be32(NFS4_OPEN_DELEGATE_WRITE);
+	case NFS4_OPEN_DELEGATE_NONE:
+	case NFS4_OPEN_DELEGATE_READ:
+	case NFS4_OPEN_DELEGATE_WRITE:
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		*p = cpu_to_be32(delegation_type);
 		break;
 	default:
 		BUG();
@@ -1504,7 +1502,7 @@ static inline void encode_claim_null(struct xdr_stream *xdr, const struct qstr *
 	encode_string(xdr, name->len, name->name);
 }
 
-static inline void encode_claim_previous(struct xdr_stream *xdr, fmode_t type)
+static inline void encode_claim_previous(struct xdr_stream *xdr, u32 type)
 {
 	__be32 *p;
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 51611583af51..d8cfa956d24c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -484,7 +484,7 @@ struct nfs_openargs {
 			nfs4_verifier   verifier; /* EXCLUSIVE */
 		};
 		nfs4_stateid	delegation;		/* CLAIM_DELEGATE_CUR */
-		fmode_t		delegation_type;	/* CLAIM_PREVIOUS */
+		__u32		delegation_type;	/* CLAIM_PREVIOUS */
 	} u;
 	const struct qstr *	name;
 	const struct nfs_server *server;	 /* Needed for ID mapping */
-- 
2.45.2


