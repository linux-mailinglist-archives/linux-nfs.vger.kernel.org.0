Return-Path: <linux-nfs+bounces-6885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715B99185C
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8244A1F2272F
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CB1156F39;
	Sat,  5 Oct 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7bwzi3c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED279156C52;
	Sat,  5 Oct 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146501; cv=none; b=HaF/IBKEVvk7BnUBl3hYjZuu8HSH0e/j0xZlT0YNYw/v4Bf6mywGpIVdT0nO/ziBiSHkKaJzdOXuKhmjrt5PSfBaIDs25V3wfZjKZnpLSdUzXZqL/qlnhS+WOEJt62Jtpoc0sq/k0KjLxvPgYoVwF9tCacGWuNQfXKS5zpxs4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146501; c=relaxed/simple;
	bh=0GLbD2BI3h0+MjUsQCsdcXZMktjOxuGzHSyFE8XhhVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLpaPSqmu3fVNsffGJQXNyDjcjaHF3F3Q4Ukznxa1ZXJdwgDVG/J0DixbWD/KsX/MZl/GEq0wePjWTmQZ25a1V6n6uvZi8CiZV4lGRGgEqFJXvqyMJojs6PKwanoxPv0Ua4U8UT3ZxTpwnuyvy/ZMiIC8jdxzORtDl7hKK0JhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7bwzi3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203DFC4CEC2;
	Sat,  5 Oct 2024 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728146500;
	bh=0GLbD2BI3h0+MjUsQCsdcXZMktjOxuGzHSyFE8XhhVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7bwzi3cACmzv/9+WRa+s7OHv3JJyfqmNhyEz0/I2qonB1prWFdZKH+qVI+1/3TgX
	 G5/lNgxkeDH30d5oc024IpxbE/6gTBIljymJQ14nV+TJNItETbLAMcsp45C5Gt894X
	 Iwjli9k+sxRa6WzQG0pfvTViZ7mepj6BYyT8mhIs0ci1GRnwihbVZ8tIyrLeHonsbd
	 K0uRS7OPVk6VbesUETBbJXfiaChUHyVVag3VMWDTnz+zn4hfmIlJA2iJK0tcmcSfdz
	 UhcX/i0kFdyxMRDDOW2G/yszftxXY592dlgKpg66vdtKAypSOHmxwTAdqUWQ/qPqeq
	 n1R7pjFYh2iiw==
Received: by pali.im (Postfix)
	id 8CE53648; Sat,  5 Oct 2024 18:41:33 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
Date: Sat,  5 Oct 2024 18:40:39 +0200
Message-Id: <20241005164039.21255-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912221917.23802-1-pali@kernel.org>
References: <20240912221917.23802-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
only GSS, but bypass any method. This is a problem specially for NFS3
AUTH_NULL-only exports.

The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
section 2.3.2, to allow mounting NFS2/3 GSS-only export without
authentication. So few procedures which do not expose security risk used
during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
client mount operation to finish successfully.

The problem with current implementation is that for AUTH_NULL-only exports,
the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
AUTH_NONE on active mount, which makes the mount inaccessible.

Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
and really allow to bypass only exports which have enabled some real
authentication (GSS, TLS, or any other).

The result would be: For AUTH_NULL-only export if client attempts to do
mount with AUTH_UNIX flavor then it will receive access errors, which
instruct client that AUTH_UNIX flavor is not usable and will either try
other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
Similarly if client attempt to do mount with AUTH_NULL flavor and only
AUTH_UNIX flavor is enabled then the client will receive access error.

This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* Apply whole NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT logic not
  only for GSS, but also for any method with the real authentication
  (anything except RPC_AUTH_NULL, RPC_AUTH_UNIX and RPC_AUTH_SHORT).
---
 fs/nfsd/export.c   | 19 ++++++++++++++++++-
 fs/nfsd/export.h   |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfs4xdr.c  |  2 +-
 fs/nfsd/nfsfh.c    | 12 +++++++++---
 fs/nfsd/vfs.c      |  2 +-
 6 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 50b3135d07ac..8a12876b9335 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 	struct svc_xprt *xprt = rqstp->rq_xprt;
@@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	if (nfsd4_spo_must_allow(rqstp))
 		return 0;
 
+	/* Some calls may be processed without authentication
+	 * on GSS exports. For example NFS2/3 calls on root
+	 * directory, see section 2.3.2 of rfc 2623.
+	 * For "may_bypass_gss" check that export has really
+	 * enabled some flavor with authentication (GSS or any
+	 * other) and also check that the used auth flavor is
+	 * without authentication (none or sys).
+	 */
+	if (may_bypass_gss && (
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
+	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
+		for (f = exp->ex_flavors; f < end; f++) {
+			if (f->pseudoflavor >= RPC_AUTH_DES)
+				return 0;
+		}
+	}
+
 denied:
 	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
 }
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ca9dc230ae3d..dc7cf4f6ac53 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -100,7 +100,7 @@ struct svc_expkey {
 #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
 
 int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss);
 
 /*
  * Function declarations
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..0f67f4a7b8b2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 			if (current_fh->fh_export &&
 					need_wrongsec_check(rqstp))
-				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
+				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
 		}
 encode_op:
 		if (op->status == nfserr_replay_me) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97f583777972..b45ea5757652 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 			nfserr = nfserrno(err);
 			goto out_put;
 		}
-		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
+		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
 		if (nfserr)
 			goto out_put;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index dd4e11a703aa..ed0eabfa3cb0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_export *exp = NULL;
+	bool may_bypass_gss = false;
 	struct dentry	*dentry;
 	__be32		error;
 
@@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	 * which clients virtually always use auth_sys for,
 	 * even while using RPCSEC_GSS for NFS.
 	 */
-	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
+	if (access & NFSD_MAY_LOCK)
 		goto skip_pseudoflavor_check;
+	/*
+	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
+	 */
+	if (access & NFSD_MAY_BYPASS_GSS)
+		may_bypass_gss = true;
 	/*
 	 * Clients may expect to be able to use auth_sys during mount,
 	 * even if they use gss for everything else; see section 2.3.2
@@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	 */
 	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
 			&& exp->ex_path.dentry == dentry)
-		goto skip_pseudoflavor_check;
+		may_bypass_gss = true;
 
-	error = check_nfsd_access(exp, rqstp);
+	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..b2f5ea7c2187 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
 	if (err)
 		return err;
-	err = check_nfsd_access(exp, rqstp);
+	err = check_nfsd_access(exp, rqstp, false);
 	if (err)
 		goto out;
 	/*
-- 
2.20.1


