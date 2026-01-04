Return-Path: <linux-nfs+bounces-17444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE67CF1201
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B88B30006F0
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5F126F0A;
	Sun,  4 Jan 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMzQ68Lx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57F178372
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543052; cv=none; b=kF+OyYNqOWf4aYjradGxST+7+SxRUIgldWl/jTsH3EXYhgE7o92d6apW3a3Bny9ud82aE28nKd67r2kw3/oB9IKnlAqWUc7fYYbC9rfurlaVuMWKJoWnYkElaozB6mbNMNLNjGveJcoeZeMSFWjec8eczUKZ7ILEfeLEufCyL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543052; c=relaxed/simple;
	bh=cP81rfi8EJ2oW2VBKOa8l4n719Dy9cHG8Gv1LS9uvMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS//b2c3ua10gA5SKld9M3x+R4QPcxtfaA1Mzyy4eAY3mynR48pGgZRY+Ig3FyGsbqsx61rVKwp3aC437VJ6WdiI2o2Lkni2NRkPUYg/oL58okYu7HSHY7D5TQ3tjW5qtCoK3i8xEUqWtQmANjrqQa5xeFyp0EFkKh0acKWXUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMzQ68Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68748C4CEF7;
	Sun,  4 Jan 2026 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543052;
	bh=cP81rfi8EJ2oW2VBKOa8l4n719Dy9cHG8Gv1LS9uvMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EMzQ68Lxk05OplS2dNSaCb2vJLfjzGJ+hNitVrjicX70XsmHJL/1qo+/zl86HCMQ0
	 x4rf6VXepqlBbdFjdBdxYmlwkGGlSyN7OwZuAW+ub/cXcPUjX/neUYGrwjZ8CLQnon
	 CRDH+/aynxXuJN6lj5GTo74LRGbhUOZfXcJJmVRbIA/fVhXB7whjUQqSCO3bXL/0Kp
	 Cvdz4gwhikdhUpdkoZLxUiK2vJws4Rk8tNdMUA/Eed7mKsYxgEL0rMQVBxHnIqCRO7
	 y8CIDWtfneAZxD9f2QFC4B9sgtPWBMY4/MzsAGKDW8cDW88ntz4uQ4aNOmfSyB6d15
	 3nTDXTpL0t5iQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 10/12] NFSD: Add support for POSIX draft ACLs for file creation
Date: Sun,  4 Jan 2026 11:10:47 -0500
Message-ID: <20260104161049.3404551-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

NFSv4.2 clients can specify POSIX draft ACLs when creating file
objects via OPEN(CREATE) and CREATE operations. The previous patch
added POSIX ACL support to the NFSv4 SETATTR operation for modifying
existing objects, but file creation follows different code paths
that also require POSIX ACL handling.

This patch integrates POSIX ACL support into nfsd4_create() and
nfsd4_create_file(). Ownership of the decoded ACL pointers
(op_dpacl, op_pacl, cr_dpacl, cr_pacl) transfers to the nfsd_attrs
structure immediately, with the original fields cleared to NULL.
This transfer ensures nfsd_attrs_free() releases the ACLs upon
completion while preventing double-free on error paths.

