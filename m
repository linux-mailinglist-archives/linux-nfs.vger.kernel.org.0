Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45507D284F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjJWCMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjJWCMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:12:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9EF8E
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:11:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF85E1FE05;
        Mon, 23 Oct 2023 02:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+tJrpWVDJJ7KETSa91IT4Yko+pzXy4M/FqN16u/imA=;
        b=s5LsyowArzqA8jhivPkChCZo47Ziif6yhlsjuYRwbsSaSV1PQx9dworgojmvuu1oHSrsK/
        rDKhoDv4kHEcmaCGsY7lzNxDF05YzdUY6HPgHaV5zn8efU3psM5+SqAwAZNZmCUmCqSgyC
        U+BwDJR8bsIvaWrfgZmmiJa329kMjOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+tJrpWVDJJ7KETSa91IT4Yko+pzXy4M/FqN16u/imA=;
        b=9LY8056gLdOPZckx/ThPj7qOa7rcXyTMj9p6Iv9QcEvVDKisdvBCchyE162cxWlTab9cSX
        57mZlbYlpeHL7lBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C925132FD;
        Mon, 23 Oct 2023 02:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QpwwCWrWNWV2bwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:54 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4/6] Move fork_workers() and wait_for_workers() in cache.c
Date:   Mon, 23 Oct 2023 12:58:34 +1100
Message-ID: <20231023021052.5258-5-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
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
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both mountd and exported have fork_workers() and wait_for_workers()
which are nearly identical.
Move this code into cache.c (adding a cache_ prefix to the function
names) and leave the minor differences in the two callers.

Also remove duplicate declarations from mountd.h.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/cache.c  | 75 ++++++++++++++++++++++++++++++++-
 support/export/export.h |  2 +
 utils/exportd/exportd.c | 90 ++++++----------------------------------
 utils/mountd/mountd.c   | 91 ++++++-----------------------------------
 utils/mountd/mountd.h   |  9 ----
 5 files changed, 99 insertions(+), 168 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 5307f6c8d872..1874156af5e5 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1,10 +1,9 @@
-
 /*
  * Handle communication with knfsd internal cache
  *
  * We open /proc/net/rpc/{auth.unix.ip,nfsd.export,nfsd.fh}/channel
  * and listen for requests (using my_svc_run)
- * 
+ *
  */
 
 #ifdef HAVE_CONFIG_H
@@ -16,6 +15,7 @@
 #include <sys/select.h>
 #include <sys/stat.h>
 #include <sys/vfs.h>
+#include <sys/wait.h>
 #include <time.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
@@ -1775,3 +1775,74 @@ cache_get_filehandle(nfs_export *exp, int len, char *p)
 	fh.fh_size = qword_get(&bp, (char *)fh.fh_handle, NFS3_FHSIZE);
 	return &fh;
 }
+
+/* Wait for all worker child processes to exit and reap them */
+void
+cache_wait_for_workers(char *prog)
+{
+	int status;
+	pid_t pid;
+
+	for (;;) {
+
+		pid = waitpid(0, &status, 0);
+
+		if (pid < 0) {
+			if (errno == ECHILD)
+				return; /* no more children */
+			xlog(L_FATAL, "%s: can't wait: %s\n", prog,
+					strerror(errno));
+		}
+
+		/* Note: because we SIG_IGN'd SIGCHLD earlier, this
+		 * does not happen on 2.6 kernels, and waitpid() blocks
+		 * until all the children are dead then returns with
+		 * -ECHILD.  But, we don't need to do anything on the
+		 * death of individual workers, so we don't care. */
+		xlog(L_NOTICE, "%s: reaped child %d, status %d\n",
+		     prog, (int)pid, status);
+	}
+}
+
+/* Fork num_threads worker children and wait for them */
+int
+cache_fork_workers(char *prog, int num_threads)
+{
+	int i;
+	pid_t pid;
+
+	if (num_threads <= 1)
+		return 1;
+
+	xlog(L_NOTICE, "%s: starting %d threads\n", prog, num_threads);
+
+	for (i = 0 ; i < num_threads ; i++) {
+		pid = fork();
+		if (pid < 0) {
+			xlog(L_FATAL, "%s: cannot fork: %s\n", prog,
+					strerror(errno));
+		}
+		if (pid == 0) {
+			/* worker child */
+
+			/* Re-enable the default action on SIGTERM et al
+			 * so that workers die naturally when sent them.
+			 * Only the parent unregisters with pmap and
+			 * hence needs to do special SIGTERM handling. */
+			struct sigaction sa;
+			sa.sa_handler = SIG_DFL;
+			sa.sa_flags = 0;
+			sigemptyset(&sa.sa_mask);
+			sigaction(SIGHUP, &sa, NULL);
+			sigaction(SIGINT, &sa, NULL);
+			sigaction(SIGTERM, &sa, NULL);
+
+			/* fall into my_svc_run in caller */
+			return 1;
+		}
+	}
+
+	/* in parent */
+	cache_wait_for_workers(prog);
+	return 0;
+}
diff --git a/support/export/export.h b/support/export/export.h
index 8d5a0d3004ef..ce561f9fbd3e 100644
--- a/support/export/export.h
+++ b/support/export/export.h
@@ -29,6 +29,8 @@ int		v4clients_process(fd_set *fdset);
 struct nfs_fh_len *
 		cache_get_filehandle(nfs_export *exp, int len, char *p);
 int		cache_export(nfs_export *exp, char *path);
