Return-Path: <linux-nfs+bounces-6043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E5965814
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0231C22423
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F4214C5A4;
	Fri, 30 Aug 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="of2lln6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Po/ACOgJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="of2lln6O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Po/ACOgJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037015217F
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001649; cv=none; b=dH+vFlp5IhramIssq/y8ybUpnnhnysfim7ynd2t9zquxR5H+TO1vYXMx4A+a9JyWyUP4CsR41gRdJgGOzD91j+wAGCek6Nv49XU7KlrKD9RjGqweQl1U4CSGKoWod1+/ei4uYKH3ESpPd31cwh3fPMrmWg8eKpKZ8dUKaoMyYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001649; c=relaxed/simple;
	bh=PBUTJen2Q4DVHp52PjELVYdcjX5lCDjY+VBSg9ydpwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts67FccsCvH6XTYS+amnbAICo4//nRH6FkKC85/UCI9CFcAw44/D84OxIv/EmRZ1p6hmx+zoHepfDh+J5g/dfGSzdktrLKmF3LyZbpArm07xxiWt+Vez6RvXvtV/++scDuS+tK6U4tjTlq2eLyEJrgHQ2RgoaMEiV+Hrrau3jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=of2lln6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Po/ACOgJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=of2lln6O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Po/ACOgJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 635FF1F7A6;
	Fri, 30 Aug 2024 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP6QlC6xdlKSppJOB39Ms9+EaaX+eN2/jBiAoAOlUxA=;
	b=of2lln6OnQowBH1EIlVg/MzkBuPeeUzB3ZomlMC9fQnomgrRugEn40lN5GgFBQGIP7Vi4T
	pSaTMWdfxKUaqxSHwrXV7Xxh5/tASQ6rY+PqYtuVtx7UMPagvQuQxbqiVxwTWdvrOiSdKr
	on1XEln99EgFTl36uM1km3gWg7ov3qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP6QlC6xdlKSppJOB39Ms9+EaaX+eN2/jBiAoAOlUxA=;
	b=Po/ACOgJ/nIB69rfhZR0ZmmYy0lZ/vFTAz6oNi9MLB/8TIJ/J7KZS9sZvXRXg5RQX/4WUO
	rY6+Jmx4u0AoytBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=of2lln6O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Po/ACOgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP6QlC6xdlKSppJOB39Ms9+EaaX+eN2/jBiAoAOlUxA=;
	b=of2lln6OnQowBH1EIlVg/MzkBuPeeUzB3ZomlMC9fQnomgrRugEn40lN5GgFBQGIP7Vi4T
	pSaTMWdfxKUaqxSHwrXV7Xxh5/tASQ6rY+PqYtuVtx7UMPagvQuQxbqiVxwTWdvrOiSdKr
	on1XEln99EgFTl36uM1km3gWg7ov3qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP6QlC6xdlKSppJOB39Ms9+EaaX+eN2/jBiAoAOlUxA=;
	b=Po/ACOgJ/nIB69rfhZR0ZmmYy0lZ/vFTAz6oNi9MLB/8TIJ/J7KZS9sZvXRXg5RQX/4WUO
	rY6+Jmx4u0AoytBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307DE13A44;
	Fri, 30 Aug 2024 07:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WRDYNaxv0WaFXAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 07:07:24 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: avoid races with wake_up_var()
Date: Fri, 30 Aug 2024 17:03:17 +1000
Message-ID: <20240830070653.7326-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830070653.7326-1-neilb@suse.de>
References: <20240830070653.7326-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 635FF1F7A6
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

wake_up_var() needs a barrier after the important change is made in the
var and before wake_up_var() is called, else it is possible that a wake
up won't be sent when it should.

In each case here the var is changed in an "atomic" manner, so
smb_mb__after_atomic() is sufficient.

In one case the important change (removing the lease) is performed
*after* the wake_up, which is backwards.  The code survives in part
because the wait_var_event is given a timeout.

This patch adds the required barriers and calls destroy_delegation()
*before* waking any threads waiting for the delegation to be destroyed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f85575ee0db..10e3a46289a1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4700,6 +4700,7 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
 	if (so != NULL) {
 		cstate->replay_owner = NULL;
 		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
+		smb_mb__after_atomic();
 		wake_up_var(&so->so_replay.rp_locked);
 		nfs4_put_stateowner(so);
 	}
@@ -5000,6 +5001,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 	 * so tell them to stop waiting.
 	 */
 	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
+	smb_mb__after_atomic();
 	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
 	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) == 2);
 
@@ -7469,8 +7471,9 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_stateid;
 
 	trace_nfsd_deleg_return(stateid);
-	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 	destroy_delegation(dp);
+	smb_mb__after_atomic();
+	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 put_stateid:
 	nfs4_put_stid(&dp->dl_stid);
 out:
-- 
2.44.0


