Return-Path: <linux-nfs+bounces-7259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D759A2FF7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 23:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980B41F215A0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3617C7C6;
	Thu, 17 Oct 2024 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="THTgrbMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MWn/rS5L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="THTgrbMJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MWn/rS5L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3590136658
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201367; cv=none; b=VQCLknjWyeB5m/WmQoPhGiGm4AlBDQ0KU+2QCeYNNO+ubyNfd+TNezGBsFWqAb9UyyqSIQqGTvqlPJ+qXtj/in36qvU2vp6mvF9BET9jeO5IlCd5Ir5dBvDv7qlWYb8ihOOE+V5ScwdCl41PihN/918U4FKlm5EdlUsZccJzdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201367; c=relaxed/simple;
	bh=k8w//HOjxvkc+8oaH5pdKyMNxELYlGH0S5R7Zsws8lw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=KKpCzfC/PEdzVV9Bj4pwElvCV2irnvnhED7blr7MKt1CEQS0DLV+nd8CtS7bdJxU/JqV41sWjSZWHY9wrAvSK0WZmNwRqwF0a95B31VwznTPznhBbSE1oiAgsfRqlrc267tdPqfwFNaYATArsU5VuUHrLVuR8TnbUl9PGJc84yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=THTgrbMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MWn/rS5L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=THTgrbMJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MWn/rS5L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B834C21E73;
	Thu, 17 Oct 2024 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729201360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO9mB86O+Mr5vSKVWKivhOIlrykkChB2yVvOOjDo6Hw=;
	b=THTgrbMJR36/0TzOLkYMUyKYnWsyhoPIHSJYO5A/zzfNT/4sTVMFdmT9ZB8hc0q3+HnU+4
	HxV0oxOYFKQh9UxUgMqU1Xn61zxQ4GAvJ3KTbriIAFpc9BEaMkAdCRVwW8dx25LQFicusX
	SAGCVRlhtsBsg3Z7T8M9JN/BVgPhDio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729201360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO9mB86O+Mr5vSKVWKivhOIlrykkChB2yVvOOjDo6Hw=;
	b=MWn/rS5LVdBaR7vics9kU6pV8Rr6+vP9KVvkbXZEb7ae0EKGpmMC5JB7nh405kNEfHV5tC
	FcZaCZWZNBamAjCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=THTgrbMJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MWn/rS5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729201360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO9mB86O+Mr5vSKVWKivhOIlrykkChB2yVvOOjDo6Hw=;
	b=THTgrbMJR36/0TzOLkYMUyKYnWsyhoPIHSJYO5A/zzfNT/4sTVMFdmT9ZB8hc0q3+HnU+4
	HxV0oxOYFKQh9UxUgMqU1Xn61zxQ4GAvJ3KTbriIAFpc9BEaMkAdCRVwW8dx25LQFicusX
	SAGCVRlhtsBsg3Z7T8M9JN/BVgPhDio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729201360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO9mB86O+Mr5vSKVWKivhOIlrykkChB2yVvOOjDo6Hw=;
	b=MWn/rS5LVdBaR7vics9kU6pV8Rr6+vP9KVvkbXZEb7ae0EKGpmMC5JB7nh405kNEfHV5tC
	FcZaCZWZNBamAjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A816713A42;
	Thu, 17 Oct 2024 21:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o7CdF86EEWezHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 17 Oct 2024 21:42:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
Date: Fri, 18 Oct 2024 08:42:31 +1100
Message-id: <172920135149.81717.3501259644641160631@noble.neil.brown.name>
X-Rspamd-Queue-Id: B834C21E73
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO


NFSD_MAY_LOCK means a few different things.
- it means that GSS is not required.
- it means that with NFSEXP_NOAUTHNLM, authentication is not required
- it means that OWNER_OVERRIDE is allowed.

None of these are specific to locking, they are specific to the NLM
protocol.
So:
 - rename to NFSD_MAY_NLM
 - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
   so that NFSD_MAY_NLM doesn't need to imply these.
 - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
   into fh_verify where other special-case tests on the MAY flags
   happen.  nfsd_permission() can be called from other places than
   fh_verify(), but none of these will have NFSD_MAY_NLM.

