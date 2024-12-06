Return-Path: <linux-nfs+bounces-8357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F29E6278
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371E41881B5C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D722083;
	Fri,  6 Dec 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PW5kAlzd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wkz4IMdk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PW5kAlzd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wkz4IMdk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F01EEF9
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446184; cv=none; b=l0NLRDtP8A9wCAa+HYSxMB+sEwN7NZpAnPTlwUbhlul3DZInT784SyXMNSFzOGbboxiLgm/7kNz4QF3Ub4Oeg8504A2gLp0av4zieegKC5EOt+hE7EhfqL8MkSfqHW3P/JdFaQ2hDOs6rY4IsceGz1f1PjsYiGV9mVekU7ZQuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446184; c=relaxed/simple;
	bh=SycaX4CcOZ4Tgav1IhJdHWorbxKIdEmrqzqxyIMFYSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMx5TWWLtZ8zKS0MrJi5ga9ALvqbNs0QO7azBKLDnQQYuqYKj/fShGHVjjoWFS9XGQ761P0EKFLW8HH70/ddERFtDO1cego6jAt1Sskfaukc3RJb1dfW26xkpLE2JO25+FhIqgEsGarJLu+2PR4a+YfterT3qpkR1RD/WuC9xtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PW5kAlzd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wkz4IMdk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PW5kAlzd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wkz4IMdk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 43FAD1F37C;
	Fri,  6 Dec 2024 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yj2KmO3F4S/81ykuHkBZhbMj6NshK8hjh6QbWdunpok=;
	b=PW5kAlzdQMalpf6x6J+JPNJYSINDzHrUqewfwVkQhHT4kmo6uvwNfcMvAb/UeEpK5+wbEy
	IDoX8KrqSVtxqG04vwbIXhdySjw/DJYary+XNObFgVWT8u8epdf8o9kcBJ3HE9JBHGiWtm
	YJxClcxebhlhPjxYf1VphmcXoo9xr3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yj2KmO3F4S/81ykuHkBZhbMj6NshK8hjh6QbWdunpok=;
	b=Wkz4IMdkbsND4LqLCdHAgw2iCClkrmQLoHgggFUUonzTh/m5RMNL+g2n4GlqF3Qrkc71rM
	qymMMnZenPo202BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PW5kAlzd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wkz4IMdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yj2KmO3F4S/81ykuHkBZhbMj6NshK8hjh6QbWdunpok=;
	b=PW5kAlzdQMalpf6x6J+JPNJYSINDzHrUqewfwVkQhHT4kmo6uvwNfcMvAb/UeEpK5+wbEy
	IDoX8KrqSVtxqG04vwbIXhdySjw/DJYary+XNObFgVWT8u8epdf8o9kcBJ3HE9JBHGiWtm
	YJxClcxebhlhPjxYf1VphmcXoo9xr3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yj2KmO3F4S/81ykuHkBZhbMj6NshK8hjh6QbWdunpok=;
	b=Wkz4IMdkbsND4LqLCdHAgw2iCClkrmQLoHgggFUUonzTh/m5RMNL+g2n4GlqF3Qrkc71rM
	qymMMnZenPo202BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25C65132EB;
	Fri,  6 Dec 2024 00:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qWEAMyJKUmcDDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:49:38 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
Date: Fri,  6 Dec 2024 11:43:18 +1100
Message-ID: <20241206004829.3497925-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206004829.3497925-1-neilb@suse.de>
References: <20241206004829.3497925-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43FAD1F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

If a client ever uses the highest available slot for a given session,
attempt to allocate more slots so there is room for the client to use
them if wanted.  GFP_NOWAIT is used so if there is not plenty of
free memory, failure is expected - which is what we want.  It also
allows the allocation while holding a spinlock.

Each time we increase the number of slots by 20% (rounded up).  This
allows fairly quick growth while avoiding excessive over-shoot.

We would expect to stablise with around 10% more slots available than
the client actually uses.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 67dfc699e411..ec4468ebbd40 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4235,11 +4235,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	slot = xa_load(&session->se_slots, seq->slotid);
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
-	/* We do not negotiate the number of slots yet, so set the
-	 * maxslots to the session maxreqs which is used to encode
-	 * sr_highest_slotid and the sr_target_slot id to maxslots */
-	seq->maxslots = session->se_fchannel.maxreqs;
-
 	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
 	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
 					slot->sl_flags & NFSD4_SLOT_INUSE);
@@ -4289,6 +4284,41 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cstate->session = session;
 	cstate->clp = clp;
 
+	/*
+	 * If the client ever uses the highest available slot,
+	 * gently try to allocate another 20%.  This allows
+	 * fairly quick growth without grossly over-shooting what
+	 * the client might use.
+	 */
+	if (seq->slotid == session->se_fchannel.maxreqs - 1 &&
+	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
+		int s = session->se_fchannel.maxreqs;
+		int cnt = DIV_ROUND_UP(s, 5);
+
+		do {
+			/*
+			 * GFP_NOWAIT is a low-priority non-blocking
+			 * allocation which can be used under
+			 * client_lock and only succeeds if there is
+			 * plenty of memory.
+			 * Use GFP_ATOMIC which is higher priority for
+			 * xa_store() so we are less likely to waste the
+			 * effort of the first allocation.
+			 */
+			slot = kzalloc(slot_bytes(&session->se_fchannel),
+				       GFP_NOWAIT);
+			if (slot &&
+			    !xa_is_err(xa_store(&session->se_slots, s, slot,
+						GFP_ATOMIC | __GFP_NOWARN))) {
+				s += 1;
+				session->se_fchannel.maxreqs = s;
+			} else {
+				kfree(slot);
+			}
+		} while (slot && --cnt > 0);
+	}
+	seq->maxslots = session->se_fchannel.maxreqs;
+
 out:
 	switch (clp->cl_cb_state) {
 	case NFSD4_CB_DOWN:
-- 
2.47.0


