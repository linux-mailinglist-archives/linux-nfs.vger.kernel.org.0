Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E24731FB7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjFOSJR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjFOSJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C8C2967
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW95zJ7Be7rHQC7EOLBUX6nGSxa8dostz7GgnMxRoUc=;
        b=ftzOcCEXvohlL980/O/nLN9CGyV3I3+XFlUEBy+cbuJVh+TT/NDq0Pvk9P68L7Hvwbrjtw
        Wm5LAG6tVh/1ehPWg+XJ1ScAHjmbM1AUgAe/nNBwaK1p8zS3tm9iugHCPE72LBfYYET37a
        4H4dmvE6RZOcecegNvkVC9JftlmPdSQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-uJz5xl95P0iZCr8CugVZyQ-1; Thu, 15 Jun 2023 14:07:37 -0400
X-MC-Unique: uJz5xl95P0iZCr8CugVZyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 565D21C05146
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:37 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 189612166B26
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:37 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 10/11] NFS: Cancel all existing RPC tasks when shutdown
Date:   Thu, 15 Jun 2023 14:07:31 -0400
Message-Id: <6f4beb04a12c061044451539ea4ff0ebb66a1352.1686851158.git.bcodding@redhat.com>
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

Walk existing RPC tasks and cancel them with -EIO when the client is
shutdown.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 1fedbaff10e9..acda8f033d30 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -217,6 +217,17 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
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
@@ -247,14 +258,14 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
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
2.40.1

