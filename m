Return-Path: <linux-nfs+bounces-2706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44489B5D6
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C953B211EB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7FB15A8;
	Mon,  8 Apr 2024 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fhM3C038";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tSVYeZqB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fhM3C038";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tSVYeZqB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573963A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542346; cv=none; b=Bp34lMqqRm1CqOAKiBOhL1EV6wjYCcxauFNnJlEU+WnsyqEzIGNIXr75h6l77W75L6avM/H9sRsC7OtCyPlk6c0V7/6gBqrglZWN5DgjApSsTd6G8/Qq2oaoIOG522Snv6HM7cg+Bkn/QbJjC5KDG+9iOClotHWlSwSOjcm9RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542346; c=relaxed/simple;
	bh=NdEW5T2kf9Bbq4BJAQIIrEW9BOdGQk8INTnKKCtD6UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWN4Gm3LgeqZKKcAK0TzUaubwrJLJL1uJzizC5QJyTllvj/FnZN3VEmE1We3EFPXJEuS3ndhRibOqs2PaA+8Gbs9zVm81tZo06jjK2m1dUR9ZsyHMJU+yv0EWlfCpDdd6m57Ti3N8rqhPPFfjFku15q6nMuV2FhIGounQgAcApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fhM3C038; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tSVYeZqB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fhM3C038; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tSVYeZqB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB3D921849;
	Mon,  8 Apr 2024 02:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8RtbrU1SBBz1+4z4ndE9jSWesFpSfkwgsnVkui419U=;
	b=fhM3C038SRRRIfc7SVij4XLRTKSZqvGJ+eBn/ICtTRjH8LXjQiLzleqLF+TQRkjDBzqHcj
	e/ZSXsFukQb4gILhDLWLwHxwHYg5JmNRX9FQQ1R8703Z+imwkIguRBS+6ywf4P662glccZ
	wpzxEodedY5gd7/N+gfF4zIqTX+r6uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8RtbrU1SBBz1+4z4ndE9jSWesFpSfkwgsnVkui419U=;
	b=tSVYeZqBQc9qNQwmx4S6zrp44jffNcMLPIuSJ0N82kEeTwCbWXvkchaKKmaqqWMBJAEpqd
	G7LqdnLkkyCE0UDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fhM3C038;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tSVYeZqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8RtbrU1SBBz1+4z4ndE9jSWesFpSfkwgsnVkui419U=;
	b=fhM3C038SRRRIfc7SVij4XLRTKSZqvGJ+eBn/ICtTRjH8LXjQiLzleqLF+TQRkjDBzqHcj
	e/ZSXsFukQb4gILhDLWLwHxwHYg5JmNRX9FQQ1R8703Z+imwkIguRBS+6ywf4P662glccZ
	wpzxEodedY5gd7/N+gfF4zIqTX+r6uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8RtbrU1SBBz1+4z4ndE9jSWesFpSfkwgsnVkui419U=;
	b=tSVYeZqBQc9qNQwmx4S6zrp44jffNcMLPIuSJ0N82kEeTwCbWXvkchaKKmaqqWMBJAEpqd
	G7LqdnLkkyCE0UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09C0313796;
	Mon,  8 Apr 2024 02:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oFjgJ4NSE2b8EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:12:19 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
Date: Mon,  8 Apr 2024 12:09:16 +1000
Message-ID: <20240408021156.6104-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408021156.6104-1-neilb@suse.de>
References: <20240408021156.6104-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.03 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[53.48%];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AB3D921849
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.03

Rather than taking the rp_mutex (via nfsd4_cstate_assign_replay) in
nfsd4_cleanup_open_state() (which seems counter-intuitive), take it and
assign rp_owner as soon as possible - in nfsd4_process_open1().

This will support a future change when nfsd4_cstate_assign_replay() might
fail.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6ac1dff29d42..2ff8cb50f2e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5360,6 +5360,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	open->op_openowner = oo;
 	if (!oo)
 		return nfserr_jukebox;
+	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
 	status = nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
 	if (status)
 		return status;
@@ -6134,12 +6135,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
 			      struct nfsd4_open *open)
 {
-	if (open->op_openowner) {
-		struct nfs4_stateowner *so = &open->op_openowner->oo_owner;
-
-		nfsd4_cstate_assign_replay(cstate, so);
-		nfs4_put_stateowner(so);
-	}
+	if (open->op_openowner)
+		nfs4_put_stateowner(&open->op_openowner->oo_owner);
 	if (open->op_file)
 		kmem_cache_free(file_slab, open->op_file);
 	if (open->op_stp)
-- 
2.44.0


