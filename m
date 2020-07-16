Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C162B222454
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 15:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGPNy3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 09:54:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728093AbgGPNy1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 09:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594907664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66tfYy9N0zJ2bF2zHXJWgjW2rZ1VHy37fz7NTnL6kKo=;
        b=Dg3RnnCBwUvNaHVahlBpno+5WbavHFTKpqVShUsmqRVt7y83oAWzrSJadS+olwZT58Pnko
        JWOkU88MBW/q6I87IuekQQmBp/tpXMTFYaNG8HWOyXxq5ol1LwD/AXvANlOhRBL0ogtGtm
        BBBE18bB60PVThREIojZ3WEvTCRlq8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Utn_VVuXNBaipod6np9XQw-1; Thu, 16 Jul 2020 09:54:20 -0400
X-MC-Unique: Utn_VVuXNBaipod6np9XQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1651100CCCE
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jul 2020 13:54:19 +0000 (UTC)
Received: from ovpn-112-45.ams2.redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 215A319D61;
        Thu, 16 Jul 2020 13:54:18 +0000 (UTC)
Message-ID: <fcf1bebd43476c9d08cf03a38daa4aa58e882dba.camel@redhat.com>
Subject: [PATCH v2 2/4] nfs-utils: Enable the retrieval of raw config
 settings without
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Thu, 16 Jul 2020 14:54:17 +0100
In-Reply-To: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Config entries sometimes contain variable expansions, this adds options
to retrieve the config entry rather than its current expanded value.

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 support/include/conffile.h |  1 +
 support/nfs/conffile.c     | 23 +++++++++++++++++++++++
 tools/nfsconf/nfsconf.man  | 17 +++++++++++++----
 tools/nfsconf/nfsconfcli.c | 22 ++++++++++++++++------
 4 files changed, 53 insertions(+), 10 deletions(-)

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
index aea35917..cbeef10d 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -752,6 +752,29 @@ conf_get_str_with_def(const char *section, const char *tag, char *def)
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
index 30791988..26c72a69 100644
--- a/tools/nfsconf/nfsconf.man
+++ b/tools/nfsconf/nfsconf.man
@@ -1,7 +1,7 @@
 .\"
 .\" nfsconf(8)
 .\"
-.TH nfsconf 8 "2 May 2018"
+.TH nfsconf 8 "16 July 2020"
 .SH NAME
 nfsconf \- Query various NFS configuration settings
 .SH SYNOPSIS
@@ -20,6 +20,15 @@ nfsconf \- Query various NFS configuration settings
 .IR section
 .IR tag
 .P
+.B nfsconf \-\-entry
+.RB [ \-v | \-\-verbose ]
+.RB [ \-f | \-\-file
+.IR infile.conf ]
+.RB [ \-a | \-\-arg
+.IR subsection ]
+.IR section
+.IR tag
+.P
 .B nfsconf \-\-isset
 .RB [ \-v | \-\-verbose ]
 .RB [ \-f | \-\-file
@@ -62,6 +71,8 @@ Output an alphabetically sorted dump of the current configuration in conf file f
 Test if a specific tag has a value set.
 .IP "\fB\-g, \-\-get\fP"
 Output the current value of the specified tag.
+.IP "\fB\-e, \-\-entry\fP"
+Output the unmodified value of the specified tag without any variable expansion.
 .IP "\fB\-s, \-\-set\fP"
 Update or Add a tag and value to the config file in a specified section, creating the tag, section, and file if necessary. If the section is defined as '#' then a comment is appended to the file. If a comment is set with a tag name then any exiting tagged comment with a matching name is replaced.
 .IP "\fB\-u, \-\-unset\fP"
@@ -75,7 +86,7 @@ Increase verbosity and print debugging information.
 .B \-f, \-\-file \fIinfile\fR
 Select a different config file to operate upon, default is
 .I /etc/nfs.conf
-.SS Options only valid in \fB\-\-get\fR and \fB\-\-isset\fR modes.
+.SS Options only valid in \fB\-\-get\fR, \fB\-\-entry\fR, and \fB\-\-isset\fR modes.
 .TP
 .B \-a, \-\-arg \fIsubsection\fR
 Select a specific sub-section
@@ -108,5 +119,3 @@ Enable debugging in nfsd
 .BR exportfs (8),
 .BR idmapd (8),
 .BR statd (8)
-.SH AUTHOR
-Justin Mitchell <jumitche@redhat.com>
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
2.18.1


