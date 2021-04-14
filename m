Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B235FA5D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhDNSKq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 14:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234410AbhDNSI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 14:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618423715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgvXjxwHZxyvRYhr8rfe9hAeXuiLeqwKflwN/sJy8eQ=;
        b=SB21a9BgSLLhec2JZqHiD8YrVVYWg0+9rhq8JExVt8gbL6AWyzO93Q1B/vjZ/7j9K/9+2g
        EWdRgK070VCajiAbe0VawNYuHIUWy8eKxE/pb5tm/y/zlyFZWT9qf/91kPfbFp7zdb9ux+
        EZG3PXqnaViCtTFKwiJuGr22KQ6i9Nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-vZX0n6D3NFC5M-EyDHVRVg-1; Wed, 14 Apr 2021 14:08:33 -0400
X-MC-Unique: vZX0n6D3NFC5M-EyDHVRVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0669F107ACCD
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B67DD60862
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:32 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/3] nfs-utils: Enable the retrieval of raw config settings without expansion
Date:   Wed, 14 Apr 2021 14:10:38 -0400
Message-Id: <20210414181040.7108-2-steved@redhat.com>
In-Reply-To: <20210414181040.7108-1-steved@redhat.com>
References: <20210414181040.7108-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Alice Mitchell <ajmitchell@redhat.com>

Config entries sometimes contain variable expansions, this adds options
to retrieve the config entry rather than its current expanded value.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/include/conffile.h |  1 +
 support/nfs/conffile.c     | 23 +++++++++++++++++++++++
 tools/nfsconf/nfsconf.man  | 10 +++++++++-
 tools/nfsconf/nfsconfcli.c | 22 ++++++++++++++++------
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/support/include/conffile.h b/support/include/conffile.h
index 7d974fe9..c4a3ca62 100644
--- a/support/include/conffile.h
+++ b/support/include/conffile.h
@@ -61,6 +61,7 @@ extern _Bool    conf_get_bool(const char *, const char *, _Bool);
 extern char    *conf_get_str(const char *, const char *);
 extern char    *conf_get_str_with_def(const char *, const char *, char *);
 extern char    *conf_get_section(const char *, const char *, const char *);
+extern char    *conf_get_entry(const char *, const char *, const char *);
 extern int      conf_init_file(const char *);
 extern void     conf_cleanup(void);
 extern int      conf_match_num(const char *, const char *, int);
diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 1e15e7d5..fd4a17ad 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -891,6 +891,29 @@ conf_get_str_with_def(const char *section, const char *tag, char *def)
 	return result;
 }
 
+/*
+ * Retrieve an entry without interpreting its contents
+ */
+char *
+conf_get_entry(const char *section, const char *arg, const char *tag)
+{
+	struct conf_binding *cb;
+
+	cb = LIST_FIRST (&conf_bindings[conf_hash (section)]);
+	for (; cb; cb = LIST_NEXT (cb, link)) {
+		if (strcasecmp(section, cb->section) != 0)
+			continue;
+		if (arg && (cb->arg == NULL || strcasecmp(arg, cb->arg) != 0))
+			continue;
+		if (!arg && cb->arg)
+			continue;
+		if (strcasecmp(tag, cb->tag) != 0)
+			continue;
+		return cb->value;
+	}
+	return 0;
+}
+
 /*
  * Find a section that may or may not have an argument
  */
diff --git a/tools/nfsconf/nfsconf.man b/tools/nfsconf/nfsconf.man
index 30791988..d44e86fb 100644
--- a/tools/nfsconf/nfsconf.man
+++ b/tools/nfsconf/nfsconf.man
@@ -11,6 +11,12 @@ nfsconf \- Query various NFS configuration settings
 .IR infile.conf ]
 .RI [ outfile ]
 .P
