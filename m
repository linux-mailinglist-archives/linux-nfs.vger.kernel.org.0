Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777437DB1CD
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 02:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjJ3BNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 21:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJ3BNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 21:13:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602EBF
        for <linux-nfs@vger.kernel.org>; Sun, 29 Oct 2023 18:13:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD16B218B5;
        Mon, 30 Oct 2023 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698628425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dto3+UrACrlCcXsljWYZDaMqE4bcBMsE2PC5UCt+H3g=;
        b=GsOXJ/4GgjynA+8y/1UyFYlL2ECOB5yDvx8kH3hMa5/IxV6BsnVU/l067hPi+Qf98KekAo
        PsoWDjwZgTtJAwTk5hvw7VlwKy0ykUmbawfd7cW5rHgy21DEBp3eDlv3XV9u3x/Jbmrl7m
        aZIf2YHAJ/Un+ouNpYiDpkxZZ7YcCr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698628425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dto3+UrACrlCcXsljWYZDaMqE4bcBMsE2PC5UCt+H3g=;
        b=NFoZL/okV9SpJ9139DneU0jbtY+g6vqTZAwbxyqSbvHNhoPRQTBeu+nWFgio4j23wNfayF
        7+yWAv8FRhDtOBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9BD513460;
        Mon, 30 Oct 2023 01:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9VcAH0UDP2WWRwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Oct 2023 01:13:41 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 5/5] nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()
Date:   Mon, 30 Oct 2023 12:08:38 +1100
Message-ID: <20231030011247.9794-6-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030011247.9794-1-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As this function now destroys the svc_serv, this is a better name.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 4 ++--
 fs/nfsd/nfsd.h   | 2 +-
 fs/nfsd/nfssvc.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 86cab5281fd2..d603e672d568 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -707,7 +707,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	if (!nn->nfsd_serv->sv_nrthreads &&
 	    list_empty(&nn->nfsd_serv->sv_permsocks))
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 
 	return err;
 }
@@ -754,7 +754,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 out_err:
 	if (!nn->nfsd_serv->sv_nrthreads &&
 	    list_empty(&nn->nfsd_serv->sv_permsocks))
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 
 	return err;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9ed0e08d16c2..304e9728b929 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -148,7 +148,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
-void nfsd_last_thread(struct net *net);
+void nfsd_destroy_serv(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 61a1d966ca48..88c2e2c94829 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -533,7 +533,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-void nfsd_last_thread(struct net *net)
+void nfsd_destroy_serv(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
@@ -555,7 +555,7 @@ void nfsd_last_thread(struct net *net)
 	/*
 	 * write_ports can create the server without actually starting
 	 * any threads--if we get shut down before any threads are
-	 * started, then nfsd_last_thread will be run before any of this
+	 * started, then nfsd_destroy_serv will be run before any of this
 	 * other initialization has been done except the rpcb information.
 	 */
 	svc_rpcb_cleanup(serv, net);
@@ -641,7 +641,7 @@ void nfsd_shutdown_threads(struct net *net)
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
-	nfsd_last_thread(net);
+	nfsd_destroy_serv(net);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -802,7 +802,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = serv->sv_nrthreads;
 out_put:
 	if (serv->sv_nrthreads == 0)
-		nfsd_last_thread(net);
+		nfsd_destroy_serv(net);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
-- 
2.42.0

