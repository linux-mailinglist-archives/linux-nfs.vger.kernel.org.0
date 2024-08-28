Return-Path: <linux-nfs+bounces-5834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A4961B2D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F500B22B8C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D59208A0;
	Wed, 28 Aug 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG1unXne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62A20309
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805898; cv=none; b=NmzJMKfSXA+bfHBUGrx/ZVgWftk9hkBW4XfAwA+iWMtdT6feDD7srPOWqNazi1Fa17YR9nYp0utiIy2YqwDNqjy+HS6byzIXMSh0w+Kqv0yKSBZQEEzTdg6jn01T3Kf7pfGVh61bY3xo9PKifmUADDw/GHqBq0/L19M9EgZ9ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805898; c=relaxed/simple;
	bh=QnKDORUSvLCatXW4RbakFrDklzp3Jn46+bnxhkkju20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKyuyHtW6P0laYgbztC5a0+KkbysRp7dQqUwBVSPb1QrdZ9en3bOhBGRMIWVOallqmMwY19JQXA6M4Dihrs3xeMmAnA+uNGf1P0ySUixK5rqzirPfZlgwL9fKmHh175SyTJAsJkf1yalia9m57vxaCvmVUx0RX0odaisVFmYm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG1unXne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D60C4DDF1;
	Wed, 28 Aug 2024 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805898;
	bh=QnKDORUSvLCatXW4RbakFrDklzp3Jn46+bnxhkkju20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QG1unXnesEaUHj79WV56LnN0sSMVyObFesfjxxpDpUV0Z2sD7gkMfrC3IZbjTpPr6
	 2Vv4xTC6bv7NJ/sQTMunaLBXFLFfWSQlq0hp59jvZPAdIkzbe1R+QR9j9ko4c2kBwb
	 fYhWPO0RTwzCB9KE0DZT0Oq/0Vf4fsFPPdL0xbwMb42kav1rtBH6xFcEKwogFIw92c
	 S6t+6ujorZHNH7YgKglMI+wYtNzNq22ebV1FBLYHXvpiq1KnX0lorryudSm8oqn1UQ
	 Cgp7sjnDQWyH50NX8EPi5aaGYxSuPtLX1tchmK1jfQcZGwAkRp+UXx7LNATsHfoHHp
	 +vowxZGP4Jf2Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [RFC PATCH 5/6] nfsd: factor out __fh_verify to allow NULL rqstp to be passed
Date: Tue, 27 Aug 2024 20:44:44 -0400
Message-ID: <20240828004445.22634-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

__fh_verify() offers an interface like fh_verify() but doesn't require
a struct svc_rqst *, instead it also takes the specific parts as
explicit required arguments.  So it is safe to call __fh_verify() with
a NULL rqstp, but the net, cred, and client args must not be NULL.

__fh_verify() does not use SVC_NET(), nor does the functions it calls.

Rather then depending on rqstp->rq_vers to determine nfs version, pass
it in explicitly.  This removes another dependency on rqstp and ensures
the correct version is checked.  The rqstp can be for an NLM request and
while some code tests that, other code does not.

Rather than using rqstp->rq_client pass the client and gssclient
explicitly to __fh_verify and then to nfsd_set_fh_dentry().

Lastly, 4 associated tracepoints are only used if rqstp is not NULL
(this is a stop-gap that should be properly fixed so localio also
benefits from the utility these tracepoints provide when debugging
fh_verify issues).

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 168 ++++++++++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 76 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 77acc26e8b02..80c06e170e9a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -142,7 +142,11 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
  * dentry.  On success, the results are used to set fh_export and
  * fh_dentry.
  */
-static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
+static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
+				 struct svc_cred *cred,
+				 struct auth_domain *client,
+				 struct auth_domain *gssclient,
+				 struct svc_fh *fhp)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct fid *fid = NULL;
@@ -184,8 +188,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	data_left -= len;
 	if (data_left < 0)
 		return error;
-	exp = rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
-			    rqstp->rq_client, rqstp->rq_gssclient,
+	exp = rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
+			    net, client, gssclient,
 			    fh->fh_fsid_type, fh->fh_fsid);
 	fid = (struct fid *)(fh->fh_fsid + len);
 
@@ -220,7 +224,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
+		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 		if (error)
 			goto out;
 	}
@@ -297,6 +301,87 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	return error;
 }
 
