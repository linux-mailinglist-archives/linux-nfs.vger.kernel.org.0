Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69CC4D38C5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiCIS2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiCIS2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:34 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C330F4F
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:34 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s207so3498910oie.11
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SObynNw7YBe+H1hb0Ma1wjzgE3CdI080SMoaM+Nrq0I=;
        b=EVTqWkUlLxJdMqkRXa7DIoCoIkVbE7YycglKvYiOmQFbIJE3JDb9INiakHpfVsyz3B
         teIrSI/vIHoV4jSSeC+K41DRoU84ZJtZLginrnrPKcBBni5uZfHghjeTC15MGTrrUrRn
         ChkXOPDwigaBrh/E9H++7pm1kcoW371Jfi9+CTGGSh7CfzPhDs7gpY24tdtoLovs/mXZ
         FcUhxyacLu/cWl+KEKuYilzh58jVuHr5e4AtsMSDBauQo57hEJGc7UR+VmH5ntznugM9
         1rWvK3ra463HH8tY9IkXHk6iLNgDdLItMYJFqrc9ggYPALIH2zm52vqfCiFTquzb3xtE
         i0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SObynNw7YBe+H1hb0Ma1wjzgE3CdI080SMoaM+Nrq0I=;
        b=KgsliNQ9RGSGUCDmp+4ISl1UjVbg6hvD064vG1Hir1xgeyOR/kngvT1zt8SpJAU5aC
         4h31LKW2xOymypRsEIgrP9pTYH/avkXHssJNMOHhv/b6KQsov0TvmF7XgzC2OLgxjIsi
         v3bIrD7I6xJF2cdcsmdSHCDceE9S8tnoZtpIm3xQ/GGPDr8WSgs6A8qDkwvf38CyvFny
         H1kB1MXgqV9RI5cDQh26/LDn+LMaLKO7DkzQ0ZPm7CsW3mLzw0WYEu9UEupTI+gyIIIF
         bVTJFCwXS3NxC7ieR1NjYN6ua1PLPJ2tzk4tprj1T5Zy3TkQYFj6Luksfso80svSC18+
         8Zhg==
X-Gm-Message-State: AOAM5337wGOGkbE1k4b3Dw3c2iHdo0XYS484s5xtJgfObBShWVqe3tTH
        Rzp/SSco3yxXXYhxmQOasZp1ory5VcM=
X-Google-Smtp-Source: ABdhPJw5h+tZDajZTJESvW8rr2uFVhpPGqk0koXACxtnXX939EqnzPG5H/XCoJd2INd6S/NdZVX6Pw==
X-Received: by 2002:a05:6808:ec6:b0:2d2:7782:4f92 with SMTP id q6-20020a0568080ec600b002d277824f92mr560232oiv.31.1646850453986;
        Wed, 09 Mar 2022 10:27:33 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:33 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 5/7] readahead: create the configuration file
Date:   Wed,  9 Mar 2022 15:26:51 -0300
Message-Id: <20220309182653.1885252-6-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

At this stage, the configuration file only accepts the default value.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 .gitignore                               |  5 ++
 configure.ac                             |  3 +
 tools/nfs-readahead-udev/Makefile.am     | 16 ++++-
 tools/nfs-readahead-udev/config_parser.c | 25 ++++++++
 tools/nfs-readahead-udev/config_parser.h | 14 +++++
 tools/nfs-readahead-udev/list.h          | 48 +++++++++++++++
 tools/nfs-readahead-udev/main.c          | 68 ++++++++++++++++++++-
 tools/nfs-readahead-udev/parser.y        | 78 ++++++++++++++++++++++++
 tools/nfs-readahead-udev/readahead.conf  |  1 +
 tools/nfs-readahead-udev/scanner.l       | 14 +++++
 10 files changed, 269 insertions(+), 3 deletions(-)
 create mode 100644 tools/nfs-readahead-udev/config_parser.c
 create mode 100644 tools/nfs-readahead-udev/config_parser.h
 create mode 100644 tools/nfs-readahead-udev/list.h
 create mode 100644 tools/nfs-readahead-udev/parser.y
 create mode 100644 tools/nfs-readahead-udev/readahead.conf
 create mode 100644 tools/nfs-readahead-udev/scanner.l