+int		cache_fork_workers(char *prog, int num_threads);
+void		cache_wait_for_workers(char *prog);
 
 bool ipaddr_client_matches(nfs_export *exp, struct addrinfo *ai);
 bool namelist_client_matches(nfs_export *exp, char *dom);
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 6f866445efc2..d07a885c6763 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -16,7 +16,6 @@
 #include <string.h>
 #include <getopt.h>
 #include <errno.h>
-#include <wait.h>
 
 #include "nfslib.h"
 #include "conffile.h"
@@ -54,90 +53,19 @@ static char shortopts[] = "d:fghs:t:liT:";
  */
 inline static void set_signals(void);
 
-/* Wait for all worker child processes to exit and reap them */
-static void
-wait_for_workers (void)
-{
-	int status;
-	pid_t pid;
-
-	for (;;) {
-
-		pid = waitpid(0, &status, 0);
-
-		if (pid < 0) {
-			if (errno == ECHILD)
-				return; /* no more children */
-			xlog(L_FATAL, "mountd: can't wait: %s\n",
-					strerror(errno));
-		}
-
-		/* Note: because we SIG_IGN'd SIGCHLD earlier, this
-		 * does not happen on 2.6 kernels, and waitpid() blocks
-		 * until all the children are dead then returns with
-		 * -ECHILD.  But, we don't need to do anything on the
-		 * death of individual workers, so we don't care. */
-		xlog(L_NOTICE, "mountd: reaped child %d, status %d\n",
-				(int)pid, status);
-	}
-}
-
 inline void
 cleanup_lockfiles (void)
 {
 	unlink(etab.lockfn);
 }
 
-/* Fork num_threads worker children and wait for them */
 static void
-fork_workers(void)
-{
-	int i;
-	pid_t pid;
-
-	xlog(L_NOTICE, "mountd: starting %d threads\n", num_threads);
-
-	for (i = 0 ; i < num_threads ; i++) {
-		pid = fork();
-		if (pid < 0) {
-			xlog(L_FATAL, "mountd: cannot fork: %s\n",
-					strerror(errno));
-		}
-		if (pid == 0) {
-			/* worker child */
-
-			/* Re-enable the default action on SIGTERM et al
-			 * so that workers die naturally when sent them.
-			 * Only the parent unregisters with pmap and
-			 * hence needs to do special SIGTERM handling. */
-			struct sigaction sa;
-			sa.sa_handler = SIG_DFL;
-			sa.sa_flags = 0;
-			sigemptyset(&sa.sa_mask);
-			sigaction(SIGHUP, &sa, NULL);
-			sigaction(SIGINT, &sa, NULL);
-			sigaction(SIGTERM, &sa, NULL);
-
-			/* fall into my_svc_run in caller */
-			return;
-		}
-	}
-
-	/* in parent */
-	wait_for_workers();
-	cleanup_lockfiles();
-	free_state_path_names(&etab);
-	xlog(L_NOTICE, "exportd: no more workers, exiting\n");
-	exit(0);
-}
-
-static void 
 killer (int sig)
 {
 	if (num_threads > 1) {
 		/* play Kronos and eat our children */
 		kill(0, SIGTERM);
-		wait_for_workers();
+		cache_wait_for_workers("exportd");
 	}
 	cleanup_lockfiles();
 	free_state_path_names(&etab);
@@ -145,6 +73,7 @@ killer (int sig)
 
 	exit(0);
 }
+
 static void
 sig_hup (int UNUSED(sig))
 {
@@ -152,8 +81,9 @@ sig_hup (int UNUSED(sig))
 	xlog (L_NOTICE, "Received SIGHUP... Ignoring.\n");
 	return;
 }
-inline static void 
-set_signals(void) 
+
+inline static void
+set_signals(void)
 {
 	struct sigaction sa;
 
@@ -295,9 +225,13 @@ main(int argc, char **argv)
 	 */
 	cache_open();
 
-	if (num_threads > 1)
-		fork_workers();
-
+	if (cache_fork_workers(progname, num_threads) == 0) {
+		/* We forked, waited, and now need to clean up */
+		cleanup_lockfiles();
+		free_state_path_names(&etab);
+		xlog(L_NOTICE, "%s: no more workers, exiting\n", progname);
+		exit(0);
+	}
 
 	v4clients_init();
 
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index f9c62cded66c..dbd5546df61c 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -21,7 +21,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 
 #include "conffile.h"
 #include "xmalloc.h"
@@ -119,90 +118,17 @@ cleanup_lockfiles (void)
 	unlink(rmtab.lockfn);
 }
 
