Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1D4599C0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhKWBe0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:34:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57862 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:34:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 392C4218B2;
        Tue, 23 Nov 2021 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vySanz2YXVqdMC84ngImA7vDUMvb5gO7Kz71f8EfliM=;
        b=N2RXzx9tkbrMN5ewG5am9NKKryE4BZRDj46jU9zvpucDmC/wJEO7Ka9xf1lBbwsU8QfMFQ
        xr8x4lGcofUtLOza144Cr/CscZ04NEp3+Pvs84o63wkTX4VarcMdN3HMphjWdhDkSXE/1a
        W/YFZ0/GNEE4Udv6nwHVJ9rdmv+jZ5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vySanz2YXVqdMC84ngImA7vDUMvb5gO7Kz71f8EfliM=;
        b=72UO+SHH0lFUnGCCHc+m/nIc5FGmJQC9X1ZxcfR6iRRhHFOZaIo02Y4NVOrp5frorXlcAI
        uyXVLhCAEJpRoxBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 159DA13BD4;
        Tue, 23 Nov 2021 01:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8L8xMGREnGHIcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:31:16 +0000
Subject: [PATCH 04/19] nfsd: make nfsd_stats.th_cnt atomic_t
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097544.7284.7451205698169106567.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
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
index 5f605e7e8091..fc5899502a83 100644
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
@@ -955,8 +955,8 @@ nfsd(void *vrqstp)
 	allow_signal(SIGINT);
 	allow_signal(SIGQUIT);
 
-	nfsdstats.th_cnt++;
 	mutex_unlock(&nfsd_mutex);
+	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
 
@@ -983,8 +983,8 @@ nfsd(void *vrqstp)
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


