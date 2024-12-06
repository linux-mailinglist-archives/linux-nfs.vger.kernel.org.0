Return-Path: <linux-nfs+bounces-8354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138019E6274
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07D3285EA4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45D1758B;
	Fri,  6 Dec 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lT4GSn9S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="avJoho5m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lT4GSn9S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="avJoho5m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE81DFD1
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446141; cv=none; b=Jz/jl4/oSLSjnS0XdjFQrylK4a5t+xnMCu2gXkPsGGiR3ZiQYjnv82Lt0ZZtKrIv7oFaoaEneGm6NeGPO4k9XQnYx/MERBOckqmYJZZP1anX69PMa/X5b6tnLUISV/HkEfD0H/fz9hHY3n+tLkK5l9UW+VhOYUIsN+fPLU/7Dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446141; c=relaxed/simple;
	bh=6+CdjamtkrPxspHL5dpTU2ralQok3Of6nq105JNGCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWAAffAkh4mk1tvmPsSeUH+/2IDFRFoCZtbtNN+K/fuJa6foBr9WsuwY8nXhZxNB90TG2UyWZZueIEoCrUXBT1N5XnKZVd+GWShvFqKXx/yLYFte3CnAoMbqVrZZB3OJzznonaoYRi4AyjwSz8MtbsVqwasL+2kkWvaUr439B4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lT4GSn9S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=avJoho5m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lT4GSn9S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=avJoho5m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74C6E1F38E;
	Fri,  6 Dec 2024 00:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXgSEi5wlQMWnDXdlDTHWAqc2sRjQcLevVVifVJ6Po=;
	b=lT4GSn9S76iPcc8FaNMrQoIJWmB7170sNoXhlLpbxwT8Ama2vvKKnvmtvVYfbM4D3qtvAK
	G1VPuFPGktNwjuhTwC6sZH1KYlPzmL1MaRVL0QnnmFId4QOve4JEv3jdB2FSiq2GJuy9rO
	wZHQn815V4gYrUOpmCox0RUv96iESLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXgSEi5wlQMWnDXdlDTHWAqc2sRjQcLevVVifVJ6Po=;
	b=avJoho5mqrCn8R53avPSlp+pBE5jMGSEVPab9oadxWxX1fWM/HewszmfIVejKwOsK+Nfrc
	xv3GOycn9ddFD9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733446137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXgSEi5wlQMWnDXdlDTHWAqc2sRjQcLevVVifVJ6Po=;
	b=lT4GSn9S76iPcc8FaNMrQoIJWmB7170sNoXhlLpbxwT8Ama2vvKKnvmtvVYfbM4D3qtvAK
	G1VPuFPGktNwjuhTwC6sZH1KYlPzmL1MaRVL0QnnmFId4QOve4JEv3jdB2FSiq2GJuy9rO
	wZHQn815V4gYrUOpmCox0RUv96iESLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733446137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXgSEi5wlQMWnDXdlDTHWAqc2sRjQcLevVVifVJ6Po=;
	b=avJoho5mqrCn8R53avPSlp+pBE5jMGSEVPab9oadxWxX1fWM/HewszmfIVejKwOsK+Nfrc
	xv3GOycn9ddFD9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535BB132EB;
	Fri,  6 Dec 2024 00:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qh9cAvdJUmfZDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 00:48:55 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/6] nfsd: use an xarray to store v4.1 session slots
Date: Fri,  6 Dec 2024 11:43:15 +1100
Message-ID: <20241206004829.3497925-2-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Using an xarray to store session slots will make it easier to change the
number of active slots based on demand, and removes an unnecessary
limit.

To achieve good throughput with a high-latency server it can be helpful
to have hundreds of concurrent writes, which means hundreds of slots.
So increase the limit to 2048 (twice what the Linux client will
currently use).  This limit is only a sanity check, not a hard limit.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++++----------
 fs/nfsd/state.h     |  9 ++++++---
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 741b9449f727..aa4f1293d4d3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1915,8 +1915,11 @@ free_session_slots(struct nfsd4_session *ses)
 	int i;
 
 	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
-		free_svc_cred(&ses->se_slots[i]->sl_cred);
-		kfree(ses->se_slots[i]);
+		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
+
+		xa_erase(&ses->se_slots, i);
+		free_svc_cred(&slot->sl_cred);
+		kfree(slot);
 	}
 }
 
@@ -1996,17 +1999,20 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	struct nfsd4_session *new;
 	int i;
 
-	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
-		     > PAGE_SIZE);
-
-	new = kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return NULL;
+	xa_init(&new->se_slots);
 	/* allocate each struct nfsd4_slot and data cache in one piece */
 	for (i = 0; i < numslots; i++) {
-		new->se_slots[i] = kzalloc(slotsize, GFP_KERNEL);
-		if (!new->se_slots[i])
+		struct nfsd4_slot *slot;
+		slot = kzalloc(slotsize, GFP_KERNEL);
+		if (!slot)
 			goto out_free;
+		if (xa_is_err(xa_store(&new->se_slots, i, slot, GFP_KERNEL))) {
+			kfree(slot);
+			goto out_free;
+		}
 	}
 
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
@@ -2017,7 +2023,8 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	return new;
 out_free:
 	while (i--)
-		kfree(new->se_slots[i]);
+		kfree(xa_load(&new->se_slots, i));
+	xa_destroy(&new->se_slots);
 	kfree(new);
 	return NULL;
 }
@@ -2124,6 +2131,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 static void __free_session(struct nfsd4_session *ses)
 {
 	free_session_slots(ses);
+	xa_destroy(&ses->se_slots);
 	kfree(ses);
 }
 
@@ -4278,7 +4286,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (seq->slotid >= session->se_fchannel.maxreqs)
 		goto out_put_session;
 
-	slot = session->se_slots[seq->slotid];
+	slot = xa_load(&session->se_slots, seq->slotid);
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	/* We do not negotiate the number of slots yet, so set the
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e16bb3717fb9..aad547d3ad8b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -227,8 +227,11 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 	return container_of(s, struct nfs4_delegation, dl_stid);
 }
 
-/* Maximum number of slots per session. 160 is useful for long haul TCP */
-#define NFSD_MAX_SLOTS_PER_SESSION     160
+/* Maximum number of slots per session.  This is for sanity-check only.
+ * It could be increased if we had a mechanism to shutdown misbehaving clients.
+ * A large number can be needed to get good throughput on high-latency servers.
+ */
+#define NFSD_MAX_SLOTS_PER_SESSION	2048
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
@@ -327,7 +330,7 @@ struct nfsd4_session {
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
-	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
+	struct xarray		se_slots;	/* forward channel slots */
 };
 
 /* formatted contents of nfs4_sessionid */
-- 
2.47.0


