Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470FE453D49
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhKQAuX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 19:50:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43342 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhKQAuX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 19:50:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB9131FD29;
        Wed, 17 Nov 2021 00:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637110044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEmpVOUjwETqcUnrx9SSUwolXsOvzVTy5yqH4SFN9o8=;
        b=rVxUOoE/bctt2k66M+wMyV+GjPHH6QTIyeLR2Oln6J34M1n+Rpq1EYrVbRBpo7GTtBLiiO
        7niBmT3ek2CQzntT1NZbAFhTbm6AD1LPowI1c9IFwyX0c2SX78yrBIm0PwAODU1jI3kvTl
        9OfLLOeURFPqJ44eRGPRUthaIBNtXb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637110044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEmpVOUjwETqcUnrx9SSUwolXsOvzVTy5yqH4SFN9o8=;
        b=cBfM44/Ug158i8oHARoZrIUd0cdqlMQE7EItITr8VKVFgAQD0tORVJn893C98k01D7pBb1
        uv2e3t0RXESDxSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC82F13BC1;
        Wed, 17 Nov 2021 00:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wfJ2JhtRlGE+WgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 00:47:23 +0000
Subject: [PATCH 03/14] NFSD: narrow nfsd_mutex protection in nfsd thread
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 17 Nov 2021 11:46:50 +1100
Message-ID: <163711001002.5485.16884237807627303217.stgit@noble.brown>
In-Reply-To: <163710954700.5485.5622638225352156964.stgit@noble.brown>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is nothing happening in the start of nfsd() that requires
protection by the mutex, so don't take it until shutting down the thread
- which does still require protection.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3c6e4faac3c3..9e517ddd8d4e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -934,9 +934,6 @@ nfsd(void *vrqstp)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int err;
 
-	/* Lock module and set up kernel thread */
-	mutex_lock(&nfsd_mutex);
-
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
 	 * umask as defined by the client instead of init's umask. */
@@ -956,7 +953,6 @@ nfsd(void *vrqstp)
 	allow_signal(SIGINT);
 	allow_signal(SIGQUIT);
 
-	mutex_unlock(&nfsd_mutex);
 	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
@@ -985,9 +981,9 @@ nfsd(void *vrqstp)
 	flush_signals(current);
 
 	atomic_dec(&nfsdstats.th_cnt);
-	mutex_lock(&nfsd_mutex);
 
 out:
+	mutex_lock(&nfsd_mutex);
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
 	 * doesn't call svc_destroy()
 	 */


