Return-Path: <linux-nfs+bounces-16409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF900C5F3DA
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E3DE348AFC
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B100346785;
	Fri, 14 Nov 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6SXPr+M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653A342536
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152177; cv=none; b=JxhAAADkkVxoCsYQ4WlkgGCZAqpLxcMUL9FZdsGHrOc5BbdmQoujhUUgAMejGsuycq/7TVa7p+nu+ofBxcHFNxH4iPR3nU5FqLJ4T2lkOuo6EZidY/Xq+yqYTKdhvEahvVwjgfpWnUOhfKMw/YdLjejQsG0BbTOXWGXwLTEAk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152177; c=relaxed/simple;
	bh=awiYQNSghYO15CxFZ3Clw+Fkg6PjC2x1pFVzNVMSqOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaZXAsYdo9sULtUgxN2tzXV9mZVJLfHQ4nGeO3cPX9Q4CGPWWZSmZgbHOBTHGP7B5iTfEq3WQcKFCw2sGK1D3vh9FUB0i99n3phd2N1Xt0Es0VBuwmxWCMMzkn39anLx05eZSJj9/vaMD70kjr8mFIyTsrayJVtUEaCxViiYUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6SXPr+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB96C4CEF8;
	Fri, 14 Nov 2025 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763152176;
	bh=awiYQNSghYO15CxFZ3Clw+Fkg6PjC2x1pFVzNVMSqOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6SXPr+Mq6BbY0LLXeoD7fwrY02lfAOvvItQfMgoTRXP0GQKafvH9N3x9U34naizE
	 RvvgiG+9dkoNtq4pqhYzHVp6m+Isrl26ydO0nGYmfjwmz2f/T65D7YG/1tz40ikYrM
	 2YzFCABDaBgE7RlH9QVKWGzVWUdoG78almZfMEFMFiueHVDChchJp+4Ij0owp4s/ld
	 OIJL4eDXFLlY2z9Rxh1l5cYvRK0gnhq3CDTk1wHCyKiK7ro+JSUWbtSdqkQY1Opprg
	 dt7k2dP/bJ0p+fgQnj89ji7zU/f2l+F9mNlm6Ngckpe0lrT9iaFCikoRen28aVxUR3
	 r4lDhy3ykXBKw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/3] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap
Date: Fri, 14 Nov 2025 15:29:31 -0500
Message-ID: <20251114202933.6133-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114202933.6133-1-cel@kernel.org>
References: <20251114202933.6133-1-cel@kernel.org>
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


