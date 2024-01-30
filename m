Return-Path: <linux-nfs+bounces-1584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3AF841823
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58831C2236F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DAD266;
	Tue, 30 Jan 2024 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHpQzwb5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BMo94KIp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHpQzwb5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BMo94KIp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FA2C868
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577086; cv=none; b=Ep4JwDpeE9GjHx/cGymCJuLLHYQiA91mic/7KF1a+5E1s2o+TzrEPaKkiuTmC0xDj//3Ivf2Z3/uSEaktiqM8LsMb74Am8n8taenV/vH0eftDNKyjrFgoYAvcA1lqIEHWYfXkZMH1nrU8HSOJ4ptu99gQjG+EChkn9qBD9Lc8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577086; c=relaxed/simple;
	bh=fnwpiq5oRli/JJD6/quVTfaym3GxEeBIkgmyfba8pG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGm1de6GKDegk71ugKc1aP3Dulx4pQSUMTKeUTxiFFp9+3PANIO66Fy+BYVHrqFWXNIW3ILITNOegpAPnVNGqlQ1cag5sBsZo3YuQ2js0gk9c4DS0h4a01Qi7R03yGj5ZczZLfa09bEqbax/ZhwcNfELdZ8/hJB6l6Q+OWDS8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHpQzwb5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BMo94KIp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHpQzwb5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BMo94KIp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11AA8220D6;
	Tue, 30 Jan 2024 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpc8SH1qg4Eq1cmloG4WGzhBbHWqgT8QyYtq8cCYxc=;
	b=dHpQzwb5KkJa/i4mlc1bCiE2pyFVK3qlZfXIVBYw90gn2KAFmTHF4AjAS1h2rjNlabb0tQ
	Y6Xd0CpuHCC+UDAv3Fp0Xl3BerZcrmEf8KYRYBCRwO9gWDmo07TEsm3Q5wAvYqejdP/w3Y
	ePOnX2oMGo5Skgc8ZKqrkOcV4fWZIJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpc8SH1qg4Eq1cmloG4WGzhBbHWqgT8QyYtq8cCYxc=;
	b=BMo94KIpF+JdkqDrWLFuNgoL+nWz16AeiDrbOEPk71PUKMvjYE6nv75S4IxyktoTmUlKpa
	kK5HOabUCW1C1jCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpc8SH1qg4Eq1cmloG4WGzhBbHWqgT8QyYtq8cCYxc=;
	b=dHpQzwb5KkJa/i4mlc1bCiE2pyFVK3qlZfXIVBYw90gn2KAFmTHF4AjAS1h2rjNlabb0tQ
	Y6Xd0CpuHCC+UDAv3Fp0Xl3BerZcrmEf8KYRYBCRwO9gWDmo07TEsm3Q5wAvYqejdP/w3Y
	ePOnX2oMGo5Skgc8ZKqrkOcV4fWZIJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCpc8SH1qg4Eq1cmloG4WGzhBbHWqgT8QyYtq8cCYxc=;
	b=BMo94KIpF+JdkqDrWLFuNgoL+nWz16AeiDrbOEPk71PUKMvjYE6nv75S4IxyktoTmUlKpa
	kK5HOabUCW1C1jCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 735A412FF7;
	Tue, 30 Jan 2024 01:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XTUeC7hMuGWcQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:11:20 +0000
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
Date: Tue, 30 Jan 2024 12:08:22 +1100
Message-ID: <20240130011102.8623-3-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130011102.8623-1-neilb@suse.de>
References: <20240130011102.8623-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dHpQzwb5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BMo94KIp
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.69%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.69
X-Rspamd-Queue-Id: 11AA8220D6
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

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
index 5e640e9945cd..ae00f9327245 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1312,6 +1312,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 
 	lockdep_assert_held(&state_lock);
 	lockdep_assert_held(&fp->fi_lock);
+	lockdep_assert_held(&clp->cl_lock);
 
 	if (nfs4_delegation_exists(clp, fp))
 		return -EAGAIN;
@@ -5558,12 +5559,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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


