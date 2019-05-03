Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F0A12BE5
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfECK5E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 06:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfECK5E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 May 2019 06:57:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D07CAC058CB4
        for <linux-nfs@vger.kernel.org>; Fri,  3 May 2019 10:57:03 +0000 (UTC)
Received: from jumitche.remote.csb (unknown [10.33.36.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F9535D9C4;
        Fri,  3 May 2019 10:57:03 +0000 (UTC)
Message-ID: <1556881021.20707.9.camel@redhat.com>
Subject: [PATCH] nfs-utils: Enable adding of comments and date modified to
 nfs.conf files
From:   Alice J Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 03 May 2019 11:57:01 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 03 May 2019 10:57:03 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Extend the nfs.conf editing code to support the inserting of comment
lines, as well as file modified information so that automated setting
adjustments and imports can be appropriately flagged.

Signed-off-by: Alice J Mitchell <ajmitchell@redhat.com>
---
 support/include/conffile.h |   2 +
 support/nfs/conffile.c     | 195 ++++++++++++++++++++++++++++++++++++++++++++-
 tools/nfsconf/nfsconf.man  |   7 +-
 tools/nfsconf/nfsconfcli.c |  12 ++-
 4 files changed, 211 insertions(+), 5 deletions(-)

diff --git a/support/include/conffile.h b/support/include/conffile.h
index a3340f9..7d974fe 100644
--- a/support/include/conffile.h
+++ b/support/include/conffile.h
@@ -69,6 +69,8 @@ extern int      conf_remove_section(int, const char *);
 extern void     conf_report(FILE *);
 extern int      conf_write(const char *, const char *, const char *, const char *, const char *);
 
+extern const char *modified_by;
+
 /*
  * Convert letter from upper case to lower case
  */
diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index d8f2e8e..66d4215 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -51,6 +51,7 @@
 #include <syslog.h>
 #include <libgen.h>
 #include <sys/file.h>
+#include <time.h>
 
 #include "conffile.h"
 #include "xlog.h"
@@ -113,6 +114,8 @@ struct conf_binding {
 
 LIST_HEAD (conf_bindings, conf_binding) conf_bindings[256];
 
+const char *modified_by = NULL;
+
 static __inline__ uint8_t
 conf_hash(const char *s)
 {
@@ -1397,6 +1400,52 @@ make_section(const char *section, const char *arg)
 	return line;
 }
 
+/* compose a comment line (with or without tag) */
+static char *
+make_comment(const char *tag, const char *comment)
+{
+	char *line;
+	int ret;
+
+	if (tag == NULL || *tag == '\0') {
+		ret = asprintf(&line, "# %s\n", comment);
+	} else {
+		ret = asprintf(&line, "# %s: %s\n", tag, comment);
+	}
+
+	if (ret == -1) {
+		xlog(L_ERROR, "malloc error composing header");
+		return NULL;
+	}
+
+	return line;
+}
+		
+/* compose a 'file modified' comment */
+static char *
+make_timestamp(const char *tag, time_t when)
+{
+	struct tm *tstamp;
+	char datestr[80];
+	char *result = NULL;
+
+	tstamp = localtime(&when);
+	if (strftime(datestr, sizeof(datestr), "%b %d %Y %H:%M:%S", tstamp) == 0) {
+		xlog(L_ERROR, "error composing date");
+		datestr[0] = '\0';
+	}
+
+	if (modified_by) {
+		char *tmpstr = NULL;
+		asprintf(&tmpstr, "%s on %s", modified_by, datestr);
+		result = make_comment(tag, tmpstr);
+		free(tmpstr);
+	} else {
+		result = make_comment(tag, datestr);
+	}
+	return result;
+}
+
 /* does the supplied line contain the named section header */
 static bool
 is_section(const char *line, const char *section, const char *arg)
@@ -1406,6 +1455,10 @@ is_section(const char *line, const char *section, const char *arg)
 	char *sub;
 	bool found = false;
 
+	/* Not a valid section name  */
+	if (strcmp(section, "#") == 0)
+		return false;
+
 	/* skip leading white space */
 	while (*line == '[' || isspace(*line))
 		line++;
@@ -1569,6 +1622,54 @@ is_comment(const char *line)
 	return false;
 }
 
+/* check that line contains the specified comment header */
+static bool
+is_taggedcomment(const char *line, const char *field)
+{
+	char *end;
+	char *name;
+	bool found = false;
+
+	if (line == NULL)
+		return false;
+
+	while (isblank(*line))
+		line++;
+
+	if (*line != '#')
+		return false;
+
+	line++;
+
+	/* quick check, is this even a likely formatted line */
+	end = strchr(line, ':');
+	if (end == NULL)
+		return false;
+
+	/* skip leading white space before field name */
+	while (isblank(*line))
+		line++;
+
+	name = strdup(line);
+	if (name == NULL) {
+		xlog_warn("conf_write: malloc failed");
+		return false;
+	}
+
+	/* strip trailing spaces from the name */
+	end = strchr(name, ':');
+	if (end) *(end--) = 0;
+	while (end && end > name && isblank(*end))
+		*(end--)=0;
+
+	if (strcasecmp(name, field)==0) 
+		found = true;
+
+	free(name);
+	return found;
+}
+
+
 /* delete a buffer queue whilst optionally outputting to file */
 static int
 flush_outqueue(struct tailhead *queue, FILE *fout)
@@ -1772,6 +1873,7 @@ conf_write(const char *filename, const char *section, const char *arg,
 	struct tailhead inqueue;
 	char * buff = NULL;
 	int buffsize = 0;
+	time_t now = time(NULL);
 
 	TAILQ_INIT(&inqueue);
 	TAILQ_INIT(&outqueue);
@@ -1804,12 +1906,81 @@ conf_write(const char *filename, const char *section, const char *arg,
 		if (lock_file(infile))
 			goto cleanup;
 
-		if (append_line(&inqueue, NULL, make_section(section, arg)))
+		if (strcmp(section, "#") == 0) {
+			if (append_line(&inqueue, NULL, make_comment(tag, value)))
+				goto cleanup;
+		} else {
+			if (append_line(&inqueue, NULL, make_section(section, arg)))
+				goto cleanup;
+
+			if (append_line(&inqueue, NULL, make_tagline(tag, value)))
+				goto cleanup;
+		}
+
+		append_queue(&inqueue, &outqueue);
+	} else 
+	if (strcmp(section, "#") == 0) {
+		/* Adding a comment line */
+		struct outbuffer *where = NULL;
+		struct outbuffer *next = NULL;
+		bool found = false;
+		int err = 0;
+
+		if (lock_file(infile))
 			goto cleanup;
 
-		if (append_line(&inqueue, NULL, make_tagline(tag, value)))
+		buffsize = 4096;
+		buff = calloc(1, buffsize);
+		if (buff == NULL) {
+			xlog(L_ERROR, "malloc error for read buffer");
 			goto cleanup;
+		}
+		buff[0] = '\0';
 
+		/* read in the file */
+		do {
+			if (*buff != '\0' 
+			&& !is_taggedcomment(buff, "Modified")) {
+				if (append_line(&inqueue, NULL, strdup(buff)))
+					goto cleanup;
+			}
+
+			err = read_line(&buff, &buffsize, infile);
+		} while (err == 0);
+
+		/* if a tagged comment, look for an existing instance */
+		if (tag && *tag != '\0') {
+			where = TAILQ_FIRST(&inqueue);
+			while (where != NULL) {
+				next = TAILQ_NEXT(where, link);
+				struct outbuffer *prev = TAILQ_PREV(where, tailhead, link);
+				if (is_taggedcomment(where->text, tag)) {
+					TAILQ_REMOVE(&inqueue, where, link);
+					free(where->text);
+					free(where);
+					found = true;
+					if (append_line(&inqueue, prev, make_comment(tag, value)))
+						goto cleanup;
+				}
+				where = next;
+			}
+		}
+		/* it wasn't tagged or we didn't find it */
+		if (!found) {
+			/* does the file end in a blank line or a comment */
+			if (!TAILQ_EMPTY(&inqueue)) {
+				struct outbuffer *tail = TAILQ_LAST(&inqueue, tailhead);
+				if (tail && !is_empty(tail->text) && !is_comment(tail->text)) {
+					/* no, so add one for clarity */
+					if (append_line(&inqueue, NULL, strdup("\n")))
+						goto cleanup;
+				}
+			}
+			/* add the new comment line */
+			if (append_line(&inqueue, NULL, make_comment(tag, value)))
+				goto cleanup;
+		}
+		/* move everything over to the outqueue for writing */
 		append_queue(&inqueue, &outqueue);
 	} else {
 		bool found = false;
@@ -1831,7 +2002,8 @@ conf_write(const char *filename, const char *section, const char *arg,
 
 			/* read in one section worth of lines */
 			do {
-				if (*buff != '\0') {
+				if (*buff != '\0' 
+				&& !is_taggedcomment(buff, "Modified")) {
 					if (append_line(&inqueue, NULL, strdup(buff)))
 						goto cleanup;
 				}
@@ -1950,6 +2122,23 @@ conf_write(const char *filename, const char *section, const char *arg,
 		} while(err == 0);
 	}
 
+	if (modified_by) {
+		/* check for and update the Modified header */
+		/* does the file end in a blank line or a comment */
+		if (!TAILQ_EMPTY(&outqueue)) {
+			struct outbuffer *tail = TAILQ_LAST(&outqueue, tailhead);
+			if (tail && !is_empty(tail->text) && !is_comment(tail->text)) {
+				/* no, so add one for clarity */
+				if (append_line(&outqueue, NULL, strdup("\n")))
+					goto cleanup;
+			}
+		}
+
+		/* now append the modified date comment */
+		if (append_line(&outqueue, NULL, make_timestamp("Modified", now)))
+			goto cleanup;
+	}
+
 	/* now rewind and overwrite the file with the updated data */
 	rewind(infile);
 
diff --git a/tools/nfsconf/nfsconf.man b/tools/nfsconf/nfsconf.man
index 1ae8543..3079198 100644
--- a/tools/nfsconf/nfsconf.man
+++ b/tools/nfsconf/nfsconf.man
@@ -31,6 +31,8 @@ nfsconf \- Query various NFS configuration settings
 .P
 .B nfsconf \-\-set
 .RB [ \-v | \-\-verbose ]
+.RB [ \-m | \-\-modified
+.IR "Modified by text" ]
 .RB [ \-f | \-\-file
 .IR infile.conf ]
 .RB [ \-a | \-\-arg
@@ -61,7 +63,7 @@ Test if a specific tag has a value set.
 .IP "\fB\-g, \-\-get\fP"
 Output the current value of the specified tag.
 .IP "\fB\-s, \-\-set\fP"
-Update or Add a tag and value to the config file, creating the file if necessary.
+Update or Add a tag and value to the config file in a specified section, creating the tag, section, and file if necessary. If the section is defined as '#' then a comment is appended to the file. If a comment is set with a tag name then any exiting tagged comment with a matching name is replaced.
 .IP "\fB\-u, \-\-unset\fP"
 Remove the specified tag and its value from the config file.
 .SH OPTIONS
@@ -77,6 +79,9 @@ Select a different config file to operate upon, default is
 .TP
 .B \-a, \-\-arg \fIsubsection\fR
 Select a specific sub-section
+.SS Options only valid in \fB\-\-set\fR mode.
+.B \-m, \-\-modified \fI"Modified by nfsconf"\fR
+Set the text on the Modified date comment in the file. Set to empty to remove.
 .SH EXIT STATUS
 .SS \fB\-\-isset\fR mode
 In this mode the command will return success (0) if the selected tag has a value, any other exit code indicates the value is not set, or some other error has occurred.
diff --git a/tools/nfsconf/nfsconfcli.c b/tools/nfsconf/nfsconfcli.c
index f98d0d1..361d386 100644
--- a/tools/nfsconf/nfsconfcli.c
+++ b/tools/nfsconf/nfsconfcli.c
@@ -24,6 +24,7 @@ static void usage(const char *name)
 	fprintf(stderr, " -v			Increase Verbosity\n");
 	fprintf(stderr, " --file filename.conf	Load this config file\n");
 	fprintf(stderr, "     (Default config file: " NFS_CONFFILE "\n");
+	fprintf(stderr, " --modified \"info\"	Use \"info\" in file modified header\n");
 	fprintf(stderr, "Modes:\n");
 	fprintf(stderr, "  --dump [outputfile]\n");
 	fprintf(stderr, "      Outputs the configuration to the named file\n");
@@ -47,6 +48,8 @@ int main(int argc, char **argv)
 
 	confmode_t mode = MODE_NONE;
 
+	modified_by = "Modified by nfsconf";
+
 	while (1) {
 		int c;
 		int index = 0;
@@ -59,10 +62,11 @@ int main(int argc, char **argv)
 			{"dump",  optional_argument, 0, 'd' },
 			{"file",  required_argument, 0, 'f' },
 			{"verbose",	no_argument, 0, 'v' },
+			{"modified", required_argument, 0, 'm' },
 			{NULL,			  0, 0, 0 }
 		};
 
-		c = getopt_long(argc, argv, "gsua:id::f:v", long_options, &index);
+		c = getopt_long(argc, argv, "gsua:id::f:vm:", long_options, &index);
 		if (c == -1) break;
 
 		switch (c) {
@@ -99,6 +103,12 @@ int main(int argc, char **argv)
 				mode = MODE_DUMP;
 				dumpfile = optarg;
 				break;
+			case 'm':
+				if (optarg == NULL || *optarg == 0)
+					modified_by = NULL;
+				else
+					modified_by = optarg;
+				break;
 			default:
 				usage(argv[0]);
 				return 1;
-- 
1.8.3.1

