Return-Path: <linux-nfs+bounces-13468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D986B1CC67
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 21:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106D418C4200
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE755846C;
	Wed,  6 Aug 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn3LHxC2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C078F59
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507752; cv=none; b=ZJzMn7ECP2DyjgCaCxdY1e2RmGT/o2qsbo7A4cElPhSojHz6PQJdnuQvBZBKj0PEyLI8+m4kYY6btrqh7CHOO62jtqdpuXTt+SSPmFmPBftOBzfa+zCQYwozXs3Vzv0MFHXZgi9c1Z+vZVaeLFDlBiR6poWAluC8VO7vF7NeFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507752; c=relaxed/simple;
	bh=gwHcfbnpxI/8zmeaROCp7NrFwzdX5muRpu4IW0bEgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReAakOYEj0ACLqzMd8qjy1l/PP3T3L35WArROzQnc8M6PoMSR5t0aNl02u4IVPJOSRQKtUfeGgwPQZ06s+O7ihxjtf+5PSkrS3yLSASUHVw0QR7zMCRnv9VfUFS5gsPgfT5R9VBFSFPKRj/EWQHloypl2lnUo6HXtPrXdhdUQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn3LHxC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754507749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n6UkJjklQHTn1zAF8/DjvJTO5HiHEDBM9QKtZiSatbE=;
	b=cn3LHxC22WMKacep+EXsD6ymihFkS9OZXqZNWsRK4yLNL5mt6sYx/j1S1ZiJAjGcU7Lw3o
	mzDGPlXFA5OROFSMV9tFXriwG0qwbeRgmvWqzjdH9BdQgc9lxe9wTKhuyUOSvMHK+NL8O+
	3jNghnkijjqNHfVF/y5qcgh1hszKtaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-JD6oMxOsPk2hLZQp1YdYRQ-1; Wed,
 06 Aug 2025 15:15:46 -0400
X-MC-Unique: JD6oMxOsPk2hLZQp1YdYRQ-1
X-Mimecast-MFC-AGG-ID: JD6oMxOsPk2hLZQp1YdYRQ_1754507745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DCB7180044F;
	Wed,  6 Aug 2025 19:15:45 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11D42195608F;
	Wed,  6 Aug 2025 19:15:45 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 49D5235F234;
	Wed, 06 Aug 2025 15:15:43 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: decouple the xprtsec policy check from check_nfsd_access()
Date: Wed,  6 Aug 2025 15:15:43 -0400
Message-ID: <20250806191543.2348885-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A while back I had reported that an NFSv3 client could successfully
mount using '-o xprtsec=none' an export that had been exported with
'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
would succeed and the mount would show up in /proc/mount.  Attempting to
do anything futher with the mount would be met with NFS3ERR_ACCES.

This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
NLM under XPRTSEC policies").

Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
so we shouldn't be conflating them when determining whether the access
checks can be bypassed.  Split check_nfsd_access() into two helpers, and
have __fh_verify() call the helpers directly since __fh_verify() has
logic that allows one or both of the checks to be skipped.  All other
sites will continue to call check_nfsd_access().

Link: https://lore.kernel.org/linux-nfs/ZjO3Qwf_G87yNXb2@aion/
Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/export.c | 83 +++++++++++++++++++++++++++++++++---------------
 fs/nfsd/export.h |  3 ++
 fs/nfsd/nfsfh.c  | 24 +++++++++++++-
 3 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index cadfc2bae60e..1c46864464ff 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1082,50 +1082,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 }
 
 /**
- * check_nfsd_access - check if access to export is allowed.
+ * check_xprtsec_policy - check if access to export is allowed by the
+ * 			  xprtsec policy
  * @exp: svc_export that is being accessed.
- * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
- * @may_bypass_gss: reduce strictness of authorization check
+ * @rqstp: svc_rqst attempting to access @exp.
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
  *
  * Return values:
  *   %nfs_ok if access is granted, or
  *   %nfserr_wrongsec if access is denied
  */
-__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
-			 bool may_bypass_gss)
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
 {
-	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt;
-
-	/*
-	 * If rqstp is NULL, this is a LOCALIO request which will only
-	 * ever use a filehandle/credential pair for which access has
-	 * been affirmed (by ACCESS or OPEN NFS requests) over the
-	 * wire. So there is no need for further checks here.
-	 */
-	if (!rqstp)
-		return nfs_ok;
-
-	xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
 		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
-			goto ok;
+			return nfs_ok;
 	}
-	if (!may_bypass_gss)
-		goto denied;
+	return nfserr_wrongsec;
+}
+
+/**
+ * check_security flavor - check if access to export is allowed by the
+ * 			   security flavor
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Helper function for check_nfsd_access().  Note that callers should be
+ * using check_nfsd_access() instead of calling this function directly.  The
+ * one exception is __fh_verify() since it has logic that may result in one
+ * or both of the helpers being skipped.
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss)
+{
+	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
 
-ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
 		return nfs_ok;
@@ -1167,10 +1179,31 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 		}
 	}
 
-denied:
 	return nfserr_wrongsec;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp.
+ * @may_bypass_gss: reduce strictness of authorization check
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
+__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
+			 bool may_bypass_gss)
+{
+	__be32 status;
+
+	status = check_xprtsec_policy(exp, rqstp);
+	if (status != nfs_ok)
+		return status;
+
+	return check_security_flavor(exp, rqstp, may_bypass_gss);
+}
+
 /*
  * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
  * auth_unix client) if it's available and has secinfo information;
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b9c0adb3ce09..ef5581911d5b 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -101,6 +101,9 @@ struct svc_expkey {
 
 struct svc_cred;
 int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
+__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
+__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp,
+			     bool may_bypass_gss);
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 			 bool may_bypass_gss);
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 74cf1f4de174..1078a4c763b0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -364,10 +364,30 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
+	/*
+	 * If rqstp is NULL, this is a LOCALIO request which will only
+	 * ever use a filehandle/credential pair for which access has
+	 * been affirmed (by ACCESS or OPEN NFS requests) over the
+	 * wire.  Skip both the xprtsec policy and the security flavor
+	 * checks.
+	 */
+	if (!rqstp)
+		goto check_permissions;
+
 	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
 		/* NLM is allowed to fully bypass authentication */
 		goto out;
 
+	/*
+	 * NLM is allowed to bypass the xprtsec policy check because lockd
+	 * doesn't support xprtsec.
+	 */
+	if (!(access & NFSD_MAY_NLM)) {
+		error = check_xprtsec_policy(exp, rqstp);
+		if (error)
+			goto out;
+	}
+
 	if (access & NFSD_MAY_BYPASS_GSS)
 		may_bypass_gss = true;
 	/*
@@ -379,13 +399,15 @@ __fh_verify(struct svc_rqst *rqstp,
 			&& exp->ex_path.dentry == dentry)
 		may_bypass_gss = true;
 
-	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
+	error = check_security_flavor(exp, rqstp, may_bypass_gss);
 	if (error)
 		goto out;
+
 	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
 	if (rqstp)
 		svc_xprt_set_valid(rqstp->rq_xprt);
 
+check_permissions:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
-- 
2.48.1


