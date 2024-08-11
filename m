Return-Path: <linux-nfs+bounces-5302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADA94E26F
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42DE1C2036E
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9817552;
	Sun, 11 Aug 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CynZUm7z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7044C7E
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397192; cv=none; b=GCGVNfcwJpUBkCn/MhfVyYKZ8dTyW7LFK9Af6/GZEt6sZgpfBKN3MVtFp/4AAicezqdx3+Ltu7wBSZDJGMnhn4kIOlyPl/UXA5AeV4k1qwCSBK6ggYv18uV7FMeAvoKErwp4lin1Ve4vX2s2tr6LOwZcZJAtlsq5dKOO6P3dtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397192; c=relaxed/simple;
	bh=+ALnNmN/1JovfQik/Fgvz0u3Jg9vYfQ5wssz0oTm7uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhArux5GpuG27MOL5zbQB+ckNcDyxJ5in8Tu1Eo6JF5P60T5tqdGmd95LQx6RTAmp969Ug94xQFaBx4edSGrTgDn5Izt9wG+1MhxN5XbJZ6FqutDx65zH9aIvEkoyR2fDmtKSgzmzW2Bf1T1dl8O/PY6Rb2Ns814FmeaXfhuG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CynZUm7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706AC32786;
	Sun, 11 Aug 2024 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723397192;
	bh=+ALnNmN/1JovfQik/Fgvz0u3Jg9vYfQ5wssz0oTm7uw=;
	h=From:To:Cc:Subject:Date:From;
	b=CynZUm7zXt0KTkA//BKIkjGrATozDXEFpecfG1Gsw0zh/953CM6vYl2e3bvWIpFKs
	 nrbl5PF1sns+rBvsWa+MpZO0g+1X7emJzAms0ruacDWI0SLQW5/64GEyZaYa5+qhP8
	 rHbr1jbf7jU4A1+IOr6cQiPb+GrDeM+ZF0Hpfv1Rue7kK7uZ1D4GuJVv/79pN7tO/a
	 IVAIl7jyEAY4MuSAbEKZCrbQNmtO30NnA2KZUFHSefaXRUD6qLsUwqlPUmpims4nwo
	 4r5zy5OwKyZO9CsEv59KcR5EBa5T49neeXC7FPJsbfb7l6mlNJnU1XAnW24oU6Soc7
	 UNBJ19wpCqjwQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Dan Shelton <dan.f.shelton@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH] NFSD: Fix NFSv4's PUTPUBFH operation
Date: Sun, 11 Aug 2024 13:26:07 -0400
Message-ID: <20240811172607.7804-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

According to RFC 8881, all minor versions of NFSv4 support PUTPUBFH.

Replace the XDR decoder for PUTPUBFH with a "noop" since we no
longer want the minorversion check, and PUTPUBFH has no arguments to
decode. (Ideally nfsd4_decode_noop should really be called
nfsd4_decode_void).

PUTPUBFH should now behave just like PUTROOTFH.

Reported-by: Cedric Blancher <cedric.blancher@gmail.com>
Fixes: e1a90ebd8b23 ("NFSD: Combine decode operations for v4 and v4.1")
Cc: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42b41d55d4ed..adfafe48b947 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1245,14 +1245,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
@@ -2374,7 +2366,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_OPEN_CONFIRM]	= nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= nfsd4_decode_noop,
 	[OP_READ]		= nfsd4_decode_read,
 	[OP_READDIR]		= nfsd4_decode_readdir,
-- 
2.45.2


