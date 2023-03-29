Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70786CDB9A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC2OJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjC2OJl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 10:09:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD44C3F
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 07:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2815B82337
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 14:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61BEC433EF;
        Wed, 29 Mar 2023 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098900;
        bh=IChDhiFbmd2EIGA90wuR0AhiQq4qrUAIgvKqgbwXdOI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PWUfqbkkOj0nQvNYanF9GlqHZZrJ4NtD8bpK0JYqhpcbNyxY6hqjnmUg2mJ0asf5P
         k9im8MwN5eakKXuqoqfMvPHN0iwjdhYix2k7L4/lGXsGZAz4G28hLE7XUihvzX2DdZ
         ZgOQ1G8utnhRto7EbH3W+pBy56TEk7Vjk+UpFbl4sQ0bChC+34IHdsQsuYBbsgXmP3
         j+i7DayT9hqluapS1sQvqUUNxpmS6jm/B1Zy8dmbZCblZOr7zenmIifKmR1U+sSJ3r
         QnNKJC7mDLDIDhu/t7FJiPccYReAa0x2GPyCOcahVRqDfDaH2zBw0bf2gGMB2QVM2H
         7q6aEYrf0oZtA==
Subject: [PATCH v2 2/4] exports: Add an xprtsec= export option
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 29 Mar 2023 10:08:19 -0400
Message-ID: <168009889899.2522.2402192914493543037.stgit@manet.1015granger.net>
In-Reply-To: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
References: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The overall goal is to enable administrators to require the use of
transport layer security when clients access particular exports.

This patch adds support to exportfs to parse, display, and push
into the kernel a new xprtsec= export option.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 support/export/cache.c       |   15 +++++++
 support/include/nfs/export.h |   14 +++++++
 support/include/nfslib.h     |   14 +++++++
 support/nfs/exports.c        |   85 ++++++++++++++++++++++++++++++++++++++++++
 utils/exportfs/exportfs.c    |    1 
 5 files changed, 129 insertions(+)

diff --git a/support/export/cache.c b/support/export/cache.c
index 2497d4f48df3..9354f71db894 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -932,6 +932,7 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
 	release_replicas(servers);
 }
 #endif
+
 static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask)
 {
 	struct sec_entry *p;
@@ -949,7 +950,20 @@ static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_m
 		qword_addint(bp, blen, p->flav->fnum);
 		qword_addint(bp, blen, p->flags & flag_mask);
 	}
+}
+
+static void write_xprtsec(char **bp, int *blen, struct exportent *ep)
+{
+	struct xprtsec_entry *p;
+
+	for (p = ep->e_xprtsec; p->info; p++);
+	if (p == ep->e_xprtsec)
+		return;
 
+	qword_add(bp, blen, "xprtsec");
+	qword_addint(bp, blen, p - ep->e_xprtsec);
+	for (p = ep->e_xprtsec; p->info; p++)
+		qword_addint(bp, blen, p->info->number);
 }
 
 static int dump_to_cache(int f, char *buf, int blen, char *domain,
@@ -992,6 +1006,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
 			qword_add(&bp, &blen, "uuid");
 			qword_addhex(&bp, &blen, u, 16);
 		}
+		write_xprtsec(&bp, &blen, exp);
 		xlog(D_AUTH, "granted access to %s for %s",
 		     path, *domain == '$' ? domain+1 : domain);
 	} else {
diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index 0eca828ee3ad..be5867cffc3c 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -40,4 +40,18 @@
 #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
 					| NFSEXP_ALLSQUASH)
 
+/*
+ * Transport layer security policies that are permitted to access
+ * an export
+ */
+#define NFSEXP_XPRTSEC_NONE	0x0001
+#define NFSEXP_XPRTSEC_TLS	0x0002
+#define NFSEXP_XPRTSEC_MTLS	0x0004
+
+#define NFSEXP_XPRTSEC_NUM	(3)
+
+#define NFSEXP_XPRTSEC_ALL	(NFSEXP_XPRTSEC_NONE | \
+				 NFSEXP_XPRTSEC_TLS | \
+				 NFSEXP_XPRTSEC_MTLS)
+
 #endif /* _NSF_EXPORT_H */
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index 6faba71bf0cd..61c19933ae01 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -62,6 +62,18 @@ struct sec_entry {
 	int flags;
 };
 