+.B nfsconf \-\-entry
+.RB [ \-\-arg  
+.IR subsection]
+.IR section
+.IR tag
+.P
 .B nfsconf \-\-get
 .RB [ \-v | \-\-verbose ]
 .RB [ \-f | \-\-file
@@ -58,6 +64,8 @@ from a range of nfs-utils configuration files.
 The following modes are available:
 .IP "\fB\-d, \-\-dump\fP"
 Output an alphabetically sorted dump of the current configuration in conf file format. Accepts an optional filename in which to write the output.
+.IP "\fB\-e, \-\-entry\fP"
+retrieve the config entry rather than its current expanded value
 .IP "\fB\-i, \-\-isset\fP"
 Test if a specific tag has a value set.
 .IP "\fB\-g, \-\-get\fP"
@@ -75,7 +83,7 @@ Increase verbosity and print debugging information.
 .B \-f, \-\-file \fIinfile\fR
 Select a different config file to operate upon, default is
 .I /etc/nfs.conf
-.SS Options only valid in \fB\-\-get\fR and \fB\-\-isset\fR modes.
+.SS Options only valid in \fB\-\-entry\fR and \fB\-\-get\fR and \fB\-\-isset\fR modes.
 .TP
 .B \-a, \-\-arg \fIsubsection\fR
 Select a specific sub-section
diff --git a/tools/nfsconf/nfsconfcli.c b/tools/nfsconf/nfsconfcli.c
index 361d386e..b2ef96d1 100644
--- a/tools/nfsconf/nfsconfcli.c
+++ b/tools/nfsconf/nfsconfcli.c
@@ -11,6 +11,7 @@
 typedef enum {
 	MODE_NONE,
 	MODE_GET,
+	MODE_ENTRY,
 	MODE_ISSET,
 	MODE_DUMP,
 	MODE_SET,
@@ -30,6 +31,8 @@ static void usage(const char *name)
 	fprintf(stderr, "      Outputs the configuration to the named file\n");
 	fprintf(stderr, "  --get [--arg subsection] {section} {tag}\n");
 	fprintf(stderr, "      Output one specific config value\n");
+	fprintf(stderr, "  --entry [--arg subsection] {section} {tag}\n");
+	fprintf(stderr, "      Output the uninterpreted config entry\n");
 	fprintf(stderr, "  --isset [--arg subsection] {section} {tag}\n");
 	fprintf(stderr, "      Return code indicates if config value is present\n");
 	fprintf(stderr, "  --set [--arg subsection] {section} {tag} {value}\n");
@@ -55,6 +58,7 @@ int main(int argc, char **argv)
 		int index = 0;
 		struct option long_options[] = {
 			{"get",		no_argument, 0, 'g' },
+			{"entry",	no_argument, 0, 'e' },
 			{"set",		no_argument, 0, 's' },
 			{"unset",	no_argument, 0, 'u' },
 			{"arg",	  required_argument, 0, 'a' },
@@ -66,7 +70,7 @@ int main(int argc, char **argv)
 			{NULL,			  0, 0, 0 }
 		};
 
-		c = getopt_long(argc, argv, "gsua:id::f:vm:", long_options, &index);
+		c = getopt_long(argc, argv, "gesua:id::f:vm:", long_options, &index);
 		if (c == -1) break;
 
 		switch (c) {
@@ -86,6 +90,9 @@ int main(int argc, char **argv)
 			case 'g':
 				mode = MODE_GET;
 				break;
+			case 'e':
+				mode = MODE_ENTRY;
+				break;
 			case 's':
 				mode = MODE_SET;
 				break;
@@ -167,8 +174,8 @@ int main(int argc, char **argv)
 		if (dumpfile)
 			fclose(out);
 	} else
-	/* --iset and --get share a lot of code */
-	if (mode == MODE_GET || mode == MODE_ISSET) {
+	/* --isset and --get share a lot of code */
+	if (mode == MODE_GET || mode == MODE_ISSET || mode == MODE_ENTRY) {
 		char * section = NULL;
 		char * tag = NULL;
 		const char * val;
@@ -186,14 +193,17 @@ int main(int argc, char **argv)
 		tag = argv[optind++];
 
 		/* retrieve the specified tags value */
-		val = conf_get_section(section, arg, tag);
+		if (mode == MODE_ENTRY)
+			val = conf_get_entry(section, arg, tag);
+		else
+			val = conf_get_section(section, arg, tag);
 		if (val != NULL) {
 			/* ret=0, success, mode --get wants to output the value as well */
-			if (mode == MODE_GET)
+			if (mode != MODE_ISSET)
 				printf("%s\n", val);
 		} else {
 			/* ret=1, no value found, tell the user if they asked */
-			if (mode == MODE_GET && verbose)
+			if (mode != MODE_ISSET && verbose)
 				fprintf(stderr, "Tag '%s' not found\n", tag);
 			ret = 1;
 		}
-- 
2.30.2