diff --git a/.gitignore b/.gitignore
index c99269a4..340ee8fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@ aclocal/ltoptions.m4
 aclocal/ltsugar.m4
 aclocal/ltversion.m4
 aclocal/lt~obsolete.m4
+ylwrap
 # files generated by configure
 confdefs.h
 config.cache
@@ -61,7 +62,11 @@ utils/statd/statd
 tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
+tools/nfs-readahead-udev/99-nfs_bdi.rules
 tools/nfs-readahead-udev/nfs-readahead-udev
+tools/nfs-readahead-udev/parser.c
+tools/nfs-readahead-udev/parser.h
+tools/nfs-readahead-udev/scanner.c
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/configure.ac b/configure.ac
index 7e5ba5d9..03cdf8f6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -300,7 +300,10 @@ AC_PROG_INSTALL
 AC_PROG_LN_S
 AC_PROG_MAKE_SET
 AC_PROG_LIBTOOL
+AC_PROG_YACC
 AM_PROG_CC_C_O
+AM_PROG_LEX
+
 
 if test "x$cross_compiling" = "xno"; then
 	CC_FOR_BUILD=${CC_FOR_BUILD-${CC-gcc}}
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 551d22e9..010350aa 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -1,12 +1,24 @@
 libexec_PROGRAMS = nfs-readahead-udev
-nfs_readahead_udev_SOURCES = main.c syslog.c
+BUILT_SOURCES = parser.c parser.h scanner.c
+nfs_readahead_udev_SOURCES = main.c syslog.c config_parser.c parser.y scanner.l
 nfs_readahead_udev_LDFLAGS= -lmount
+AM_YFLAGS = -d
 
-udev_rulesdir = /etc/udev/rules.d
+udev_rulesdir = $(sysconfdir)/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
 
+ra_confdir = $(sysconfdir)
+ra_conf_DATA = readahead.conf
+
 99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
 	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
 
 clean-local:
 	$(RM) 99-nfs_bdi.rules
