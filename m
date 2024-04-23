Return-Path: <linux-nfs+bounces-2929-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE28ADE3C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 09:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C671C216E8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE046450;
	Tue, 23 Apr 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MhB4ChsO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D5lYs2ff";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pokCsc5U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hzRE05b1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22428689
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857344; cv=none; b=P+Hsn5IQWrxwMT/EkTCS0BXesDVFdaD6Td/x/+TfQr5Po1Dd4uH9g/UQmYqz7mZVrgO1ybEr4GNnVVcWCCzRDHHdJ3NlK3uLSbT1XgCwFB6K+HUwKJmOTk5j/k4MHRCwXQjxsDUj7unOEiEjPKBAtcdceSutD2IdJvyJUK2/aW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857344; c=relaxed/simple;
	bh=0dbjfNce5V4Z7Eqm1uv4w54bHo63YGa/x4ub3ALzl1g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=ivP9gqTZ20N6f7OsNmCDS5sYxD3BPktGkGR8XXoe+KPiLglq1JjealqxmVQKSFCVQMEFi/PHA10vQhvakU17yc9OmD1WM5MQuZillhc/EfrK+8ZMKl6XVGVhTqP4C9R0BHJzndIt8r8qD/G05O3hCk0FTRLtKrzvQTuZkbcl0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MhB4ChsO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D5lYs2ff; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pokCsc5U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hzRE05b1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFC8637B5F;
	Tue, 23 Apr 2024 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713857341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIz+HS9B3MXDbyYAB70pvrGyOaAEldEs99g6VrWdUYc=;
	b=MhB4ChsOcpQd7laqYu7z9Jfkk6bQX0bl9uSP3jhmlLAY6xTilxDU02AGozX5MSZvyTQ8BK
	gBBDFLF2SE+f2sqb3qhNFLj315YtoG0r6AOjLjBl/YbsJcqhtbqjvjZC3jT0t/tbMj2kNL
	3miANVPmGbrYhlNh8FMXRb36FEzrskA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713857341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIz+HS9B3MXDbyYAB70pvrGyOaAEldEs99g6VrWdUYc=;
	b=D5lYs2ffcw5Am1TefY4ng/lS7PNzpJzn9qWrJjPReKxPVTtn2JLwQ9lDcD90EGqoYB/cnT
	ferIpmL3xSy/alAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713857338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIz+HS9B3MXDbyYAB70pvrGyOaAEldEs99g6VrWdUYc=;
	b=pokCsc5UpaazKfkW2+w8fd8bexKxk1CzBEiBGzVRfuG5nX/NBlgz1ap/mlBDFUrTU1yVI0
	mfVQy7zbUJYhtRgjr0/M/U7kV5flGCWMbKgRQh8VSK4xAbMdpUXg9mTWaC5XzVamipP7sB
	92HgbyWp4x1TLQzqe1RnAXtFPc8UJMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713857338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VIz+HS9B3MXDbyYAB70pvrGyOaAEldEs99g6VrWdUYc=;
	b=hzRE05b1ZkXcB7INEEdKKRsroG7gsP37yoJ4loorh/MuMlv/jJ4L3afLqhf39WO0o0oJBQ
	a8COKv47O3TX7YBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39D113929;
	Tue, 23 Apr 2024 07:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id inyWHTdjJ2bgdwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 23 Apr 2024 07:28:55 +0000
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
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: return hard failure for OP_SETCLIENTID when there
 are too many clients.
Date: Tue, 23 Apr 2024 17:28:46 +1000
Message-id: <171385732687.7600.2864936377155228614@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO


If there are more non-courteous clients than the calculated limit, we
should fail the request rather than report a soft failure and
encouraging the client to retry indefinitely.

If there a courteous clients which push us over the limit, then expedite
their removal.

This is not known to have caused a problem is production use, but
testing of lots of clients reports repeated NFS4ERR_DELAY responses
which doesn't seem helpful.

Also remove an outdated comment - we do use a slab cache.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index daf83823ba48..dfc19a5d1780 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2212,21 +2212,20 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	return 1;
 }
=20
-/*=20
- * XXX Should we use a slab cache ?
- * This type of memory management is somewhat inefficient, but we use it
- * anyway since SETCLIENTID is not a common operation.
- */
 static struct nfs4_client *alloc_client(struct xdr_netobj name,
 				struct nfsd_net *nn)
 {
 	struct nfs4_client *clp;
 	int i;
=20
-	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients) {
+	if (atomic_read(&nn->nfs4_client_count) -
+	    atomic_read(&nn->nfsd_courtesy_clients) >=3D nn->nfs4_max_clients)
+		return ERR_PTR(-EREMOTEIO);
+
+	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients &&
+	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
 		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-		return NULL;
-	}
+
 	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp =3D=3D NULL)
 		return NULL;
@@ -3118,8 +3117,8 @@ static struct nfs4_client *create_client(struct xdr_net=
obj name,
 	struct dentry *dentries[ARRAY_SIZE(client_files)];
=20
 	clp =3D alloc_client(name, nn);
-	if (clp =3D=3D NULL)
-		return NULL;
+	if (IS_ERR_OR_NULL(clp))
+		return clp;
=20
 	ret =3D copy_cred(&clp->cl_cred, &rqstp->rq_cred);
 	if (ret) {
@@ -3501,6 +3500,8 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
 	new =3D create_client(exid->clname, rqstp, &verf);
 	if (new =3D=3D NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		return nfserr_resource;
 	status =3D copy_impl_id(new, exid);
 	if (status)
 		goto out_nolock;
@@ -4421,6 +4422,8 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
 	new =3D create_client(clname, rqstp, &clverifier);
 	if (new =3D=3D NULL)
 		return nfserr_jukebox;
+	if (IS_ERR(new))
+		return nfserr_resource;
 	spin_lock(&nn->client_lock);
 	conf =3D find_confirmed_client_by_name(&clname, nn);
 	if (conf && client_has_state(conf)) {
--=20
2.44.0


