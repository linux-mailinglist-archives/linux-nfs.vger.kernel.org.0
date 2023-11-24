Return-Path: <linux-nfs+bounces-58-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84D7F6B61
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A43B20E5D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2359EB673;
	Fri, 24 Nov 2023 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U3GY2bmj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6aUUWnHJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF7D6E
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:33:09 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A75D920C42;
	Fri, 24 Nov 2023 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700785795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrqNpICGQKKPp72bAUVRGmzzNkYjFAujlIrL39ZplII=;
	b=U3GY2bmjxjZ/I6i7Xa//oqXUjdCR33j9qSz+uAuVGMYQ0NjUUYuDla9MsL0EtDvOpyqurR
	d2cfOw79KHMT7QKMriegyYfH3vOlyjosU1FuKaDmBZCvEiQKNzmBcYUahZnep7nrZ9JG7e
	b1Ed6zFX6SU41dqhh5RjgA73cL4eO5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700785795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrqNpICGQKKPp72bAUVRGmzzNkYjFAujlIrL39ZplII=;
	b=6aUUWnHJ+EyNanqcRcsE3qhxR6kuh7pXi27LZDmscJvUHtY+ax3iBrVRucNuRUQ+sAGV/K
	eSZlvDNzqF1fDADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7703C1340B;
	Fri, 24 Nov 2023 00:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cCp/CoHuX2VCegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:29:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 02/11] nfsd: don't call functions with side-effecting inside WARN_ON()
Date: Fri, 24 Nov 2023 11:23:14 +1100
Message-ID: <20231124002504.19515-3-neilb@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124002504.19515-1-neilb@suse.de>
References: <20231124002504.19515-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.71
X-Spamd-Result: default: False [4.71 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.19)[-0.974];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

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
index 042c7a50f425..dd01d0b9e21e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1605,7 +1605,7 @@ static void release_open_stateid_locks(struct nfs4_ol_stateid *open_stp,
 	while (!list_empty(&open_stp->st_locks)) {
 		stp = list_entry(open_stp->st_locks.next,
 				struct nfs4_ol_stateid, st_locks);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, reaplist);
 	}
 }
@@ -2234,7 +2234,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -6234,7 +6234,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8060,7 +8060,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		stp = list_first_entry(&lo->lo_owner.so_stateids,
 				       struct nfs4_ol_stateid,
 				       st_perstateowner);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
@@ -8353,7 +8353,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.42.1


