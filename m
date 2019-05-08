Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9517ABE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEHNfr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 09:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31589 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfEHNfr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 8 May 2019 09:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6F05305B886
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:46 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A585C269
        for <linux-nfs@vger.kernel.org>; Wed,  8 May 2019 13:35:46 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 13/19] Removed resource leaks from gssd/krb5_util.c
Date:   Wed,  8 May 2019 09:35:30 -0400
Message-Id: <20190508133536.6077-14-steved@redhat.com>
In-Reply-To: <20190508133536.6077-1-steved@redhat.com>
References: <20190508133536.6077-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 08 May 2019 13:35:46 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

gssd/krb5_util.c:696: overwrite_var: Overwriting "k5err" in
	"k5err = gssd_k5_err_msg(context, code)" leaks
	the storage that "k5err" points to.

gssd/krb5_util.c:737: overwrite_var: Overwriting "k5err" in
	"k5err = gssd_k5_err_msg(context, code)" leaks
	the storage that "k5err" points to.

gssd/krb5_util.c:899: overwrite_var: Overwriting "k5err" in
	"k5err = gssd_k5_err_msg(context, code)" leaks
	the storage that "k5err" points to.

krb5_util.c:1173: leaked_storage: Variable "l" going out
	of scope leaks the storage it points to.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/krb5_util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 6daba44..454a6eb 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -699,6 +699,8 @@ gssd_search_krb5_keytab(krb5_context context, krb5_keytab kt,
 				 "we failed to unparse principal name: %s\n",
 				 k5err);
 			k5_free_kt_entry(context, kte);
+			free(k5err);
+			k5err = NULL;
 			continue;
 		}
 		printerr(4, "Processing keytab entry for principal '%s'\n",
@@ -900,6 +902,8 @@ find_keytab_entry(krb5_context context, krb5_keytab kt,
 				k5err = gssd_k5_err_msg(context, code);
 				printerr(1, "%s while building principal for '%s'\n",
 					 k5err, spn);
+				free(k5err);
+				k5err = NULL;
 				continue;
 			}
 			code = krb5_kt_get_entry(context, kt, princ, 0, 0, kte);
@@ -1169,7 +1173,8 @@ gssd_get_krb5_machine_cred_list(char ***list)
 		*list = l;
 		retval = 0;
 		goto out;
-	}
+	} else
+		free((void *)l);
   out:
 	return retval;
 }
@@ -1217,6 +1222,8 @@ gssd_destroy_krb5_machine_creds(void)
 			printerr(0, "WARNING: %s while resolving credential "
 				    "cache '%s' for destruction\n", k5err,
 				    ple->ccname);
+			free(k5err);
+			k5err = NULL;
 			continue;
 		}
 
-- 
2.20.1