Signed-off-by: NeilBrown <neilb@suse.de>
---

No change from previous patch - the corruption in the email has been
avoided (I hope).


 fs/nfsd/lockd.c | 13 +++++++++++--
 fs/nfsd/nfsfh.c | 12 ++++--------
 fs/nfsd/trace.h |  2 +-
 fs/nfsd/vfs.c   | 12 +-----------
 fs/nfsd/vfs.h   |  2 +-
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e5..edc9f75dc75c 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struc=
t file **filp,
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export =3D NULL;
=20
+	/*
+	 * Allow BYPASS_GSS as some client implementations use AUTH_SYS
+	 * for NLM even when GSS is used for NFS.
+	 * Allow OWNER_OVERRIDE as permission might have been changed
+	 * after the file was opened.
+	 * Pass MAY_NLM so that authentication can be completely bypassed
+	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
+	 * for NLM requests.
+	 */
 	access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
-	access |=3D NFSD_MAY_LOCK;
+	access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
 	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
 	fh_put(&fh);
- 	/* We return nlm error codes as nlm doesn't know
+	/* We return nlm error codes as nlm doesn't know
 	 * about nfsd, but nfsd does know about nlm..
 	 */
 	switch (nfserr) {
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 40533f7c7297..6a831cb242df 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
=20
-	/*
-	 * pseudoflavor restrictions are not enforced on NLM,
-	 * which clients virtually always use auth_sys for,
-	 * even while using RPCSEC_GSS for NFS.
-	 */
-	if (access & NFSD_MAY_LOCK)
-		goto skip_pseudoflavor_check;
+	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
+		/* NLM is allowed to fully bypass authentication */
+		goto out;
+
 	if (access & NFSD_MAY_BYPASS_GSS)
 		may_bypass_gss =3D true;
 	/*
@@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
=20
-skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
 	error =3D nfsd_permission(cred, exp, dentry, access);
 out:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99..3448e444d410 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_READ,		"READ" },		\
 		{ NFSD_MAY_SATTR,		"SATTR" },		\
 		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
-		{ NFSD_MAY_LOCK,		"LOCK" },		\
+		{ NFSD_MAY_NLM,			"NLM" },		\
 		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
 		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
 		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 51f5a0b181f9..2610638f4301 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_expor=
t *exp,
 		(acc & NFSD_MAY_EXEC)?	" exec"  : "",
 		(acc & NFSD_MAY_SATTR)?	" sattr" : "",
 		(acc & NFSD_MAY_TRUNC)?	" trunc" : "",
-		(acc & NFSD_MAY_LOCK)?	" lock"  : "",
+		(acc & NFSD_MAY_NLM)?	" nlm"  : "",
 		(acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
 		inode->i_mode,
 		IS_IMMUTABLE(inode)?	" immut" : "",
@@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_expo=
rt *exp,
 	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
 		return nfserr_perm;
=20
-	if (acc & NFSD_MAY_LOCK) {
-		/* If we cannot rely on authentication in NLM requests,
-		 * just allow locks, otherwise require read permission, or
-		 * ownership
-		 */
-		if (exp->ex_flags & NFSEXP_NOAUTHNLM)
-			return 0;
-		else
-			acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
-	}
 	/*
 	 * The file owner always gets access permission for accesses that
 	 * would normally be checked at open time. This is to make
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 854fb95dfdca..f9b09b842856 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -20,7 +20,7 @@
 #define NFSD_MAY_READ			0x004 /* =3D=3D MAY_READ */
 #define NFSD_MAY_SATTR			0x008
 #define NFSD_MAY_TRUNC			0x010
-#define NFSD_MAY_LOCK			0x020
+#define NFSD_MAY_NLM			0x020 /* request is from lockd */
 #define NFSD_MAY_MASK			0x03f
=20
 /* extra hints to permission and open routines: */

base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
--=20
2.46.0


