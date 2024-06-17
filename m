Return-Path: <linux-nfs+bounces-3867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE590A1B8
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E50F1F20FC7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD8FBFC;
	Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFclFwd4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FCFBE8
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587513; cv=none; b=KVGJLt1M9tAcZggDOCc8yLUzYy24cBKjN1gvRv4eml840iYOsSxA8u+RODESZb+vYKDtZoNZEi3FFuAUL87yAg+t+0Fr7SiNhEHdg0dip5wUln4jt+2trakS+/CQ9hpZ0We31g2H1E4sy7cg/OGD8+9xDW26p0TB24nLuhpj4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587513; c=relaxed/simple;
	bh=UQz2PXalU/eYcbe4YL7TaS0X97+6v6WL4f83uTPtJUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWWIKJD+/w5YHcX2J7CDbulueXII/46/iRmageLzAVxJ1cuffl9i8V7V2Q2IrJpM7Uteo3J61V3SdQb8oKI8wZv2OZEZWyTiJAEHtQfjEhWyhi6hwbsvp8aHPvgfspMBiK7NeoLVF2bv8YWK6soGkTlsdkOZzAiT8kpOQ2ZoqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFclFwd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD42C4AF49
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587513;
	bh=UQz2PXalU/eYcbe4YL7TaS0X97+6v6WL4f83uTPtJUs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DFclFwd4qqZq5lZwn8GtvA8eU07O+i6M1LY7MpC7JkbJj/D7NpesJOdZ/gTVA2tkR
	 fjqtyAeqS7llXqUcNRROAfQ35lqKLRVd5ooURunNo95s8q7fLWG1Ml5ilyfURYXCJR
	 q85+448zzwIPeCjx+JCTv7u4AV1cynWKJ5pXJ7mY8JiXcK5rb8pPG64tjZxZL9tBjF
	 ND9ggNxvcYsZTU94Atmi1YSfdEQyXcrV5lbRrDpxQO637ZY3kCBRsGlX2ENaE37YLm
	 6eX32jDtz8w/sKh/48mC5w2xEKciJxaCPbNo6ihd+I2zZrbW3zC8sCpWlzkzqxXSQp
	 643MvIDyGcRbQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/19] NFSv4: Add recovery of attribute delegations
Date: Sun, 16 Jun 2024 21:21:26 -0400
Message-ID: <20240617012137.674046-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-8-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

After a reboot of the NFSv4.2 server, the recovery code needs to specify
whether the delegation to be recovered is an attribute delegation or
not.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 18 +++++++++++++++---
 fs/nfs/nfs4xdr.c        | 18 ++++++++----------
 include/linux/nfs_xdr.h |  2 +-
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f4215dcf3614..34182a3c38a7 100644
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


