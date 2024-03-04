Return-Path: <linux-nfs+bounces-2153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8586F94C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2171F21555
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E917C8;
	Mon,  4 Mar 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYbCyUeE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ih2NWfy1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYbCyUeE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ih2NWfy1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3E566D
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527415; cv=none; b=VLc20mUDnLaeSeB71TMAO72bBQZ8tD2ZVvUQpquQI+z25VBdSPqI+Yxf+LorwUpPNVclD0x/LuHBE0g77f2cb0dPA51Qp44CE7RRzIyLusNg9IdtzfNScFx1eHFM2/VDBYWHkpvOhumCcH/Ns76fBPn5+M3S0lp6vGjsCGrbljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527415; c=relaxed/simple;
	bh=0ESQCpDlQ9lX3G3gCGTdkEAg5Z/CgXqKKs40iMaPdpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBeaxzCEBYsLFSOEOvrVdP95TVUxHiPTCGnRFZmY6Lff753eJ1sUSw4zGAlzlhZKpxTyGQV3IQeUoEF+gKvBksAi2opqorvF5CKnZd/HeTCr5I7sg8+BHlv4JPQpBchL4r//RGzxpi+UIiWq91SifPBU25ASo3CirceRvheTu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYbCyUeE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ih2NWfy1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYbCyUeE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ih2NWfy1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D82E4D76B;
	Mon,  4 Mar 2024 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNW/+XkE6qPhf6TpbwrdsTvBegiFjh3rDveqQTc1s6o=;
	b=oYbCyUeEwgO3u9DpbRITXXbMzMHVgeXuu9a85k3mCWbBj/xlTX/FjtsMExiYmDMghtEbD8
	cCU1Be/tfM1F4urTL+Z7/Ca3E6BtbbJxxDAGWwNuIVS3er9RxSE0ubyI8Ehg/kY7pvkgA2
	gtEZAkwXm3Yy5BWad/ACn5YLEE+5Sas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNW/+XkE6qPhf6TpbwrdsTvBegiFjh3rDveqQTc1s6o=;
	b=ih2NWfy1ZeS7Rc/62MDxI6rdmq6E1q0xFtSaEHWeKos7zfbt4+2HxzzmRGhRfWc8RG1wbq
	Ht0UuiaOimuSTBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNW/+XkE6qPhf6TpbwrdsTvBegiFjh3rDveqQTc1s6o=;
	b=oYbCyUeEwgO3u9DpbRITXXbMzMHVgeXuu9a85k3mCWbBj/xlTX/FjtsMExiYmDMghtEbD8
	cCU1Be/tfM1F4urTL+Z7/Ca3E6BtbbJxxDAGWwNuIVS3er9RxSE0ubyI8Ehg/kY7pvkgA2
	gtEZAkwXm3Yy5BWad/ACn5YLEE+5Sas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNW/+XkE6qPhf6TpbwrdsTvBegiFjh3rDveqQTc1s6o=;
	b=ih2NWfy1ZeS7Rc/62MDxI6rdmq6E1q0xFtSaEHWeKos7zfbt4+2HxzzmRGhRfWc8RG1wbq
	Ht0UuiaOimuSTBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB66113A9F;
	Mon,  4 Mar 2024 04:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODLLE3FR5WVYNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:43:29 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in the one place.
Date: Mon,  4 Mar 2024 15:40:20 +1100
Message-ID: <20240304044304.3657-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304044304.3657-1-neilb@suse.de>
References: <20240304044304.3657-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
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
index 2f1e465628b1..690d0e697320 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -539,7 +539,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xdr_netobj *owner)
 }
 
 static struct nfs4_openowner *
-find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
+find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
 			struct nfs4_client *clp)
 {
 	struct nfs4_stateowner *so;
@@ -556,18 +556,6 @@ find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *open,
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
@@ -4588,34 +4576,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
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
@@ -5064,28 +5064,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
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


