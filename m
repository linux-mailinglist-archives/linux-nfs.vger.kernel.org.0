Return-Path: <linux-nfs+bounces-7833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301569C343F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 19:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02731F210BD
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBA7A13A;
	Sun, 10 Nov 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvRtKEHF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910C381AF;
	Sun, 10 Nov 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731264344; cv=none; b=d4s8dD2Bv7mN8IQ20NlzVrmJOCzFQ7zMPyGP4E8bbMZwlkWQHv0X8xNW61eOaoRYA9OvqCnTQ9NUCZAw0pFsavxQ6pOPYf4CBrnffoyGs85KOVaBvqOWzT9oNA97G6AHrf9nELCTllc8JgpAWPadE81zx98mdQ/BI2nZFIy/7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731264344; c=relaxed/simple;
	bh=xZ1UQMVFcdJBnOqYi4Z9od0d1zAGea+kLBbkARztQzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jujBEgTm0VppMO3GL/bPRri+bBkuUmQYGgzcLlizyybdYpjF8553rIjfv6B0nCvWez/iZNnZdxxtOVKgwrtl15sStX2WEKtpSAHazGZrAwUzojT4LmXkseLfyldlCaWawwI7akzBE7+TvuoZF7TFaJJJaW5C2nPsIc4NRcuF26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvRtKEHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133DC4CECD;
	Sun, 10 Nov 2024 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731264343;
	bh=xZ1UQMVFcdJBnOqYi4Z9od0d1zAGea+kLBbkARztQzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MvRtKEHFrfLLEHC+pzZWTWzpgGCkNeToNqmNdaIDuTSQDKdXOD5Ie16m76G34Zzgb
	 swFIyp+NRFhvlI6R4a6ed4SbRu1blJL4QsS1AkCLcN4lKnQp3A5A9F72KzMXxFa7EX
	 PtY1P4N/WwToew5W4GRqWu/Bpwe34HeyBtz1GEtcZomQ/rr8TFRHLcnnq6d0Htba0f
	 CRbwijHNTlWeEcbikgszGk5H3ruqO76K3bNktr3Qxf4KJR55gAaMk5yzcLJ23q9xin
	 8lVL5ERwKpCsJWNwXXbbN+MRuXwbM6gQxIjBgvSdtS8gN8G5TQ5VwD16GhX+2zjTt2
	 n3F5hcZEgmkVw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Dan Shelton <dan.f.shelton@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH 5.4] NFSD: Fix NFSv4's PUTPUBFH operation
Date: Sun, 10 Nov 2024 13:45:10 -0500
Message-ID: <20241110184510.20129-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae ]

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
Cc: stable@vger.kernel.org
[ cel: adjusted to apply to origin/linux-5.4.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

In response to:

https://lore.kernel.org/stable/2024100703-decorated-bodacious-fa3c@gregkh/

here is a version of upstream commit 202f39039a11 ("NFSD: Fix
NFSv4's PUTPUBFH operation") that applies to both origin/linux-5.4.y
and origin/linux-4.19.y.


diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1d24fff2709c..55b18c145390 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1068,14 +1068,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 	DECODE_TAIL;
 }
 
-static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
@@ -1825,7 +1817,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_OPEN_CONFIRM]	= (nfsd4_dec)nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= (nfsd4_dec)nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= (nfsd4_dec)nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_READ]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_READDIR]		= (nfsd4_dec)nfsd4_decode_readdir,
-- 
2.47.0


