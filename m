Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A76EB19B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 20:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDUS1p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjDUS1m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 14:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38C12691
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 11:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51BA564E25
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 18:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651ACC433D2;
        Fri, 21 Apr 2023 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682101659;
        bh=b4KIzptUhzTcQCxMJhTXnsMiiG8jJrmadsHmNaVOQWM=;
        h=From:To:Cc:Subject:Date:From;
        b=VXCqRIYGgrvBsZ8RWlzwS4P9f+jsLT+3lrrBUqGAdP9HOVEHFXwXz4HEzSd8Xi6Nk
         hJAvpvMoeBpvmNUyy03TyRmE3hiG1B3afWVLLtl05k56ZQRSJZa9/ev76EogcdC8m7
         NWn5Po8T7gOw6gt8PGZcB3Mm+Nic+kCz2HeqW3YGNCDmQFR2+y46RPyRenrwqtuBqV
         u8/qrX0BbWOTGnl30g3DHiZjoRQM/Nt3BTOjPBRywF7dryQ/VHEu08aEOp9fZ1Slmd
         Tj8f0hQrA3/7fMJTzZZ4uYXg0nurY3jnHTB3tQMGQs0/ektgAwdgkfOqRX0gYx+o3z
         YsckoQV9UymXg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, bcodding@redhat.com
Cc:     anna@kernel.org
Subject: [RFC PATCH] NFS: add a sysfs file for enabling & disabling nfs features
Date:   Fri, 21 Apr 2023 14:27:38 -0400
Message-Id: <20230421182738.901701-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And add some basic checking so we only enable features that are present
in a given NFS version.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/sysfs.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h |  6 +++
 2 files changed, 105 insertions(+)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 39bfcbcf916c..667c3e544b23 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -216,7 +216,106 @@ static void nfs_sysfs_sb_release(struct kobject *kobj)
 	/* no-op: why? see lib/kobject.c kobject_cleanup() */
 }
 
+static inline char nfs_sysfs_server_capable(struct nfs_server *server,
+					    unsigned int capability)
+{
+	return (server->caps & capability) ? '+' : '-';
+}
+
+static ssize_t nfs_netns_sb_features_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+
+	return sysfs_emit(buf, "%creaddirplus\n"
+				"%csecurity_label\n"
+				"%cseek\n"
+				"%callocate\n"
+				"%cdeallocate\n"
+				"%clayoutstats\n"
+				"%cclone\n"
+				"%ccopy\n"
+				"%coffload_cancel\n"
+				"%clayouterror\n"
+				"%ccopy_notify\n"
+				"%cxattr\n"
+				"%cread_plus\n",
+			nfs_sysfs_server_capable(server, NFS_CAP_READDIRPLUS),
+			nfs_sysfs_server_capable(server, NFS_CAP_SECURITY_LABEL),
+			nfs_sysfs_server_capable(server, NFS_CAP_SEEK),
+			nfs_sysfs_server_capable(server, NFS_CAP_ALLOCATE),
+			nfs_sysfs_server_capable(server, NFS_CAP_DEALLOCATE),
+			nfs_sysfs_server_capable(server, NFS_CAP_LAYOUTSTATS),
+			nfs_sysfs_server_capable(server, NFS_CAP_CLONE),
+			nfs_sysfs_server_capable(server, NFS_CAP_COPY),
+			nfs_sysfs_server_capable(server, NFS_CAP_OFFLOAD_CANCEL),
+			nfs_sysfs_server_capable(server, NFS_CAP_LAYOUTERROR),
+			nfs_sysfs_server_capable(server, NFS_CAP_COPY_NOTIFY),
+			nfs_sysfs_server_capable(server, NFS_CAP_XATTR),
+			nfs_sysfs_server_capable(server, NFS_CAP_READ_PLUS));
+}
+
+static ssize_t nfs_netns_sb_features_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct nfs_server *server = container_of(kobj, struct nfs_server, kobj);
+	unsigned int cap;
+
+	if (!strncmp(buf + 1, "readdirplus", count - 2))
+		cap = NFS_CAP_READDIRPLUS;
+	else if (!strncmp(buf + 1, "security_label", count - 2))
+		cap = NFS_CAP_SECURITY_LABEL;
+	else if (!strncmp(buf + 1, "seek", count - 2))
+		cap = NFS_CAP_SEEK;
+	else if (!strncmp(buf + 1, "allocate", count - 2))
+		cap = NFS_CAP_ALLOCATE;
+	else if (!strncmp(buf + 1, "deallocate", count - 2))
+		cap = NFS_CAP_DEALLOCATE;
+	else if (!strncmp(buf + 1, "layoutstats", count - 2))
+		cap = NFS_CAP_LAYOUTSTATS;
+	else if (!strncmp(buf + 1, "clone", count - 2))
+		cap = NFS_CAP_CLONE;
+	else if (!strncmp(buf + 1, "copy", count - 2))
+		cap = NFS_CAP_COPY;
+	else if (!strncmp(buf + 1, "offload_cancel", count - 2))
+		cap = NFS_CAP_OFFLOAD_CANCEL;
+	else if (!strncmp(buf + 1, "layouterror", count - 2))
+		cap = NFS_CAP_LAYOUTERROR;
+	else if (!strncmp(buf + 1, "copy_notify", count - 2))
+		cap = NFS_CAP_COPY_NOTIFY;
+	else if (!strncmp(buf + 1, "xattr", count - 2))
+		cap = NFS_CAP_XATTR;
+	else if (!strncmp(buf + 1, "read_plus", count - 2))
+		cap = NFS_CAP_READ_PLUS;
+	else
+		return -EINVAL;
+
+	switch (cap) {
+	case NFS_CAP_READDIRPLUS:
+		if (server->nfs_client->rpc_ops->version == 2)
+			return -EINVAL;
+		break;
+	default:
+		if (server->nfs_client->rpc_ops->version != 4 ||
+		    server->nfs_client->cl_minorversion < 2)
+			return -EINVAL;
+	}
+
+	if (buf[0] == '+')
+		server->caps |= cap;
+	else
+		server->caps &= ~cap;
+		
+	return count;
+}
+
+static struct kobj_attribute nfs_netns_sb_features = __ATTR(features,
+		0644, nfs_netns_sb_features_show, nfs_netns_sb_features_store);
+
 static struct attribute *nfs_mp_attrs[] = {
+	&nfs_netns_sb_features.attr,
         NULL,
 };
 
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index 34e40f3a14cb..ed89fc873c68 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -14,6 +14,12 @@ struct nfs_netns_client {
 	const char __rcu *identifier;
 };
 
+struct nfs_netns_server {
+	struct kobject kobject;
+	struct net *net;
+	unsigned int caps;
+};
+
 extern struct kobject *nfs_client_kobj;
 
 extern int nfs_sysfs_init(void);
-- 
2.40.0

