Return-Path: <linux-nfs+bounces-2190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65987104E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D19B23D94
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6141C6AB;
	Mon,  4 Mar 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n2I1Jxdy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bDuHn61l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n2I1Jxdy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bDuHn61l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A23C28
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592458; cv=none; b=Cua6dGpqDL6J0XdJ+CQIVPqktsbnJydasmlm83qBtJzvoCGqAEV4x4RP3CxlGEDaHBft3tqOWapqLNbi0UZIDOAS9n39bolDq/2Ux8iHpWCAurx3mB5pbt5t8WlU0sPPguebXZ0bJh63WllrX2AwxKeNFSH+TJPGN2gdITn4PH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592458; c=relaxed/simple;
	bh=sId/eKh+dcs/8FAWjUVdKOTw9dlG0CuykFXJJHFxTJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO5ENn56XDysuy6flJ0sfI1sj4da8ciOsqwD2AfA/llQraEe4KTmM7l6RKb2stAd3TArP0jAIQwiaWqjJaBi2YZ4n+fXq7Om1vHid5lSG5ee8jbkaY53HtlvWzQEK5XtYL/EkyfYH5ejyG82Zc9Ypi68BsHGuGeSS6Lpc4ChqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n2I1Jxdy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bDuHn61l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n2I1Jxdy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bDuHn61l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18AA420D66;
	Mon,  4 Mar 2024 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpsLy1ROmmZPQNnbDUqjl3UQJzQpt8usQ2K4vI/HzaI=;
	b=n2I1JxdyGpqrS8lmNRnZrbJu7XIhTTURj9qt+wwq4hSXx/d0W05ioEQ6cM3rEbe6O12Xxo
	nkUahlMu74M/qNHmRdcIR1tsbPW8LfIn/lgSsQ13IBSZBp+y4v4xkE9rq5Zt4UJIpgClRR
	orsjJlJbg6Sm5eJ1xDELwxx9qfKhLew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpsLy1ROmmZPQNnbDUqjl3UQJzQpt8usQ2K4vI/HzaI=;
	b=bDuHn61lvIGSaaxItKbBUJL/JL1gjScD5KA2Sz431bvcG+tVF8W0z07jQB42NjkL+mBzVc
	0bw18eNL1QRUYuAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709592455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpsLy1ROmmZPQNnbDUqjl3UQJzQpt8usQ2K4vI/HzaI=;
	b=n2I1JxdyGpqrS8lmNRnZrbJu7XIhTTURj9qt+wwq4hSXx/d0W05ioEQ6cM3rEbe6O12Xxo
	nkUahlMu74M/qNHmRdcIR1tsbPW8LfIn/lgSsQ13IBSZBp+y4v4xkE9rq5Zt4UJIpgClRR
	orsjJlJbg6Sm5eJ1xDELwxx9qfKhLew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709592455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpsLy1ROmmZPQNnbDUqjl3UQJzQpt8usQ2K4vI/HzaI=;
	b=bDuHn61lvIGSaaxItKbBUJL/JL1gjScD5KA2Sz431bvcG+tVF8W0z07jQB42NjkL+mBzVc
	0bw18eNL1QRUYuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7908413A5B;
	Mon,  4 Mar 2024 22:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 10iDB4RP5mUYYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:47:32 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
Date: Tue,  5 Mar 2024 09:45:21 +1100
Message-ID: <20240304224714.10370-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304224714.10370-1-neilb@suse.de>
References: <20240304224714.10370-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n2I1Jxdy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bDuHn61l
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.04 / 50.00];
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
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.04)[-0.212];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.61)[92.50%]
X-Spam-Score: 1.04
X-Rspamd-Queue-Id: 18AA420D66
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
index ee9aa4843443..b9b3a2601675 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5333,15 +5333,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
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
@@ -5351,6 +5351,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (oo == NULL)
 		return nfserr_jukebox;
 	open->op_openowner = oo;
+	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
 alloc_stateid:
 	open->op_stp = nfs4_alloc_open_stateid(clp);
 	if (!open->op_stp)
@@ -6122,12 +6123,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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
2.43.0


