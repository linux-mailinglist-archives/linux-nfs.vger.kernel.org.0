Return-Path: <linux-nfs+bounces-1517-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426C83FCD3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBFD1F222B8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65411718;
	Mon, 29 Jan 2024 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9TB+dHb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bVdqZP1K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9TB+dHb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bVdqZP1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82001172C
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499425; cv=none; b=ow4GFZpPHDP17RxrGYFi0F5gZQhjV4iE/1UPpzt4At3HmdKj3RHQjNYtDyvI2Dm2q6OPXLwu6PeMhxgpXwLx1hHmNtBEc3mJH9KWkd1+ueYmFC/18ULRf7KwqmVPM/IJMszz1N0jQXzxPyUNUIx5HQcbIgCzBBPHK722o1ZoKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499425; c=relaxed/simple;
	bh=u4MXg5CWiDWN5wVVGu+mJ/GxNHKILONuEXxAMifFi6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fucRWZp4FUrnZ74fbR/g6xzN2lMCHqPPfQ01VacUg7eGYGjdgJSU6L9crGUvFrkgExWHFDmZ2JNLhkSRtLdxoKW/Uq55g7v2Ej5ZwAZPB7Xamty4MTu7MYpAT8JTE4jzz6KDK5/lq9wN3+llYcOVvFcs8SnOAicaRayJ8RDsYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9TB+dHb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bVdqZP1K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9TB+dHb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bVdqZP1K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1079C1F7C9;
	Mon, 29 Jan 2024 03:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaQNrZdrJQ2oiXWurcfSf0wVHBYCdcL/aS+CMuWjn3E=;
	b=h9TB+dHbYGDoMYHdyqpaUvBftdrslxHxD1VREiTyeq6Lq/qPppuCZVl+gOiclOu5r6PAfO
	dMe/AGtzFBIE2HB6hPatFS/g45ILeMPmTEAakcY2/XE837Bs9+meDfFqBM/jht7dQXLCJA
	/TApawZ76ZbJ2fINUycsDZ/cgjLdqiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaQNrZdrJQ2oiXWurcfSf0wVHBYCdcL/aS+CMuWjn3E=;
	b=bVdqZP1Kd9Is/q6Jghd6BVK8EqHw8QXVb6Zo2l/5u/ZwMiMubWQm9UesuC5My+9IAmsYiY
	e067Au9ceW4MZsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaQNrZdrJQ2oiXWurcfSf0wVHBYCdcL/aS+CMuWjn3E=;
	b=h9TB+dHbYGDoMYHdyqpaUvBftdrslxHxD1VREiTyeq6Lq/qPppuCZVl+gOiclOu5r6PAfO
	dMe/AGtzFBIE2HB6hPatFS/g45ILeMPmTEAakcY2/XE837Bs9+meDfFqBM/jht7dQXLCJA
	/TApawZ76ZbJ2fINUycsDZ/cgjLdqiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaQNrZdrJQ2oiXWurcfSf0wVHBYCdcL/aS+CMuWjn3E=;
	b=bVdqZP1Kd9Is/q6Jghd6BVK8EqHw8QXVb6Zo2l/5u/ZwMiMubWQm9UesuC5My+9IAmsYiY
	e067Au9ceW4MZsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7054913867;
	Mon, 29 Jan 2024 03:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id owpLClsdt2UYKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:36:59 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 02/13] nfsd: hold ->cl_lock for hash_delegation_locked()
Date: Mon, 29 Jan 2024 14:29:24 +1100
Message-ID: <20240129033637.2133-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129033637.2133-1-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

The protocol for creating a new state in nfsd is to allocate the state
leaving it largely uninitialised, add that state to the ->cl_stateids
idr so as to reserve a state-id, then complete initialisation of the
state and only set ->sc_type to non-zero once the state is fully
initialised.

If a state is found in the idr with ->sc_type == 0, it is ignored.
The ->cl_lock lock is used to avoid races - it is held while checking
sc_type during lookup, and held when a non-zero value is stored in
->sc_type.

... except... hash_delegation_locked() finalises the initialisation of a
delegation state, but does NOT hold ->cl_lock.

So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
and so ensures there are no races (which are extremely unlikely in any
case).
As ->fi_lock is often taken when ->cl_lock is held, we need to take
->cl_lock first of those two.
Currently ->cl_lock and state_lock are never both taken at the same time.
We need both for this patch so an arbitrary choice is needed concerning
which to take first.  As state_lock is more global, it might be more
contended, so take it first.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d377a0a56e45..051c3e99fac6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1312,6 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 
 	lockdep_assert_held(&state_lock);
 	lockdep_assert_held(&fp->fi_lock);
+	lockdep_assert_held(&clp->cl_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
 		return -EAGAIN;
@@ -5557,12 +5558,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		goto out_unlock;
 
 	spin_lock(&state_lock);
+	spin_lock(&clp->cl_lock);
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_had_conflict)
 		status = -EAGAIN;
 	else
 		status = hash_delegation_locked(dp, fp);
 	spin_unlock(&fp->fi_lock);
+	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
 	if (status)
-- 
2.43.0


