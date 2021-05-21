Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8538BDA4
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 06:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhEUEzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 21 May 2021 00:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:55518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhEUEzb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 May 2021 00:55:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 185CBAACA;
        Fri, 21 May 2021 04:54:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Subject: [PATCH nfs-utils] gssd: use mutex to protect decrement of refcount
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Fri, 21 May 2021 14:54:03 +1000
Message-id: <162157284381.19062.14252943620142216829@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


The decrement of the "ple" refcount is not protected so it can race with
increments or decrements from other threads.  An increment could be lost
and then the ple would be freed early, leading to memory corruption.

So use the mutex to protect decrements (increments are already
protected).

As gssd_destroy_krb5_principals() calls release_ple() while holding the
mutex, we need a "release_pte_locked()" which doesn't take the mutex.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/gssd/krb5_util.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 28b60ba307d0..51e0c6a2484b 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -169,18 +169,28 @@ static int gssd_get_single_krb5_cred(krb5_context context,
 static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
 		char **ret_realm);
 
-static void release_ple(krb5_context context, struct gssd_k5_kt_princ *ple)
+static void release_ple_locked(krb5_context context,
+			       struct gssd_k5_kt_princ *ple)
 {
 	if (--ple->refcount)
 		return;
 
-	printerr(3, "freeing cached principal (ccname=%s, realm=%s)\n", ple->ccname, ple->realm);
+	printerr(3, "freeing cached principal (ccname=%s, realm=%s)\n",
+		 ple->ccname, ple->realm);
 	krb5_free_principal(context, ple->princ);
 	free(ple->ccname);
 	free(ple->realm);
 	free(ple);
 }
 
+static void release_ple(krb5_context context, struct gssd_k5_kt_princ *ple)
+{
+	pthread_mutex_lock(&ple_lock);
+	release_ple_locked(context, ple);
+	pthread_mutex_unlock(&ple_lock);
+}
+
+
 /*
  * Called from the scandir function to weed out potential krb5
  * credentials cache files
@@ -1420,7 +1430,7 @@ gssd_destroy_krb5_principals(int destroy_machine_creds)
 			}
 		}
 
-		release_ple(context, ple);
+		release_ple_locked(context, ple);
 	}
 	pthread_mutex_unlock(&ple_lock);
 	krb5_free_context(context);
-- 
2.31.1

