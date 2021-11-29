Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C859460E32
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 05:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbhK2E7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 23:59:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbhK2E5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 23:57:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6A8F212BC;
        Mon, 29 Nov 2021 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638161588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55eU6IUmMGnMWDSrM7QS/etQjMpj5mfpzAQJ988Ay8s=;
        b=1qzwSM/st+Nu8pVhK1O9W0+QeHgn6fEDqlonRY6UF9QjHrO033z8vdDy23k9ROgwJ90PGC
        0ng1mSZOaeBZSNtWbcP65z3nlUVQbfJRWj1NJWf3A4UFGImY565kNKFKMoTUHy0Vz+FLUq
        66bxnKO1mg5xAjK0tXGcKuuPmDzk3Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638161588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55eU6IUmMGnMWDSrM7QS/etQjMpj5mfpzAQJ988Ay8s=;
        b=4u0vZ5ExNe8VdpzhY9i9SztKWvx4tBpq7q+BMxvQKZmvShNSsfJeB8GNntB8iEk5lnB5GT
        PxYShfLdXN8D8XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9070C133FE;
        Mon, 29 Nov 2021 04:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pC1iE7NcpGEGbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 04:53:07 +0000
Subject: [PATCH 07/20] NFSD: narrow nfsd_mutex protection in nfsd thread
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:51:25 +1100
Message-ID: <163816148556.32298.7308512506129152207.stgit@noble.brown>
In-Reply-To: <163816133466.32298.13831616524908720974.stgit@noble.brown>
References: <163816133466.32298.13831616524908720974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is nothing happening in the start of nfsd() that requires
protection by the mutex, so don't take it until shutting down the thread
- which does still require protection - but only for nfsd_put().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e9c9fa820b17..097abd8b059c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -932,9 +932,6 @@ nfsd(void *vrqstp)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int err;
 
-	/* Lock module and set up kernel thread */
-	mutex_lock(&nfsd_mutex);
-
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
 	 * umask as defined by the client instead of init's umask. */
@@ -954,7 +951,6 @@ nfsd(void *vrqstp)
 	allow_signal(SIGINT);
 	allow_signal(SIGQUIT);
 
-	mutex_unlock(&nfsd_mutex);
 	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
@@ -983,7 +979,6 @@ nfsd(void *vrqstp)
 	flush_signals(current);
 
 	atomic_dec(&nfsdstats.th_cnt);
-	mutex_lock(&nfsd_mutex);
 
 out:
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
@@ -995,10 +990,11 @@ nfsd(void *vrqstp)
 	svc_exit_thread(rqstp);
 
 	/* Now if needed we call svc_destroy in appropriate context */
+	mutex_lock(&nfsd_mutex);
 	nfsd_put(net);
+	mutex_unlock(&nfsd_mutex);
 
 	/* Release module */
-	mutex_unlock(&nfsd_mutex);
 	module_put_and_exit(0);
 	return 0;
 }