+	$(RM) parser.c parser.h scanner.c
+
+parser.$(OBJEXT): CFLAGS += -Wno-strict-prototypes
+
+scanner.$(OBJEXT): CFLAGS += -Wno-strict-prototypes
+
+main.$(OBJEXT): CFLAGS += -DSYSCONFDIR=\"@sysconfdir@\"
diff --git a/tools/nfs-readahead-udev/config_parser.c b/tools/nfs-readahead-udev/config_parser.c
new file mode 100644
index 00000000..24d58a6b
--- /dev/null
+++ b/tools/nfs-readahead-udev/config_parser.c
@@ -0,0 +1,25 @@
+#include <stdlib.h>
+#include <string.h>
+#include "config_parser.h"
+
+struct config_entry *config_entry_new(void);
+
+struct config_entry *config_entry_new(void) {
+	struct config_entry *new = malloc(sizeof(struct config_entry));
+	if (!new) {
+		return NULL; // Make this an err_ptr
+	}
+
+	memset(new, 0, sizeof(struct config_entry));
+	list_init(&new->list);
+	return new;
+}
+
+
+void config_entry_free(struct config_entry *ce)
+{
+#define sfree(ce) if (ce) free(ce)
+	sfree(ce->mountpoint);
+	sfree(ce->fstype);
+#undef sfree
+}
diff --git a/tools/nfs-readahead-udev/config_parser.h b/tools/nfs-readahead-udev/config_parser.h
new file mode 100644
index 00000000..f9f138bb
--- /dev/null
+++ b/tools/nfs-readahead-udev/config_parser.h
@@ -0,0 +1,14 @@
+#ifndef __ra_libparser_h__
+#define __ra_libparser_h__
+#include "list.h"
+
+struct config_entry {
+	struct list_head list;
+	char *mountpoint;
+	char *fstype;
+	int readahead;
+};
+
+extern int parse_config(const char *, struct list_head *config_list);
+extern void config_entry_free(struct config_entry *);
+#endif
diff --git a/tools/nfs-readahead-udev/list.h b/tools/nfs-readahead-udev/list.h
new file mode 100644
index 00000000..69239502
--- /dev/null
+++ b/tools/nfs-readahead-udev/list.h
@@ -0,0 +1,48 @@
+#ifndef __ra_list_h__
+#define __ra_list_h__
+struct list_head
+{
+	struct list_head *next, *prev;
+};
+
+static inline void list_init(struct list_head *lh)
+{
+	lh->next = lh;
+	lh->prev = lh;
+}
+
+#define LIST_DECLARE(name)	 \
+	struct list_head name;	 \
+	list_init(&name);
+
+static inline void list_add(struct list_head *l, struct list_head *a)
+{
+	a->prev = l;
+	a->next = l->next;
+	l->next->prev = a;
+	l->next = a;
+}
+
+static inline void list_del(struct list_head *a)
+{
+	a->next->prev = a->prev;
+	a->prev->next = a->next;
+	a->next = a;
+	a->prev = a;
+}
+
+#define list_for_each(pos, head)				\
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+#define list_free(head, free_func) ({				\
+	for (struct list_head *__lh = (head)->next;		\
+			__lh != head; __lh = (head)->next) {	\
+		list_del(__lh);					\
+		free_func(__lh);				\
+	}})
+
+#define containerof(p, type, field) ({				\
+	const __typeof__(((type *)0)->field) *__ptr = (p);	\
+	(type *)((char *)__ptr - offsetof(type, field) ); })
+
+#endif
diff --git a/tools/nfs-readahead-udev/main.c b/tools/nfs-readahead-udev/main.c
index bbb408c0..2bd76138 100644
--- a/tools/nfs-readahead-udev/main.c
+++ b/tools/nfs-readahead-udev/main.c
@@ -2,16 +2,23 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <stddef.h>
 
 #include <libmount/libmount.h>
 #include <sys/sysmacros.h>
 
 #include "log.h"
+#include "list.h"
+#include "config_parser.h"
 
 #ifndef MOUNTINFO_PATH
 #define MOUNTINFO_PATH "/proc/self/mountinfo"
 #endif
 
