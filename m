Return-Path: <linux-nfs+bounces-5344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347619513BB
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 07:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700A8B211F7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 05:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5A4204B;
	Wed, 14 Aug 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAcJ1t4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMisham1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAcJ1t4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMisham1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB639879
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611961; cv=none; b=KFGrN7yO7rrH9FCUNmEWuWofGSlgyS6aWYufoly3/Jxzq77E9NhqKfGlVPW7GkNASaehgwdSEDGgcbkN8IXMtpGQbVB99ub1t2Zm+zvipjnAwDCi2nR3YNyur90rgLtSCi1CBaaIgZKcqgrhiJmdbB58OCKBQT7VSRh4s98LBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611961; c=relaxed/simple;
	bh=XTrTzcnzpvGkjMfOebabCPq4QFHXgN/gvvkhXiEMVtk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=lRxaBZyb+NSqkDbbG3hniy2DriO34ipIy84MO6I5Yd8id9976IehLp3r6BAZrSkiLtGoh8ZvfEt//2c738pZTcv4rX957OYyIscXmpGF0AhxxwQ+xysNEsxG4gRVx87Lcdz2o7b82YyPYULAafXDWmKnSjGXU0+I45QdYCTeLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAcJ1t4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMisham1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAcJ1t4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rMisham1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BCE322606;
	Wed, 14 Aug 2024 05:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723611958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFFQGiTP5flYvLZ0zBwKCghD2bCcRm17+uU1oNIi2E4=;
	b=qAcJ1t4XxyXr3LNkSrFYYYFPriBxIKNvWle5xhETEETYSI9kPj7SAfvxPf/Sq+qE8nlSgI
	vyra3TJv+ZQRejPOzz3L5grQgGADGBW+LMG6UX9MYd4pGG95aYrhYgCQHP/iW5RSCVKLzT
	UmBYMq+MkL+jAmn7dw70NtXatK40fhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723611958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFFQGiTP5flYvLZ0zBwKCghD2bCcRm17+uU1oNIi2E4=;
	b=rMisham1bjD2TtiytvNf0yCfqBzDYymCPSHcy5p52Z33USulimYnZdU99WhkcXrZlhFR42
	k/Vc40y8lM4FkOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723611958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFFQGiTP5flYvLZ0zBwKCghD2bCcRm17+uU1oNIi2E4=;
	b=qAcJ1t4XxyXr3LNkSrFYYYFPriBxIKNvWle5xhETEETYSI9kPj7SAfvxPf/Sq+qE8nlSgI
	vyra3TJv+ZQRejPOzz3L5grQgGADGBW+LMG6UX9MYd4pGG95aYrhYgCQHP/iW5RSCVKLzT
	UmBYMq+MkL+jAmn7dw70NtXatK40fhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723611958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFFQGiTP5flYvLZ0zBwKCghD2bCcRm17+uU1oNIi2E4=;
	b=rMisham1bjD2TtiytvNf0yCfqBzDYymCPSHcy5p52Z33USulimYnZdU99WhkcXrZlhFR42
	k/Vc40y8lM4FkOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE5FF139B9;
	Wed, 14 Aug 2024 05:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NSmzJDQ7vGZbCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 14 Aug 2024 05:05:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] SQUASH: nfsd: move error choice for incorrect object types
 to version-specific code.
Date: Wed, 14 Aug 2024 15:05:38 +1000
Message-id: <172361193894.6062.4098495640528994632@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 


[This should be squashed into the existing patch for the same name,
with this commit message used instead of the current one.  It addresses
the pynfs failures that Jeff found]

If an NFS operation expects a particular sort of object (file, dir, link,
etc) but gets a file handle for a different sort of object, it must
return an error.  The actual error varies among NFS version in non-trivial
ways.

For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
INVAL is suitable.

For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
was found when not expected.  This take precedence over NOTDIR.

For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
preference to EINVAL when none of the specific error codes apply.

When nfsd_mode_check() finds a symlink where it expected a directory it
needs to return an error code that can be converted to NOTDIR for v2 or
v3 but will be SYMLINK for v4.  It must be different from the error
code returns when it finds a symlink but expects a regular file - that
must be converted to EINVAL or SYMLINK.

