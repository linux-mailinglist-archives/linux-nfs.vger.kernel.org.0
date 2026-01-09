Return-Path: <linux-nfs+bounces-17703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED2D0B42D
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6601E3070F90
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9283644CF;
	Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyqKuY4h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF962773DA
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975716; cv=none; b=tKCBDPtxOGdSujSY2bwiRPniUrOoH7raFKvrxPf2uV+J4SK3PcJ53JX4BQzsjjZjGKiZoWvIhjWT2Ui75Gp6p+HVIBFlkMc+D8xBMyRdr9yUV65+bzPqIRxuqHCLUFZoScbXymKRgQmEtEOzirl1yw3bP6BWnyomp+afGohxezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975716; c=relaxed/simple;
	bh=S/S6q6t6bCTHKtQtxXojU653WEETS2t6QZXcwZkVAg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB9fPCSOJeF9TmzgWLc/wnVtReWmxedxINO/E6gG9X4q0XhlVX6c8mU9EYdWAgCRZgNMLZif0jCThNC7hHDSh0spiwxDHl8w2mDZCa5py8nT0gOVUVejJgbo9F9vpumtm46cAdyymaQc+zo5Ndwd/g/3OZNHoiMzhEaDEI2jQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyqKuY4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E02C19422;
	Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975716;
	bh=S/S6q6t6bCTHKtQtxXojU653WEETS2t6QZXcwZkVAg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyqKuY4hLXaocAWMDkRfvguisPh21qTOphtoMOLbueCnaUkrInKEN9mtIhujwn/6l
	 8ladxb/Xt5XF6G549JOiPfn4IaQJzbneBgMvFnYOIIaN3c63vDW0Y+iujyBmJE0XSW
	 iMoDjmBFL9Dm29jYBG6Bgogpdt8iom4C6mGoMvPH4ellH7/1POQ4V27FPnB82Zn4pY
	 1olBInckRCkzxkGfFcw8dazaVjHqQ8EOhTvbBYq8zT+P7+URhpZowZPW2DUKalDHxs
	 gNrjTyI0dxAf25Nka64zQHVL6jO6RYrE9nrN96/+mVs/mvS83Yxool6uqi+98IQAyL
	 budDz+jNfEYBQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 09/13] NFSD: Refactor nfsd_setattr()'s ACL error reporting
Date: Fri,  9 Jan 2026 11:21:38 -0500
Message-ID: <20260109162143.4186112-10-cel@kernel.org>
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

Support for FATTR4_POSIX_ACCESS_ACL and FATTR4_POSIX_DEFAULT_ACL
attributes in subsequent patches allows clients to set both ACL
types simultaneously during SETATTR and file creation. Each ACL
type can succeed or fail independently, requiring the server to
clear individual attribute bits in the reply bitmap when one
fails while the other succeeds.

The existing na_aclerr field cannot distinguish which ACL type
encountered an error. Separate error fields (na_paclerr for
access ACLs, na_dpaclerr for default ACLs) enable the server to
report per-ACL-type failures accurately.

This refactoring also adds validation previously absent: default
ACL processing rejects non-directory targets with EINVAL and
passes NULL to set_posix_acl() when a_count is zero to delete
the ACL. Access ACL processing rejects zero a_count with EINVAL
for ACL_SCOPE_FILE_SYSTEM semantics (the only scope currently
supported).

The changes preserve compatibility with existing NFSv4 ACL code.
NFSv4 ACL conversion (nfs4_acl_nfsv4_to_posix()) never produces
POSIX ACLs with a_count == 0, so the new validation logic only
affects future POSIX ACL attribute handling.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  8 +++++---
 fs/nfsd/vfs.c      | 34 +++++++++++++++++++++++++++-------
 fs/nfsd/vfs.h      |  3 ++-
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a77ec0685eee..2da092f9ac40 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -377,7 +377,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (attrs.na_labelerr)
 		open->op_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-	if (attrs.na_aclerr)
+	if (attrs.na_paclerr || attrs.na_dpaclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
 	end_creating(child);
@@ -858,7 +858,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (attrs.na_labelerr)
 		create->cr_bmval[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
-	if (attrs.na_aclerr)
+	if (attrs.na_paclerr || attrs.na_dpaclerr)
 		create->cr_bmval[0] &= ~FATTR4_WORD0_ACL;
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
@@ -1232,7 +1232,9 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
-		status = nfserrno(attrs.na_aclerr);
+		status = nfserrno(attrs.na_dpaclerr);
+	if (!status)
+		status = nfserrno(attrs.na_paclerr);
 out:
 	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 168d3ccc8155..c884c3f34afb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -596,15 +596,35 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attr->na_seclabel && attr->na_seclabel->len)
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);
-	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
-		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
-						dentry, ACL_TYPE_ACCESS,
-						attr->na_pacl);
-	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
-	    !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))
-		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_dpacl) {
+		if (!S_ISDIR(inode->i_mode))
+			attr->na_dpaclerr = -EINVAL;
+		else if (attr->na_dpacl->a_count > 0)
+			/* a_count == 0 means delete the ACL. */
+			attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+		else
+			attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
+						dentry, ACL_TYPE_DEFAULT,
+						NULL);
+	}
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) {
+		/*
+		 * For any file system that is not ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 MUST reply nfserr_inval.
+		 * For a file system that is ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 deletes the ACL.
+		 * XXX File systems that are ACL_SCOPE_FILE_OBJECT
+		 * are not yet supported.
+		 */
+		if (attr->na_pacl->a_count > 0)
+			attr->na_paclerr = set_posix_acl(&nop_mnt_idmap,
+							dentry, ACL_TYPE_ACCESS,
+							attr->na_pacl);
+		else
+			attr->na_paclerr = -EINVAL;
+	}
 out_fill_attrs:
 	/*
 	 * RFC 1813 Section 3.3.2 does not mandate that an NFS server
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e192dca4a679..702a844f2106 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -53,7 +53,8 @@ struct nfsd_attrs {
 	struct posix_acl	*na_dpacl;	/* input */
 
 	int			na_labelerr;	/* output */
-	int			na_aclerr;	/* output */
+	int			na_dpaclerr;	/* output */
+	int			na_paclerr;	/* output */
 };
 
 static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
-- 
2.52.0


