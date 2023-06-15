Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D5731FB6
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjFOSJQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjFOSJF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 14:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21E2962
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686852459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8cKMHtWmxtTWj1nFRLPWbR85cCwhoUlocUTG6Oa+EA=;
        b=Ms9YtqFdEMt78fYMEoLf95VdRR/lSxvMb8AaGXJqVNzZEjFplL+OeBE1ZjkD9cqWI2kzWp
        GVovMG7DX9hUCnheYzUp1k/0I723pwuPOKjDaTfl07lI/hW6koDZA1yPPhNEEq07rBqMUK
        QTLVPshK3jr4vXCl+o5nxl6IIyECL5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-9_IXtc3zNxug4DupZvVpng-1; Thu, 15 Jun 2023 14:07:37 -0400
X-MC-Unique: 9_IXtc3zNxug4DupZvVpng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E362F8028AF
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:36 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A503E2166B25
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 18:07:36 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 09/11] NFS: add sysfs shutdown knob
Date:   Thu, 15 Jun 2023 14:07:30 -0400
Message-Id: <b0b862935c831240b72e2076171157287e742371.1686851158.git.bcodding@redhat.com>
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

Within each nfs_server sysfs tree, add an entry named "shutdown".  Writing
1 to this file will set the cl_shutdown bit on the rpc_clnt structs
associated with that mount.  If cl_shutdown is set, the task scheduler
immediately returns -EIO for new tasks.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/sysfs.c              | 54 ++++++++++++++++++++++++++++++++++++-
 include/linux/nfs_fs_sb.h   |  1 +
 include/linux/sunrpc/clnt.h |  3 ++-
 net/sunrpc/clnt.c           |  5 ++++
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7009de149158..1fedbaff10e9 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/nfs_fs.h>
 #include <linux/rcupdate.h>
+#include <linux/lockd/lockd.h>
 
 #include "nfs4_fs.h"
 #include "netns.h"
@@ -216,6 +217,50 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
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
@@ -259,9 +304,16 @@ void nfs_sysfs_add_server(struct nfs_server *server)
 
 	ret = kobject_init_and_add(&server->kobj, &nfs_sb_ktype,
 				&nfs_kset->kobj, "server-%d", server->s_sysfs_id);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_warn("NFS: nfs sysfs add server-%d failed (%d)\n",
 					server->s_sysfs_id, ret);
+		return;
+	}
+	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_shutdown.attr,
+				nfs_netns_server_namespace(&server->kobj));
+	if (ret < 0)
+		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
+			server->s_sysfs_id, ret);
 }
 EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 9e71eb357e0b..a886c1689663 100644
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
2.40.1

