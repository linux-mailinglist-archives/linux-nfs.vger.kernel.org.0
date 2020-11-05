Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214B92A81A5
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgKEO4r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 09:56:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731013AbgKEO4r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 09:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604588205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nzgr1SuqOUrNhxxrIe6PsSa7YMqdI7HNiCRVmyjOT6w=;
        b=KixPpgX2CbL3fftVRG3P8W5VlDXlmkIOlAClRXy1JU4dvS7SAJMdtqCoC4ySsD1zoGkhna
        BVPV+wjHATqOpRCn2w8cAougunNfxTrOMR+UWrA08xrflPH40NE9ZM57KGJgi/Ysd3OIhx
        hjATaqgq98wffYzH95MMZVf9hWLetHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-LbPWR-dRO7SkrJWhwPSB9A-1; Thu, 05 Nov 2020 09:56:44 -0500
X-MC-Unique: LbPWR-dRO7SkrJWhwPSB9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67808800461
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 270335D9D5
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/3] conffile: process config.d directory config files.
Date:   Thu,  5 Nov 2020 09:56:32 -0500
Message-Id: <20201105145634.98281-2-steved@redhat.com>
In-Reply-To: <20201105145634.98281-1-steved@redhat.com>
References: <20201105145634.98281-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a /etc/nfs.conf.d or /etc/nfsmount.conf.d directory
exists and config file(s) do exist in those directories,
those file(s) will be used and will override the same
settings that are set in the main config files.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/conffile.c | 119 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 116 insertions(+), 3 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 3d13610..456bcf6 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -52,6 +52,7 @@
 #include <libgen.h>
 #include <sys/file.h>
 #include <time.h>
+#include <dirent.h>
 
 #include "conffile.h"
 #include "xlog.h"
@@ -456,7 +457,7 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
 		free(subconf);
 	} else {
 		/* XXX Perhaps should we not ignore errors?  */
-		conf_set(trans, *section, *subsection, line, val, 0, 0);
+		conf_set(trans, *section, *subsection, line, val, 1, 0);
 	}
 }
 
@@ -577,6 +578,30 @@ static void conf_free_bindings(void)
 	}
 }
 
+static int
+conf_load_files(int trans, const char *conf_file)
+{
+	char *conf_data;
+	char *section = NULL;
+	char *subsection = NULL;
+
+	conf_data = conf_readfile(conf_file);
+	if (conf_data == NULL)
+		return 1;
+
+	/* Load default configuration values.  */
+	conf_load_defaults();
+
+	/* Parse config contents into the transaction queue */
+	conf_parse(trans, conf_data, &section, &subsection, conf_file);
+	if (section) 
+		free(section);
+	if (subsection) 
+		free(subsection);
+	free(conf_data);
+
+	return 0;
+}
 /* Open the config file and map it into our address space, then parse it.  */
 static int
 conf_load_file(const char *conf_file)
@@ -609,18 +634,106 @@ conf_load_file(const char *conf_file)
 	return 0;
 }
 
+static void 
+conf_init_dir(const char *conf_file)
+{
+	struct dirent **namelist = NULL;
+	char *dname, fname[PATH_MAX + 1];
+	int n = 0, i, nfiles = 0, fname_len, dname_len;
+	int trans;
+
+	dname = malloc(strlen(conf_file) + 3);
+	if (dname == NULL) {
+		xlog(L_WARNING, "conf_init_dir: malloc: %s", strerror(errno));
+		return;	
+	}
+	sprintf(dname, "%s.d", conf_file);
+
+	n = scandir(dname, &namelist, NULL, versionsort);
+	if (n < 0) {
+		if (errno != ENOENT) {
+			xlog(L_WARNING, "conf_init_dir: scandir %s: %s", 
+				dname, strerror(errno));
+		}
+		free(dname);
+		return;
+	} else if (n == 0) {
+		free(dname);
+		return;
+	}
+
+	trans = conf_begin();
+	dname_len = strlen(dname);
+	for (i = 0; i < n; i++ ) {
+		struct dirent *d = namelist[i];
+
+	 	switch (d->d_type) {
+			case DT_UNKNOWN:
+			case DT_REG:
+			case DT_LNK:
+				break;
+			default:
+				continue;
+		}
+		if (*d->d_name == '.')
+			continue;
+		
+		fname_len = strlen(d->d_name);
+		if (!fname_len || (fname_len + dname_len) > PATH_MAX) {
+			xlog(L_WARNING, "conf_init_dir: Too long file name: %s in %s", 
+				d->d_name, dname);
+			continue; 
+		}
+		sprintf(fname, "%s/%s", dname, d->d_name);
+
+		if (conf_load_files(trans, fname))
+			continue;
+		nfiles++;
+	}
+
+	if (nfiles) {
+		/* Apply the configuration values */
+		conf_end(trans, 1);
+	}
+	for (i = 0; i < n; i++)
+		free(namelist[i]);
+	free(namelist);
+	free(dname);
+	
+	return;
+}
+
 int
 conf_init_file(const char *conf_file)
 {
 	unsigned int i;
+	int ret;
 
 	for (i = 0; i < sizeof conf_bindings / sizeof conf_bindings[0]; i++)
 		LIST_INIT (&conf_bindings[i]);
 
 	TAILQ_INIT (&conf_trans_queue);
 
-	if (conf_file == NULL) conf_file=NFS_CONFFILE;
-	return conf_load_file(conf_file);
+	if (conf_file == NULL) 
+		conf_file=NFS_CONFFILE;
+
+	/*
+	 * First parse the give config file 
+	 * then parse the config.conf.d directory 
+	 * (if it exists)
+	 *
+	 */
+	ret = conf_load_file(conf_file);
+
+	/*
+	 * When the same variable is set in both files
+	 * the conf.d file will override the config file.
+	 * This allows automated admin systems to
+	 * have the final say.
+	 */
+	conf_init_dir(conf_file);
+
+	return ret;
 }
 
 /*
-- 
2.26.2

