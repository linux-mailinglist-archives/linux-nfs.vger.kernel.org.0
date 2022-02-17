Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0674BA564
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbiBQQGB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242919AbiBQQFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:05:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252C929C128
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D94DAB8235A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67125C340E8;
        Thu, 17 Feb 2022 16:05:38 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 3/8] SUNRPC: Remove svo_shutdown method
Date:   Thu, 17 Feb 2022 11:05:37 -0500
Message-Id:  <164511393711.1361.3789898013043466921.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
References:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; h=from:subject:message-id; bh=fHgQODB8uuOZFn6mcjPdLQlfTGbG3UtczqU7X2H+7zk=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnJRkc/yFQOpYUi9FtiQP3/JlU6VD/67SsLR2IKy BrgKnEuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yUQAKCRAzarMzb2Z/lwaDEA CXLjwcLiH9PchRGQ76yj3I1LDOmP4znb60NeAXVIf7olT08aYviXKUMiySS9ibo9V59JjKCjpsWFfN PlIKiGIGZj1x5WWau/LnYcElKxEv3imRhHMaKP/ipW0ab5En5WUGC45jkvzyguDKQehEnpx2F6XWSK 0MCuPmJy563VMa0Y844zUt29lE/K8vstv8r9AXbPG/tqYvzgNgrcGTXyRi7Kcsof/HPe2qInRTpNSp LDULhRSljlBJlCr/lv5hR5Hp31jwRUFVK4t2cTEIzxAY/Wl0Cd0FenDpBYtz1+cNPFCwY89JcAHlXi LmKtTNMGGnh9bL0FqaFRq40Bq1ED/b1YW3ZF6T1dYyPW9hAXjsQtVjpgZa0igVb4vVKoYgwxS1AlDz 5kYn+IT/WXjTW6Q398bvmsAcVlh9MIfsxoEmASQCwGbhTnfufOpk2Q2UPfZYhDr6BQeS2ZOHvmPIYj RGbhAb1u9cDxgbKUNZ4b1P+VyeSbAxep8Hlb00hw1Q+4v9ZljYq+E4NgVn+Vx9igu962iBEICEkbYv jnrqdLXlWOFoNxiJyRWHIREJ9IgqfP/CPwQ/iNSazDSIXYJjvokGrgI/IdclUWMcd9Zp7v5fNug/Hc APpsmAvXAAoDhWy1xOy77BnokLUrpaTY8ClIqNpK6fTEt26FMq8/onN34fSQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Neil observed that "any code that calls svc_shutdown_net()
knows what the shutdown function should be, and so can call it
directly."

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c             |    5 ++---
 fs/nfsd/nfssvc.c           |    2 +-
 include/linux/sunrpc/svc.h |    3 ---
 net/sunrpc/svc.c           |    3 ---
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 3a05af873625..f5b688a844aa 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -249,6 +249,7 @@ static int make_socks(struct svc_serv *serv, struct net *net,
 		printk(KERN_WARNING
 			"lockd_up: makesock failed, error=%d\n", err);
 	svc_shutdown_net(serv, net);
+	svc_rpcb_cleanup(serv, net);
 	return err;
 }
 
@@ -287,8 +288,7 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 			cancel_delayed_work_sync(&ln->grace_period_end);
 			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
-			dprintk("%s: per-net data destroyed; net=%x\n",
-				__func__, net->ns.inum);
+			svc_rpcb_cleanup(serv, net);
 		}
 	} else {
 		pr_err("%s: no users! net=%x\n",
@@ -351,7 +351,6 @@ static struct notifier_block lockd_inet6addr_notifier = {
 #endif
 
 static const struct svc_serv_ops lockd_sv_ops = {
-	.svo_shutdown		= svc_rpcb_cleanup,
 	.svo_function		= lockd,
 	.svo_module		= THIS_MODULE,
 };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index aeeac6de1f0a..0c6b216e439e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -613,7 +613,6 @@ static int nfsd_get_default_max_blksize(void)
 }
 
 static const struct svc_serv_ops nfsd_thread_sv_ops = {
-	.svo_shutdown		= nfsd_last_thread,
 	.svo_function		= nfsd,
 	.svo_module		= THIS_MODULE,
 };
@@ -724,6 +723,7 @@ void nfsd_put(struct net *net)
 
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
+		nfsd_last_thread(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
 		spin_lock(&nfsd_notifier_lock);
 		nn->nfsd_serv = NULL;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 6ef9c1cafd0b..63794d772eb3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -55,9 +55,6 @@ struct svc_pool {
 struct svc_serv;
 
 struct svc_serv_ops {
-	/* Callback to use when last thread exits. */
-	void		(*svo_shutdown)(struct svc_serv *, struct net *);
-
 	/* function for service threads to run */
 	int		(*svo_function)(void *);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2aabec2b4bec..74a75a22da9a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -539,9 +539,6 @@ EXPORT_SYMBOL_GPL(svc_create_pooled);
 void svc_shutdown_net(struct svc_serv *serv, struct net *net)
 {
 	svc_close_net(serv, net);
-
-	if (serv->sv_ops->svo_shutdown)
-		serv->sv_ops->svo_shutdown(serv, net);
 }
 EXPORT_SYMBOL_GPL(svc_shutdown_net);
 

