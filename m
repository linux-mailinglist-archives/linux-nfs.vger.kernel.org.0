Return-Path: <linux-nfs+bounces-8376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F759E6481
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A90C1884AB6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510A1E522;
	Fri,  6 Dec 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvmxFIUV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4lRmG9PK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvmxFIUV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4lRmG9PK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42179140360
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453874; cv=none; b=e+mVFL0/jZpW0JgEj+PtZ/aMKw7N5k942Wz+X96ioEAsQ44PpCkr92yz26+RXw1B8/125TiJHNhdSQ6HpHQ0ffPVtsnBmRREpYzwJKcQdoABF0vQjsHrVu8kupTcAJAlZ3x6N6lLub5VT54WYBWQs16dennKl1us0aI4c0FV6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453874; c=relaxed/simple;
	bh=uvFgt5yx789Im18vnXI4NB/N/imCO0INah9F6MzT5xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2THunOzo9XqeqUIFrLcOv9E2cKJttF1olSni6NTTEfkA57oa1eujp4wW/pFebLG3NJZ9oFAdKF/+MX5v7wA5tWflIJMcNd12sgov+RImfKPXTFtYXZJAwQWaNh+bSKG9t8LapTllrD5mYv4f1L6ZMv+mQ6vmcPhXM0aJFrqzno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvmxFIUV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4lRmG9PK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvmxFIUV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4lRmG9PK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74EBC21184;
	Fri,  6 Dec 2024 02:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT9K3tYKoxkt2F07biwmOxAj6ya+Wt548z9y4CCZ4a4=;
	b=mvmxFIUV0RPr91ZSQD/hNtl7bXPVRHxrLTPpPSs1bL2nhIZpccUfgjppkN8aDMxlWepRCt
	J5Uot4DSaZVrVko1meutDt7p2zgnZjKrMvg3GrdxZx5RJ8h4uRzi7TrJhCZsPMxwVmB0kO
	9Ku5QcD6NwcAZAnGRUrAhljLoJ7OAL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT9K3tYKoxkt2F07biwmOxAj6ya+Wt548z9y4CCZ4a4=;
	b=4lRmG9PKYSJ8QNUQdMGRKX79BvyeJG406qULoydO8QWTJrdg8lFBxdjeKYFsPcyWi+jwb/
	R9FtAcIt6HpK/3BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT9K3tYKoxkt2F07biwmOxAj6ya+Wt548z9y4CCZ4a4=;
	b=mvmxFIUV0RPr91ZSQD/hNtl7bXPVRHxrLTPpPSs1bL2nhIZpccUfgjppkN8aDMxlWepRCt
	J5Uot4DSaZVrVko1meutDt7p2zgnZjKrMvg3GrdxZx5RJ8h4uRzi7TrJhCZsPMxwVmB0kO
	9Ku5QcD6NwcAZAnGRUrAhljLoJ7OAL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT9K3tYKoxkt2F07biwmOxAj6ya+Wt548z9y4CCZ4a4=;
	b=4lRmG9PKYSJ8QNUQdMGRKX79BvyeJG406qULoydO8QWTJrdg8lFBxdjeKYFsPcyWi+jwb/
	R9FtAcIt6HpK/3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5609313647;
	Fri,  6 Dec 2024 02:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q2YrAyloUme2LAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:57:45 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/2] nfsd: use new wake_up_var interfaces.
Date: Fri,  6 Dec 2024 13:55:52 +1100
Message-ID: <20241206025723.3537777-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206025723.3537777-1-neilb@suse.de>
References: <20241206025723.3537777-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The wake_up_var interface is fragile as barriers are sometimes needed.
There are now new interfaces so that most wake-ups can use an interface
that is guaranteed to have all barriers needed.

This patch changes the wake up on cl_cb_inflight to use
atomic_dec_and_wake_up().

It also changes the wake up on rp_locked to use store_release_wake_up().
This involves changing rp_locked from atomic_t to int.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4callback.c |  3 +--
 fs/nfsd/nfs4state.c    | 16 ++++++----------
 fs/nfsd/state.h        |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 3877b53e429f..a8dc9de2f7fb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1036,8 +1036,7 @@ static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
 static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
 {
 
-	if (atomic_dec_and_test(&clp->cl_cb_inflight))
-		wake_up_var(&clp->cl_cb_inflight);
+	atomic_dec_and_wake_up(&clp->cl_cb_inflight);
 }
 
 static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 741b9449f727..9fbf7c8f0a3e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4739,7 +4739,7 @@ static void init_nfs4_replay(struct nfs4_replay *rp)
 	rp->rp_status = nfserr_serverfault;
 	rp->rp_buflen = 0;
 	rp->rp_buf = rp->rp_ibuf;
-	atomic_set(&rp->rp_locked, RP_UNLOCKED);
+	rp->rp_locked = RP_UNLOCKED;
 }
 
 static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
@@ -4747,9 +4747,9 @@ static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstate,
 {
 	if (!nfsd4_has_session(cstate)) {
 		wait_var_event(&so->so_replay.rp_locked,
-			       atomic_cmpxchg(&so->so_replay.rp_locked,
-					      RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
-		if (atomic_read(&so->so_replay.rp_locked) == RP_UNHASHED)
+			       cmpxchg(&so->so_replay.rp_locked,
+				       RP_UNLOCKED, RP_LOCKED) != RP_LOCKED);
+		if (so->so_replay.rp_locked == RP_UNHASHED)
 			return -EAGAIN;
 		cstate->replay_owner = nfs4_get_stateowner(so);
 	}
@@ -4762,9 +4762,7 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
-		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
-		smp_mb__after_atomic();
-		wake_up_var(&so->so_replay.rp_locked);
+		store_release_wake_up(&so->so_replay.rp_locked, RP_UNLOCKED);
 		nfs4_put_stateowner(so);
 	}
 }
@@ -5069,9 +5067,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 	 * Some threads with a reference might be waiting for rp_locked,
 	 * so tell them to stop waiting.
 	 */
-	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
-	smp_mb__after_atomic();
-	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
+	store_release_wake_up(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
 	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
 
 	release_all_access(s);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e16bb3717fb9..ba30b2335b66 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -505,7 +505,7 @@ struct nfs4_replay {
 	unsigned int		rp_buflen;
 	char			*rp_buf;
 	struct knfsd_fh		rp_openfh;
-	atomic_t		rp_locked;
+	int			rp_locked;
 	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
 };
 
-- 
2.47.0


