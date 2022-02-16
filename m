Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E874B8F7F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiBPRmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 12:42:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiBPRmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 12:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67B55125505
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645033327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UEcDWyCAAK6xb7ogc+elUoLUwJfh9zufJO2dRxptpHg=;
        b=MjAKjDv6ZTzI+DaAx1MqAwiciPrbqdQfjyfYLaIgkKmDqcGUyCbFLvA5957YUwPyNCi+WB
        ReO9AOqeHAlfH5Le0kVi6YnJNPmkXs1/KoNPC4xL9BQE4qUlIRK6Vhv8TretI91N5LB4Ja
        +YJhv4W2IEkzat7tfigtLj0I0MqdSBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-oyy11l4DOT6OFofhefsJiQ-1; Wed, 16 Feb 2022 12:42:03 -0500
X-MC-Unique: oyy11l4DOT6OFofhefsJiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF27F8144E0;
        Wed, 16 Feb 2022 17:42:00 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B671838D1;
        Wed, 16 Feb 2022 17:42:00 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 09BDB10C30F0; Wed, 16 Feb 2022 12:42:00 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Tune the race to set and use the client id uniquifier
Date:   Wed, 16 Feb 2022 12:42:00 -0500
Message-Id: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In order to set a unique but persistent value for the nfs client's ID, the
client exposes a per-network-namespace sysfs file that can be used to
configure a "uniquifier" for this value.

However any userspace mechanism used to configure this value must do so in
the potentially small window between either (1) the nfs module getting
loaded or (2) the creation of a new network namespace, and the client
sending SETCLIENTID or EXCHANGE_ID.

In (1) the time between these events can be very small if the kernel loads
the nfs module as triggered by the first mount request.  That leaves little
time for another process such as a userspace helper to lookup or generate a
uniquifier and write it to the kernel before the kernel attempts to create
and use the identifier.

In (2) the network namespace may be created but network configuration and
processes within that namespace that may trigger on the creation of the
sysfs file are not ready, or the setup of filesystems and tools for that
namespace may happen in parallel.

Fix this by creating a new nfs module parameter "nfs4_unique_id_timeout"
that will allow userspace a tunable window of time to uniquify the client.
When set, the client waits for a uniquifier to be set before sending
SETCLIENTID or EXCHANGE_ID.  The parameter defaults to 500ms. Setting the
parameter to zero reverts any waiting for a uniquifier.

A tunable delay can accommodate situations where the size of the race
window needs to be modified due to hardware differences or various
approaches to container initialization with respect to the use of NFS
within those containers.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4_fs.h  | 1 +
 fs/nfs/nfs4proc.c | 4 ++++
 fs/nfs/super.c    | 4 ++++
 fs/nfs/sysfs.c    | 3 +++
 fs/nfs/sysfs.h    | 2 ++
 5 files changed, 14 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3e344bec3647..052805c3cfc0 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -544,6 +544,7 @@ extern bool recover_lost_locks;
 
 #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
+extern unsigned int nfs4_client_id_uniquifier_timeout;
 
 extern int nfs4_try_get_tree(struct fs_context *);
 extern int nfs4_get_referral_tree(struct fs_context *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3106bd28b113..2ddffd799c7f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6135,6 +6135,10 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
 	buf[0] = '\0';
 
 	if (nn_clp) {
+		if (!nn_clp->user_uniquified && nfs4_client_id_uniquifier_timeout)
+			wait_for_completion_interruptible_timeout(&nn_clp->uniquified,
+				msecs_to_jiffies(nfs4_client_id_uniquifier_timeout));
+
 		rcu_read_lock();
 		id = rcu_dereference(nn_clp->identifier);
 		if (id)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..cad5acd1f79d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1329,6 +1329,7 @@ unsigned short max_session_slots = NFS4_DEF_SLOT_TABLE_SIZE;
 unsigned short max_session_cb_slots = NFS4_DEF_CB_SLOT_TABLE_SIZE;
 unsigned short send_implementation_id = 1;
 char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN] = "";
+unsigned int nfs4_client_id_uniquifier_timeout = 500;
 bool recover_lost_locks = false;
 
 EXPORT_SYMBOL_GPL(nfs_callback_nr_threads);
@@ -1339,6 +1340,7 @@ EXPORT_SYMBOL_GPL(max_session_slots);
 EXPORT_SYMBOL_GPL(max_session_cb_slots);
 EXPORT_SYMBOL_GPL(send_implementation_id);
 EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier);
+EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier_timeout);
 EXPORT_SYMBOL_GPL(recover_lost_locks);
 
 #define NFS_CALLBACK_MAXPORTNR (65535U)
@@ -1370,6 +1372,7 @@ module_param(nfs_idmap_cache_timeout, int, 0644);
 module_param(nfs4_disable_idmapping, bool, 0644);
 module_param_string(nfs4_unique_id, nfs4_client_id_uniquifier,
 			NFS4_CLIENT_ID_UNIQ_LEN, 0600);
+module_param_named(nfs4_unique_id_timeout, nfs4_client_id_uniquifier_timeout, int, 0644);
 MODULE_PARM_DESC(nfs4_disable_idmapping,
 		"Turn off NFSv4 idmapping when using 'sec=sys'");
 module_param(max_session_slots, ushort, 0644);
@@ -1382,6 +1385,7 @@ module_param(send_implementation_id, ushort, 0644);
 MODULE_PARM_DESC(send_implementation_id,
 		"Send implementation ID with NFSv4.1 exchange_id");
 MODULE_PARM_DESC(nfs4_unique_id, "nfs_client_id4 uniquifier string");
+MODULE_PARM_DESC(nfs4_unique_id_timeout, "msecs to wait for nfs_client_id4 uniquifier string");
 
 module_param(recover_lost_locks, bool, 0644);
 MODULE_PARM_DESC(recover_lost_locks,
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index be05522a2c8b..a54d342bc381 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -117,6 +117,8 @@ static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
 		synchronize_rcu();
 		kfree(old);
 	}
+	c->user_uniquified = true;
+	complete(&c->uniquified);
 	return count;
 }
 
@@ -171,6 +173,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	if (p) {
 		if (net != &init_net)
 			assign_unique_clientid(p);
+		init_completion(&p->uniquified);
 		p->net = net;
 		p->kobject.kset = nfs_client_kset;
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index 5501ef573c32..f733439a1084 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -12,6 +12,8 @@ struct nfs_netns_client {
 	struct kobject kobject;
 	struct net *net;
 	const char __rcu *identifier;
+	bool user_uniquified;
+	struct completion uniquified;
 };
 
 extern struct kobject *nfs_client_kobj;
-- 
2.31.1

