Return-Path: <linux-nfs+bounces-8098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DDC9D1CC7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BA4282211
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568B8825;
	Tue, 19 Nov 2024 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oppi3qKD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H+qVWjdb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oppi3qKD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H+qVWjdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096F25634
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977394; cv=none; b=n67BjChOacbXyHJ73wbhrcURMBQok7tBfy8sYTLC3h2OS3zuxeJANKb5jcyCx0HmvS/seM0rdwNtTeVbofFQoP6h3DizCBOEi/X0EuJTZZzdj4R90kBB/56AGJWYrmHdL6m8ssLKrbXRMWurSwgoEkvyDOTctMuCHnrAUP9j2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977394; c=relaxed/simple;
	bh=csJ5MBHtdtC5By9RenTjcjZequPDTG6EYXXM6xUrpCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhBY+hFOO4omytde58UCNt30+W46cE2whn/je04KHaQJJHJrSF5wH/76Llu4e5u65Em452yTSjDfp4LdDYlWjA38SSNwYcKy3gpau/rcDEG7d+zOSE3UYZM8/AtSWp7/W/Gj4f57lBDkKV5oj2AWcA5qRdQzvFFmyG5UV0+bylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oppi3qKD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H+qVWjdb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oppi3qKD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H+qVWjdb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55EB121757;
	Tue, 19 Nov 2024 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njM+Luaws02Ib6cYYLYPk7SjhHHsnOngonPOsYqXErc=;
	b=Oppi3qKD62M9jL0phLG4FHdMa/6GbuvKiONDTfk1g4jof3w1FeDlaiAeJge2mQFVrIu1ua
	bZWOAz/QCdVgP/bEoT32tADV1NeSt7Dnyl4R7oIaWcpecYjEc/4ydLmx2j4qX6JAMwlhu+
	yd92g907fFgI1g2AF/yydn6nmFHw7mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njM+Luaws02Ib6cYYLYPk7SjhHHsnOngonPOsYqXErc=;
	b=H+qVWjdbaMmPVe5oJPvEXPV9ysguF71oC/nOrxBQwHR3C4UBQVxtJZoXQEj/U2w0hVcSZG
	I7Kflx3jPJKb5cBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oppi3qKD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H+qVWjdb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731977391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njM+Luaws02Ib6cYYLYPk7SjhHHsnOngonPOsYqXErc=;
	b=Oppi3qKD62M9jL0phLG4FHdMa/6GbuvKiONDTfk1g4jof3w1FeDlaiAeJge2mQFVrIu1ua
	bZWOAz/QCdVgP/bEoT32tADV1NeSt7Dnyl4R7oIaWcpecYjEc/4ydLmx2j4qX6JAMwlhu+
	yd92g907fFgI1g2AF/yydn6nmFHw7mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731977391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njM+Luaws02Ib6cYYLYPk7SjhHHsnOngonPOsYqXErc=;
	b=H+qVWjdbaMmPVe5oJPvEXPV9ysguF71oC/nOrxBQwHR3C4UBQVxtJZoXQEj/U2w0hVcSZG
	I7Kflx3jPJKb5cBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A3BA1376E;
	Tue, 19 Nov 2024 00:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AZbyAK3gO2eaJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 00:49:49 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/6] nfsd: use an xarray to store v4.1 session slots
Date: Tue, 19 Nov 2024 11:41:28 +1100
Message-ID: <20241119004928.3245873-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119004928.3245873-1-neilb@suse.de>
References: <20241119004928.3245873-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55EB121757
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Using an xarray to store session slots will make it easier to change the
number of active slots based on demand, and removes an unnecessary
limit.

To achieve good throughput with a high-latency server it can be helpful
to have hundreds of concurrent writes, which means hundreds of slots.
So increase the limit to 2048 (twice what the Linux client will
currently use).

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++++----------
 fs/nfsd/state.h     |  8 +++++---
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e0daf8b3982c..b48c1423d89b 100644
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
 
@@ -4292,7 +4300,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (seq->slotid >= session->se_fchannel.maxreqs)
 		goto out_put_session;
 
-	slot = session->se_slots[seq->slotid];
+	slot = xa_load(&session->se_slots, seq->slotid);
 	dprintk("%s: slotid %d\n", __func__, seq->slotid);
 
 	/* We do not negotiate the number of slots yet, so set the
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 554041da8593..e97626916a68 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -245,8 +245,10 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 	return container_of(s, struct nfs4_delegation, dl_stid);
 }
 
-/* Maximum number of slots per session. 160 is useful for long haul TCP */
-#define NFSD_MAX_SLOTS_PER_SESSION     160
+/* Maximum number of slots per session.  A large number can be need to
+ * get good throughput on high-latency servers.
+ */
+#define NFSD_MAX_SLOTS_PER_SESSION	2048
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
@@ -345,7 +347,7 @@ struct nfsd4_session {
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
-	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
+	struct xarray		se_slots;	/* forward channel slots */
 };
 
 /* formatted contents of nfs4_sessionid */
-- 
2.47.0


