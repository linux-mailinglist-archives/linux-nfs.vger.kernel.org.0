Return-Path: <linux-nfs+bounces-6264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7796E2CA
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242391C2336C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7018C342;
	Thu,  5 Sep 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M98hPArf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971818BC31
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563420; cv=none; b=sJ89eIGsfLTM5pwS7i6tVSEdDX/y9HROAPIC8XYLwVkFiwwdvcv4rRqbZ0c2QiS+k4e3KvjYHwU+VhaBbya5f3lciaU032fSKqbjJ/TvRsNNn9fD9RYInBKsudsZWOivrReVcDOkVwjxey4KNr3VvfDC2lQuGB5d4Jn0tJtrm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563420; c=relaxed/simple;
	bh=7ydj7uFNVevw/icsB23/X3dzVXLeH84MRGvl2kgrFcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0BaH8GbwKGtIogNvDwug3WBDjF+KRe8WuNnKfPyMqANiulaW5qGEQ4eP+GiUG8dAMeDYwQlxxrOuwgEX6amCf5IGN2AszKd7K21o9jecnJoNQEZJD13toGFSHF+gSfcgsbEowV2S1BCcuBpb5Qx0lyq5UlKAt/2ECZ2XuXAatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M98hPArf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9538C4CEC3;
	Thu,  5 Sep 2024 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563419;
	bh=7ydj7uFNVevw/icsB23/X3dzVXLeH84MRGvl2kgrFcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M98hPArfyC+MGbgziXk9SUG9GesyFSCSrZmv5bHV+pFiTHLw1pq01zd1N4U6qnclF
	 6lqbRrzu3vfMj2XwYjgKQJOqJCM8CyLKQpsc71xbswnEhh+IklPxcp06QoD4Sk57/Q
	 pk/kSdykPzC3GRASkR7OmKbkl3W3mW7ykutwyBooQiasH4cRTtQIeNavvlRlY84QR0
	 Z+b6SB/JoM9oEkISMeeVgsYzYL++FlKsVLXAq43uYkJz9R4Ymo7D4llsf4WGPcvkSk
	 296YNfDGWsSvjZJggorygwkXVFosyA6c5P2w43onqyQjZDoEPyApErHma6oVa2naNU
	 fsylsGtS8xEdw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 05/26] NFSD: Refactor nfsd_setuser_and_check_port()
Date: Thu,  5 Sep 2024 15:09:39 -0400
Message-ID: <20240905191011.41650-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

There are several places where __fh_verify unconditionally dereferences
rqstp to check that the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talks directly to the local server.

Prepare these to always succeed when rqstp is NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 50d23d56f403..4b964a71a504 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -87,23 +87,24 @@ nfsd_mode_check(struct dentry *dentry, umode_t requested)
 	return nfserr_wrong_type;
 }
 
-static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
+static bool nfsd_originating_port_ok(struct svc_rqst *rqstp,
+				     struct svc_cred *cred,
+				     struct svc_export *exp)
 {
-	if (flags & NFSEXP_INSECURE_PORT)
+	if (nfsexp_flags(cred, exp) & NFSEXP_INSECURE_PORT)
 		return true;
 	/* We don't require gss requests to use low ports: */
-	if (rqstp->rq_cred.cr_flavor >= RPC_AUTH_GSS)
+	if (cred->cr_flavor >= RPC_AUTH_GSS)
 		return true;
 	return test_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
+					  struct svc_cred *cred,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
-
 	/* Check if the request originated from a secure port. */
-	if (!nfsd_originating_port_ok(rqstp, flags)) {
+	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
 		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 		dprintk("nfsd: request from insecure port %s!\n",
 		        svc_print_addr(rqstp, buf, sizeof(buf)));
@@ -111,7 +112,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
+	return nfserrno(nfsd_setuser(cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct dentry *dentry,
@@ -219,7 +220,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, exp);
+		error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 		if (error)
 			goto out;
 	}
@@ -358,7 +359,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, exp);
+	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 	if (error)
 		goto out;
 
-- 
2.44.0


