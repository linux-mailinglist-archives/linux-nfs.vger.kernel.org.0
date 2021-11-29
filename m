Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4297460E2C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbhK2E6S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:58:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60100 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbhK2E4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:56:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDAFA2170E;
        Mon, 29 Nov 2021 04:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vySanz2YXVqdMC84ngImA7vDUMvb5gO7Kz71f8EfliM=;
        b=xrhqA5a1ygyZBooQ8NU2LWFao3wUV4T7/ba9WFXPJALle0d9fzrRq7V1N6NFYi6SUMhrgR
        FSSv0h3pnCKYz3hiUOVJwI8246rV6NXGv5yCqY3Twy+Q+kY0lLS9ruMh+Mn0/1+SwktHmQ
        nLvMgxt30yHuhF00kh/JCoy9oYlHojo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vySanz2YXVqdMC84ngImA7vDUMvb5gO7Kz71f8EfliM=;
        b=Q6vv5HPNJE2vpU/4BlgCbQ/Frjc1pVDcxdv08xe1NYgSNwce8YmhqkvtcJZCL6ygpYYUnn
        H4OcgqBC2bzPeVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2FA0133FE;
        Mon, 29 Nov 2021 04:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ry8XI6pcpGHybgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:52:58 +0000
Subject: [PATCH 05/20] nfsd: make nfsd_stats.th_cnt atomic_t
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148555.32298.5422275287728622222.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
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


