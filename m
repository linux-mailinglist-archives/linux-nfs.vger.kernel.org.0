Return-Path: <linux-nfs+bounces-16455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D1C65031
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF24E0685
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA502BE7AD;
	Mon, 17 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tshb7pke"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6A29E117
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395254; cv=none; b=dliazjAsEIyb7yIqUkXByDmcQLHcYJ8ALv4oqt7L57L/pelwJpCp4NodBtSJ0I7CIqORsGpCAQVr2pl9p4/d+YRqR1e6hMAfvDlWLY9g9gL9CePclEKsZF+hKSODVaFQFPEMvRHk6vKaB4DP4Zp7zxN0zfWak2aB0mcjjm9dQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395254; c=relaxed/simple;
	bh=awiYQNSghYO15CxFZ3Clw+Fkg6PjC2x1pFVzNVMSqOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb+czYGanKc72t/zqvnNVgaz8vFwMome4dJuV6ZADHDiD+swQ5CNGI5mZLa53pUUoZTnE9I6EJq5bQfxNh4Pr0nd3FCeSFbiHmxNgGR+BQHAQDR8giMQ1lmE3BQ4kY/R4xJ85rlqsNZQKjjAAPfKvTSpQtANFi/17S+zGFdEfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tshb7pke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F008AC4AF09;
	Mon, 17 Nov 2025 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395254;
	bh=awiYQNSghYO15CxFZ3Clw+Fkg6PjC2x1pFVzNVMSqOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tshb7pkeJXnethrJKgcphExI73xQo7pITq0RlMebM0SmvbDlmjqrqaCcmgknLmTTk
	 Pm2oQss1HsfUAtMor8KpOGUuoJjuAvUIMYFzlz1WqxbPjJpeqCSHClZ2WSYQ+IuWId
	 eD5kE4gMv5HzUB0jdiuSAqa/16EraRzj5T7Nkpl2oDThelvayU4N8OF76LGfH6DchY
	 E139mFpk/7OkzSRlzG8tScVeBMHlvVaJgnh7bVXXWqyjXwodTACXDVukmh73pGRFHf
	 CZu7DBYRTLKoUfiJnh7Xa1HBrw2Mg87lvMAIJLzI0CSAxtCZXadT9eMWd9B5r2+X5T
	 iwSNdfz4bYxHA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/3] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Mon, 17 Nov 2025 11:00:49 -0500
Message-ID: <20251117160051.10213-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117160051.10213-1-cel@kernel.org>
References: <20251117160051.10213-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

From RFC 8881:

5.8.1.14. Attribute 75: suppattr_exclcreat

> The bit vector that would set all REQUIRED and RECOMMENDED
> attributes that are supported by the EXCLUSIVE4_1 method of file
> creation via the OPEN operation. The scope of this attribute
> applies to all objects with a matching fsid.

There's nothing in RFC 8881 that states that suppattr_exclcreat is
or is not allowed to contain bits for attributes that are clear in
the reported supported_attrs bitmask. But it doesn't make sense for
an NFS server to indicate that it /doesn't/ implement an attribute,
but then also indicate that clients /are/ allowed to set that
attribute using OPEN(create) with EXCLUSIVE4_1.

Ensure that the SECURITY_LABEL and ACL bits are not set in the
suppattr_exclcreat bitmask when they are also not set in the
supported_attrs bitmask.

Fixes: 8c18f2052e75 ("nfsd41: SUPPATTR_EXCLCREAT attribute")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 30ce5851fe4c..51ef97c25456 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3375,6 +3375,11 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[resp->cstate.minorversion], sizeof(supp));
+	if (!IS_POSIXACL(d_inode(args->dentry)))
+		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!args->contextsupport)
+		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+
 	supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
 	supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
 	supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
-- 
2.51.0


