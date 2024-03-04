Return-Path: <linux-nfs+bounces-2191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868287104D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CEF1F22050
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA71C6AB;
	Mon,  4 Mar 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C4IGSP65";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tlt1/t+V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C4IGSP65";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tlt1/t+V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08F3C28
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592465; cv=none; b=XljgKGLymxaO4k801Kr/Jv5j410+kRcNfZN+9HdiHBNwwCtsIaZXbMnYHTLu4IxtECI7aWkv+JJ989gj8Tg/k81ha2CnJeixhePirBIhN43iCjcPR1Mj5GFjDjYS9bJI6qrK9SgkYKOVSi6O6DUXZrAh1PeZye25o10PX6zoqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592465; c=relaxed/simple;
	bh=Ojz2m/aihoD2V28qa5vcDoHUqGnvXDekCokJNqUSFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtD+l+RTOj8NkS6d13D8n6snpai0u6tnFWECbJ/VIx8rU7PV4oVRa6f4hAWaZQAotDpkaYsEikr2A4+mfY2CZo9gbFsVlY0NdkGzUm7bpHLEAqhlJieUpe9TrltsfouwXu8onPys6akv8CZNSS6BpdDpBYVHKvyYcM4yu1AzZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C4IGSP65; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tlt1/t+V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C4IGSP65; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tlt1/t+V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE50734F96;
	Mon,  4 Mar 2024 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq4x/pVuOAzwaezzzlCkndJfR0i/ykU8Td+cXfm1ARw=;
	b=C4IGSP65dq6qVv81XqRCuZPzNIkNrbSWBC3OvFeqvW+UlTM82yXo0kcXyCm8YWRaWSfcC1
	FdULpIlOwcELL64XPkR9lESLtpTNDopv80MRyFknyJvnc9mS0FQGhqvoxv12CuCiJ+VkQd
	K1EqBCp+ORhA26Rq/jT3UHNRePvTMKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq4x/pVuOAzwaezzzlCkndJfR0i/ykU8Td+cXfm1ARw=;
	b=tlt1/t+V5KfbDnFghL8+wz0NZ328wJWbHS6rZiDTBEKpzsuPohlramIXxHFdGXI9PCIihX
	EsSvcJOlmz26g5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq4x/pVuOAzwaezzzlCkndJfR0i/ykU8Td+cXfm1ARw=;
	b=C4IGSP65dq6qVv81XqRCuZPzNIkNrbSWBC3OvFeqvW+UlTM82yXo0kcXyCm8YWRaWSfcC1
	FdULpIlOwcELL64XPkR9lESLtpTNDopv80MRyFknyJvnc9mS0FQGhqvoxv12CuCiJ+VkQd
	K1EqBCp+ORhA26Rq/jT3UHNRePvTMKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq4x/pVuOAzwaezzzlCkndJfR0i/ykU8Td+cXfm1ARw=;
	b=tlt1/t+V5KfbDnFghL8+wz0NZ328wJWbHS6rZiDTBEKpzsuPohlramIXxHFdGXI9PCIihX
	EsSvcJOlmz26g5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A75C13A5B;
	Mon,  4 Mar 2024 22:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UTbHN4pP5mUrYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:47:38 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in the one place.
Date: Tue,  5 Mar 2024 09:45:22 +1100
Message-ID: <20240304224714.10370-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304224714.10370-1-neilb@suse.de>
References: <20240304224714.10370-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.59
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.69)[0.895];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Currently find_openstateowner_str looks are done both in
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
 fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b9b3a2601675..0c1058e8cc4b 100644
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
@@ -4855,34 +4843,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
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
-	spin_lock(&clp->cl_lock);
-	ret = find_openstateowner_str_locked(strhashval, open, clp);
-	if (ret == NULL) {
-		hash_openowner(oo, clp, strhashval);
-		ret = oo;
-	} else
-		nfs4_free_stateowner(&oo->oo_owner);
+	while (1) {
+		spin_lock(&clp->cl_lock);
+		oo = find_openstateowner_str(strhashval, open, clp);
+		if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
+			/* Replace unconfirmed owners without checking for replay. */
+			release_openowner(oo);
+			oo = NULL;
+		}
+		if (oo) {
+			spin_unlock(&clp->cl_lock);
+			if (new)
+				nfs4_free_stateowner(&new->oo_owner);
+			return oo;
+		}
+		if (new) {
+			hash_openowner(new, clp, strhashval);
+			spin_unlock(&clp->cl_lock);
+			return new;
+		}
+		spin_unlock(&clp->cl_lock);
 
-	spin_unlock(&clp->cl_lock);
-	return ret;
+		new = alloc_stateowner(openowner_slab, &open->op_owner, clp);
+		if (!new)
+			return NULL;
+		new->oo_owner.so_ops = &openowner_ops;
+		new->oo_owner.so_is_open_owner = 1;
+		new->oo_owner.so_seqid = open->op_seqid;
+		new->oo_flags = 0;
+		if (nfsd4_has_session(cstate))
+			new->oo_flags |= NFS4_OO_CONFIRMED;
+		new->oo_time = 0;
+		new->oo_last_closed_stid = NULL;
+		INIT_LIST_HEAD(&new->oo_close_lru);
+	}
 }
 
 static struct nfs4_ol_stateid *
@@ -5331,28 +5331,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	clp = cstate->clp;
 
 	strhashval = ownerstr_hashval(&open->op_owner);
-	oo = find_openstateowner_str(strhashval, open, clp);
+	oo = find_or_alloc_open_stateowner(strhashval, open, cstate);
 	open->op_openowner = oo;
 	if (!oo)
-		goto new_owner;
-	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
-		/* Replace unconfirmed owners without checking for replay. */
-		release_openowner(oo);
-		open->op_openowner = NULL;
-		goto new_owner;
-	}
+		return nfserr_jukebox;
 	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
-	goto alloc_stateid;
-new_owner:
-	oo = alloc_init_open_stateowner(strhashval, open, cstate);
-	if (oo == NULL)
-		return nfserr_jukebox;
-	open->op_openowner = oo;
-	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
-alloc_stateid:
+
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
 		return nfserr_jukebox;
-- 
2.43.0


