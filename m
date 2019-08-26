Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A619D1B7
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfHZOeY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 10:34:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31931 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfHZOeY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 10:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44CF3A2E0E8
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 14:34:24 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01B761001B11
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 14:34:23 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] nfs-utils: Removed a number of Coverity Scan RESOURCE_LEAK errors
Date:   Mon, 26 Aug 2019 10:34:20 -0400
Message-Id: <20190826143421.13712-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 26 Aug 2019 14:34:24 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfsidmap/libnfsidmap.c | 3 +++
 utils/gssd/krb5_util.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index 7b8a871..9299e65 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -486,6 +486,9 @@ out:
 	if (gss_methods)
 		conf_free_list(gss_methods);
 
+	if (nfs4_methods)
+		conf_free_list(nfs4_methods);
+
 	return ret ? -ENOENT: 0;
 }
 
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 454a6eb..f68be85 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -912,6 +912,8 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 				k5err = gssd_k5_err_msg(context, code);
 				printerr(3, "%s while getting keytab entry for '%s'\n",
 					 k5err, spn);
+				free(k5err);
+				k5err = NULL;
 				/*
 				 * We tried the active directory machine account
 				 * with the hostname part as-is and failed...
@@ -1231,6 +1233,8 @@ gssd_destroy_krb5_machine_creds(void)
 			k5err = gssd_k5_err_msg(context, code);
 			printerr(0, "WARNING: %s while destroying credential "
 				    "cache '%s'\n", k5err, ple->ccname);
+			free(k5err);
+			k5err = NULL;
 		}
 	}
 	krb5_free_context(context);
-- 
2.21.0

