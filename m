Return-Path: <linux-nfs+bounces-2251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D228C8778BD
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 23:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889B6281654
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 22:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3323B2BD;
	Sun, 10 Mar 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ctvg3HDU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WbDoahlB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ctvg3HDU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WbDoahlB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6492744E
	for <linux-nfs@vger.kernel.org>; Sun, 10 Mar 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109087; cv=none; b=WZCycTeKKmGYb86Y8PO8Sd7uPGZ4cDM2O/gOaujh9SGAVn7DUwHGBdADBA1GeN0e1e48Uzpy3lO0OTqdDDigRNZTkFnkzc8l/s6fnCjMO3HlFvHpfOXFNKiPSQAXWvs3m3Vr4ixrkwZZNNII9EEqRMvU/12r6JbcGK1bhHhLwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109087; c=relaxed/simple;
	bh=8vyETe7TmPOum9L5EDHROwJxTucN6DuSBRNeV3+mc1o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=l3r4vQijjZKQTXOHh7AtF3BonFxFUvcavoBH4Tum4+rX9q9AWNR8IcX5UelWSB8S2I2uASpPIey243rGREOpdTK23ulyRfzHdR0PjqyiedhmqHHzLxVj7fAHFe+/1thowgTo97c3B2U77vA1RoDUKW+DgHzQvRoHnd2tMsA391Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ctvg3HDU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WbDoahlB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ctvg3HDU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WbDoahlB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C6FB3369B;
	Sun, 10 Mar 2024 22:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710109083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUQTd9dXiPpS1vtyuft3lXtvhOvArOb0u29VfV4O9Ik=;
	b=ctvg3HDU2aqSb28thPvULYccp2oRTvP0Ry57ily/N4GJiOVWm5veOxWDTk7b1zhwhg6ss/
	aPX6fjQt0ekW+KoUKIg5vK3kIQXShDK+uS4Q0tKbTYhEX5BKQPe241szwDlRS9FleDGCee
	QAjeLdue5mpsWWj8TPhqJj4426B5cXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710109083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUQTd9dXiPpS1vtyuft3lXtvhOvArOb0u29VfV4O9Ik=;
	b=WbDoahlBApiLIgVIpPGmQDqrahS8TID6QaTZGoIRoSmY9IGZRpeDju6U+gm9QKYhTQ1aB8
	oj1AIv3LdtLrh9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710109083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUQTd9dXiPpS1vtyuft3lXtvhOvArOb0u29VfV4O9Ik=;
	b=ctvg3HDU2aqSb28thPvULYccp2oRTvP0Ry57ily/N4GJiOVWm5veOxWDTk7b1zhwhg6ss/
	aPX6fjQt0ekW+KoUKIg5vK3kIQXShDK+uS4Q0tKbTYhEX5BKQPe241szwDlRS9FleDGCee
	QAjeLdue5mpsWWj8TPhqJj4426B5cXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710109083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUQTd9dXiPpS1vtyuft3lXtvhOvArOb0u29VfV4O9Ik=;
	b=WbDoahlBApiLIgVIpPGmQDqrahS8TID6QaTZGoIRoSmY9IGZRpeDju6U+gm9QKYhTQ1aB8
	oj1AIv3LdtLrh9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F10EE134AB;
	Sun, 10 Mar 2024 22:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LhPlJJgx7mXxSgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 10 Mar 2024 22:18:00 +0000
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
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4  v3] nfsd: perform all find_openstateowner_str calls in
 the one place.
Date: Mon, 11 Mar 2024 09:17:57 +1100
Message-id: <171010907730.13576.5751778995820664441@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ctvg3HDU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WbDoahlB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 9C6FB3369B
X-Spam-Flag: NO


Currently find_openstateowner_str lookups are done both in
nfsd4_process_open1() and alloc_init_open_stateowner() - the latter
possibly being a surprise based on its name.

It would be easier to follow, and more conformant to common patterns, if
the lookup was all in the one place.

So replace alloc_init_open_stateowner() with
find_or_alloc_open_stateowner() and use the latter in
nfsd4_process_open1() without any calls to find_openstateowner_str().

This means all finds are find_openstateowner_str_locked() and
find_openstateowner_str() is no longer needed.  So discard
find_openstateowner_str() and rename find_openstateowner_str_locked() to
find_openstateowner_str().

Signed-off-by: NeilBrown <neilb@suse.de>
---

The previous version of this patch could deadlock on ->cl_lcok as it
called release_openowner() while holding that lock.
This version doesn't.

Subsequent patch in the original series should be unchanged.  If needed
I can resent them all after -rc1 is out.

 fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ee9aa4843443..3e144b1a1386 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -541,7 +541,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xdr_ne=
