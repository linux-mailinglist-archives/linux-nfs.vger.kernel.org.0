Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B322A81A8
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEO4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 09:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731013AbgKEO4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 09:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604588207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZnLgXcbNSoZx6u4cjZpXSL4ZqBPt3mZdI9BXPKpBMI=;
        b=hUR/6U3RNlpk6209IGZFveGS2nKB+2X+kalQxepFnPggdiiGVEsmTqHzyoDHT3JxIr8cMM
        EN7gYiOumIFZnV7chKpX2fjoEso4QOIl16RRupGxv3vECxne3V5QhEnwGS5cA6r4/PwuhL
        pWAwEv6Z6SxektxeJrjGsb9cRNMckEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-09RmCd9lNNW1b1XchgnNSg-1; Thu, 05 Nov 2020 09:56:44 -0500
X-MC-Unique: 09RmCd9lNNW1b1XchgnNSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA685803626
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0D75D9D5
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 14:56:43 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/3] conffile: Only process files in the config.d dirs that end with ".conf"
Date:   Thu,  5 Nov 2020 09:56:33 -0500
Message-Id: <20201105145634.98281-3-steved@redhat.com>
In-Reply-To: <20201105145634.98281-1-steved@redhat.com>
References: <20201105145634.98281-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allows admins or admin systems to change configurations
by renaming the files, only process file that end with ".conf"

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/conffile.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 456bcf6..1574531 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -57,6 +57,9 @@
 #include "conffile.h"
 #include "xlog.h"
 
+#define CONF_FILE_EXT ".conf"
+#define CONF_FILE_EXT_LEN ((int) (sizeof(CONF_FILE_EXT) - 1))
+
 #pragma GCC visibility push(hidden)
 
 static void conf_load_defaults(void);
@@ -638,8 +641,8 @@ static void
 conf_init_dir(const char *conf_file)
 {
 	struct dirent **namelist = NULL;
-	char *dname, fname[PATH_MAX + 1];
-	int n = 0, i, nfiles = 0, fname_len, dname_len;
+	char *dname, fname[PATH_MAX + 1], *cname;
+	int n = 0, nfiles = 0, i, fname_len, dname_len;
 	int trans;
 
 	dname = malloc(strlen(conf_file) + 3);
@@ -684,6 +687,23 @@ conf_init_dir(const char *conf_file)
 				d->d_name, dname);
 			continue; 
 		}
+
+		/*
+		 * Check the naming of the file. Only process files
+		 * that end with CONF_FILE_EXT
+		 */
+		if (fname_len <= CONF_FILE_EXT_LEN) {
+			xlog(D_GENERAL, "conf_init_dir: %s: name too short", 
+				d->d_name);
+			continue;
+		}
+		cname = (d->d_name + (fname_len - CONF_FILE_EXT_LEN));
+		if (strcmp(cname, CONF_FILE_EXT) != 0) {
+			xlog(D_GENERAL, "conf_init_dir: %s: invalid file extension", 
+				d->d_name);
+			continue;
+		}
+
 		sprintf(fname, "%s/%s", dname, d->d_name);
 
 		if (conf_load_files(trans, fname))
-- 
2.26.2

