Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245827F0AAA
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKTCyb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTCyb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:54:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DAF12D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:54:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DF4321858;
        Mon, 20 Nov 2023 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700448866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ujCpSqXyTsqhBoQkSmE+Q95IYCKPGRDdrjsq8wkLkI=;
        b=nGX7cGuuC9UkYAXsIRIYas/MDZrU/dxCJt3onvgIYQHj9Se/l85rHD0uustnySH4RaxRFX
        KNS4dwe23dl4Llv/CyRBD612wvtGuqjeyHj69lAdanNIJ1J9JRmhGSKlqwtsZDIu3wSjJm
        zpFsKCsJWibwtPyiE6LIzIjyzLuzdqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700448866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ujCpSqXyTsqhBoQkSmE+Q95IYCKPGRDdrjsq8wkLkI=;
        b=9XQg11tMaLcCbGiZsVGifVpr8/tqsbrRkgJInvgLVCFXjDNjY53UzEAhP0YozD4KIkou8/
        OEoGDkinfXfoETDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D9F4138E3;
        Mon, 20 Nov 2023 02:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dE0aNGDKWmXFQQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 20 Nov 2023 02:54:24 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] conffile: don't report error from conf_init_file()
Date:   Mon, 20 Nov 2023 13:52:27 +1100
Message-ID: <20231120025354.17511-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120025354.17511-1-neilb@suse.de>
References: <20231120025354.17511-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 8.40
X-Spamd-Result: default: False [8.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

conf_init_file() currently reports an error if the main config file
doesn't exist - even if there are conf files in the conf.d directory.

This is only used by nfsconfcli.c.  However this is not needed.  If
there is a real error, and error message is already logged.
If it is simply that the file doesn't exist, that isn't really an error.

So remove the error messages and change conf_init_file() to not return
any status.

Also fix up assorted nearby white-space issues.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/include/conffile.h |  2 +-
 support/nfs/conffile.c     | 32 ++++++++++++++------------------
 tools/nfsconf/nfsconfcli.c | 15 ++-------------
 3 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/support/include/conffile.h b/support/include/conffile.h
index c4a3ca62860e..c04cd1ec5c0c 100644
--- a/support/include/conffile.h
+++ b/support/include/conffile.h
@@ -62,7 +62,7 @@ extern char    *conf_get_str(const char *, const char *);
 extern char    *conf_get_str_with_def(const char *, const char *, char *);
 extern char    *conf_get_section(const char *, const char *, const char *);
 extern char    *conf_get_entry(const char *, const char *, const char *);
-extern int      conf_init_file(const char *);
+extern void     conf_init_file(const char *);
 extern void     conf_cleanup(void);
 extern int      conf_match_num(const char *, const char *, int);
 extern int      conf_remove(int, const char *, const char *);
diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index fd4a17ad4293..6b813dd95147 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -658,7 +658,7 @@ conf_load_file(const char *conf_file)
 	return 0;
 }
 
-static void 
+static void
 conf_init_dir(const char *conf_file)
 {
 	struct dirent **namelist = NULL;
@@ -669,14 +669,14 @@ conf_init_dir(const char *conf_file)
 	dname = malloc(strlen(conf_file) + 3);
 	if (dname == NULL) {
 		xlog(L_WARNING, "conf_init_dir: malloc: %s", strerror(errno));
-		return;	
+		return;
 	}
 	sprintf(dname, "%s.d", conf_file);
 
 	n = scandir(dname, &namelist, NULL, versionsort);
 	if (n < 0) {
 		if (errno != ENOENT) {
-			xlog(L_WARNING, "conf_init_dir: scandir %s: %s", 
+			xlog(L_WARNING, "conf_init_dir: scandir %s: %s",
 				dname, strerror(errno));
 		}
 		free(dname);
@@ -691,7 +691,7 @@ conf_init_dir(const char *conf_file)
 	for (i = 0; i < n; i++ ) {
 		struct dirent *d = namelist[i];
 
-	 	switch (d->d_type) {
+		switch (d->d_type) {
 			case DT_UNKNOWN:
 			case DT_REG:
 			case DT_LNK:
@@ -701,13 +701,13 @@ conf_init_dir(const char *conf_file)
 		}
 		if (*d->d_name == '.')
 			continue;
-		
+
 		fname_len = strlen(d->d_name);
 		path_len = (fname_len + dname_len);
 		if (!fname_len || path_len > PATH_MAX) {
 			xlog(L_WARNING, "conf_init_dir: Too long file name: %s in %s", 
 				d->d_name, dname);
-			continue; 
+			continue;
 		}
 
 		/*
@@ -715,7 +715,7 @@ conf_init_dir(const char *conf_file)
 		 * that end with CONF_FILE_EXT
 		 */
 		if (fname_len <= CONF_FILE_EXT_LEN) {
-			xlog(D_GENERAL, "conf_init_dir: %s: name too short", 
+			xlog(D_GENERAL, "conf_init_dir: %s: name too short",
 				d->d_name);
 			continue;
 		}
@@ -746,31 +746,29 @@ conf_init_dir(const char *conf_file)
 		free(namelist[i]);
 	free(namelist);
 	free(dname);
-	
+
 	return;
 }
 
-int
+void
 conf_init_file(const char *conf_file)
 {
 	unsigned int i;
-	int ret;
 
 	for (i = 0; i < sizeof conf_bindings / sizeof conf_bindings[0]; i++)
 		LIST_INIT (&conf_bindings[i]);
 
 	TAILQ_INIT (&conf_trans_queue);
 
-	if (conf_file == NULL) 
-		conf_file=NFS_CONFFILE;
+	if (conf_file == NULL)
+		conf_file = NFS_CONFFILE;
 
 	/*
-	 * First parse the give config file 
-	 * then parse the config.conf.d directory 
+	 * First parse the give config file
+	 * then parse the config.conf.d directory
 	 * (if it exists)
-	 *
 	 */
-	ret = conf_load_file(conf_file);
+	conf_load_file(conf_file);
 
 	/*
 	 * When the same variable is set in both files
@@ -779,8 +777,6 @@ conf_init_file(const char *conf_file)
 	 * have the final say.
 	 */
 	conf_init_dir(conf_file);
-
-	return ret;
 }
 
 /*
diff --git a/tools/nfsconf/nfsconfcli.c b/tools/nfsconf/nfsconfcli.c
index b2ef96d1c600..bd9d52701aa6 100644
--- a/tools/nfsconf/nfsconfcli.c
+++ b/tools/nfsconf/nfsconfcli.c
@@ -135,19 +135,8 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (mode != MODE_SET && mode != MODE_UNSET) {
-		if (conf_init_file(confpath)) {
-			/* config file was missing or had an error, warn about it */
-			if (verbose || mode != MODE_ISSET) {
-				fprintf(stderr, "Error loading config file %s\n",
-					confpath);
-			}
-
-			/* this isnt fatal for --isset */
-			if (mode != MODE_ISSET)
-				return 1;
-		}
-	}
+	if (mode != MODE_SET && mode != MODE_UNSET)
+		conf_init_file(confpath);
 
 	/* --dump mode, output the current configuration */
 	if (mode == MODE_DUMP) {
-- 
2.42.0

