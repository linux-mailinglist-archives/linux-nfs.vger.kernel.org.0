Return-Path: <linux-nfs+bounces-1585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF593841824
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF96B229FB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649022083;
	Tue, 30 Jan 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Olc/yvaT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jak0cjU7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MkYu4/98";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W3YjmN2f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD4D266
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577094; cv=none; b=fesz7TdInETlI0axsqRlvPFrihIEbyK+q6gndYitqT/Kv1azr2Mms6xfe+Qv05NHO+Jke7Lr73Aw957f7wL22HTIGiT1+uhLQqzUxB7c654YBq2Z2g4KV/OlafMs0t7e8cL43/8CAKwogmc0E+hygbZlb+iCFeBQjZ32bOvPBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577094; c=relaxed/simple;
	bh=kStnCaeYh9I3gsYRjXIvZhMiy4LkymQxlojuk0qtUko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIdugXP65tfwurmdcIIRRKm1swzSohWkzwydsTkZQviZLfNwEuvOmmetD6Wk9IgHBIe2cq2i80lQULQwNj8TXKW0exF0TqgJwvikakSgr0gh85/puEgPNba9WEZradZrP3wbP2yy8vliNlO0uJHYZXaMNRGtAY8V6890IqugRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Olc/yvaT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jak0cjU7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MkYu4/98; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W3YjmN2f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA2C01F7ED;
	Tue, 30 Jan 2024 01:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZs+ONYOZpKeX4h+oQ+9vW74ciSIq6qS9ax6DvIFoRY=;
	b=Olc/yvaT06q0S7Z5KbOtLfGJJtsQciLzmKpfzB9q+vv31pEvCsqem7+v3G71uFkLqlH88n
	PYtPRQotqwhoChljNh5OlLnWgFkODGuZJklzE+xC6mgq+uqQ6QnpbxBzWPsER8hq/AYb4k
	sw7BrqgZjbOa0KormDwgH6M0ctLo3/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZs+ONYOZpKeX4h+oQ+9vW74ciSIq6qS9ax6DvIFoRY=;
	b=Jak0cjU7fcivpwZobJVTrmQg1V71NnqVC5TzhUPJcBr9ebq4ilb5nRPRdAWAtctOEfMU+x
	CgSB0nTmGDrc5+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZs+ONYOZpKeX4h+oQ+9vW74ciSIq6qS9ax6DvIFoRY=;
	b=MkYu4/98Fsl33ktaGf0n9+oQ61wNoXhG95/fIXdFopekkTk5LdDTPva7rwM3BQw4apgV4A
	DkEAn3Cg/LyLVfXdcLZDgcnnx7/FZbO0yF53c1KDXiQFv4Sk5MTHT4bk1ZUmqBRN2t54of
	JiDrSdd1Pi+6hZO3p7h/ZvK0zQcSIWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZs+ONYOZpKeX4h+oQ+9vW74ciSIq6qS9ax6DvIFoRY=;
	b=W3YjmN2f29OE+0CBjC+2w3EQTD38FwfUv72lGNKJV/yjWPARJ+8YO3d0Ye/rT+ko7NCGXk
	Yfy1KNK19cg0N9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5763412FF7;
	Tue, 30 Jan 2024 01:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KRs6BL5MuGWhQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:11:26 +0000
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
Date: Tue, 30 Jan 2024 12:08:23 +1100
Message-ID: <20240130011102.8623-4-neilb@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.87 / 50.00];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.92%]
X-Spam-Level: ****
X-Spam-Score: 4.87
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ae00f9327245..59982fa5d4fa 100644
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
@@ -6170,7 +6170,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		unhash_delegation_locked(dp);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8010,7 +8010,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		stp = list_first_entry(&lo->lo_owner.so_stateids,
 				       struct nfs4_ol_stateid,
 				       st_perstateowner);
-		WARN_ON(!unhash_lock_stateid(stp));
+		unhash_lock_stateid(stp);
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
@@ -8303,7 +8303,7 @@ nfs4_state_shutdown_net(struct net *net)
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