+#ifndef READAHEAD_CONFIG_FILE
+#define READAHEAD_CONFIG_FILE SYSCONFDIR "/readahead.conf"
+#endif
+
 /* Device information from the system */
 struct device_info {
 	char *device_number;
@@ -110,6 +117,60 @@ static int get_device_info(const char *device_number, struct device_info *device
 	return ret;
 }
 
+static void config_entry_list_head_free(struct list_head *lh) {
+	struct config_entry *ce = containerof(lh, struct config_entry, list);
+	config_entry_free(ce);
+}
+
+static int match_config(struct device_info *di, struct config_entry *ce) {
+#define FIELD_CMP(field) \
+	(ce->field == NULL || (di->field != NULL && strcmp(di->field, ce->field) == 0))
+
+	if (!FIELD_CMP(mountpoint))
+		return 0;
+
+	if (!FIELD_CMP(fstype))
+		return 0;
+
+	debug("Device matched with config\n");
+	return 1;
+#undef FIELD_CMP
+}
+
+static int get_readahead(struct device_info *di, unsigned int *readahead)
+{
+	LIST_DECLARE(configs);
+	struct list_head *lh;
+	int ret = 0;
+	int default_ra = 0;
+
+	if ((ret = parse_config(READAHEAD_CONFIG_FILE, &configs)) != 0) {
+		err("Failed to read configuration (%d)\n", ret);
+		goto out;
+	}
+
+	list_for_each(lh, &configs) {
+		struct config_entry *ce = containerof(lh, struct config_entry, list);
+		if (ce->mountpoint == NULL && ce->fstype == NULL) {
+			default_ra = ce->readahead;
+			continue;
+		}
+
+		if (match_config(di, ce)) {
+			*readahead = ce->readahead;
+			goto out;
+		}
+	}
+
+	/* fallthrough */
+	debug("Setting readahead to default %d\n", default_ra);
+	*readahead = default_ra;
+
+out:
+	list_free(&configs, config_entry_list_head_free);
+	return ret;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	int ret = 0;
@@ -134,7 +195,12 @@ int main(int argc, char **argv, char **envp)
 		goto out;
 	}
 
-	info("Setting %s readahead to 128\n", device.mountpoint);
+	if ((ret = get_readahead(&device, &readahead)) != 0) {
+		err("Failed to find readahead (%d)\n", ret);
+		goto out;
+	}
+
+	info("Setting %s readahead to %u\n", device.mountpoint, readahead);
 
 	log_close();
 	printf("%d\n", readahead);
diff --git a/tools/nfs-readahead-udev/parser.y b/tools/nfs-readahead-udev/parser.y
new file mode 100644
index 00000000..f6db05c4
--- /dev/null
+++ b/tools/nfs-readahead-udev/parser.y
@@ -0,0 +1,78 @@
+%{
+#include <stdio.h>
+#include "parser.h"
+#include "config_parser.h"
+#include "log.h"
+
+extern int yylex();
+extern int yyparse();
+extern FILE *yyin;
+void yyerror(const char *s);
+
+// This should be visible only to this file
+extern struct config_entry *config_entry_new(void);
+
+struct config_entry *current;
+%}
+
+%union {
+	int ival;
+}
+
+%token <ival> INT
+%token EQ
+%token ENDL
+%token DEFAULT
+%token READAHEAD
+%token END_CONFIG 0
+
+%%
+config:
+	lines
+lines:
+	lines line | line | endls lines
+line:
+	tokens endls {
+		struct config_entry *new = config_entry_new();
+		list_add(&current->list, &new->list);
+		current = new;
+	}
+
+
+tokens:
+	tokens token | token
+
+token:
+	default | pair
+
+default:
+	DEFAULT
+
+pair:
+	READAHEAD EQ INT	{ current->readahead = $3; }
+
+endls:
+	endls ENDL | ENDL
+
+%%
+int parse_config(const char *filename, struct list_head *list)
+{
+	int ret;
+
+	yyin = fopen(filename, "r");
+	current = config_entry_new();
+	list_add(list, &current->list);
+
+	ret = yyparse();
+
+	/* The parser will create an empty entry that need to be eliminated */
+	list_del(&current->list);
+	free(current);
+	fclose(yyin);
+
+	return ret;
+}
+
+void yyerror(const char *s) {
+	err("Failed to parse configuration: %s", s);
+}
diff --git a/tools/nfs-readahead-udev/readahead.conf b/tools/nfs-readahead-udev/readahead.conf
new file mode 100644
index 00000000..988b30c7
--- /dev/null
+++ b/tools/nfs-readahead-udev/readahead.conf
@@ -0,0 +1 @@
+default				readahead=128
diff --git a/tools/nfs-readahead-udev/scanner.l b/tools/nfs-readahead-udev/scanner.l
new file mode 100644
index 00000000..d1ceb90b
--- /dev/null
+++ b/tools/nfs-readahead-udev/scanner.l
@@ -0,0 +1,14 @@
+%{
+#include "parser.h"
+#define yyterminate() return END_CONFIG
+%}
+%option noyywrap
+%%
+default		{ return DEFAULT; }
+readahead	{ return READAHEAD; }
+[ \t]		;
+#[^\n]*\n	{ return ENDL; }
+\n		{ return ENDL; }
+[0-9]+		{ yylval.ival = atoi(yytext); return INT; }
+=		{ return EQ; }
+%%
-- 
2.35.1

