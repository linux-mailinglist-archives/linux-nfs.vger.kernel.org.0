Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D57D74A4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJYTrk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTrj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 15:47:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1693
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 12:47:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FD6E2199B;
        Wed, 25 Oct 2023 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698263251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gljzIdmLP8BYQ/heFOwqk/coLY1U9+Mw6Vt9T9/FimM=;
        b=xsCct/GxlU9A8YHYCOVncSFFNdy2vAHxlNgetB5p8SzdSnoZeJovC3j6SVcSyb+Nc0Huhp
        kRjd8btDRdOtDcwJUFgKcw84aoqOyf7sKqxyVWB01MVmyHxh8kBpkng/MIbdDTkE8KPfh4
        xOTP2FPdAjFoKbn4OJPcjyaVyxmrb+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698263251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gljzIdmLP8BYQ/heFOwqk/coLY1U9+Mw6Vt9T9/FimM=;
        b=tNPfnzpmt/2KRl9uQNsa9zh3bY7QdNrys3TAtw8MdJaC8pGqCP8sQocD+VSvRdELq8JYh0
        Bx/SWmS7hw6MYvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFFC313A9B;
        Wed, 25 Oct 2023 19:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2L9ML9JwOWVwFQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 19:47:30 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
Subject: [PATCH 3/3] support/backend_sqlite.c: Add getrandom() fallback
Date:   Wed, 25 Oct 2023 21:47:01 +0200
Message-ID: <20231025194701.456031-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025194701.456031-1-pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.82
X-Spamd-Result: default: False [0.82 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.08)[63.94%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Allow to compile reexport on systems with older libc. (getrandom()
wrapper is supported on glibc 2.25+ and  musl 1.1.20+, uclibc-ng does
not yet support it).

getrandom() syscall is supported Linux 3.17+ (old enough to bother with
a check).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile.am                       |  1 +
 aclocal/getrandom.m4              | 16 ++++++++++++++++
 configure.ac                      |  3 +++
 support/reexport/backend_sqlite.c | 18 +++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 aclocal/getrandom.m4

diff --git a/Makefile.am b/Makefile.am
index 00220842..72ad4ba7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -10,6 +10,7 @@ EXTRA_DIST = \
 	autogen.sh \
 	\
 	aclocal/bsdsignals.m4 \
+	aclocal/getrandom.m4 \
 	aclocal/nfs-utils.m4 \
 	aclocal/kerberos5.m4 \
 	aclocal/tcp-wrappers.m4 \
diff --git a/aclocal/getrandom.m4 b/aclocal/getrandom.m4
new file mode 100644
index 00000000..bc0fe16a
--- /dev/null
+++ b/aclocal/getrandom.m4
@@ -0,0 +1,16 @@
+dnl Checks for getrandom support (glibc 2.25+, musl 1.1.20+)
+dnl
+AC_DEFUN([AC_GETRANDOM], [
+    AC_MSG_CHECKING(for getrandom())
+    AC_LINK_IFELSE(
+		[AC_LANG_PROGRAM([[
+		   #include <stdlib.h>  /* for NULL */
+		   #include <sys/random.h>
+		]],
+		[[ return getrandom(NULL, 0U, 0U); ]] )],
+		[AC_DEFINE([HAVE_GETRANDOM], [1], [Define to 1 if you have the `getrandom' function.])
+		AC_MSG_RESULT([yes])],
+		[AC_MSG_RESULT([no])])
+
+	AC_SUBST(HAVE_GETRANDOM)
+])
diff --git a/configure.ac b/configure.ac
index 6fbcb974..4bff679d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -277,6 +277,9 @@ AC_TCP_WRAPPERS
 # Arrange for large-file support
 AC_SYS_LARGEFILE
 
+dnl Check for getrandom() libc support
+AC_GETRANDOM
+
 AC_CONFIG_SRCDIR([support/include/config.h.in])
 AC_CONFIG_HEADERS([support/include/config.h])
 
diff --git a/support/reexport/backend_sqlite.c b/support/reexport/backend_sqlite.c
index 132f30c4..0eb5ea37 100644
--- a/support/reexport/backend_sqlite.c
+++ b/support/reexport/backend_sqlite.c
@@ -7,9 +7,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/random.h>
 #include <unistd.h>
 
+#ifdef HAVE_GETRANDOM
+# include <sys/random.h>
+# if !defined(SYS_getrandom) && defined(__NR_getrandom)
+   /* usable kernel-headers, but old glibc-headers */
+#  define SYS_getrandom __NR_getrandom
+# endif
+#endif
+
 #include "conffile.h"
 #include "reexport_backend.h"
 #include "xlog.h"
@@ -20,6 +27,15 @@
 static sqlite3 *db;
 static int init_done;
 
+#if !defined(HAVE_GETRANDOM) && defined(SYS_getrandom)
+/* libc without function, but we have syscall */
+static int getrandom(void *buf, size_t buflen, unsigned int flags)
+{
+	return (syscall(SYS_getrandom, buf, buflen, flags));
+}
+# define HAVE_GETRANDOM
+#endif
+
 static int prng_init(void)
 {
 	int seed;
-- 
2.42.0

