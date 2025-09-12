Return-Path: <linux-nfs+bounces-14396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F174B5583F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE787BA9D0
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3A334731;
	Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2TaPHCt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97149335BAF
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711654; cv=none; b=GQt1byP8SRzc5b9vHzx4n7S2QBcwbFgjF32OEoAPeW+RqwPSCLuf9Mtt4g2wXIIEqXJiWIBAU/oNsUdvplH1TYx4syCL68//cbg9UZ01QoPHPnwADuawCKv4ZSxY0LDYJk2DyfRIRR4YSevaRq+XzRuBShGi0reOeFbN3mtC4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711654; c=relaxed/simple;
	bh=vaXppXYadsfq3p7lAWdwj0YZXBAKIB2opbiSkNBYEVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpNuC+x56xwRE1uIZ24pZMIhUBLj6TLHuwr1LbbdNKVqEeP5pOcPQOu9mECQgSonIrHw5Oaa1ZQ0IzhGJlk5vr4BF6krvLkhfanuMD9gVD3tAqw6ar1GhC2MoH+eO75x+m28wjTEglek3fNL7a20HuoQiLHK63npgfJwuGEOze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2TaPHCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB2FC4CEF1;
	Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711654;
	bh=vaXppXYadsfq3p7lAWdwj0YZXBAKIB2opbiSkNBYEVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2TaPHCtqBIcAHSbO5U+m9No93sag7q2GOqjLJ1gms4hEdl01fApQ9QLjuyKyOfet
	 UTJaMEzkgz06mpZoScfbM7y0aKhMR608cH4j0K5h8s54xLJbgvETWJ6CKLfseHadP0
	 7/FMO3eKdtUzyUIKdK9/N1mVwHVujhWzCKdLokeHEX+09hbsDMpFKbP1zB62Kq2hA2
	 t6AXHOxZLhai4U6QgFYqgqRVvS1XqPZT43nrNWvKa1hpJ2HjxOZbPDY/53f2cqTkfD
	 3dfj6SZPWceuvKYd4H8Ya8RMYsgMp2zmduOchc6g95GVK7KnQcgEYvEw1yjhwfTT0J
	 ziz137SP1V1eA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 4/9] NFS: Update listxattr to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:05 -0400
Message-ID: <20250912211410.837006-6-anna@kernel.org>
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
 fs/nfs/nfs42proc.c      | 4 ++--
 fs/nfs/nfs42xdr.c       | 2 +-
 include/linux/nfs_xdr.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 6a0b5871ba3b..d537fb0c230e 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1514,7 +1514,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 
 
 	ret = -ENOMEM;
-	res.scratch = alloc_page(GFP_KERNEL);
+	res.scratch = folio_alloc(GFP_KERNEL, 0);
 	if (!res.scratch)
 		goto out;
 
@@ -1552,7 +1552,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 	}
 	kfree(pages);
 out_free_scratch:
-	__free_page(res.scratch);
+	folio_put(res.scratch);
 out:
 	return ret;
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 4cc915d5741d..e10d83ba835e 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1781,7 +1781,7 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
-	xdr_set_scratch_page(xdr, res->scratch);
+	xdr_set_scratch_folio(xdr, res->scratch);
 
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 7823d4574e29..d56583572c98 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1596,7 +1596,7 @@ struct nfs42_listxattrsargs {
 
 struct nfs42_listxattrsres {
 	struct nfs4_sequence_res	seq_res;
-	struct page			*scratch;
+	struct folio			*scratch;
 	void				*xattr_buf;
 	size_t				xattr_len;
 	u64				cookie;
-- 
2.51.0


