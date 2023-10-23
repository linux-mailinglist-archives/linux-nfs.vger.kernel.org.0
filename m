Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5D7D2850
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjJWCMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjJWCMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:12:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89654135
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:12:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26F1E21A7F;
        Mon, 23 Oct 2023 02:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzwlzp/M6AhoIJULxUZ0rApD1agxj3RFV36T21E6jWo=;
        b=js/bYquh0SKd8RYixV17Wr23vmY62P3NO+N3BOki2JQTeWq7i+ZdiwtRGDMy4LfpELBrdL
        ato60a+9NV48ZOM2VDPE7C6A8InyB3a6BTdrI9KRwZZrecQSfdKtUWx2XaP/f8NlwQEsy7
        iHhpIGcXcHVk/fj17vvXnhMMwCnBit4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzwlzp/M6AhoIJULxUZ0rApD1agxj3RFV36T21E6jWo=;
        b=wYphfpHlfRJBHSzxyeYijKioz1HOcxpZm3vwqFyuwun4RoBGclMmZ34hG+yEu+S900l0CL
        6a++kpmreG08IaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEABF132FD;
        Mon, 23 Oct 2023 02:11:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jfIMKW/WNWWHbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:59 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5/6] Share process_loop code between mountd and exportd.
Date:   Mon, 23 Oct 2023 12:58:35 +1100
Message-ID: <20231023021052.5258-6-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.61
X-Spamd-Result: default: False [0.61 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.29)[74.73%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is substantial commonality between cache_process_loop() used by
exportd and my_svc_run() used by mountd.

Remove the looping from cache_process_loop() renaming it to
cache_process() and call it in a loop from exportd.
my_svc_run() now calls cache_process() for all the common functionality
and adds code specific to being an RPC server.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c  | 49 +++++++++++++++++++++--------------------
 support/export/export.h |  1 +
 utils/exportd/exportd.c |  5 +++--
 utils/mountd/svc_run.c  | 23 ++++---------------
 4 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 1874156af5e5..a01eba4f6619 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1602,40 +1602,41 @@ int cache_process_req(fd_set *readfds)
 }
 
 /**
- * cache_process_loop - process incoming upcalls
+ * cache_process - process incoming upcalls
+ * Returns -ve on error, or number of fds in svc_fds
+ * that might need processing.
  */
-void cache_process_loop(void)
+int cache_process(fd_set *readfds)
 {
-	fd_set	readfds;
+	fd_set fdset;
 	int	selret;
 
-	FD_ZERO(&readfds);
-
-	for (;;) {
-
-		cache_set_fds(&readfds);
-		v4clients_set_fds(&readfds);
-
-		selret = select(FD_SETSIZE, &readfds,
-				(void *) 0, (void *) 0, (struct timeval *) 0);
+	if (!readfds) {
+		FD_ZERO(&fdset);
+		readfds = &fdset;
+	}
+	cache_set_fds(readfds);
+	v4clients_set_fds(readfds);
 
+	selret = select(FD_SETSIZE, readfds,
+			(void *) 0, (void *) 0, (struct timeval *) 0);
 
-		switch (selret) {
-		case -1:
-			if (errno == EINTR || errno == ECONNREFUSED
-			 || errno == ENETUNREACH || errno == EHOSTUNREACH)
-				continue;
-			xlog(L_ERROR, "my_svc_run() - select: %m");
-			return;
+	switch (selret) {
+	case -1:
+		if (errno == EINTR || errno == ECONNREFUSED
+		    || errno == ENETUNREACH || errno == EHOSTUNREACH)
+			return 0;
+		return -1;
 
-		default:
-			cache_process_req(&readfds);
-			v4clients_process(&readfds);
-		}
+	default:
+		selret -= cache_process_req(readfds);
+		selret -= v4clients_process(readfds);
+		if (selret < 0)
+			selret = 0;
 	}
+	return selret;
 }
 
-
 /*
  * Give IP->domain and domain+path->options to kernel
  * % echo nfsd $IP  $[now+DEFAULT_TTL] $domain > /proc/net/rpc/auth.unix.ip/channel
diff --git a/support/export/export.h b/support/export/export.h
index ce561f9fbd3e..e2009ccdc443 100644
--- a/support/export/export.h
+++ b/support/export/export.h
@@ -31,6 +31,7 @@ struct nfs_fh_len *
 int		cache_export(nfs_export *exp, char *path);
 int		cache_fork_workers(char *prog, int num_threads);
 void		cache_wait_for_workers(char *prog);
+int		cache_process(fd_set *readfds);
 
 bool ipaddr_client_matches(nfs_export *exp, struct addrinfo *ai);
 bool namelist_client_matches(nfs_export *exp, char *dom);
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index d07a885c6763..a2e370ac506f 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -236,9 +236,10 @@ main(int argc, char **argv)
 	v4clients_init();
 
 	/* Process incoming upcalls */
-	cache_process_loop();
+	while (cache_process(NULL) >= 0)
+		;
 
-	xlog(L_ERROR, "%s: process loop terminated unexpectedly. Exiting...\n",
+	xlog(L_ERROR, "%s: process loop terminated unexpectedly(%m). Exiting...\n",
 		progname);
 
 	free_state_path_names(&etab);
diff --git a/utils/mountd/svc_run.c b/utils/mountd/svc_run.c
index 167b9757bde2..2aaf3756bbb1 100644
--- a/utils/mountd/svc_run.c
+++ b/utils/mountd/svc_run.c
@@ -97,28 +97,13 @@ my_svc_run(void)
 	int	selret;
 
 	for (;;) {
-
 		readfds = svc_fdset;
-		cache_set_fds(&readfds);
-		v4clients_set_fds(&readfds);
-
-		selret = select(FD_SETSIZE, &readfds,
-				(void *) 0, (void *) 0, (struct timeval *) 0);
-
-
-		switch (selret) {
-		case -1:
-			if (errno == EINTR || errno == ECONNREFUSED
-			 || errno == ENETUNREACH || errno == EHOSTUNREACH)
-				continue;
+		selret = cache_process(&readfds);
+		if (selret < 0) {
 			xlog(L_ERROR, "my_svc_run() - select: %m");
 			return;
-
-		default:
-			selret -= cache_process_req(&readfds);
-			selret -= v4clients_process(&readfds);
-			if (selret)
-				svc_getreqset(&readfds);
 		}
+		if (selret)
+			svc_getreqset(&readfds);
 	}
 }
-- 
2.42.0

