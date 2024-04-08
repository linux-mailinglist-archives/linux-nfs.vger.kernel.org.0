Return-Path: <linux-nfs+bounces-2707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D172D89B5D5
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEA1F216CF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207915C9;
	Mon,  8 Apr 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RoYV4C9T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HPH1UEox";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IGb+1q9G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Tg7aFzC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1321366
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542346; cv=none; b=FiyLr8mxFq6zWN0bo0bJKQteDkZGqMaOGgcZoYt3jVL/B6VdV/w/1Ovi5vSPbethDQfZ12VZMAtFJKwCxQn5OuSdg2yJYmoJVTlinpbxeGNKHEZzphe8nZG0ZVwHxaPAnMS/04rW8hWDoGxiUj8Z3qoaxYT8fWg1dD3/Uxwz16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542346; c=relaxed/simple;
	bh=F8hQ3mxPOf2ZPs1CsPthYzXcWB5eY3htAOdGnmzm0KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C38NhgdmqmuyCUsk78vtM6z9Bjs8hsaQyKQCwQMt/tFU2FE6P3ObyhW8BcoOoXki8XmM9NbVCQcnN6SN/L2hmXYumrKiqFWiC9TQFh1z/fhSjlljXKXpY7A9C20cmZl4Y0r1RKWF9jm887bN1Lti8Nj12c+Kpk7T7/mI+cmvqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RoYV4C9T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HPH1UEox; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IGb+1q9G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Tg7aFzC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB2E3200A7;
	Mon,  8 Apr 2024 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT3M4fHTfEoy4mWAzP1BvGtZHy8GyDxkQmr2ry0lsuY=;
	b=RoYV4C9TUtQKovh/1SeqC/AaUvlzSLwVyFtxFItSK1u4ZcW0tbuspZmVxRlOk7xa6yJWSo
	z9jEkzJmiNLCiJfXgWast6gaNs9LTygi7/EI0PdetU2Tn8AVWU9yTkArTGIMU6rbk4eg+a
	dZ657rRxYzZ9LggHuRVBuOCuRBOXeYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT3M4fHTfEoy4mWAzP1BvGtZHy8GyDxkQmr2ry0lsuY=;
	b=HPH1UEoxx6ZmExHMJbF17K8GnbEuQpM4ByHMmZwh7NrOVQIdih2gziaWAia1H4g1mS9vUR
	02JvTNS6x/s9rxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT3M4fHTfEoy4mWAzP1BvGtZHy8GyDxkQmr2ry0lsuY=;
	b=IGb+1q9GoH8tJDp2qR3WpQeCmcIgDxHOFHL6KksRJcRljdY89xnAR6GvVD9QDl+qR6HFCt
	xgiUa1XtHR+qKCIdDsf4MKw9tTs7reKv/UTobP295i+onsQ+cf9DhEg5EMDP5zg7846g7x
	J52IGFy8x4yFYTfVey0Dv4sEVKCuE6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZT3M4fHTfEoy4mWAzP1BvGtZHy8GyDxkQmr2ry0lsuY=;
	b=0Tg7aFzCIurK/tmuKwWS/CppP4iosxZHcQC9Kf1vK9aQCvypWgd6zForH3VoWi6/B0JiIb
	Sfy5E4ZmqLkKx+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3296F13796;
	Mon,  8 Apr 2024 02:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SC7YMXxSE2b0EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:12:12 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4] nfsd: perform all find_openstateowner_str calls in the one place.
Date: Mon,  8 Apr 2024 12:09:15 +1000
Message-ID: <20240408021156.6104-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408021156.6104-1-neilb@suse.de>
References: <20240408021156.6104-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

Currently find_openstateowner_str look ups are done both in
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1824a30e7dd4..6ac1dff29d42 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -541,7 +541,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xdr_netobj *owner)
 }
 
 static struct nfs4_openowner *
-find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
+find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
 			struct nfs4_client *clp)
 {
 	struct nfs4_stateowner *so;
@@ -558,18 +558,6 @@ find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
 	return NULL;
 }
 
-static struct nfs4_openowner *
-find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
-			struct nfs4_client *clp)
-{
-	struct nfs4_openowner *oo;
-
-	spin_lock(&clp->cl_lock);
-	oo = find_openstateowner_str_locked(hashval, open, clp);
-	spin_unlock(&clp->cl_lock);
-	return oo;
-}
-
 static inline u32
 opaque_hashval(const void *ptr, int nbytes)
 {
@@ -4880,34 +4868,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 }
 
 static struct nfs4_openowner *
-alloc_init_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
-			   struct nfsd4_compound_state *cstate)
+find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
+			      struct nfsd4_compound_state *cstate)
 {
 	struct nfs4_client *clp = cstate->clp;
-	struct nfs4_openowner *oo, *ret;
+	struct nfs4_openowner *oo, *new = NULL;
 
-	oo = alloc_stateowner(openowner_slab, &open->op_owner, clp);
-	if (!oo)
-		return NULL;
-	oo->oo_owner.so_ops = &openowner_ops;
-	oo->oo_owner.so_is_open_owner = 1;
-	oo->oo_owner.so_seqid = open->op_seqid;
-	oo->oo_flags = 0;
-	if (nfsd4_has_session(cstate))
-		oo->oo_flags |= NFS4_OO_CONFIRMED;
-	oo->oo_time = 0;
-	oo->oo_last_closed_stid = NULL;
-	INIT_LIST_HEAD(&oo->oo_close_lru);
+retry:
 	spin_lock(&clp->cl_lock);
-	ret = find_openstateowner_str_locked(strhashval, open, clp);
-	if (ret == NULL) {
-		hash_openowner(oo, clp, strhashval);
-		ret = oo;
-	} else
-		nfs4_free_stateowner(&oo->oo_owner);
-
+	oo = find_openstateowner_str(strhashval, open, clp);
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
+		oo = NULL;
+	}
+	if (oo) {
+		if (new)
+			nfs4_free_stateowner(&new->oo_owner);
+		return oo;
+	}
+
+	new = alloc_stateowner(openowner_slab, &open->op_owner, clp);
+	if (!new)
+		return NULL;
+	new->oo_owner.so_ops = &openowner_ops;
+	new->oo_owner.so_is_open_owner = 1;
+	new->oo_owner.so_seqid = open->op_seqid;
+	new->oo_flags = 0;
+	if (nfsd4_has_session(cstate))
+		new->oo_flags |= NFS4_OO_CONFIRMED;
+	new->oo_time = 0;
+	new->oo_last_closed_stid = NULL;
+	INIT_LIST_HEAD(&new->oo_close_lru);
+	goto retry;
 }
 
 static struct nfs4_ol_stateid *
@@ -5356,27 +5356,14 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	clp = cstate->clp;
 
 	strhashval = ownerstr_hashval(&open->op_owner);
-	oo = find_openstateowner_str(strhashval, open, clp);
+	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
 	open->op_openowner = oo;
-	if (!oo) {
-		goto new_owner;
-	}
-	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
-		/* Replace unconfirmed owners without checking for replay. */
-		release_openowner(oo);
-		open->op_openowner = NULL;
-		goto new_owner;
-	}
+	if (!oo)
+		return nfserr_jukebox;
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
-	goto alloc_stateid;
-new_owner:
-	oo = alloc_init_open_stateowner(strhashval, open, cstate);
-	if (oo == NULL)
-		return nfserr_jukebox;
-	open->op_openowner = oo;
-alloc_stateid:
+
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
 		return nfserr_jukebox;
-- 
2.44.0


