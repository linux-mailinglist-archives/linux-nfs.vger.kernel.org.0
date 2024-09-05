Return-Path: <linux-nfs+bounces-6267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55F96E2CD
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9DB1C2253F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980F18E029;
	Thu,  5 Sep 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRhTHqhf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404918DF81
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563424; cv=none; b=M2UAWEuol9fUhjQxpi+nS4xk5eQAcNzfxhoDa28G8jADJE3zv2iSxtsblNi/ifNWY4LjjPkzgQ+Pwy7c/oGWDjSSQVaZ5S3zBHIg/PIIKePewTC20DofkLxo23BzOb6E1qJh1ZEZv9MKKXRjWNHTd0wN/vSMXHeFP1b1zH3QdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563424; c=relaxed/simple;
	bh=itUYaslxAPllR/1NH4isYsXv5SFtnJ31gvkimcKDKg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC8cDMvKFEg4b5auq5B17Q+akTc9JXEeFLLlzubmGP4NM6vukgYMbPzJi84SaeYOgiqz9w+exhGM1Bacjvo4OdLHZrDdHj0lclfBaqqxwAge0dEy5V1BL2F4IL0ul8hPzRgwj30Ux1b0JgEEkbIyuMTucKh6C9s3wlKLXmEdbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRhTHqhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C20EC4CEC3;
	Thu,  5 Sep 2024 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563423;
	bh=itUYaslxAPllR/1NH4isYsXv5SFtnJ31gvkimcKDKg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRhTHqhfIdyU73e7FBagW1J8V9grYPEQHXxUXGETgY//RXJMpohPOqopaopppbXSB
	 hBgQy40/TpWCiJLqGUu1O1K+32FYrMqiTUH9nQiZPei5U4s2piwyPkz+uob4ExvKeF
	 yRAxKelIgQWq91S1FoQLMSUS9nPs2mh16gbP5mcO2VtGMv3d+KIGeNSoCtFk6NiS9c
	 WXERtgtZPUOxAefSYPCDAy9mMuBHMwesSSO6rM2OwGdPAeGxBVooDXE8pJcUldv047
	 i/TcF7WMhrpGrwFkR7Az0E7GPuh46qkzxHjAetN0xVOPDY9HbW/QPApowOqVwo9ZfY
	 ix/bF1w1667WQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 08/26] nfsd: factor out __fh_verify to allow NULL rqstp to be passed
Date: Thu,  5 Sep 2024 15:09:42 -0400
Message-ID: <20240905191011.41650-9-snitzer@kernel.org>
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

__fh_verify() offers an interface like fh_verify() but doesn't require
a struct svc_rqst *, instead it also takes the specific parts as
explicit required arguments.  So it is safe to call __fh_verify() with
a NULL rqstp, but the net, cred, and client args must not be NULL.

__fh_verify() does not use SVC_NET(), nor does the functions it calls.

Rather than using rqstp->rq_client pass the client and gssclient
explicitly to __fh_verify and then to nfsd_set_fh_dentry().

Lastly, it should be noted that the previous commit prepared for 4
associated tracepoints to only be used if rqstp is not NULL (this is a
stop-gap that should be properly fixed so localio also benefits from
the utility these tracepoints provide when debugging fh_verify
issues).

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 91 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 60c2395d7af7..a77af71892a3 100644
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
@@ -295,42 +299,33 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 }
 
 /**
- * fh_verify - filehandle lookup and access checking
- * @rqstp: pointer to current rpc request
+ * __fh_verify - filehandle lookup and access checking
+ * @rqstp: RPC transaction context, or NULL
+ * @net: net namespace in which to perform the export lookup
+ * @cred: RPC user credential
+ * @client: RPC auth domain
+ * @gssclient: RPC GSS auth domain, or NULL
  * @fhp: filehandle to be verified
  * @type: expected type of object pointed to by filehandle
  * @access: type of access needed to object
  *
- * Look up a dentry from the on-the-wire filehandle, check the client's
- * access to the export, and set the current task's credentials.
- *
- * Regardless of success or failure of fh_verify(), fh_put() should be
- * called on @fhp when the caller is finished with the filehandle.
- *
- * fh_verify() may be called multiple times on a given filehandle, for
- * example, when processing an NFSv4 compound.  The first call will look
- * up a dentry using the on-the-wire filehandle.  Subsequent calls will
- * skip the lookup and just perform the other checks and possibly change
- * the current task's credentials.
- *
- * @type specifies the type of object expected using one of the S_IF*
- * constants defined in include/linux/stat.h.  The caller may use zero
- * to indicate that it doesn't care, or a negative integer to indicate
- * that it expects something not of the given type.
- *
- * @access is formed from the NFSD_MAY_* constants defined in
- * fs/nfsd/vfs.h.
+ * See fh_verify() for further descriptions of @fhp, @type, and @access.
  */
-__be32
-fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+static __be32
+__fh_verify(struct svc_rqst *rqstp,
+	    struct net *net, struct svc_cred *cred,
+	    struct auth_domain *client,
+	    struct auth_domain *gssclient,
+	    struct svc_fh *fhp, umode_t type, int access)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
 
 	if (!fhp->fh_dentry) {
-		error = nfsd_set_fh_dentry(rqstp, fhp);
+		error = nfsd_set_fh_dentry(rqstp, net, cred, client,
+					   gssclient, fhp);
 		if (error)
 			goto out;
 	}
@@ -359,7 +354,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
+	error = nfsd_setuser_and_check_port(rqstp, cred, exp);
 	if (error)
 		goto out;
 
@@ -389,7 +384,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 
 skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
-	error = nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
+	error = nfsd_permission(cred, exp, dentry, access);
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
@@ -397,6 +392,40 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	return error;
 }
 
+/**
+ * fh_verify - filehandle lookup and access checking
+ * @rqstp: pointer to current rpc request
+ * @fhp: filehandle to be verified
+ * @type: expected type of object pointed to by filehandle
+ * @access: type of access needed to object
+ *
+ * Look up a dentry from the on-the-wire filehandle, check the client's
+ * access to the export, and set the current task's credentials.
+ *
+ * Regardless of success or failure of fh_verify(), fh_put() should be
+ * called on @fhp when the caller is finished with the filehandle.
+ *
+ * fh_verify() may be called multiple times on a given filehandle, for
+ * example, when processing an NFSv4 compound.  The first call will look
+ * up a dentry using the on-the-wire filehandle.  Subsequent calls will
+ * skip the lookup and just perform the other checks and possibly change
+ * the current task's credentials.
+ *
+ * @type specifies the type of object expected using one of the S_IF*
+ * constants defined in include/linux/stat.h.  The caller may use zero
+ * to indicate that it doesn't care, or a negative integer to indicate
+ * that it expects something not of the given type.
+ *
+ * @access is formed from the NFSD_MAY_* constants defined in
+ * fs/nfsd/vfs.h.
+ */
+__be32
+fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
+{
+	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred,
+			   rqstp->rq_client, rqstp->rq_gssclient,
+			   fhp, type, access);
+}
 
 /*
  * Compose a file handle for an NFS reply.
-- 
2.44.0


