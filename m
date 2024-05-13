Return-Path: <linux-nfs+bounces-3245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EA8C3B01
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55501C20E56
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25D146006;
	Mon, 13 May 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tkqfb7R8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ddjVBe1M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tkqfb7R8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ddjVBe1M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9481CD3D
	for <linux-nfs@vger.kernel.org>; Mon, 13 May 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715578979; cv=none; b=qJnGVzUTFzsv0HvnNPz07iBW7fG0zExksdDmJHQxeXr4md4MgSSWYbQwpBpwcPKIxKt83s/NTePwNqn8A3lW1IV+eULTc/0ekfx10KKJkWrOc8OhB5WoUBuL1OQA1sQvt5L6pqqJWFR9+LSQe6MsU+eGOfH9pfrvdIRdfQFDMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715578979; c=relaxed/simple;
	bh=CA55rC9gJESjn+Ia4yOdpr4ubaND4jZsHsbQreXZD8A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=AWsbiP9It/tM4nhR0svJwFczVZj8D4Sqbj9YCOzoG30MLp2eQHl1TZ4BjLzT63WUDwZAvHNOusRf0j+b/T0CorWWBwXt3qeO/nU21rmdzmnLGbvVzbXMB4/d91EPWsc8f03paq+NZtRBYUKe7XRgTGZrvBkADtu3hixGEkiJdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tkqfb7R8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ddjVBe1M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tkqfb7R8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ddjVBe1M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF85C3F2F8;
	Mon, 13 May 2024 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715578975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVsjHxtY5SDX5FLrTOqusAwwE8NFaHXVBIOIFhPWVy8=;
	b=tkqfb7R8quNDrA1YPU2Dp1AFdBTnztZak240Az5QfB7OP8ynAbKStundgkmMxojb4lwGxe
	Sdb/hkM5AP/KUfREEYwqs0q/8ajsp+unHYGIKzNpmZ5rIi/ItA4FRXpsLF0+Ye+asuSQv3
	DQ06iGog6qXS/QqN9C9yzCZ3VSDop9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715578975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVsjHxtY5SDX5FLrTOqusAwwE8NFaHXVBIOIFhPWVy8=;
	b=ddjVBe1M3rcYnDEiXFTM2ox3YbaiPVR9EMXAVEt1JATgLXMtoJVqQTQne5+iNGOY5wJ3Pg
	1v1LP97Qwx9WgcCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tkqfb7R8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ddjVBe1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715578975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVsjHxtY5SDX5FLrTOqusAwwE8NFaHXVBIOIFhPWVy8=;
	b=tkqfb7R8quNDrA1YPU2Dp1AFdBTnztZak240Az5QfB7OP8ynAbKStundgkmMxojb4lwGxe
	Sdb/hkM5AP/KUfREEYwqs0q/8ajsp+unHYGIKzNpmZ5rIi/ItA4FRXpsLF0+Ye+asuSQv3
	DQ06iGog6qXS/QqN9C9yzCZ3VSDop9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715578975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVsjHxtY5SDX5FLrTOqusAwwE8NFaHXVBIOIFhPWVy8=;
	b=ddjVBe1M3rcYnDEiXFTM2ox3YbaiPVR9EMXAVEt1JATgLXMtoJVqQTQne5+iNGOY5wJ3Pg
	1v1LP97Qwx9WgcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEA181351A;
	Mon, 13 May 2024 05:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UeQIJFyoQWb9AQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 13 May 2024 05:42:52 +0000
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
 Dai Ngo <Dai.Ngo@oracle.com>, Olga Kornievskaia <kolga@netapp.com>,
 Tom Talpey <tom@talpey.com>
Cc:
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: change nfsd_create_setattr() to call nfsd_setattr()
 unconditionally
Date: Mon, 13 May 2024 15:42:48 +1000
Message-id: <171557896893.4857.2572536847924540881@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DF85C3F2F8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01


A recent change improved the guard on calling nfsd_setattr() from
nfsd_create_setattr() so that it could be called even if ia_valid was
zero - if there was a security label that needed to be set.

Unfortunately this is not sufficient as there could be an ACL that needs
to be set.  Most likely in this case there would also be mode bits so
->ia_valid would not be zero, but it isn't safe to depend on that.

Rather than making nfsd_attrs_valid() more complete, this patch removes
it and places the code in-line at the top of nfsd_setattr().  If there
is nothing to be set, that function now short-circuits to the end where
commit_metadata() is called.

With this change it is appropriate to call nfsd_setattr()
unconditionally.

Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c | 17 +++++++++--------
 fs/nfsd/vfs.h |  8 --------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..e63f870696ad 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -499,6 +499,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
 	int		retries;
=20
+	if (!(iap->ia_valid ||
+	      (attr->na_seclabel && attr->na_seclabel->len) ||
+	      (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) ||
+	      (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
+	       !attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mode))))
+		/* Don't bother with inode_lock() */
+		goto out;
+
 	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
 		ftype =3D S_IFREG;
@@ -1418,14 +1426,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
 	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID))
 		iap->ia_valid &=3D ~(ATTR_UID|ATTR_GID);
=20
-	/*
-	 * Callers expect new file metadata to be committed even
-	 * if the attributes have not changed.
-	 */
-	if (nfsd_attrs_valid(attrs))
-		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
-	else
-		status =3D nfserrno(commit_metadata(resfhp));
+	status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
=20
 	/*
 	 * Transactional filesystems had a chance to commit changes
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 57cd70062048..c60fdb6200fd 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -60,14 +60,6 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *attr=
s)
 	posix_acl_release(attrs->na_dpacl);
 }
=20
-static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
-{
-	struct iattr *iap =3D attrs->na_iattr;
-
-	return (iap->ia_valid || (attrs->na_seclabel &&
-		attrs->na_seclabel->len));
-}
-
 __be32		nfserrno (int errno);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
--=20
2.44.0


