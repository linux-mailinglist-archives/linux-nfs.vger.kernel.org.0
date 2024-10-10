Return-Path: <linux-nfs+bounces-7039-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07D999478
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05C12820DF
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD61BC077;
	Thu, 10 Oct 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fcRup9ge";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DSvaiHmx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fcRup9ge";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DSvaiHmx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76928F6A
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595882; cv=none; b=hNdrQifao0ZfS8he9SVjMr0k9hSx8KEV/1tNGsP/HBHRJVlDBLiuvq6jWHRt2sVOeYRGw/RZPlS/YQjcOGcZNel18RDG1NQ7tr5XiHQJF35UVXxYKYfjdjyGGeEPQ1GfhlMSLtNWRXxIY4QIFetOePuFo6nTKBISm2U23+559BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595882; c=relaxed/simple;
	bh=PPb6dd9DfzXq30WnZuE/KSKBcsAGlfzs2XOPkw7IxB0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=byNNPhFLNKZPrAJw0V9ipNG3qlMdyIQrVW/C8+wDCZ7ZCEv8T7p/Yn2YloddBj6rk9w8mW9lm3MzGHLdYoZQ7XiNslCrtz3eYkjhYMim8wdvKBGaC5BFEHY+zJW2KTYLeKVqjH7BlmX8ThD4O1AsjHQiGxm6P7buXTWMu8uh1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fcRup9ge; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DSvaiHmx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fcRup9ge; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DSvaiHmx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E60F921ADB;
	Thu, 10 Oct 2024 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728595878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5E/YJarnG9NJun/4LDdDDVktbd43fDyq7f3/AucM3aI=;
	b=fcRup9geKt2/lRBFQEvOCUASRKVtSzAFm7UgFeAtKjVA7xHzc7P1Ye1Wvkoiq40LT6AVaO
	grQ1b2Ee7m8lN6yLWl6YXmmOeXRYrOcp67+LVpEi4k/lvksJMzHkeQr4TpboGKWmumpv7N
	s/IS5fgotuptWF4Sa1v/M7Lv4TuI5ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728595878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5E/YJarnG9NJun/4LDdDDVktbd43fDyq7f3/AucM3aI=;
	b=DSvaiHmxVsgTtNRuKOz4VlNt0gXnH21fYfGGT7tDA+M5O8UQWYzR3H6pLUqFegMthxxm6M
	AdTwb74YJV41FHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728595878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5E/YJarnG9NJun/4LDdDDVktbd43fDyq7f3/AucM3aI=;
	b=fcRup9geKt2/lRBFQEvOCUASRKVtSzAFm7UgFeAtKjVA7xHzc7P1Ye1Wvkoiq40LT6AVaO
	grQ1b2Ee7m8lN6yLWl6YXmmOeXRYrOcp67+LVpEi4k/lvksJMzHkeQr4TpboGKWmumpv7N
	s/IS5fgotuptWF4Sa1v/M7Lv4TuI5ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728595878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5E/YJarnG9NJun/4LDdDDVktbd43fDyq7f3/AucM3aI=;
	b=DSvaiHmxVsgTtNRuKOz4VlNt0gXnH21fYfGGT7tDA+M5O8UQWYzR3H6pLUqFegMthxxm6M
	AdTwb74YJV41FHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBBB913A6E;
	Thu, 10 Oct 2024 21:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2pYIHKRHCGdnZAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 10 Oct 2024 21:31:16 +0000
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
Subject: [PATCH nfsd-next] nfsd: refine and rename NFSD_MAY_LOCK
Date: Fri, 11 Oct 2024 08:31:09 +1100
Message-id: <172859586932.444407.11362678410508147927@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
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
   into fh_verify() where other special-case tests on the MAY flags
   happen.  nfsd_permission() can be called from other places than
   fh_verify(), but none of these will have NFSD_MAY_NLM.

Signed-off-by: NeilBrown <neilb@suse.de>
---
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
index 4c5deea0e953..885a58ca33d8 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;From 226d19d36029605a16d837d1a94a6f81b6e06681 Mon Sep 17 00:00:00=
 2001
From: NeilBrown <neilb@suse.de>
Date: Fri, 11 Oct 2024 08:23:08 +1100


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
index c625966cfcf3..b7abf1cba9e2 100644
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

base-commit: 144cb1225cd863e1bd3ae3d577d86e1531afd932
prerequisite-patch-id: 7a049ff3732fdc61d6d4ff6f916f35341eddfa04
--=20
2.46.0


