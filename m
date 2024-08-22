Return-Path: <linux-nfs+bounces-5590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851595BE72
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC031F24348
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F513A414;
	Thu, 22 Aug 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NycsMLl1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCC2AD00;
	Thu, 22 Aug 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352427; cv=none; b=Yx+IBzVeI9rgtMe6ALnq5fLAKi/uTBP5zIhWXxBfHKR4+fHyCmxTLLSIU/qCbnidIr0I97CKV+R6hDVA7NJGPmQ5BQaabhvEZy80dQWnep68Mj3gpIRj5Tx6hBGT5MsL9QqNHGjnRBcE39hTXogAm7dAshKHjd0lqvEJEPIfaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352427; c=relaxed/simple;
	bh=DjkpqITY+ykp6gL3/kloFhYWkwTc90uZpAjWVpcNnWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JvFQe8NfGhFZtmNP6zkgvPflhuEZtms0XebBpbCKlqYm3Y3hH1L69X8QvKjXGQJRAFNWEOY4echAsOtlEhFn1lvHAEspE08azhzqOQsntpEDdW9VzRK1ZOTsVlw9C2FG2/S/cSPSS4PxUXARDBVQmQ3HXYDGd5s9kcVKUGrJ7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NycsMLl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC4C32782;
	Thu, 22 Aug 2024 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724352426;
	bh=DjkpqITY+ykp6gL3/kloFhYWkwTc90uZpAjWVpcNnWg=;
	h=From:Date:Subject:To:Cc:From;
	b=NycsMLl1raNoVkm3Jm7Ch9T1gGbyocMJlbAGk87SO5i4XyNPIfZSwEzpubRMbkQ/I
	 kwU5gusVYem/qEO6ftuJATWQS2sqgf/ZdxMSzWzgQUaep2BKwu5tAm8BGlmL7Ir/uE
	 SIGe7b1WvHTG21gthgRgpaDSCyUKndJ5tUAptJBUjFE2lzvzCIqfKgmbpwyQtLpH2u
	 /dl2VobSyn+J+WAzl2H03mwfTELhdnWej9b2FKRgDBpx/V8/78vD7k62rP6U6he9+b
	 yIqzJsJWmlGXKZW1T2O5W5ZXyvEh8JgNeDcVFbAnk41KSnq0t+VfwDaGf1ScEy/jmn
	 +lh7nkFjB+Rbw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 22 Aug 2024 14:47:01 -0400
Subject: [PATCH] nfsd: ensure that nfsd4_fattr_args.context is zeroed out
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-nfsd-fixes-v1-1-905ae5249531@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKSHx2YC/x2LQQqAIBAAvxJ7TtBVKPpKdEhday8WLkQg/j3pO
 MxMBaHCJLAMFQo9LHzlDmYcIJx7Pkhx7Ayo0ekZUeUkUSV+SZQOk08OvbbWQB/uQr/o/bq19gF
 jF+6eXAAAAA==
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DjkpqITY+ykp6gL3/kloFhYWkwTc90uZpAjWVpcNnWg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmx4emSZ1osSQCDu59a9JajmtxpwOy0EMKzjlne
 p9q5QyLNr6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZseHpgAKCRAADmhBGVaC
 FV1LD/9xNVUZbBw+c+jhxGzhp2TgSHv2dtr/Y+vb+ZGBEHD7u6od7EYv/PuTVdrDDB0XUJaSdir
 ssGfwPOHoETJ4r6rmToOwc8szZ4UAiFK588tSoSAgaVk/FIeOixREBiM53BLohDjahA+hcvCKty
 9J0WefTyNHerkFJ/2uJF/+W1cTCca2+bhluGjBqjuQ4ZqBKDHIU2TTvanQPI/AX1sE1XOtFsi1M
 U/OZXwPOG4wkVYHylHAlR0cbfGNH4FT3ggRWdO0BJiYoYpTCl8zgRCV6ucD3uLFQ37ORwLD01ny
 Si92uwJTU0Rz1L095+d/W1DnoaAMoOvn2uGxAparrB1BbQxSl2ltdQygqlZNZVIQZ3tqEW9TmDs
 IIQ989lE7VoYtRR6d8dmqGRpPoZ/9opHkfrQZ+OKQCwNN4cI2LiI5ukb+xobyukBcjUXLU9CwX9
 /wh+fmogF4XnaJhfMnHn7CNKYelxg/P3J5ydTb7tI+z4vU3nfivXRMhe1o/WVXXz24+WbSL9O2R
 7NUgwklv04yHqDgB+HzFZMExHuNZZLXw0esejkRZ1zKSDg2GAjIwCD1VCzVgSMHnzUvp/CvKpZb
 7mgoi4uBw8IpYvdIf3kecKnJQeHF5zSvbD6acdUfeKw6fiqjJXGBUEHw431yHpDsnX1UvOnckCA
 frRYXK8Uc4m7FWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If nfsd4_encode_fattr4 ends up doing a "goto out" before we get to
checking for the security label, then args.context will be set to
uninitialized junk on the stack, which we'll then try to free.
Initialize it early.

Fixes: f59388a579c6 ("NFSD: Add nfsd4_encode_fattr4_sec_label()")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 643ca3f8ebb3..ee1c6a68b663 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3537,6 +3537,9 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.dentry = dentry;
 	args.ignore_crossmnt = (ignore_crossmnt != 0);
 	args.acl = NULL;
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	args.context = NULL;
+#endif
 
 	/*
 	 * Make a local copy of the attribute bitmap that can be modified.
@@ -3609,7 +3612,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.contextsupport = false;
 
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
-	args.context = NULL;
 	if ((attrmask[2] & FATTR4_WORD2_SECURITY_LABEL) ||
 	     attrmask[0] & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)

---
base-commit: afec13278f4ed7dad696cfdaddbee978d905b9f2
change-id: 20240822-nfsd-fixes-0c7bf42b0331

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


