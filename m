Return-Path: <linux-nfs+bounces-17445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA0CF11FE
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCF13004CC5
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7B27056F;
	Sun,  4 Jan 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ2vNVT7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACB26D4DD
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543052; cv=none; b=TWpA5ARa5Ou0xIN1C+y4U42zsKFKJlwzrRh/IHRAg16FfV+FeGcR7P8twlqkni7825kH4LEwkq6iO079Shq3aubVzjnWhI3xsstdmzNX+rO4D41rRycBGtgpsMqZdzHz25Tuk64/JsZXYYvQk+S8j8lVzBWXSzSdODGtKDfkjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543052; c=relaxed/simple;
	bh=bkH/6h+POklqv8mcVwtE/uq4ReJg47toslY0V43aAZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9aS5jqmcMig/46qgz1LXojwGP3V5R3DVwev0mbDSeNDwwMkhoizLXqy4ifeF/WFegfmeUWy0lZ+y4qeQU2MaSFALFzx9iatZ6fpVBw++1Blnuw8AIM+hA8474YLzc5/Xl2+SYevfRqw4XugeJqXaNEf6XXh7gZwTXk3MAh1EKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ2vNVT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B5AC19421;
	Sun,  4 Jan 2026 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543052;
	bh=bkH/6h+POklqv8mcVwtE/uq4ReJg47toslY0V43aAZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJ2vNVT7hv851MRpdP/cQ7rfEBOR6+K79YTn0qvFksmpXnOjz+sE6hki8nuJ8gu+Q
	 MKqhc0OGc/nMksEAfGv8AXagwdplr9HoVu9rO68n6WgveMKfAv070WGJYJ/z/A9HAy
	 C1kFLqVTAnmUULeRbfBt9+rywftxaYftHSHFAsu7UX6xUYa9aDyPlivj/7aT+oE96/
	 9r2zWoIUsU2sYAIuKDkbvPm/2b9DmHACRtW54vXyczyHOUSBSgojV5uwuJDC7++OZM
	 7DcmzHXTw9Aq+OcmnphwXFDNwH3oKrRuAwUiIbtLRGebMnytjxu5itOOii/OJFl9Gv
	 VXOT76gT5Nr1A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 11/12] NFSD: Add POSIX draft ACL support to the NFSv4 SETATTR operation
Date: Sun,  4 Jan 2026 11:10:48 -0500
Message-ID: <20260104161049.3404551-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161049.3404551-1-cel@kernel.org>
References: <20260104161049.3404551-1-cel@kernel.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c6bada560620..d659cd09e291 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1211,6 +1211,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &setattr->sa_iattr,
 		.na_seclabel	= &setattr->sa_label,
+		.na_pacl	= setattr->sa_pacl,
+		.na_dpacl	= setattr->sa_dpacl,
 	};
 	bool save_no_wcc, deleg_attrs;
 	struct nfs4_stid *st = NULL;
@@ -1218,6 +1220,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status = nfs_ok;
 	int err;
 
+	/* Transfer ownership to attrs for cleanup via nfsd_attrs_free() */
+	setattr->sa_pacl = NULL;
+	setattr->sa_dpacl = NULL;
+
 	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
@@ -1231,7 +1237,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
 				flags, NULL, &st);
 		if (status)
-			return status;
+			goto out_err;
 	}
 
 	if (deleg_attrs) {
@@ -1249,17 +1255,24 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -1277,8 +1290,9 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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


