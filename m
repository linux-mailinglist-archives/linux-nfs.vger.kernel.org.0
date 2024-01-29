Return-Path: <linux-nfs+bounces-1526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3A83FCDC
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2941F220ED
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8D10A0C;
	Mon, 29 Jan 2024 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ww4OoIkl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7276beUY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ww4OoIkl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7276beUY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BF10A03
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499479; cv=none; b=O/47APMgtTQ8NhSGEYXKXAgKBDS8YRd2Fbc8iEaReZmTnFDUjelI597e865zA2E9rKCjvgEUuNZ4Rb8mZyvHO/fSBSU8S/n8z/dFoQGunQjHoRq7xjTe5X/tMbBIQhV/MZqMFw6noK7gdhKIMnh9INhns06cJH5CKd0wrul7H6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499479; c=relaxed/simple;
	bh=lOWJNegrhSHHL1iGb8ljl+/Hvjg2ZrMNQu5H87yyLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkK7gFUSvMnpWFRecbLJxAjtO65Gufugdnno/aquA52NEpsiTLErYjjuIeT4QpCBLNK7wN1/h5aaFOQsnkFoqecFdD5+WvPQ4DYpCM1AKS/gSf/K5BFgZzPxw9LSZvM0B9W6Rne3TZlFzchnwqzcwdOLw8UwlBFsD4Q8A3W9HJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ww4OoIkl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7276beUY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ww4OoIkl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7276beUY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CF5D1F7C4;
	Mon, 29 Jan 2024 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vITnWuN43OysXFiY1KLnQFRtep9QHe0BYwO7pl32Co=;
	b=Ww4OoIklJQTFEpg28idXT359aHlUm93D8tsfB9LjQEofOWYKp21BnnbYZBiUDZV/hmzR7/
	ojdgh3oqEKmR8UT+rjrF29GtgqlZPoy8ni9+xYJiOBRd+1iuGuab7gN2dNxwAxMSdUiLVo
	6VMDBmQFJ2jrVurK4/cCxh5yyU2h5F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vITnWuN43OysXFiY1KLnQFRtep9QHe0BYwO7pl32Co=;
	b=7276beUYSfNsJtHGlbyAtyg4Aw0Yy8q/Bc4l80ZonCzjw8FqJqbaL7893nQUJNmI+gMtkz
	079enoqiduQ2x6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vITnWuN43OysXFiY1KLnQFRtep9QHe0BYwO7pl32Co=;
	b=Ww4OoIklJQTFEpg28idXT359aHlUm93D8tsfB9LjQEofOWYKp21BnnbYZBiUDZV/hmzR7/
	ojdgh3oqEKmR8UT+rjrF29GtgqlZPoy8ni9+xYJiOBRd+1iuGuab7gN2dNxwAxMSdUiLVo
	6VMDBmQFJ2jrVurK4/cCxh5yyU2h5F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vITnWuN43OysXFiY1KLnQFRtep9QHe0BYwO7pl32Co=;
	b=7276beUYSfNsJtHGlbyAtyg4Aw0Yy8q/Bc4l80ZonCzjw8FqJqbaL7893nQUJNmI+gMtkz
	079enoqiduQ2x6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FF5313867;
	Mon, 29 Jan 2024 03:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z5VJBpEdt2VMKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 11/13] nfsd: allow open state ids to be revoked and then freed
Date: Mon, 29 Jan 2024 14:29:33 +1100
Message-ID: <20240129033637.2133-12-neilb@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ww4OoIkl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7276beUY
X-Spamd-Result: default: False [4.66 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.03)[55.20%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.66
X-Rspamd-Queue-Id: 0CF5D1F7C4
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Revoking state through 'unlock_filesystem' now revokes any open states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Possibly the related lock states should be revoked too, but a
subsequent patch will do that for all lock state on the superblock.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a5c17dab8bdb..5dc8f60e18dc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1717,7 +1717,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = SC_TYPE_LOCK;
+	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1732,6 +1732,22 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case SC_TYPE_OPEN:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  OPEN_STATEID_MUTEX);
+
+					spin_lock(&clp->cl_lock);
+					if (stid->sc_status == 0) {
+						stid->sc_status |=
+							SC_STATUS_ADMIN_REVOKED;
+						atomic_inc(&clp->cl_admin_revoked);
+						spin_unlock(&clp->cl_lock);
+						release_all_access(stp);
+					} else
+						spin_unlock(&clp->cl_lock);
+					mutex_unlock(&stp->st_mutex);
+					break;
 				case SC_TYPE_LOCK:
 					stp = openlockstateid(stid);
 					mutex_lock_nested(&stp->st_mutex,
@@ -4662,6 +4678,13 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 	bool unhashed;
 
 	switch (s->sc_type) {
+	case SC_TYPE_OPEN:
+		stp = openlockstateid(s);
+		if (unhash_open_stateid(stp, &reaplist))
+			put_ol_stateid_locked(stp, &reaplist);
+		spin_unlock(&cl->cl_lock);
+		free_ol_stateid_reaplist(&reaplist);
+		break;
 	case SC_TYPE_LOCK:
 		stp = openlockstateid(s);
 		unhashed = unhash_lock_stateid(stp);
-- 
2.43.0