tobj *owner)
 }
=20
 static struct nfs4_openowner *
-find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
+find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
 			struct nfs4_client *clp)
 {
 	struct nfs4_stateowner *so;
@@ -558,18 +558,6 @@ find_openstateowner_str_locked(unsigned int hashval, str=
uct nfsd4_open *open,
 	return NULL;
 }
=20
-static struct nfs4_openowner *
-find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
-			struct nfs4_client *clp)
-{
-	struct nfs4_openowner *oo;
-
-	spin_lock(&clp->cl_lock);
-	oo =3D find_openstateowner_str_locked(hashval, open, clp);
-	spin_unlock(&clp->cl_lock);
-	return oo;
-}
-
 static inline u32
 opaque_hashval(const void *ptr, int nbytes)
 {
@@ -4855,34 +4843,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_file *f=
p, struct nfsd4_open *open)
 }
=20
 static struct nfs4_openowner *
-alloc_init_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
-			   struct nfsd4_compound_state *cstate)
+find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_open *op=
en,
+			      struct nfsd4_compound_state *cstate)
 {
 	struct nfs4_client *clp =3D cstate->clp;
-	struct nfs4_openowner *oo, *ret;
+	struct nfs4_openowner *oo, *new =3D NULL;
=20
-	oo =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
-	if (!oo)
-		return NULL;
-	oo->oo_owner.so_ops =3D &openowner_ops;
-	oo->oo_owner.so_is_open_owner =3D 1;
-	oo->oo_owner.so_seqid =3D open->op_seqid;
-	oo->oo_flags =3D 0;
-	if (nfsd4_has_session(cstate))
-		oo->oo_flags |=3D NFS4_OO_CONFIRMED;
-	oo->oo_time =3D 0;
-	oo->oo_last_closed_stid =3D NULL;
-	INIT_LIST_HEAD(&oo->oo_close_lru);
+retry:
 	spin_lock(&clp->cl_lock);
-	ret =3D find_openstateowner_str_locked(strhashval, open, clp);
-	if (ret =3D=3D NULL) {
-		hash_openowner(oo, clp, strhashval);
-		ret =3D oo;
-	} else
-		nfs4_free_stateowner(&oo->oo_owner);
-
+	oo =3D find_openstateowner_str(strhashval, open, clp);
+	if (!oo && new) {
+		hash_openowner(new, clp, strhashval);
+		spin_unlock(&clp->cl_lock);
+		return new;
+	}
 	spin_unlock(&clp->cl_lock);
-	return ret;
+
+	if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
+		/* Replace unconfirmed owners without checking for replay. */
+		release_openowner(oo);
+		oo =3D NULL;
+	}
+	if (oo) {
+		if (new)
+			nfs4_free_stateowner(&new->oo_owner);
+		return oo;
+	}
+
+	new =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
+	if (!new)
+		return NULL;
+	new->oo_owner.so_ops =3D &openowner_ops;
+	new->oo_owner.so_is_open_owner =3D 1;
+	new->oo_owner.so_seqid =3D open->op_seqid;
+	new->oo_flags =3D 0;
+	if (nfsd4_has_session(cstate))
+		new->oo_flags |=3D NFS4_OO_CONFIRMED;
+	new->oo_time =3D 0;
+	new->oo_last_closed_stid =3D NULL;
+	INIT_LIST_HEAD(&new->oo_close_lru);
+	goto retry;
 }
=20
 static struct nfs4_ol_stateid *
@@ -5331,27 +5331,14 @@ nfsd4_process_open1(struct nfsd4_compound_state *csta=
te,
 	clp =3D cstate->clp;
=20
 	strhashval =3D ownerstr_hashval(&open->op_owner);
-	oo =3D find_openstateowner_str(strhashval, open, clp);
+	oo =3D find_or_alloc_open_stateowner(strhashval, open, cstate);
 	open->op_openowner =3D oo;
-	if (!oo) {
-		goto new_owner;
-	}
-	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
-		/* Replace unconfirmed owners without checking for replay. */
-		release_openowner(oo);
-		open->op_openowner =3D NULL;
-		goto new_owner;
-	}
+	if (!oo)
+		return nfserr_jukebox;
 	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
-	goto alloc_stateid;
-new_owner:
-	oo =3D alloc_init_open_stateowner(strhashval, open, cstate);
-	if (oo =3D=3D NULL)
-		return nfserr_jukebox;
-	open->op_openowner =3D oo;
-alloc_stateid:
+
 	open->op_stp =3D nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
 		return nfserr_jukebox;
--=20
2.43.0