+#define XPRTSECMODE_COUNT 3
+
+struct xprtsec_info {
+	const char		*name;
+	int			number;
+};
+
+struct xprtsec_entry {
+	const struct xprtsec_info *info;
+	int			flags;
+};
+
 /*
  * Data related to a single exports entry as returned by getexportent.
  * FIXME: export options should probably be parsed at a later time to
@@ -83,6 +95,7 @@ struct exportent {
 	char *          e_fslocdata;
 	char *		e_uuid;
 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
+	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
 	unsigned int	e_ttl;
 	char *		e_realpath;
 };
@@ -99,6 +112,7 @@ struct rmtabent {
 void			setexportent(char *fname, char *type);
 struct exportent *	getexportent(int,int);
 void 			secinfo_show(FILE *fp, struct exportent *ep);
+void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
 void			putexportent(struct exportent *xep);
 void			endexportent(void);
 struct exportent *	mkexportent(char *hname, char *path, char *opts);
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 7f12383981c3..da8ace3a65fd 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, int fromkernel)
 	ee->e_fslocmethod = FSLOC_NONE;
 	ee->e_fslocdata = NULL;
 	ee->e_secinfo[0].flav = NULL;
+	ee->e_xprtsec[0].info = NULL;
 	ee->e_nsquids = 0;
 	ee->e_nsqgids = 0;
 	ee->e_uuid = NULL;
@@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep)
 	}
 }
 
+void xprtsecinfo_show(FILE *fp, struct exportent *ep)
+{
+	struct xprtsec_entry *p1, *p2;
+
+	for (p1 = ep->e_xprtsec; p1->info; p1 = p2) {
+		fprintf(fp, ",xprtsec=%s", p1->info->name);
+		for (p2 = p1 + 1; p2->info && (p1->flags == p2->flags); p2++)
+			fprintf(fp, ":%s", p2->info->name);
+	}
+}
+
 static void
 fprintpath(FILE *fp, const char *path)
 {
@@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
 	}
 	fprintf(fp, "anonuid=%d,anongid=%d", ep->e_anonuid, ep->e_anongid);
 	secinfo_show(fp, ep);
+	xprtsecinfo_show(fp, ep);
 	fprintf(fp, ")\n");
 }
 
@@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, struct exportent *ep)
 	return out;
 }
 
+static const struct xprtsec_info xprtsec_name2info[] = {
+	{ "none",	NFSEXP_XPRTSEC_NONE },
+	{ "tls",	NFSEXP_XPRTSEC_TLS },
+	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
+	{ NULL,		0 }
+};
+
+static const struct xprtsec_info *find_xprtsec_info(const char *name)
+{
+	const struct xprtsec_info *info;
+
+	for (info = xprtsec_name2info; info->name; info++)
+		if (strcmp(info->name, name) == 0)
+			return info;
+	return NULL;
+}
+
+/*
+ * Append the given xprtsec mode to the exportent's e_xprtsec array,
+ * or do nothing if it's already there. Returns the index of flavor in
+ * the resulting array in any case.
+ */
+static int xprtsec_addmode(const struct xprtsec_info *info, struct exportent *ep)
+{
+	struct xprtsec_entry *p;
+
+	for (p = ep->e_xprtsec; p->info; p++)
+		if (p->info == info || p->info->number == info->number)
+			return p - ep->e_xprtsec;
+
+	if (p - ep->e_xprtsec >= XPRTSECMODE_COUNT) {
+		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
+			XPRTSECMODE_COUNT);
+		return -1;
+	}
+	p->info = info;
+	p->flags = ep->e_flags;
+	(p + 1)->info = NULL;
+	return p - ep->e_xprtsec;
+}
+
+/*
+ * @str is a colon seperated list of transport layer security modes.
+ * Their order is recorded in @ep, and a bitmap corresponding to the
+ * list is returned.
+ *
+ * A zero return indicates an error.
+ */
+static unsigned int parse_xprtsec(char *str, struct exportent *ep)
+{
+	unsigned int out = 0;
+	char *name;
+
+	while ((name = strsep(&str, ":"))) {
+		const struct xprtsec_info *info = find_xprtsec_info(name);
+		int bit;
+
+		if (!info) {
+			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
+			return 0;
+		}
+		bit = xprtsec_addmode(info, ep);
+		if (bit < 0)
+			return 0;
+		out |= 1 << bit;
+	}
+	return out;
+}
+
 /* Sets the bits in @mask for the appropriate security flavor flags. */
 static void setflags(int mask, unsigned int active, struct exportent *ep)
 {
@@ -687,6 +769,9 @@ bad_option:
 			active = parse_flavors(opt+4, ep);
 			if (!active)
 				goto bad_option;
+		} else if (strncmp(opt, "xprtsec=", 8) == 0) {
+			if (!parse_xprtsec(opt + 8, ep))
+				goto bad_option;
 		} else {
 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
 					flname, flline, opt);
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 6d79a5b3480d..37b9e4b3612d 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -743,6 +743,7 @@ dump(int verbose, int export_format)
 #endif
 			}
 			secinfo_show(stdout, ep);
+			xprtsecinfo_show(stdout, ep);
 			printf("%c\n", (c != '(')? ')' : ' ');
 		}
 	}


