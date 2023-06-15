Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D706731FBC
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjFOSJT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjFOSJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9752965
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ta1+dw/AUa5DOohgOxc6SgQ7GsCWdbkhBXmVMALa2Hs=;
        b=eSiCSfZzHg5RI9+VJGwcLHDllMghs8THT6MLR38rKsbaRYP6HQ09oedDGRcqXz6Sa+Ycxy
        V/vTuzCSCc5JEQ7/BvEqw3y8Tkbtm5XTvTW0Dl2qJHwYqUCjd2sOuuUwNa+dGFW9VakxQk
        BtFVa6/YJMMbRNG+h836cTuCm4DyfNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-O0lhMK_yNEC5-X_BDr9nLA-1; Thu, 15 Jun 2023 14:07:36 -0400
X-MC-Unique: O0lhMK_yNEC5-X_BDr9nLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C29B85A5A6
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:36 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17622166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:35 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 07/11] NFS: add a sysfs link to the lockd rpc_client
Date:   Thu, 15 Jun 2023 14:07:28 -0400
Message-Id: <f79a68b9b709133ee861257370e2f8e364522de0.1686851158.git.bcodding@redhat.com>
In-Reply-To: <cover.1686851158.git.bcodding@redhat.com>
References: <cover.1686851158.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After lockd is started, add a symlink for lockd's rpc_client under
NFS' superblock sysfs.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/clntlock.c        | 6 ++++++
 fs/nfs/client.c            | 1 +
 include/linux/lockd/bind.h | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index a5bb3f721a9d..0340e10b5715 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -94,6 +94,12 @@ void nlmclnt_done(struct nlm_host *host)
 }
 EXPORT_SYMBOL_GPL(nlmclnt_done);
 
+struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host)
+{
+	return host->h_rpcclnt;
+}
+EXPORT_SYMBOL_GPL(nlmclnt_rpc_clnt);
+
 /*
  * Queue up a lock for blocking so that the GRANTED request can see it
  */
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 82a37565d73a..4967ac800b14 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -592,6 +592,7 @@ static int nfs_start_lockd(struct nfs_server *server)
 
 	server->nlm_host = host;
 	server->destroy = nfs_destroy_server;
+	nfs_sysfs_link_rpc_client(server, nlmclnt_rpc_clnt(host), NULL);
 	return 0;
 }
 
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 3bc9f7410e21..c53c81242e72 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -20,6 +20,7 @@
 /* Dummy declarations */
 struct svc_rqst;
 struct rpc_task;
+struct rpc_clnt;
 
 /*
  * This is the set of functions for lockd->nfsd communication
@@ -56,6 +57,7 @@ struct nlmclnt_initdata {
 
 extern struct nlm_host *nlmclnt_init(const struct nlmclnt_initdata *nlm_init);
 extern void	nlmclnt_done(struct nlm_host *host);
+extern struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host);
 
 /*
  * NLM client operations provide a means to modify RPC processing of NLM
-- 
2.40.1

