Return-Path: <linux-nfs+bounces-2131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB686D825
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 01:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7654B20D58
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2417E;
	Fri,  1 Mar 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VgynxoeL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="or90K7HB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VgynxoeL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="or90K7HB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AB629
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251808; cv=none; b=pjC636n0ZoPQESKYjzo1Q1s/xSU0ZvSHrCjFQDd1pmNbL2XJqDA8tkuEsJ90dylEmXNHQqPrQxplvSfcvp+efjMtX4gE40O74Rm6OtyEgN98ng+lZCQdhY3yiJteP+bd1i0rtSSbbmS7HYuJ9PMs1/Lt5VrmTgqxga2AKbaE+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251808; c=relaxed/simple;
	bh=qXQ2oUvVgRI4k71x4p0GR1bPnxu5BO9O+6p7Ce06sV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRPRbzHczFbTXNBL1eaAD87QWoFu7RYiIzHfdwWCER01L/hhMHIQyaehVNyTlOlxizIgCxuz/UGn470tSg/ZrV9VnhJI+b9X9whkfJcXOykKE8zg423E9g2R7PVGloL3J1amiowq+aK5NaI73A6t80xZ9j+WEA6oKBbdcH4WFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VgynxoeL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=or90K7HB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VgynxoeL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=or90K7HB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2818522361;
	Fri,  1 Mar 2024 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu+Aw5m68F52YnvoMFzIucdUgFDCCW+gbyNhlvNHPQY=;
	b=VgynxoeLEngzLLF9cc0jbE3P3KfsY/VIcexxkUOQz+5ImYAT2pf8ySwLc60Lxe7LBbwpDW
	/54JaFX9eWqWcek9+Oiv1XPUrLGmMa2x2TtmnJE1T6joxKQOYVArI0Dify8hYMEhgFkkq7
	8BEEmbzBO/elBd/tw1V775yARzNDQcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu+Aw5m68F52YnvoMFzIucdUgFDCCW+gbyNhlvNHPQY=;
	b=or90K7HBRJguI0hJmosHQTK5kwuBVWBk1yfyal3iT6M8iSlL83JpBOm7rioq6dnCQt/1A7
	hsxNOk4Rbk84sEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709251805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu+Aw5m68F52YnvoMFzIucdUgFDCCW+gbyNhlvNHPQY=;
	b=VgynxoeLEngzLLF9cc0jbE3P3KfsY/VIcexxkUOQz+5ImYAT2pf8ySwLc60Lxe7LBbwpDW
	/54JaFX9eWqWcek9+Oiv1XPUrLGmMa2x2TtmnJE1T6joxKQOYVArI0Dify8hYMEhgFkkq7
	8BEEmbzBO/elBd/tw1V775yARzNDQcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709251805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu+Aw5m68F52YnvoMFzIucdUgFDCCW+gbyNhlvNHPQY=;
	b=or90K7HBRJguI0hJmosHQTK5kwuBVWBk1yfyal3iT6M8iSlL83JpBOm7rioq6dnCQt/1A7
	hsxNOk4Rbk84sEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1BF613AB0;
	Fri,  1 Mar 2024 00:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6tg7JNoc4WWxJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 00:10:02 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/3] nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
Date: Fri,  1 Mar 2024 11:07:37 +1100
Message-ID: <20240301000950.2306-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301000950.2306-1-neilb@suse.de>
References: <20240301000950.2306-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VgynxoeL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=or90K7HB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.74)[93.41%]
X-Spam-Score: -0.25
X-Rspamd-Queue-Id: 2818522361
X-Spam-Flag: NO

Rather than taking the rp_mutex in nfsd4_cleanup_open_state() (which
seems counter-intuitive), take it and assign rp_owner as soon as
possible.

This will support a future change when nfsd4_cstate_assign_replay() might
fail.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7d6c657e0409..e625f738f7b0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5066,15 +5066,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	strhashval = ownerstr_hashval(&open->op_owner);
 	oo = find_openstateowner_str(strhashval, open, clp);
 	open->op_openowner = oo;
-	if (!oo) {
+	if (!oo)
 		goto new_owner;
-	}
 	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
 		/* Replace unconfirmed owners without checking for replay. */
 		release_openowner(oo);
 		open->op_openowner = NULL;
 		goto new_owner;
 	}
+	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
@@ -5084,6 +5084,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (oo == NULL)
 		return nfserr_jukebox;
 	open->op_openowner = oo;
+	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
 alloc_stateid:
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
@@ -5835,12 +5836,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 			      struct nfsd4_open *open)
 {
-	if (open->op_openowner) {
-		struct nfs4_stateowner *so = &open->op_openowner->oo_owner;
-
-		nfsd4_cstate_assign_replay(cstate, so);
-		nfs4_put_stateowner(so);
-	}
+	if (cstate->replay_owner)
+		nfs4_put_stateowner(cstate->replay_owner);
 	if (open->op_file)
 		kmem_cache_free(file_slab, open->op_file);
 	if (open->op_stp)
-- 
2.43.0


