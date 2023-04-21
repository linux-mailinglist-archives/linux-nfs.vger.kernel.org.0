Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C96EB076
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjDURUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDURUQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64731024E
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4+F4u3i25b+jqtXug/7kYRG3NEDgvJ+bE5/YIlCl7g=;
        b=L/6cc6DHKqR1wInHgW5nG2BJJgDUg/ASzGzWj3+XxOufiE4Jw5kLOyjNssuwBsOuZnwG8W
        h6eHqFrd//aOq/rNu5jqZ6WBkEixQ+x+euHmQMtYu2GLpWpuGFeGuG9jbVzPuyJ7/KokVD
        qaDkckL2JWkiQXnBCLV4/XLo9EqAmtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-S7HqvddnPL-QDjsDNCxL3Q-1; Fri, 21 Apr 2023 13:18:45 -0400
X-MC-Unique: S7HqvddnPL-QDjsDNCxL3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5188E886063
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF7EE40C2064
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:18:44 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/9] NFS: Cancel all existing RPC tasks when shutdown
Date:   Fri, 21 Apr 2023 13:18:38 -0400
Message-Id: <8a519c1620702ae155885b924d8d4e2fe932b390.1682097420.git.bcodding@redhat.com>
In-Reply-To: <cover.1682097420.git.bcodding@redhat.com>
References: <cover.1682097420.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Walk existing RPC tasks and cancel them with -EIO when the client is
shutdown.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 09fde2719495..70cd211d870c 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -192,6 +192,17 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 	}
 }
 
+static bool shutdown_match_client(const struct rpc_task *task, const void *data)
+{
+	return true;
+}
+
+static void shutdown_client(struct rpc_clnt *clnt)
+{
+	clnt->cl_shutdown = 1;
+	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
+}
+
 static ssize_t
 shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -222,14 +233,14 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto out;
 
 	server->flags |= NFS_MOUNT_SHUTDOWN;
-	server->client->cl_shutdown = 1;
-	server->nfs_client->cl_rpcclient->cl_shutdown = 1;
+	shutdown_client(server->client);
+	shutdown_client(server->nfs_client->cl_rpcclient);
 
 	if (!IS_ERR(server->client_acl))
-		server->client_acl->cl_shutdown = 1;
+		shutdown_client(server->client_acl);
 
 	if (server->nlm_host)
-		server->nlm_host->h_rpcclnt->cl_shutdown = 1;
+		shutdown_client(server->nlm_host->h_rpcclnt);
 out:
 	return count;
 }
-- 
2.39.2

