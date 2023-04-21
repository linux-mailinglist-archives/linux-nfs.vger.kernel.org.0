Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418866EB048
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjDURJb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDURJ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D97ECB
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDT2xZslmwC5RymDr+i2C+SpKbLu+XFfhz6wrT81Es4=;
        b=fsrDbs1yx7DZOJ6fuUZgjitry7dLs7A5Y7E/iqvpVYl4jBTon1qxhFQuW/Lc3xbS6XfI5e
        2FnznX/X6H8xuUwhLXcp/x5N8XIA//avXB1qJIPWQcpEnxU1Denq+ALAj8AI9WX3Hbi0OB
        Ef+AMIyYP3dbv4qxnb2Crr6xpXXIGXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-BbeuFrPZM0myRC4tAdZ_lQ-1; Fri, 21 Apr 2023 13:08:17 -0400
X-MC-Unique: BbeuFrPZM0myRC4tAdZ_lQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBE8D800047
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:16 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858E8492C13
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:16 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/9] NFS: add a sysfs link to the lockd rpc_client
Date:   Fri, 21 Apr 2023 13:08:08 -0400
Message-Id: <e2d9155b4bbf300805ab4927cd66b87e7f8c77c9.1682096307.git.bcodding@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
References: <cover.1682096307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index de275f1fde92..eede8c28a56b 100644
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
2.39.2

