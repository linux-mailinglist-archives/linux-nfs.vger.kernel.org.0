Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671E66EB04B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjDURJo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjDURJe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0A16B23
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9S3EJJd783yVw0y/enXpAp/TWSHq6vt71X8pLPKuEJo=;
        b=b12y//TXoP2AZKumuX6qMtgVC4y+NeVITUb9VY6CmphuIw7K4XCjUXZr3ICH/+yGmTBowC
        1tpnsRrLHoyQj1uHrrqS7nq5cVt1vBivSkKmN+2ZkvZ2kelsxChhfLypiRmi4C4pwNhq9V
        wEuXttURlKH3axek+t2pugyNX2sojA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-XpC4p56ROCeVnoQXe7tRPg-1; Fri, 21 Apr 2023 13:08:18 -0400
X-MC-Unique: XpC4p56ROCeVnoQXe7tRPg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F9BB858F0E
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:18 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBD7A492C13
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:08:17 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/9] NFS: add sysfs shutdown knob
Date:   Fri, 21 Apr 2023 13:08:10 -0400
Message-Id: <2493a957a1c842d5cf32a4c2347dd17e6cb3370d.1682096307.git.bcodding@redhat.com>
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

Within each nfs_server sysfs tree, add an entry named "shutdown".  Writing
1 to this file will set the cl_shutdown bit on the rpc_clnt structs
associated with that mount.  If cl_shutdown is set, the task scheduler
immediately returns -EIO for new tasks.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c              | 46 +++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h   |  1 +
 include/linux/sunrpc/clnt.h |  3 ++-
 net/sunrpc/clnt.c           |  5 ++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index e1b5df7a3df5..09fde2719495 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/nfs_fs.h>
 #include <linux/rcupdate.h>
+#include <linux/lockd/lockd.h>
 
 #include "nfs4_fs.h"
 #include "netns.h"
@@ -191,6 +192,50 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 	}
 }
 
+static ssize_t
+shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	bool shutdown = server->flags & NFS_MOUNT_SHUTDOWN;
+	return sysfs_emit(buf, "%d\n", shutdown);
+}
+
+static ssize_t
+shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct nfs_server *server;
+	int ret, val;
+
+	server = container_of(kobj, struct nfs_server, kobj);
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	/* already shut down? */
+	if (server->flags & NFS_MOUNT_SHUTDOWN)
+		goto out;
+
+	server->flags |= NFS_MOUNT_SHUTDOWN;
+	server->client->cl_shutdown = 1;
+	server->nfs_client->cl_rpcclient->cl_shutdown = 1;
+
+	if (!IS_ERR(server->client_acl))
+		server->client_acl->cl_shutdown = 1;
+
+	if (server->nlm_host)
+		server->nlm_host->h_rpcclnt->cl_shutdown = 1;
+out:
+	return count;
+}
+
+static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
+
 #define RPC_CLIENT_NAME_SIZE 64
 
 void nfs_sysfs_link_rpc_client(struct nfs_server *server,
@@ -217,6 +262,7 @@ static void nfs_sysfs_sb_release(struct kobject *kobj)
 }
 
 static struct attribute *nfs_mp_attrs[] = {
+		&nfs_sysfs_attr_shutdown.attr,
         NULL,
 };
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index dee1664abca8..bc89496384ff 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -153,6 +153,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
+#define NFS_MOUNT_SHUTDOWN			0x08000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 4ec718aa91f5..9f72c75a2056 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -63,7 +63,8 @@ struct rpc_clnt {
 				cl_discrtry : 1,/* disconnect before retry */
 				cl_noretranstimeo: 1,/* No retransmit timeouts */
 				cl_autobind : 1,/* use getport() */
-				cl_chatty   : 1;/* be verbose */
+				cl_chatty   : 1,/* be verbose */
+				cl_shutdown : 1;/* rpc immediate -EIO */
 
 	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
 	const struct rpc_timeout *cl_timeout;	/* Timeout strategy */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0b0b9f1eed46..3c5dca88a918 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1717,6 +1717,11 @@ call_start(struct rpc_task *task)
 
 	trace_rpc_request(task);
 
+	if (task->tk_client->cl_shutdown) {
+		rpc_call_rpcerror(task, -EIO);
+		return;
+	}
+
 	/* Increment call count (version might not be valid for ping) */
 	if (clnt->cl_program->version[clnt->cl_vers])
 		clnt->cl_program->version[clnt->cl_vers]->counts[idx]++;
-- 
2.39.2

