Return-Path: <linux-nfs+bounces-2152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56C86F94A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327DB2811B9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D317C8;
	Mon,  4 Mar 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oyZzrZKl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8cP18JU2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oyZzrZKl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8cP18JU2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27033566D
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527404; cv=none; b=pgz/vfQv/toOo+OW50txanCgp+h0iwXkAawMTuUkerqjrk9Pjq0vkgtKacxgnn7Q58Wj6jdhP826CAfQ5nJS0X28Mtbh/iDt4klhQ1PZpy9Ai5o0GLNeoXNpL0iZJn0Ufc98NOU6bqd4n59f6fTDmzsKfJzi1HV9/JKIiXbekxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527404; c=relaxed/simple;
	bh=MIX03G4snrHvayiPjxXKj9E4TLP8wJ6m54VhlYSGZio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIMAOhA0oylG5N5yd2jdD5FzqqWUcZH0bb3d+n5SWBV5xDc/Yti//eJbNCqyak6/rbQqrceCoFK3HtNPUkURiRhiwRCoz7XYZzu0623x8QwWEjAwv6cN55klM/w2yBcxzoFxbB2z8y4ZkFlStRJNpMAMa5uZ9JeyXI6Cp8YnuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oyZzrZKl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8cP18JU2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oyZzrZKl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8cP18JU2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74BDB680B5;
	Mon,  4 Mar 2024 04:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6WDPy50KQPQimySt7X67d4uQB1c56FDS6osYeXPvHY=;
	b=oyZzrZKlrHeQMhQHxPDidAqx6Fmn63AExwSTldkDiOYQEHwc9xshYTgh48DRyQP35UwN0f
	2tkMl8optHTKBkgy0h7JSJWpU8nfRICHbyFLjx0UGtX2iq9YtKrBEGU73UKXyQ/BWdGIEk
	AdJx92bD8FC+7jt++vD8AP/pBSH3bLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6WDPy50KQPQimySt7X67d4uQB1c56FDS6osYeXPvHY=;
	b=8cP18JU2QDw+KjWBtNNchs5jmpDIYgap/gOxHh5LOmQhZfjb7fkjVzseQaNzQRZUvsRb8n
	WaCratWEJaZU3kCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6WDPy50KQPQimySt7X67d4uQB1c56FDS6osYeXPvHY=;
	b=oyZzrZKlrHeQMhQHxPDidAqx6Fmn63AExwSTldkDiOYQEHwc9xshYTgh48DRyQP35UwN0f
	2tkMl8optHTKBkgy0h7JSJWpU8nfRICHbyFLjx0UGtX2iq9YtKrBEGU73UKXyQ/BWdGIEk
	AdJx92bD8FC+7jt++vD8AP/pBSH3bLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6WDPy50KQPQimySt7X67d4uQB1c56FDS6osYeXPvHY=;
	b=8cP18JU2QDw+KjWBtNNchs5jmpDIYgap/gOxHh5LOmQhZfjb7fkjVzseQaNzQRZUvsRb8n
	WaCratWEJaZU3kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D124D13A9F;
	Mon,  4 Mar 2024 04:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id en0RHWZR5WVTNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:43:18 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open handling.
Date: Mon,  4 Mar 2024 15:40:19 +1100
Message-ID: <20240304044304.3657-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304044304.3657-1-neilb@suse.de>
References: <20240304044304.3657-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.07
X-Spamd-Result: default: False [3.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.63)[82.34%]
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
index 7d6c657e0409..2f1e465628b1 100644
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
+	if (open->op_openowner)
+		nfs4_put_stateowner(&open->op_openowner->oo_owner);
 	if (open->op_file)
 		kmem_cache_free(file_slab, open->op_file);
 	if (open->op_stp)
-- 
2.43.0


