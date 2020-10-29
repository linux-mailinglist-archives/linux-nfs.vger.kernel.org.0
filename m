Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339C229F69C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgJ2VHF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Oct 2020 17:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgJ2VHE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Oct 2020 17:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604005622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puWxCQ919rQFwx2xb5uDIKZoXNT0ftypp8YdElVg1e4=;
        b=Z8NzyW+QPKaZZ6EW6/DC9Qw6Uhhf6IXdEbQRFFvHCPSacx753ehV5vqnIw1FfezPBPj6iv
        pele8HvKqjmr1hdQxvcC2ZXDcFNq2zfHj8a2PTRBlMthmEcNiVbMiTYK4uc5TOHDgqWIkI
        PCNkkgwmIPzAuF4YN5q21Czjpenn5XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-LctAY51TO5OnP4feX6eiUQ-1; Thu, 29 Oct 2020 17:04:05 -0400
X-MC-Unique: LctAY51TO5OnP4feX6eiUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 891431084D65
        for <linux-nfs@vger.kernel.org>; Thu, 29 Oct 2020 21:04:04 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499905C22D
        for <linux-nfs@vger.kernel.org>; Thu, 29 Oct 2020 21:04:04 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/1] conffile: process config.d directory config files.
Date:   Thu, 29 Oct 2020 17:04:01 -0400
Message-Id: <20201029210401.446244-2-steved@redhat.com>
In-Reply-To: <20201029210401.446244-1-steved@redhat.com>
References: <20201029210401.446244-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a /etc/nfs.conf.d or /etc/nfsmount.conf.d directory
exists and there are config file(s) in those directory
exist, those config file(s) are used instead of the given
/etc/nfs.conf and /etc/nfsmount.conf files.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/conffile.c | 78 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 3d13610..c60e511 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -52,6 +52,7 @@
 #include <libgen.h>
 #include <sys/file.h>
 #include <time.h>
+#include <dirent.h>
 
 #include "conffile.h"
 #include "xlog.h"
@@ -609,6 +610,69 @@ conf_load_file(const char *conf_file)
 	return 0;
 }
 
+static int 
+conf_init_dir(const char *conf_file)
+{
+	struct dirent **namelist = NULL;
+	char *dname, fname[PATH_MAX + 1];
+	int n = 0, nfiles = 0, i, fname_len, dname_len;
+
+	dname = malloc(strlen(conf_file) + 3);
+	if (dname == NULL) {
+		xlog(L_WARNING, "conf_init_dir: malloc: %s", strerror(errno));
+		return nfiles;	
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
+		return nfiles;
+	} else if (n == 0) {
+		free(dname);
+		return nfiles;
+	}
+
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
+		if (conf_load_file(fname))
+			continue;
+		nfiles++;
+	}
+
+	for (i = 0; i < n; i++)
+		free(namelist[i]);
+	free(namelist);
+	free(dname);
+	
+	return nfiles;
+}
+
 int
 conf_init_file(const char *conf_file)
 {
@@ -619,7 +683,19 @@ conf_init_file(const char *conf_file)
 
 	TAILQ_INIT (&conf_trans_queue);
 
-	if (conf_file == NULL) conf_file=NFS_CONFFILE;
+	if (conf_file == NULL) 
+		conf_file=NFS_CONFFILE;
+
+	/* 
+	 * Check to see if there is a config directory 
+	 * if so use those file(s) if they exist
+	 */
+	if (conf_init_dir(conf_file) != 0)
+		return 0;
+
+	/*
+	 * Otherwise using the giving config file
+	 */
 	return conf_load_file(conf_file);
 }
 
-- 
2.26.2