+static __be32
+__fh_verify(struct svc_rqst *rqstp,
+	    struct net *net, struct svc_cred *cred,
+	    struct auth_domain *client,
+	    struct auth_domain *gssclient,
+	    struct svc_fh *fhp, umode_t type, int access)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_export *exp = NULL;
+	struct dentry	*dentry;
+	__be32		error;
+
+	if (!fhp->fh_dentry) {
+		error = nfsd_set_fh_dentry(rqstp, net, cred, client,
+					   gssclient, fhp);
+		if (error)
+			goto out;
+	}
+	dentry = fhp->fh_dentry;
+	exp = fhp->fh_export;
+
+	trace_nfsd_fh_verify(rqstp, fhp, type, access);
+
+	/*
+	 * We still have to do all these permission checks, even when
+	 * fh_dentry is already set:
+	 * 	- fh_verify may be called multiple times with different
+	 * 	  "access" arguments (e.g. nfsd_proc_create calls
+	 * 	  fh_verify(...,NFSD_MAY_EXEC) first, then later (in
+	 * 	  nfsd_create) calls fh_verify(...,NFSD_MAY_CREATE).
+	 *	- in the NFSv4 case, the filehandle may have been filled
+	 *	  in by fh_compose, and given a dentry, but further
+	 *	  compound operations performed with that filehandle
+	 *	  still need permissions checks.  In the worst case, a
+	 *	  mountpoint crossing may have changed the export
+	 *	  options, and we may now need to use a different uid
+	 *	  (for example, if different id-squashing options are in
+	 *	  effect on the new filesystem).
+	 */
+	error = check_pseudo_root(dentry, exp);
+	if (error)
+		goto out;
+
+	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
+	if (error)
+		goto out;
+
+	error = nfsd_mode_check(dentry, type);
+	if (error)
+		goto out;
+
+	/*
+	 * pseudoflavor restrictions are not enforced on NLM,
+	 * which clients virtually always use auth_sys for,
+	 * even while using RPCSEC_GSS for NFS.
+	 */
+	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
+		goto skip_pseudoflavor_check;
+	/*
+	 * Clients may expect to be able to use auth_sys during mount,
+	 * even if they use gss for everything else; see section 2.3.2
+	 * of rfc 2623.
+	 */
+	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
+			&& exp->ex_path.dentry == dentry)
+		goto skip_pseudoflavor_check;
+
+	error = check_nfsd_access(exp, rqstp);
+	if (error)
+		goto out;
+
+skip_pseudoflavor_check:
+	/* Finally, check access permissions. */
+	error = nfsd_permission(cred, exp, dentry, access);
+out:
+	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
+	if (error == nfserr_stale)
+		nfsd_stats_fh_stale_inc(nn, exp);
+	return error;
+}
+
 /**
  * fh_verify - filehandle lookup and access checking
  * @rqstp: pointer to current rpc request
@@ -327,80 +412,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	struct svc_export *exp = NULL;
-	struct dentry	*dentry;
-	__be32		error;
-
-	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, fhp);
-		if (error)
-			goto out;
-	}
-	dentry = fhp->fh_dentry;
-	exp = fhp->fh_export;
-
-	trace_nfsd_fh_verify(rqstp, fhp, type, access);
-
-	/*
-	 * We still have to do all these permission checks, even when
-	 * fh_dentry is already set:
-	 * 	- fh_verify may be called multiple times with different
-	 * 	  "access" arguments (e.g. nfsd_proc_create calls
-	 * 	  fh_verify(...,NFSD_MAY_EXEC) first, then later (in
-	 * 	  nfsd_create) calls fh_verify(...,NFSD_MAY_CREATE).
-	 *	- in the NFSv4 case, the filehandle may have been filled
-	 *	  in by fh_compose, and given a dentry, but further
-	 *	  compound operations performed with that filehandle
-	 *	  still need permissions checks.  In the worst case, a
-	 *	  mountpoint crossing may have changed the export
-	 *	  options, and we may now need to use a different uid
-	 *	  (for example, if different id-squashing options are in
-	 *	  effect on the new filesystem).
-	 */
-	error = check_pseudo_root(dentry, exp);
-	if (error)
-		goto out;
-
-	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
-	if (error)
-		goto out;
-
-	error = nfsd_mode_check(dentry, type);
-	if (error)
-		goto out;
-
-	/*
-	 * pseudoflavor restrictions are not enforced on NLM,
-	 * which clients virtually always use auth_sys for,
-	 * even while using RPCSEC_GSS for NFS.
-	 */
-	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
-		goto skip_pseudoflavor_check;
-	/*
-	 * Clients may expect to be able to use auth_sys during mount,
-	 * even if they use gss for everything else; see section 2.3.2
-	 * of rfc 2623.
-	 */
-	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
-			&& exp->ex_path.dentry == dentry)
-		goto skip_pseudoflavor_check;
-
-	error = check_nfsd_access(exp, rqstp);
-	if (error)
-		goto out;
-
-skip_pseudoflavor_check:
-	/* Finally, check access permissions. */
-	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
-out:
-	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
-	if (error == nfserr_stale)
-		nfsd_stats_fh_stale_inc(nn, exp);
-	return error;
+	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred,
+			   rqstp->rq_client, rqstp->rq_gssclient,
+			   fhp, type, access);
 }
 
-
 /*
  * Compose a file handle for an NFS reply.
  *
-- 
2.45.2


