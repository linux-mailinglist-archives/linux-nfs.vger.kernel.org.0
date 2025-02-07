Return-Path: <linux-nfs+bounces-9923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD464A2BA94
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CD4162810
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748BC63D;
	Fri,  7 Feb 2025 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12vu3uee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pRf3/HIG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12vu3uee";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pRf3/HIG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881014F9C4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905473; cv=none; b=keM+elW6iijkj6dVfVGXWKKskp0mJ0AjPH6JmzedCtYjqL1CLY2kJr2mqThjKZ5TbR9ibzfsdvyUdHDRLpe5srhKAaNWbnzBHSDohf2tbCuXjjRQg2gLN/9eR96uZmV/sSFI/Pg13rCFJZFsKUFC0VaVGw1x6nlSScQOnK0wB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905473; c=relaxed/simple;
	bh=BLdjNi4jt+e1njUxgffpEoCfT/OEDGut/T7MPmYKMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmQgnPGGn3JgtwEmjRIYEucwNFWet+I5YtuuYyqq/44DSJdlrhpN9NMbpeBdFzzJ7CvGQxNltib0bxjrorK6RA1PaBQ7jGgO7FH5c6q1eIQz/PDIhkwGMXpDG7iRfI/y1IOfsUbg5wBea4nwd/DOd6g6wWvipZsZ7jf0VKfC2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=12vu3uee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pRf3/HIG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=12vu3uee; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pRf3/HIG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00EA51F38D;
	Fri,  7 Feb 2025 05:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srMh542wBPbyvKGDrB6pMPkBocvKPHx47uRByHLSBJI=;
	b=12vu3ueewO/UtWcsyVBCA65lK5qWJp07YUyuctZSLmqZOfeD+hRfuC/Nr8C0DdS9aZZXtj
	nvV1rJjkVKwCv4REZLsnwoq3Tavc8Oo74bCCTYfpPkN+02h7mqPsW/ufosYnKF/ZYNT/bi
	tFiRxKMTVVS54QffGYGBE9riJkcwg1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srMh542wBPbyvKGDrB6pMPkBocvKPHx47uRByHLSBJI=;
	b=pRf3/HIGOMcTUgjuB/ZY+iITR23dOL0cHX2QCG27FeCk75lFBv6U2WyjJSiAokV+EXSICX
	0F5xzpFRrbG5EADA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=12vu3uee;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pRf3/HIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srMh542wBPbyvKGDrB6pMPkBocvKPHx47uRByHLSBJI=;
	b=12vu3ueewO/UtWcsyVBCA65lK5qWJp07YUyuctZSLmqZOfeD+hRfuC/Nr8C0DdS9aZZXtj
	nvV1rJjkVKwCv4REZLsnwoq3Tavc8Oo74bCCTYfpPkN+02h7mqPsW/ufosYnKF/ZYNT/bi
	tFiRxKMTVVS54QffGYGBE9riJkcwg1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srMh542wBPbyvKGDrB6pMPkBocvKPHx47uRByHLSBJI=;
	b=pRf3/HIGOMcTUgjuB/ZY+iITR23dOL0cHX2QCG27FeCk75lFBv6U2WyjJSiAokV+EXSICX
	0F5xzpFRrbG5EADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79A3513694;
	Fri,  7 Feb 2025 05:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tSG3C3uXpWceFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:47 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5/6] nfsd: filecache: don't repeatedly add/remove files on the lru list
Date: Fri,  7 Feb 2025 16:15:15 +1100
Message-ID: <20250207051701.3467505-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207051701.3467505-1-neilb@suse.de>
References: <20250207051701.3467505-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00EA51F38D
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
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

There is no need to remove a file from the lru every time we access it,
and then add it back.  It is sufficient to set the REFERENCED flag every
time we put the file.  The order in the lru of REFERENCED files is
largely irrelevant as they will all be moved to the end.

With this patch, files are only added when they are allocated (if
want_gc) and they are only removed by the list_lru_(shrink_)walk
callback or when forcibly removing a file.

This should reduce contention on the list_lru spinlock(s) and reduce
memory traffic a little.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 51 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9faf469354a5..d1ce0bc86ff7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -318,15 +318,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static bool nfsd_file_lru_add(struct nfsd_file *nf)
+static void nfsd_file_lru_add(struct nfsd_file *nf)
 {
-	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
-	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
-	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
+	refcount_inc(&nf->nf_ref);
+	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru))
 		trace_nfsd_file_lru_add(nf);
-		return true;
-	}
-	return false;
+	else
+		WARN_ON(1);
+	nfsd_file_schedule_laundrette();
 }
 
 static bool nfsd_file_lru_remove(struct nfsd_file *nf)
@@ -362,20 +361,10 @@ nfsd_file_put(struct nfsd_file *nf)
 
 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		/*
-		 * If this is the last reference (nf_ref == 1), then try to
-		 * transfer it to the LRU.
-		 */
-		if (refcount_dec_not_one(&nf->nf_ref))
-			return;
-
-		/* Try to add it to the LRU.  If that fails, decrement. */
-		if (nfsd_file_lru_add(nf)) {
-			nfsd_file_schedule_laundrette();
-			return;
-		}
-
+		set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+		set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
 	}
+
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
 }
@@ -510,13 +499,12 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	}
 
 	/*
-	 * Put the reference held on behalf of the LRU. If it wasn't the last
-	 * one, then just remove it from the LRU and ignore it.
+	 * Put the reference held on behalf of the LRU if it is the last
+	 * reference, else rotate.
 	 */
-	if (!refcount_dec_and_test(&nf->nf_ref)) {
+	if (!refcount_dec_if_one(&nf->nf_ref)) {
 		trace_nfsd_file_gc_in_use(nf);
-		list_lru_isolate(lru, &nf->nf_lru);
-		return LRU_REMOVED;
+		return LRU_ROTATE;
 	}
 
 	/* Refcount went to zero. Unhash it and queue it to the dispose list */
@@ -1046,16 +1034,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 	nf = nfsd_file_lookup_locked(net, current_cred(), inode, need, want_gc);
 	rcu_read_unlock();
 
-	if (nf) {
-		/*
-		 * If the nf is on the LRU then it holds an extra reference
-		 * that must be put if it's removed. It had better not be
-		 * the last one however, since we should hold another.
-		 */
-		if (nfsd_file_lru_remove(nf))
-			refcount_dec(&nf->nf_ref);
+	if (nf)
 		goto wait_for_construction;
-	}
 
 	new = nfsd_file_alloc(net, inode, need, want_gc);
 	if (!new) {
@@ -1149,6 +1129,9 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 	 */
 	if (status != nfs_ok || inode->i_nlink == 0)
 		nfsd_file_unhash(nf);
+	else if (want_gc)
+		nfsd_file_lru_add(nf);
+
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	if (status == nfs_ok)
 		goto out;
-- 
2.47.1


