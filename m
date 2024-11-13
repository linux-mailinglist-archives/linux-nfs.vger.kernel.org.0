Return-Path: <linux-nfs+bounces-7925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C99C68EA
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 06:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3031F251D6
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188172309AE;
	Wed, 13 Nov 2024 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGBFws1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Irv7UYsI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w1B8l8c1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L6mjnozM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A51714A8
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477257; cv=none; b=ORmwx3/jbDv+1OWKP+5PWjvk60u16GTQJwzZp4omCrwe4BSChlipLVaJ98jf21Aavc+4BnpsQ6MvSwm2JlPKjSNZpGgQaU3PyP5S7LeIwvKKYGHBwl9Pln7WsoTH0H4/W03oxedNkdScLAQMSZc/X2uiywmiLxj82fGVfQe2IKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477257; c=relaxed/simple;
	bh=CLtreox0NRnKElIsQB+6pPr7emiNOIuz5JRiVVirs+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U26UzCHQavDb/uMIrb4GD+QS8Rm1BWhcGW2ItkynReRSVIS8FFooTboDu6aMOHP1sbD4OUSuJbGsiY/oCnVJuFhCMN42wRsP7NdE2aKq1Z8myJEZW2CoXEo3JwUhFL2ECOptmYS3yMsxdv18Kh0UDj2lWZXH8VRDo6WRI77GiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGBFws1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Irv7UYsI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w1B8l8c1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L6mjnozM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FAE61F365;
	Wed, 13 Nov 2024 05:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIqMQ61JhhGJ1qI1S9DraRk8NA5yvbgGVN70rWkZk68=;
	b=vGBFws1QQ2sK9x3L9Z9iL8utM1qrNZNQfR38KeIS9hB61updek3XCvzYHvoLPIn+DrBavO
	NtbMzCUDFdBLkYLBF4/HkJB7opwhvIsEwDz2VUbapVxdpQfU29/lE+gU/UTxTt+94wGUvx
	cdnS5owUJb2CchQS9mME2Z67D1uGgDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIqMQ61JhhGJ1qI1S9DraRk8NA5yvbgGVN70rWkZk68=;
	b=Irv7UYsI5/co9fBsFrL2K40ElHnYrKH3zaf16jIt4k5A2Q7Ay65p6Bk3gJEBcb+56OndA4
	zbTLtS4D+yBmhJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731477252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIqMQ61JhhGJ1qI1S9DraRk8NA5yvbgGVN70rWkZk68=;
	b=w1B8l8c1d3tFrgZcsPnQdj0AGQeHuOk7upEiF8xUJlFer7X/9yHgpOn68MFgv3UY5Asw2c
	9kwYbpn6cwLISgXOc7gInm6F+iJ5oh/sWqvUzH6jl8JZnOWhH4397ucXFoyhE1//QtP+Vr
	eHJTnb2V/bNs80O6a5597pkyPl9yEi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731477252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIqMQ61JhhGJ1qI1S9DraRk8NA5yvbgGVN70rWkZk68=;
	b=L6mjnozMjpIvtPqL5aSuI2UurvdjJCV9Zfc9BKXKhwp5Qb69MpQcjbdVPXtzMdZJ5/Sl7y
	ex5xEFj6IFVPcZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87AE713890;
	Wed, 13 Nov 2024 05:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p6LUDwI/NGeXfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 05:54:10 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/4] nfsd: free unused session-DRC slots
Date: Wed, 13 Nov 2024 16:38:36 +1100
Message-ID: <20241113055345.494856-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113055345.494856-1-neilb@suse.de>
References: <20241113055345.494856-1-neilb@suse.de>
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
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

When the client confirms that some currently allocated DRC slots are not
used, free some.  We currently keep 6 (NFSD_MAX_UNUSED_SLOTS) unused
slots to support bursts of client activity.  This could be tuned with a
shrinker.

When we free a slot we store the seqid in the slot pointer so that it can
be restored when we reactivate the slot.  The RFC requires the seqid for
each slot to increment on each request and does not permit it ever to be
reset.

We decoding sa_highest_slotid into maxslots we need to add 1 - this
matches how it is encoded for the reply.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 25 +++++++++++++++++++------
 fs/nfsd/nfs4xdr.c   |  3 ++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 683bb908039b..15de62416243 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1910,14 +1910,21 @@ gen_sessionid(struct nfsd4_session *ses)
 #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
 
 static void
-free_session_slots(struct nfsd4_session *ses)
+free_session_slots(struct nfsd4_session *ses, int from)
 {
 	int i;
 
-	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
+	if (from >= ses->se_fchannel.maxreqs)
+		return;
+
+	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
+		uintptr_t seqid = ses->se_slots[i]->sl_seqid;
 		free_svc_cred(&ses->se_slots[i]->sl_cred);
 		kfree(ses->se_slots[i]);
+		/* Save the seqid in case we reactivate this slot */
+		ses->se_slots[i] = (void *)seqid;
 	}
+	ses->se_fchannel.maxreqs = from;
 }
 
 /*
@@ -2069,7 +2076,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 
 static void __free_session(struct nfsd4_session *ses)
 {
-	free_session_slots(ses);
+	free_session_slots(ses, 0);
 	kfree(ses);
 }
 
@@ -4214,6 +4221,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out_put_session;
 
+	/* If there are lots of unused slots, free some */
+	free_session_slots(session, seq->maxslots + NFSD_MAX_UNUSED_SLOTS);
+
 	buflen = (seq->cachethis) ?
 			session->se_fchannel.maxresp_cached :
 			session->se_fchannel.maxresp_sz;
@@ -4244,10 +4254,13 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
 		int s = session->se_fchannel.maxreqs;
 
-		session->se_slots[s] = kzalloc(slot_bytes(&session->se_fchannel),
-					       GFP_NOWAIT);
-		if (session->se_slots[s])
+		struct nfsd4_slot *slot = kzalloc(slot_bytes(&session->se_fchannel),
+						  GFP_NOWAIT);
+		if (slot) {
+			slot->sl_seqid = (uintptr_t)session->se_slots[s];
+			session->se_slots[s] = slot;
 			session->se_fchannel.maxreqs += 1;
+		}
 	}
 	seq->maxslots = session->se_fchannel.maxreqs;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f118921250c3..846ed52fdaf5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *argp,
 		return nfserr_bad_xdr;
 	seq->seqid = be32_to_cpup(p++);
 	seq->slotid = be32_to_cpup(p++);
-	seq->maxslots = be32_to_cpup(p++);
+	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
+	seq->maxslots = be32_to_cpup(p++) + 1;
 	seq->cachethis = be32_to_cpup(p);
 
 	seq->status_flags = 0;
-- 
2.47.0