-/* Wait for all worker child processes to exit and reap them */
-static void
-wait_for_workers (void)
-{
-	int status;
-	pid_t pid;
-
-	for (;;) {
-
-		pid = waitpid(0, &status, 0);
-
-		if (pid < 0) {
-			if (errno == ECHILD)
-				return; /* no more children */
-			xlog(L_FATAL, "mountd: can't wait: %s\n",
-					strerror(errno));
-		}
-
-		/* Note: because we SIG_IGN'd SIGCHLD earlier, this
-		 * does not happen on 2.6 kernels, and waitpid() blocks
-		 * until all the children are dead then returns with
-		 * -ECHILD.  But, we don't need to do anything on the
-		 * death of individual workers, so we don't care. */
-		xlog(L_NOTICE, "mountd: reaped child %d, status %d\n",
-				(int)pid, status);
-	}
-}
-
-/* Fork num_threads worker children and wait for them */
-static void
-fork_workers(void)
-{
-	int i;
-	pid_t pid;
-
-	xlog(L_NOTICE, "mountd: starting %d threads\n", num_threads);
-
-	for (i = 0 ; i < num_threads ; i++) {
-		pid = fork();
-		if (pid < 0) {
-			xlog(L_FATAL, "mountd: cannot fork: %s\n",
-					strerror(errno));
-		}
-		if (pid == 0) {
-			/* worker child */
-
-			/* Re-enable the default action on SIGTERM et al
-			 * so that workers die naturally when sent them.
-			 * Only the parent unregisters with pmap and
-			 * hence needs to do special SIGTERM handling. */
-			struct sigaction sa;
-			sa.sa_handler = SIG_DFL;
-			sa.sa_flags = 0;
-			sigemptyset(&sa.sa_mask);
-			sigaction(SIGHUP, &sa, NULL);
-			sigaction(SIGINT, &sa, NULL);
-			sigaction(SIGTERM, &sa, NULL);
-
-			/* fall into my_svc_run in caller */
-			return;
-		}
-	}
-
-	/* in parent */
-	wait_for_workers();
-	unregister_services();
-	cleanup_lockfiles();
-	free_state_path_names(&etab);
-	free_state_path_names(&rmtab);
-	xlog(L_NOTICE, "mountd: no more workers, exiting\n");
-	exit(0);
-}
-
 /*
  * Signal handler.
  */
-static void 
+static void
 killer (int sig)
 {
 	unregister_services();
 	if (num_threads > 1) {
 		/* play Kronos and eat our children */
 		kill(0, SIGTERM);
-		wait_for_workers();
+		cache_wait_for_workers("mountd");
 	}
 	cleanup_lockfiles();
 	free_state_path_names(&etab);
@@ -220,7 +146,7 @@ sig_hup (int UNUSED(sig))
 }
 
 bool_t
-mount_null_1_svc(struct svc_req *rqstp, void *UNUSED(argp), 
+mount_null_1_svc(struct svc_req *rqstp, void *UNUSED(argp),
 	void *UNUSED(resp))
 {
 	struct sockaddr *sap = nfs_getrpccaller(rqstp->rq_xprt);
@@ -922,8 +848,15 @@ main(int argc, char **argv)
 	 */
 	cache_open();
 
-	if (num_threads > 1)
-		fork_workers();
+	if (cache_fork_workers("mountd", num_threads) == 0) {
+		/* We forked, waited, and now need to clean up */
+		unregister_services();
+		cleanup_lockfiles();
+		free_state_path_names(&etab);
+		free_state_path_names(&rmtab);
+		xlog(L_NOTICE, "mountd: no more workers, exiting\n");
+		exit(0);
+	}
 
 	nfsd_path_init();
 	v4clients_init();
diff --git a/utils/mountd/mountd.h b/utils/mountd/mountd.h
index d30775313f66..bd5c9576d8ad 100644
--- a/utils/mountd/mountd.h
+++ b/utils/mountd/mountd.h
@@ -51,13 +51,4 @@ void		mountlist_del(char *host, const char *path);
 void		mountlist_del_all(const struct sockaddr *sap);
 mountlist	mountlist_list(void);
 
-void		cache_open(void);
-struct nfs_fh_len *
-		cache_get_filehandle(nfs_export *exp, int len, char *p);
-int		cache_export(nfs_export *exp, char *path);
-
-bool ipaddr_client_matches(nfs_export *exp, struct addrinfo *ai);
-bool namelist_client_matches(nfs_export *exp, char *dom);
-bool client_matches(nfs_export *exp, char *dom, struct addrinfo *ai);
-
 #endif /* MOUNTD_H */
-- 
2.42.0