Mutual exclusion between NFSv4 ACLs and POSIX ACLs is enforced:
setting both op_acl and op_dpacl/op_pacl simultaneously returns
nfserr_inval. Errors during ACL application clear the corresponding
bits in the result bitmask (fattr->bmval), signaling partial
completion to the client.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 59 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7ba4f193852d..c6bada560620 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -91,6 +91,10 @@ check_attr_support(struct nfsd4_compound_state *cstate, u32 *bmval,
 		return nfserr_attrnotsupp;
 	if ((bmval[0] & FATTR4_WORD0_ACL) && !IS_POSIXACL(d_inode(dentry)))
 		return nfserr_attrnotsupp;
+	if ((bmval[2] & (FATTR4_WORD2_POSIX_DEFAULT_ACL |
+					FATTR4_WORD2_POSIX_ACCESS_ACL)) &&
+					!IS_POSIXACL(d_inode(dentry)))
+		return nfserr_attrnotsupp;
 	if ((bmval[2] & FATTR4_WORD2_SECURITY_LABEL) &&
 			!(exp->ex_flags & NFSEXP_SECURITY_LABEL))
 		return nfserr_attrnotsupp;
@@ -265,8 +269,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		return nfserrno(host_err);
 
-	if (is_create_with_attrs(open))
-		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+	if (open->op_acl) {
+		if (open->op_dpacl || open->op_pacl) {
+			status = nfserr_inval;
+			goto out_write;
+		}
+		if (is_create_with_attrs(open))
+			nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+	} else if (is_create_with_attrs(open)) {
+		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
+		attrs.na_dpacl = open->op_dpacl;
+		attrs.na_pacl = open->op_pacl;
+		open->op_dpacl = NULL;
+		open->op_pacl = NULL;
+	}
 
 	child = start_creating(&nop_mnt_idmap, parent,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
@@ -379,6 +395,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 	if (attrs.na_paclerr || attrs.na_dpaclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
+	if (attrs.na_dpaclerr)
+		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+	if (attrs.na_paclerr)
+		open->op_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 out:
 	end_creating(child);
 	nfsd_attrs_free(&attrs);
@@ -546,8 +566,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	open->op_rqstp = rqstp;
 
 	/* This check required by spec. */
-	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
-		return nfserr_inval;
+	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL) {
+		status = nfserr_inval;
+		goto out_err;
+	}
 
 	open->op_created = false;
 	/*
@@ -556,8 +578,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	if (nfsd4_has_session(cstate) &&
 	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags) &&
-	    open->op_claim_type != NFS4_OPEN_CLAIM_PREVIOUS)
-		return nfserr_grace;
+	    open->op_claim_type != NFS4_OPEN_CLAIM_PREVIOUS) {
+		status = nfserr_grace;
+		goto out_err;
+	}
 
 	if (nfsd4_has_session(cstate))
 		copy_clientid(&open->op_clientid, cstate->session);
@@ -644,6 +668,9 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	nfsd4_cleanup_open_state(cstate, open);
 	nfsd4_bump_seqid(cstate, status);
+out_err:
+	posix_acl_release(open->op_dpacl);
+	posix_acl_release(open->op_pacl);
 	return status;
 }
 
@@ -784,6 +811,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &create->cr_iattr,
 		.na_seclabel	= &create->cr_label,
+		.na_dpacl	= create->cr_dpacl,
+		.na_pacl	= create->cr_pacl,
 	};
 	struct svc_fh resfh;
 	__be32 status;
@@ -793,13 +822,20 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
 	if (status)
-		return status;
+		goto out_aftermask;
 
 	status = check_attr_support(cstate, create->cr_bmval, nfsd_attrmask);
 	if (status)
-		return status;
+		goto out_aftermask;
 
-	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
+	if (create->cr_acl) {
+		if (create->cr_dpacl || create->cr_pacl) {
+			status = nfserr_inval;
+			goto out_aftermask;
+		}
+		status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl,
+								&attrs);
+	}
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -860,12 +896,17 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		create->cr_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 	if (attrs.na_paclerr || attrs.na_dpaclerr)
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
+	if (attrs.na_dpaclerr)
+		create->cr_bmval[2] &= ~FATTR4_WORD2_POSIX_DEFAULT_ACL;
+	if (attrs.na_paclerr)
+		create->cr_bmval[2] &= ~FATTR4_WORD2_POSIX_ACCESS_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
 out:
 	fh_put(&resfh);
 out_umask:
 	current->fs->umask = 0;
+out_aftermask:
 	nfsd_attrs_free(&attrs);
 	return status;
 }
-- 
2.52.0


