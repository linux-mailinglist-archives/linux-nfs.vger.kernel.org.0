Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D35453D48
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhKQAuT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43334 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAuS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 605A61FCA3;
        Wed, 17 Nov 2021 00:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dogf4KV5xBmJdtHS3MuDs43xue9VGYJ2HwovmWJcUcA=;
        b=Z/Zu3gFI3e/xLy9QSXgcbmsD5JpMFENUFHXtoRciseT4nUwivuE7nV5P9Vjx4O+usXPn4K
        6EN6DY/sXxSpSEGAbbrwjlrt4jhQOSGkesMjFpFn5pQEeWAozW4vvD0PzdQPvk6jq7qH5p
        ECTtH1lr20/5GidlqkEgnzF62Pf9gig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dogf4KV5xBmJdtHS3MuDs43xue9VGYJ2HwovmWJcUcA=;
        b=or0fkFp7e6Z4/gsl8PsaggTonK/gHI/6w9Obc6Vuq2q9xh8Fo1qkhubpA3/4RxIaXJNyjw
        2u2yxs6bP5TVWUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DE5C13BC1;
        Wed, 17 Nov 2021 00:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EG+2AxdRlGEyWgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:19 +0000
Subject: [PATCH 02/14] nfsd: make nfsd_stats.th_cnt atomic_t
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001002.5485.13517095896813251508.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allows us to move the updates for th_cnt out of the mutex.
This is a step towards reducing mutex coverage in nfsd().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c |    6 +++---
 fs/nfsd/stats.c  |    2 +-
 fs/nfsd/stats.h  |    4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1c9505ee4f89..3c6e4faac3c3 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -57,7 +57,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
 /*
  * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and the members
  * of the svc_serv struct. In particular, ->sv_nrthreads but also to some
- * extent ->sv_temp_socks and ->sv_permsocks. It also protects nfsdstats.th_cnt
+ * extent ->sv_temp_socks and ->sv_permsocks.
  *
  * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
  * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
@@ -956,8 +956,8 @@ nfsd(void *vrqstp)
 	allow_signal(SIGINT);
 	allow_signal(SIGQUIT);
 
-	nfsdstats.th_cnt++;
 	mutex_unlock(&nfsd_mutex);
+	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
 
@@ -984,8 +984,8 @@ nfsd(void *vrqstp)
 	/* Clear signals before calling svc_exit_thread() */
 	flush_signals(current);
 
+	atomic_dec(&nfsdstats.th_cnt);
 	mutex_lock(&nfsd_mutex);
-	nfsdstats.th_cnt --;
 
 out:
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 1d3b881e7382..a8c5a02a84f0 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -45,7 +45,7 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
-	seq_printf(seq, "th %u 0", nfsdstats.th_cnt);
+	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
 
 	/* deprecated thread usage histogram stats */
 	for (i = 0; i < 10; i++)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 51ecda852e23..9b43dc3d9991 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -29,11 +29,9 @@ enum {
 struct nfsd_stats {
 	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
 
-	/* Protected by nfsd_mutex */
-	unsigned int	th_cnt;		/* number of available threads */
+	atomic_t	th_cnt;		/* number of available threads */
 };
 
-
 extern struct nfsd_stats	nfsdstats;
 
 extern struct svc_stat		nfsd_svcstats;


