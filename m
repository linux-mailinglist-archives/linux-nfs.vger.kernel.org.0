Return-Path: <linux-nfs+bounces-3013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71F8B2B40
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 23:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA111F21D1F
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Apr 2024 21:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC1155758;
	Thu, 25 Apr 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEZoH7Ru"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209A153834
	for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081588; cv=none; b=oJQ/pn+tDfTbJ7XVgfjST3d2VSiUduHgIfBAwMUbkDEdlsbb39a4i0C8fVR0JIzhmQCshWA1VwD/r8oI0/Z3beQO1RvNEEhAAbYpByR+MgRyw3QXnsWoPuoCer5sIhyb/yakhjBsUD1T0RyeU7voheig1XnpdL/wDbWsW1CzvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081588; c=relaxed/simple;
	bh=l19NV/eoss0o5ZtuHfwwGEyqFf6Se8O9kWzeOivWCJs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=c90QuodjOc8ZiP4wpK2eQLQ7FwJD/BkfhLo8WCfAP6x09Ks9pZFS89qTgH78pP/jn+481Xauc8BwIUAVS5ue4OAQ1OWo7kFuy/ICAujkPubV555/pv2k9N3RZZa8vvJEOfEUj4ra8zvQzI1Mulx/XvKv7/ogqeatD1CHYLYSp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEZoH7Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB1CC2BD10;
	Thu, 25 Apr 2024 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714081588;
	bh=l19NV/eoss0o5ZtuHfwwGEyqFf6Se8O9kWzeOivWCJs=;
	h=Subject:From:To:Cc:Date:From;
	b=DEZoH7Ruxp1xsALWjx6iazIvhzjKlCr2EnbsQxKcAa1y2tc3lmGALHRjbVwXeRmQ8
	 bbPWYH1MTVuZWgWA7owD7kPxVJbHImfqZszFATRzu6GcpZq6BEqG0ffAI3+xtCSo+L
	 ODvvWrPIh4pCQgnyP798sR/HClJRw15Eyafh5qIri3Agsio6KwlwusnbS6K+FOanvZ
	 Ch9Z9dW0/nfK3Ux0CPnlFHixNwwMjXojJSZJnmjGedjglKiK6wU8rQyMY+6AaZPyCG
	 euc+ahPq8u0wAjLdPkkiFF53j0nF4nqfeskmDaJ7W0pa/r4ym08Vc3DfeNURKG7ttS
	 jBVnfAh3WZEsg==
Subject: [PATCH] NFSD: Fix nfsd4_encode_fattr4() crasher
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Scott Mayhew <smayhew@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 25 Apr 2024 17:46:26 -0400
Message-ID: 
 <171408158627.5888.8537954061249742363.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Ensure that args.acl is initialized early. It is used in an
unconditional call to kfree() on the way out of
nfsd4_encode_fattr4().

Reported-by: Scott Mayhew <smayhew@redhat.com>
Fixes: 83ab8678ad0c ("NFSD: Add struct nfsd4_fattr_args")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 85d43b3249f9..ea76100e50ca 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3544,6 +3544,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	args.exp = exp;
 	args.dentry = dentry;
 	args.ignore_crossmnt = (ignore_crossmnt != 0);
+	args.acl = NULL;
 
 	/*
 	 * Make a local copy of the attribute bitmap that can be modified.
@@ -3602,7 +3603,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	} else
 		args.fhp = fhp;
 
-	args.acl = NULL;
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
 		if (err == -EOPNOTSUPP)



