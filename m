Return-Path: <linux-nfs+bounces-1518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5383FCD4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED19DB2289B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9611CBA;
	Mon, 29 Jan 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yJud5itc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9vebZ+bD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IvMMAw6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bHbC7ypn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD111CAB
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499431; cv=none; b=HA9MRBbRhA4M8AEXvAMrzCvxm6aFRVPD9v/1VlNZ0os39zvy5ssHryugDFKP9XvuBsYtn11xc46t7jyVN0rjEt+2icqaH8+RIdtBUVXcfrU7F8/yJq9G99AjqmXydhc5A1VEDRjVWD+Ju3fmfjZoZJ/KpINIcBOwGwSj+2XlMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499431; c=relaxed/simple;
	bh=TbpaK5C/7xOEP0/WZNsg0xLIK+Mt3PRsSAP54ntLXMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRvkLVTfvvsqbhcB29xGhA6axplcTgaw4lyW3uyO5hNq/Ixvzao33FBIx+B9hhGC/eAy35ln5bbRO4diCAQZXRcNEsXXc4JAZwOFr3Ds2tZwAdiptKC4kGrJ+u6jq1UrHjLVaHmUIfmyCg63iOjzbUUbo5ik9JVOfCLCwhJsJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yJud5itc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9vebZ+bD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IvMMAw6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bHbC7ypn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF9932229C;
	Mon, 29 Jan 2024 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XShG8QVtL9fy2376YviiDKQ69VncvZ1JPh37BM3sPrg=;
	b=yJud5itcFVK4Ea44t+aOZdYVdvrE7xmEamiEQKaz1bTBz9kc8Xx4dySuxgg6Hv9QBO1fZE
	3ez2crKiwhqxBRMBOjmUDW7nXzT3f463EYiooYYO1PyozgpcfZpEWntaytaQY8saSxTkkj
	3fvL5pJ+3EN7dr8kMhFd4G030Zal6HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XShG8QVtL9fy2376YviiDKQ69VncvZ1JPh37BM3sPrg=;
	b=9vebZ+bDhaQNkbrUk8u/GM+QtyI+op4XMkI/fg6trezShDpynozE2Q728JBwDsyiyjheAY
	YrXyKqL3vybz1nBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XShG8QVtL9fy2376YviiDKQ69VncvZ1JPh37BM3sPrg=;
	b=IvMMAw6PBh4v6EM/B0vEjEb+fZowMYfnXEC5g3I3TxSadbse235ptXZDSOjvcXOxaY0y7a
	nhBROiiON90a36nrbAfVC53m8tNl1+neuMCLfJCJo5WPONEV58Ibb93zdRxz0st+fF4Whg
	wXAoo8taRmbz+MTjt7+y9Sm9SObLbdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XShG8QVtL9fy2376YviiDKQ69VncvZ1JPh37BM3sPrg=;
	b=bHbC7ypn3mAIlC9I1XBTnXGZjjKvqoULdex/7V32cn1Yu7/AchGzEBXbj4WdZvniLUC49u
	RAK/9TPnTZ6dkiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CA613867;
	Mon, 29 Jan 2024 03:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AEIVBGEdt2UeKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:05 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 03/13] nfsd: don't call functions with side-effecting inside WARN_ON()
Date: Mon, 29 Jan 2024 14:29:25 +1100
Message-ID: <20240129033637.2133-4-neilb@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.89 / 50.00];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.59%]
X-Spam-Level: ****
X-Spam-Score: 4.89
X-Spam-Flag: NO

Code like:

    WARN_ON(foo())

looks like an assertion and might not be expected to have any side
effects.
When testing if a function with side-effects fails a construct like

    if (foo())
       WARN_ON(1);

makes the intent more obvious.

nfsd has several WARN_ON calls where the test has side effects, so it
would be good to change them.  These cases don't really need the
WARN_ON.  They have never failed in 8 years of usage so let's just
remove the WARN_ON wrapper.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 051c3e99fac6..2ddbb7b4a40e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1600,7 +1600,7 @@ static void release_open_stateid_locks(struct nfs4_ol_stateid *open_stp,
 	while (!list_empty(&open_stp->st_locks)) {
 		stp = list_entry(open_stp->st_locks.next,
 				struct nfs4_ol_stateid, st_locks);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, reaplist);
 	}
 }
@@ -2229,7 +2229,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -6169,7 +6169,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -7999,7 +7999,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		stp = list_first_entry(&lo->lo_owner.so_stateids,
 				       struct nfs4_ol_stateid,
 				       st_perstateowner);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
@@ -8292,7 +8292,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.43.0


