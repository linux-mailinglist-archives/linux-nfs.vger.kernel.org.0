Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3302311D1A7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2019 17:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfLLQAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Dec 2019 11:00:04 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37418 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfLLQAE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Dec 2019 11:00:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id z7so854779ywd.4
        for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2019 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7eDh9zo3AXPLhKktIeZw7v2NNLD1S4t/sU2qkQnktL0=;
        b=rwz5sE6cgSvnM/RodNhxupyFwMszoCBS9p3hrK6s4xquKbDN0E38/DdCNDlWQ7hkMh
         81/TsDy/d1fpv4thIgecizoSBnJuKiHgr9NtM9r2skDDwhqgC8FFLHwGtaL2ab6HTgDE
         JgPbYVrk7m8lkSruWKXG4C/hKBxaBSM7AZLy2GpvCtz9NWqxXQdNy5+EfrCIsoFh1/ZI
         eM81RNopsDF/USLy3HEy0dxW9bJQ/OQNeZuo7ukZ/ubZDSRpXQ3Jfo1EBfu18ibtGb66
         WNCgLuVRETmMlG1VMvyiDZyyBeB9f0nIW6Cuvv/yoUUrxgAjvKcEsPJ7dSqtLTw93o9G
         jmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7eDh9zo3AXPLhKktIeZw7v2NNLD1S4t/sU2qkQnktL0=;
        b=Qp30craSxE2d69g6aQlvrKDvVQGRGJ4vIq2ooDma4tMuYgKfFysB5/+JUc6lnNK3se
         FLf4U44eZLe+TxAbmoVumInrI09iXg4a9NHm4wPUxvcz5uSAy7sfRAEA3+8/5utQiI7T
         /8YebaD4RNcHK9EN4kJRL7kDt5rUO1PK66x7Kf5jbfBWm83k+Kf0QL5D8Lj7s+bX8Q4o
         ZQKbHNX6KX4CWQtTL99A3Gn4ukT56ScZ81jZ0uoAhfW9YM7cpT+ySb4uKJTFaQSvO+Lf
         M6ue7vybr+BLJOsuQIGQy8q9iKmYgQUVF7oyp2D2sTEKotLmgZjJpLfKrk12+YmBJ3FV
         cbQQ==
X-Gm-Message-State: APjAAAX/69foSJPurqX4kWA0bnw/Xscvra4umKx2QvWNnLrwqQR/xuYk
        gIzpt3Pe8LyYa+omoacZPrA=
X-Google-Smtp-Source: APXvYqzEBJs4esC4unPpwlfxTIcBckWOBBiBk/Ti3Ricu9nWl6Uw673oG81c5fbfIksa1QRZAJuYPw==
X-Received: by 2002:a81:7911:: with SMTP id u17mr4542735ywc.135.1576166402916;
        Thu, 12 Dec 2019 08:00:02 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g190sm2616584ywd.85.2019.12.12.08.00.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Dec 2019 08:00:02 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] gssd: force getting tgt if ticket cache was removed
Date:   Thu, 12 Dec 2019 11:00:00 -0500
Message-Id: <20191212160000.22320-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If ticket cache was removed manually, but gssd thinks it has a valid
credentials it will fail mount creation as it can't get a service
ticket (due to lack of the tgt).

Check if file-based ticket cache is not there and set the "nocache"
to 1 forcing the client to get a new tgt.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/krb5_util.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 0474783..bff759f 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -121,6 +121,9 @@
 #include <krb5.h>
 #include <rpc/auth_gss.h>
 
+#include <sys/types.h>
+#include <fcntl.h>
+
 #include "nfslib.h"
 #include "gssd.h"
 #include "err_util.h"
@@ -314,6 +317,25 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 	return err;
 }
 
+/* check if the ticket cache exists, if not set nocache=1 so that new
+ * tgt is gotten
+ */
+static int
+gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
+{
+	int fd;
+	char cc_name[BUFSIZ];
+
+	snprintf(cc_name, sizeof(cc_name), "%s/%s%s_%s",
+		ccachesearch[0], GSSD_DEFAULT_CRED_PREFIX,
+		GSSD_DEFAULT_MACHINE_CRED_SUFFIX, ple->realm);
+	fd = open(cc_name, O_RDONLY);
+	if (fd < 0)
+		return 1;
+	close(fd);
+	return 0;
+}
+
 /*
  * Obtain credentials via a key in the keytab given
  * a keytab handle and a gssd_k5_kt_princ structure.
@@ -348,6 +370,8 @@ gssd_get_single_krb5_cred(krb5_context context,
 
 	memset(&my_creds, 0, sizeof(my_creds));
 
+	if (!nocache && !use_memcache)
+		nocache = gssd_check_if_cc_exists(ple);
 	/*
 	 * Workaround for clock skew among NFS server, NFS client and KDC
 	 * 300 because clock skew must be within 300sec for kerberos
-- 
1.8.3.1

