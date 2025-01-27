Return-Path: <linux-nfs+bounces-9652-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09CA1CF70
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F243A4DAB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1825A64F;
	Mon, 27 Jan 2025 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1bbUW81J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O5TcVYE9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1bbUW81J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IMX40MhZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDB748F
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941045; cv=none; b=mSqEl4S5YqFVJ37AmTLh4/4Z405dIC424z/tLAqqytEWKxjWntaZC+H1s133tEIt5yOWUVwWj4E0UvOM8PmoSSXJmSrwHDFUG1aGrTonPQIcPtWZxJQC9ScK+GN1nG0DVV0uhp88tnFMqBX/Lg+4XhzO72KHE5NAHJV83JbU9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941045; c=relaxed/simple;
	bh=R7m2owio9kZQqxShzhzbGlntX6WT7Jyy2pMKJ/3lrq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqsctwFTaRb+huLHBLgAxeV7SOFeeoeyDBVPXmzOD4EcynzG85iz81SGlc7InaK2Djz/d/8RimhKXL+Hz+KFEis93IDWAy0eec0m7E3/GAQtm1CgVELH1Cc29gspL+EArXNFc7q6tQ7Zl3I44qKo1ex0K7yuzuQwT/OK+jlH4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1bbUW81J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O5TcVYE9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1bbUW81J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IMX40MhZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1AB621160;
	Mon, 27 Jan 2025 01:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTX9N9tDS+afoY64V0+pIMkwbjDy/6zwdtprJN5rJB0=;
	b=1bbUW81JVYZWud4v8ANKD1CC/janU7Cn+WMf6Z9SnAlp9hmu1xzdHnwFpBFxUYD9JlxUWJ
	znc5mga6bpxJO24uZuUNoYcKhlXAXFaw3BLcnZG7ucICrDSPrTTXSv+gkFgcnCaOBspVHa
	D3ifTXIhUDbr+ET6CWaXfEX5PuyKf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTX9N9tDS+afoY64V0+pIMkwbjDy/6zwdtprJN5rJB0=;
	b=O5TcVYE9wi0VTe64rkPI0vGK1mTfAzUX/tt5wD5V0TzkuBmjhuxXMg6XuaCHYxlmATToRf
	az49OQLYt7krwZAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1bbUW81J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IMX40MhZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTX9N9tDS+afoY64V0+pIMkwbjDy/6zwdtprJN5rJB0=;
	b=1bbUW81JVYZWud4v8ANKD1CC/janU7Cn+WMf6Z9SnAlp9hmu1xzdHnwFpBFxUYD9JlxUWJ
	znc5mga6bpxJO24uZuUNoYcKhlXAXFaw3BLcnZG7ucICrDSPrTTXSv+gkFgcnCaOBspVHa
	D3ifTXIhUDbr+ET6CWaXfEX5PuyKf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTX9N9tDS+afoY64V0+pIMkwbjDy/6zwdtprJN5rJB0=;
	b=IMX40MhZLxdR3bpW92JPAGX6Ba6k9fzGKEX2mNOj8d7xqJVmfc/AvuEbXgsoshouzV/uxE
	No3wdoneMVS8tyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7548513782;
	Mon, 27 Jan 2025 01:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIKnCi/glmeqCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:59 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6/7] nfsd: filecache: change garbage collection to a timer.
Date: Mon, 27 Jan 2025 12:20:37 +1100
Message-ID: <20250127012257.1803314-7-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127012257.1803314-1-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1AB621160
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

garbage collection never sleeps and no longer walks a list so it runs
quickly only requiring a spinlock.

This means we don't need to use a workqueue, we can use a simple timer
instead.

Rather than taking the lock in the timer callback, which would require
using _bh locking, simply test a flag and wake an nfsd thread.  That
thread checks the flag and ages the lists when needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 7264faa57280..eb95a53f806f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -67,10 +67,12 @@ struct nfsd_fcache_disposal {
 	struct list_head older;	/* haven't been used in last 0-2 seconds */
 	struct list_head freeme; /* ready to be discarded */
 	unsigned long num_gc; /* Approximate size of recent plus older */
-	struct delayed_work filecache_laundrette;
+	struct timer_list timer;
 	struct shrinker *file_shrinker;
 	struct nfsd_net *nn;
+	unsigned long flags;
 };
+#define NFSD_FCACHE_DO_AGE	BIT(0)	/* time to age the lists */
 
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
@@ -115,8 +117,8 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
 static void
 nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
 {
-	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
-			   NFSD_LAUNDRETTE_DELAY);
+	if (!timer_pending(&l->timer))
+		mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
 }
 
 static void
@@ -521,6 +523,19 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 {
 	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
+	if (test_and_clear_bit(NFSD_FCACHE_DO_AGE, &l->flags)) {
+		spin_lock(&l->lock);
+		list_splice_init(&l->older, &l->freeme);
+		list_splice_init(&l->recent, &l->older);
+		/* We don't know how many were moved to 'freeme' and don't want
+		 * to waste time counting - guess a half.  This is only used
+		 * for the shrinker which doesn't need complete precision.
+		 */
+		l->num_gc /= 2;
+		if (!list_empty(&l->older) || !list_empty(&l->recent))
+			mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
+		spin_unlock(&l->lock);
+	}
 	if (!list_empty(&l->freeme)) {
 		LIST_HEAD(dispose);
 		int i;
@@ -557,23 +572,13 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 }
 
 static void
-nfsd_file_gc_worker(struct work_struct *work)
+nfsd_file_gc_worker(struct timer_list *t)
 {
 	struct nfsd_fcache_disposal *l = container_of(
-		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
+		t, struct nfsd_fcache_disposal, timer);
 
-	spin_lock(&l->lock);
-	list_splice_init(&l->older, &l->freeme);
-	list_splice_init(&l->recent, &l->older);
-	/* We don't know how many were moved to 'freeme' and don't want
-	 * to waste time counting - guess a half.
-	 */
-	l->num_gc /= 2;
-	if (!list_empty(&l->freeme))
-		svc_wake_up(l->nn->nfsd_serv);
-	if (!list_empty(&l->older) || !list_empty(&l->recent))
-		nfsd_file_schedule_laundrette(l);
-	spin_unlock(&l->lock);
+	set_bit(NFSD_FCACHE_DO_AGE, &l->flags);
+	svc_wake_up(l->nn->nfsd_serv);
 }
 
 static unsigned long
@@ -868,7 +873,7 @@ nfsd_alloc_fcache_disposal(void)
 	if (!l)
 		return NULL;
 	spin_lock_init(&l->lock);
-	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
+	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
 	INIT_LIST_HEAD(&l->recent);
 	INIT_LIST_HEAD(&l->older);
 	INIT_LIST_HEAD(&l->freeme);
@@ -891,7 +896,7 @@ nfsd_alloc_fcache_disposal(void)
 static void
 nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
 {
-	cancel_delayed_work_sync(&l->filecache_laundrette);
+	del_timer_sync(&l->timer);
 	shrinker_free(l->file_shrinker);
 	nfsd_file_release_list(&l->recent);
 	WARN_ON_ONCE(!list_empty(&l->recent));
-- 
2.47.1