So we introduce an internal error code nfserr_symlink_not_dir which each
version converts as appropriate.

nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
only used by NFSv4 and only for OPEN.  NFSERR_INVAL is never a suitable
error if the object is the wrong time.  For v4.0 we use nfserr_symlink
for non-dirs even if not a symlink.  For v4.1 we have nfserr_wrong_type.
We handling this difference in-place in nfsd_check_obj_isreg() as there
is nothing to be gained by delaying the choice to nfsd4_map_status().

As a result of these changes, nfsd_mode_check() doesn't need an rqstp
arg any more.

Note that NFSv4 operations are actually performed in the xdr code(!!!)
so to the only place that we can map the status code successfully is in
nfsd4_encode_operation().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4proc.c | 31 +++++++++----------------------
 fs/nfsd/nfs4xdr.c  | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e355085e443..fc68af757080 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -158,7 +158,7 @@ do_open_permission(struct svc_rqst *rqstp, struct svc_fh =
*current_fh, struct nfs
 	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
 }
=20
-static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
+static __be32 nfsd_check_obj_isreg(struct svc_fh *fh, u32 minor_version)
 {
 	umode_t mode =3D d_inode(fh->fh_dentry)->i_mode;
=20
@@ -168,7 +168,13 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
 		return nfserr_isdir;
 	if (S_ISLNK(mode))
 		return nfserr_symlink;
-	return nfserr_wrong_type;
+
+	/* RFC 7530 - 16.16.6 */
+	if (minor_version =3D=3D 0)
+		return nfserr_symlink;
+	else
+		return nfserr_wrong_type;
+
 }
=20
 static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cs=
tate, struct nfsd4_open *open, struct svc_fh *resfh)
@@ -179,23 +185,6 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd=
4_compound_state *cstate
 			&resfh->fh_handle);
 }
=20
-static __be32 nfsd4_map_status(__be32 status, u32 minor)
-{
-	switch (status) {
-	case nfs_ok:
-		break;
-	case nfserr_wrong_type:
-		/* RFC 8881 - 15.1.2.9 */
-		if (minor =3D=3D 0)
-			status =3D nfserr_inval;
-		break;
-	case nfserr_symlink_not_dir:
-		status =3D nfserr_symlink;
-		break;
-	}
-	return status;
-}
-
 static inline bool nfsd4_create_is_exclusive(int createmode)
 {
 	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
@@ -478,7 +467,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate, stru
 	}
 	if (status)
 		goto out;
-	status =3D nfsd_check_obj_isreg(*resfh);
+	status =3D nfsd_check_obj_isreg(*resfh, cstate->minorversion);
 	if (status)
 		goto out;
=20
@@ -2815,8 +2804,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 			nfsd4_encode_replay(resp->xdr, op);
 			status =3D op->status =3D op->replay->rp_status;
 		} else {
-			op->status =3D nfsd4_map_status(op->status,
-						      cstate->minorversion);
 			nfsd4_encode_operation(resp, op);
 			status =3D op->status;
 		}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42b41d55d4ed..1c3067f46be7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5729,6 +5729,23 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compoundres =
*resp, u32 respsize)
 	return nfserr_rep_too_big;
 }
=20
+static __be32 nfsd4_map_status(__be32 status, u32 minor)
+{
+	switch (status) {
+	case nfs_ok:
+		break;
+	case nfserr_wrong_type:
+		/* RFC 8881 - 15.1.2.9 */
+		if (minor =3D=3D 0)
+			status =3D nfserr_inval;
+		break;
+	case nfserr_symlink_not_dir:
+		status =3D nfserr_symlink;
+		break;
+	}
+	return status;
+}
+
 void
 nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 {
@@ -5796,6 +5813,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, =
struct nfsd4_op *op)
 						so->so_replay.rp_buf, len);
 	}
 status:
+	op->status =3D nfsd4_map_status(op->status,
+				      resp->cstate.minorversion);
 	*p =3D op->status;
 release:
 	if (opdesc && opdesc->op_release)
--=20
2.44.0


