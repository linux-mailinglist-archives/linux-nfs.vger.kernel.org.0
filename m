Return-Path: <linux-nfs+bounces-14395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8EB55835
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D211C257DD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598F32F75F;
	Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkIpM7Qt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186E334731
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711654; cv=none; b=aatD+KEaSxA7bXWP240Zw0fgsySNdF+yLy4MAJFJSig+NaK59gOHhwy8188AJGSsv7w/owtfWv4b1h+zeNpgGW7xzC5afzY3rMXziObSYPAJfXVB9YyGDRLivaPgjGxnj2lLhftbh4EjnG6Ftl+YatUmfn9eJKrAmeECGgKFjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711654; c=relaxed/simple;
	bh=oiZtSPfZAutl/dkpZOcnAeBCshev5i1q7/CqTkLPBsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDeceIMJowJaQ1sMgUqS3H/NyOOEo9oE8gZreWb7vJ0AS39jlH/vrp9kJfwdxHah3zEjw7pNeRD2RdYAnKwQDabi78Yaauw94bgAb0E7s1n90ujKjAQxcKAPsmCu9rkXSKZXf7BsB0AYh7E0wGTsACEZqz4EsTsxtKMfeMjPZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkIpM7Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75428C4CEFA;
	Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711653;
	bh=oiZtSPfZAutl/dkpZOcnAeBCshev5i1q7/CqTkLPBsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkIpM7QtIn34bhz1jkMbGUld3cNcWa4nNAue0x3iO9M/YATHJ/8K74POr17ccx76+
	 eyFEF365/XLPMjpkxFxuLU+f4Q1gg3n1gzhCCfrp8kxJsfgVa/NO8KTNiAQSi2v3s0
	 ZMVkFMn7ZwjRVSyHtLeMmi/OHJK874lhktl456aF5AGlzd8RTZMcSp00E7q1qx8aUH
	 Uq+44IOoZ/ahDWU6sfnGJO1jVRCUG2TSfIqzubTU8gvH1cJbbADojQRDgSqlf8uo2P
	 Sj3fjPdb8ZYguRR4f9XaDaOJPxy1whBoFaM+nR3dyhMdVwvUJw6yRor5SBAXORlGdP
	 F/z2uYTFaN4GA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 3/9] NFS: Update getacl to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:04 -0400
Message-ID: <20250912211410.837006-5-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912211410.837006-1-anna@kernel.org>
References: <20250912211410.837006-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs4proc.c       | 4 ++--
 fs/nfs/nfs4xdr.c        | 2 +-
 include/linux/nfs_xdr.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4de3e4bd724b..a5085820ec0a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6160,7 +6160,7 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 	}
 
 	/* for decoding across pages */
-	res.acl_scratch = alloc_page(GFP_KERNEL);
+	res.acl_scratch = folio_alloc(GFP_KERNEL, 0);
 	if (!res.acl_scratch)
 		goto out_free;
 
@@ -6196,7 +6196,7 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 	while (--i >= 0)
 		__free_page(pages[i]);
 	if (res.acl_scratch)
-		__free_page(res.acl_scratch);
+		folio_put(res.acl_scratch);
 	kfree(pages);
 	return ret;
 }
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 4ee88a4c1daa..1d0e6c10f921 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6585,7 +6585,7 @@ nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	int status;
 
 	if (res->acl_scratch != NULL)
-		xdr_set_scratch_page(xdr, res->acl_scratch);
+		xdr_set_scratch_folio(xdr, res->acl_scratch);
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ac4bff6e9913..7823d4574e29 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -862,7 +862,7 @@ struct nfs_getaclres {
 	size_t				acl_len;
 	size_t				acl_data_offset;
 	int				acl_flags;
-	struct page *			acl_scratch;
+	struct folio *			acl_scratch;
 };
 
 struct nfs_setattrres {
-- 
2.51.0


