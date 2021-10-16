Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99140430572
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhJPWsz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWsy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:48:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD9E61181;
        Sat, 16 Oct 2021 22:46:45 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 04/14] SUNRPC: Clean up svc_destroy()
Date:   Sat, 16 Oct 2021 18:46:44 -0400
Message-Id:  <163442440430.1001.16737049644722800748.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; h=from:subject:message-id; bh=pHz3/FZ4MdaiU1BpceCHhOsHbNPFjPa/dtX0AbrsEbQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZUe2od219Ib51AG43njolgWV47uxdJbPteYqRY rj6X5WaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWVAAKCRAzarMzb2Z/l09RD/ 9gjQX+nAoJ4yIODio7JXoBOMogSuAQSZ5ucyOAUQuMyLFxxnIvogjTTG5Z56cf+/R+XwJ5LNWtIKA+ MO1q1oQnvtSqaxLm1abyZMXJFrm786bLsRGXErmVCCm2y+sW2evFVBtlNe91wDG9D7IqoKuWttxQkM DGxY0pPIE+b2T8mYODc/b9TJwtE448otsobFzl1N5m5nVHpDGmaeL3/+KAQluPzczPlc6tKhwpKPRv ZMwX5t/Wnxai6i34na8y1/V816a5nd+9O1cds8uPDF8FmDHh0yOfLNf1GRnUlHMR7TXdf0Uh1bDdWK M7XAduIreIAGz2WgkigJ4O6TdLvrFF6CgSINigw9aJGK5tSY8EG44vYT++/hmAZOXhu1OA2t9ngQI1 +s997ErO77068Q2lM9apgCcMPELber90APCafsrzH5BRhuywb4kCixj453O5hRYA2s2INPrx10a4ut BBGMOprCsV+mBWpyNHAN8sl46mQK9uX1UR2RrZkAYPiBueE0oPtiivQjSQgRaWqmqaRI0itS3xuQBB f+krGm7apmERwMf/ZN/f49F1aUxXQewQiqBXfE4I1Wumho6QmNwtnWGEinBx56WELk7kO1FuNRHMAi x7anSop4pE9TakeF68z8/Z38fGPzw0Zh6jGd9ExR2f822vA2GBrbBtzP1uvA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Remove rarely-used printk() call sites in svc_destroy, and
defang the BUG_ON sites.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4292278a9552..f7d8401d97ac 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -521,24 +521,21 @@ void svc_shutdown_net(struct svc_serv *serv, struct net *net)
 }
 EXPORT_SYMBOL_GPL(svc_shutdown_net);
 
-/*
- * Destroy an RPC service. Should be called with appropriate locking to
- * protect the sv_nrthreads, sv_permsocks and sv_tempsocks.
+/**
+ * svc_destroy - Destroy an RPC service
+ * @serv: RPC server context to be destroyed
+ *
+ * Caller must serialize to protect sv_nrthreads, sv_permsocks
+ * and sv_tempsocks.
  */
-void
-svc_destroy(struct svc_serv *serv)
+void svc_destroy(struct svc_serv *serv)
 {
-	dprintk("svc: svc_destroy(%s, %d)\n",
-				serv->sv_program->pg_name,
-				serv->sv_nrthreads);
-
 	if (serv->sv_nrthreads) {
 		if (--(serv->sv_nrthreads) != 0) {
 			svc_sock_update_bufs(serv);
 			return;
 		}
-	} else
-		printk("svc_destroy: no threads for serv=%p!\n", serv);
+	}
 
 	del_timer_sync(&serv->sv_temptimer);
 
@@ -546,8 +543,8 @@ svc_destroy(struct svc_serv *serv)
 	 * The last user is gone and thus all sockets have to be destroyed to
 	 * the point. Check this.
 	 */
-	BUG_ON(!list_empty(&serv->sv_permsocks));
-	BUG_ON(!list_empty(&serv->sv_tempsocks));
+	WARN_ON(!list_empty(&serv->sv_permsocks));
+	WARN_ON(!list_empty(&serv->sv_tempsocks));
 
 	cache_clean_deferred(serv);
 

