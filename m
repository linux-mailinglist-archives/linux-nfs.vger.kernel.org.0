Return-Path: <linux-nfs+bounces-17706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D2D0B3CA
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4515E3098F84
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAE364032;
	Fri,  9 Jan 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF9zkCkD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7A364025
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975719; cv=none; b=PfaFIbmPbXTlfHn2/4o5aLi3OZE4WlQBj54VT51HfT3i7324d0b9xFIqQkt8qSwPluuSc7w/V8pK1bv+hCrUb2CHE+K2gpkI9ImjQzCpTHkZV9WIkqjeayDat0f/DQKn86wurYorScT7H3rC9/bwVeRq5jG8d1mSAKDdK7oOPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975719; c=relaxed/simple;
	bh=UKfdruc8/GEdr1Nh0rN6G1Web3mpE3UXzMpS1q9SRGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGeBNGQLwycdMec1zuE4roLKs9c4hz/orQ/PZpUNpM4CpVKsvxfxiVl+Vd59AcDKFrGsjokyeFRbPMhV9xpgOITalFnKi2oTyhckJUyVa1sTq0wvXpNZGbQDRIMaAvuL+ct19QDqTJqC+ZTlWHxiu8iEMBIQs0BzL8fnp0XvmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF9zkCkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822E0C4CEF7;
	Fri,  9 Jan 2026 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975719;
	bh=UKfdruc8/GEdr1Nh0rN6G1Web3mpE3UXzMpS1q9SRGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SF9zkCkDMIPKeBxw7m80V1P6A7b+SxaGo3zQw5mjdW0TJj7ljtxs5fvOj9zju57xW
	 jaa68uQiCKda33U0cRrTfWSpX3Gey33N0VPlUOhYZ4aod3YlbFtpspnJ3zmnyvsTaX
	 whef/8YwFxueGfQy4JNvlC1n0mEBsyV9xfQVTCFT+Cssxi3Yf9Tj57pmITmCgV69/k
	 d9fpq7y+OKZ9TDY9oGTK9CF4DQg91n3CW0DHBnBCYVbHJRRrV5YeHG1xCXRyHsHkqm
	 iDAb4wcU/8HXXAUfu5AnIAb3g37BYLQSb1/SrnDTWU0JHAhWimubQjwwGN5L6ESMaG
	 0rjfw6oXXGASg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 12/13] NFSD: Add POSIX draft ACL support to the NFSv4 SETATTR operation
Date: Fri,  9 Jan 2026 11:21:41 -0500
Message-ID: <20260109162143.4186112-13-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The POSIX ACL extension to NFSv4 enables clients to set access
and default ACLs via FATTR4_POSIX_ACCESS_ACL and
FATTR4_POSIX_DEFAULT_ACL attributes. Integration of these
attributes into SETATTR processing requires wiring them through
the nfsd_attrs structure and ensuring proper cleanup on all
code paths.

This patch connects the na_pacl and na_dpacl fields in
nfsd_attrs to the decoded ACL pointers from the NFSv4 SETATTR
decoder. Ownership of these ACL references transfers to attrs
immediately after initialization, with the decoder's pointers
cleared to NULL. This transfer ensures nfsd_attrs_free()
releases the ACLs on normal completion, while new error paths
call posix_acl_release() directly when cleanup occurs before
nfsd_attrs_free() runs.

Early returns in the nfsd4_setattr() function gain conversions
to goto statements that branch to proper cleanup handlers.
Error paths before fh_want_write() branch to out_err for ACL
release only; paths after fh_want_write() use the existing out
label for full cleanup via nfsd_attrs_free().

The patch adds mutual exclusion between NFSv4 ACLs (sa_acl) and
POSIX ACLs. Setting both types simultaneously returns
nfserr_inval because these ACL models cannot coexist on the
same file object.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 72edf4add536..d476d108f6e1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1214,6 +1214,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &setattr->sa_iattr,
 		.na_seclabel	= &setattr->sa_label,
+		.na_pacl	= setattr->sa_pacl,
+		.na_dpacl	= setattr->sa_dpacl,
 	};
 	bool save_no_wcc, deleg_attrs;
 	struct nfs4_stid *st = NULL;
@@ -1221,6 +1223,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	int err;
 
+	/* Transfer ownership to attrs for cleanup via nfsd_attrs_free() */
+	setattr->sa_pacl = NULL;
+	setattr->sa_dpacl = NULL;
+
 	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
@@ -1234,7 +1240,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
 				flags, NULL, &st);
 		if (status)
-			return status;
+			goto out_err;
 	}
 
 	if (deleg_attrs) {
@@ -1252,17 +1258,24 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (st)
 		nfs4_put_stid(st);
 	if (status)
-		return status;
+		goto out_err;
 
 	err = fh_want_write(&cstate->current_fh);
-	if (err)
-		return nfserrno(err);
+	if (err) {
+		status = nfserrno(err);
+		goto out_err;
+	}
 	status = nfs_ok;
 
 	status = check_attr_support(cstate, setattr->sa_bmval, nfsd_attrmask);
 	if (status)
 		goto out;
 
+	if (setattr->sa_acl && (attrs.na_dpacl || attrs.na_pacl)) {
+		status = nfserr_inval;
+		goto out;
+	}
+
 	inode = cstate->current_fh.fh_dentry->d_inode;
 	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
 				   setattr->sa_acl, &attrs);
@@ -1280,8 +1293,9 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!status)
 		status = nfserrno(attrs.na_paclerr);
 out:
-	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
+out_err:
+	nfsd_attrs_free(&attrs);
 	return status;
 }
 
-- 
2.52.0


