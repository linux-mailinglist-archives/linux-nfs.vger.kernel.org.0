Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FA4E6B87
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 01:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiCYA0Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbiCYA0Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 20:26:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F44705A
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 17:24:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C4F2210F4;
        Fri, 25 Mar 2022 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648167888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nTmDplsnaHF4up01PXxclUqEJeJVkoKXEQDkrb8vGzk=;
        b=07+20TzLSMz//8U0Esq+ZHgwMwps38dY1iunINGLyxlQK9AxnGFqAE4M6M5LuI+ZQXxJwo
        51l7uJ/ENveZTJxEFIOmlankrO2RiTGklaXLWPTe9e1f9Yag++sQ6tBMNnJUoU2PRe+3l3
        7iA1qc44pxqWobVHoVJBiM+u0NQi1Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648167888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nTmDplsnaHF4up01PXxclUqEJeJVkoKXEQDkrb8vGzk=;
        b=b6uqzX8NZew9099MUBsj2HOzIYEkg8pp8AKVS7K1E+Pj6ab6YGxw4/14E+KXSyLwtTyYa0
        4Sh/cyxUhLa/x+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9771C132E9;
        Fri, 25 Mar 2022 00:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xH9tFM4LPWJIXgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 25 Mar 2022 00:24:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH/RFC] NFSv4: ensure different netns do not share cl_owner_id
Date:   Fri, 25 Mar 2022 11:24:38 +1100
Message-id: <164816787898.6096.12819715693501838662@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


[[ This implements an idea I had while discussing the issues around
   NFSv4 client identity.  It isn't a solution, but instead aims to make
   the problem more immediately visible so that sites can "fix" their
   configuration before they get strange errors.
   I'm not convinced it is a good idea, but it seems worthy of a little
   discussion at least.
   There is a follow up patch to nfs-utils which expands this more
   towards a b-grade solution, but again if very open for discussion.
]]

The default cl_owner_id is based on host name which may be common
amongst different network namespaces.  If two clients in different
network namespaces with the same cl_owner_id attempt to mount from the
same server, problem will occur as each client can "steal" the lease
from the other.

To make this failure more immediate, keep track of all cl_owner_id in
use, and return an error if there is an attempt to use one in two
different network namespaces.

We use an rhl_table which is a resizeable hash table which can contain
multiple entries with the same key.  All nfs_client are added to this
table with the cl_owner_id as the key.

This doesn't fix the problem of non-unique client identifier, it only
makes it more visible and causes a hard immediate failure.  The failure
is reported to userspace which *could* make a policy decision to set
  /sys/fs/nfs/net/nfs_client/identifier
to a random value and retry the mount.

Note that this *could* cause a regression of configurations which are
currently working, is different network namespaces only mount from
different servers.  Such configurations are fragile and supporting them
might not be justified.  It would require rejecting mounts only when the
netns is different and the server is the same, but at the point when we
commit to the client identifer, we don't have a unique identity for the
server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/nfs4_fs.h          |  7 +++
 fs/nfs/nfs4client.c       |  1 +
 fs/nfs/nfs4proc.c         | 89 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4state.c        |  4 ++
 fs/nfs/nfs4super.c        |  8 ++++
 include/linux/nfs_fs_sb.h |  2 +
 6 files changed, 111 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 84f39b6f1b1e..83a70ea300d1 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -336,6 +336,13 @@ extern void nfs4_update_changeattr(struct inode *dir,
 extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 				    struct page **pages);
=20
+/* Interfaces for owner_id hash table, which ensures no two
+ * clients in the name net use the same owner_id.
+ */
+void nfs4_drop_owner_id(struct nfs_client *clp);
+int nfs4_init_owner_id_hash(void);
+void nfs4_destroy_owner_id_hash(void);
+
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *=
);
 extern int nfs4_proc_create_session(struct nfs_client *, const struct cred *=
);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 47a6cf892c95..2a659d14b663 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -289,6 +289,7 @@ static void nfs4_shutdown_client(struct nfs_client *clp)
 		nfs_idmap_delete(clp);
=20
 	rpc_destroy_wait_queue(&clp->cl_rpcwaitq);
+	nfs4_drop_owner_id(clp);
 	kfree(clp->cl_serverowner);
 	kfree(clp->cl_serverscope);
 	kfree(clp->cl_implid);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0e0db6c27619..8f171e8b45b4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -55,6 +55,8 @@
 #include <linux/utsname.h>
 #include <linux/freezer.h>
 #include <linux/iversion.h>
+#include <linux/rhashtable.h>
+#include <linux/xxhash.h>
=20
 #include "nfs4_fs.h"
 #include "delegation.h"
@@ -6240,6 +6242,89 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf,=
 size_t buflen)
 	return strlen(buf);
 }
=20
+static u32 owner_id_hash(const void *obj, u32 len, u32 seed)
+{
+	const char *const *idp =3D obj;
+	const char *id =3D *idp;
+
+	return xxh32(id, strlen(id), seed);
+}
+
+static int owner_id_cmp(struct rhashtable_compare_arg *arg,
+			const void *obj)
+{
+	const char *const *idp =3D arg->key;
+	const char *id =3D *idp;
+	const struct nfs_client *clp =3D obj;
+
+	return strcmp(id, clp->cl_owner_id);
+}
+
+static struct rhltable nfs4_owner_id;
+static DEFINE_SPINLOCK(nfs4_owner_id_lock);
+const struct rhashtable_params nfs4_owner_id_params =3D {
+	.key_offset =3D offsetof(struct nfs_client, cl_owner_id),
+	.head_offset =3D offsetof(struct nfs_client, cl_owner_id_hash),
+	.key_len =3D 1,
+	.automatic_shrinking =3D true,
+	.hashfn =3D owner_id_hash,
+	.obj_cmpfn =3D owner_id_cmp,
+};
+
+int nfs4_init_owner_id_hash(void)
+{
+	return rhltable_init(&nfs4_owner_id, &nfs4_owner_id_params);
+}
+
+void nfs4_destroy_owner_id_hash(void)
+{
+	rhltable_destroy(&nfs4_owner_id);
+}
+
+static bool nfs4_record_owner_id(struct nfs_client *clp)
+{
+	/*
+	 * Any two nfs_client with the same cl_owner_id must
+	 * have the same cl_net.
+	 */
+	int ret;
+	int loops =3D 0;
+	struct rhlist_head *h;
+
+	/* rhltable_insert can fail for transient reasons, so loop a few times */
+	while (loops < 5) {
+		spin_lock(&nfs4_owner_id_lock);
+		rcu_read_lock();
+		h =3D rhltable_lookup(&nfs4_owner_id, &clp->cl_owner_id,
+				    nfs4_owner_id_params);
+		if (h &&
+		    container_of(h, struct nfs_client,
+				 cl_owner_id_hash)->cl_net !=3D clp->cl_net) {
+			rcu_read_unlock();
+			spin_unlock(&nfs4_owner_id_lock);
+			return false;
+		}
+		rcu_read_unlock();
+		ret =3D rhltable_insert(&nfs4_owner_id,
+				      &clp->cl_owner_id_hash,
+				      nfs4_owner_id_params);
+		spin_unlock(&nfs4_owner_id_lock);
+		if (ret =3D=3D 0)
+			return true;
+		/* Transient error */
+		msleep(20);
+		loops +=3D 1;
+	}
+	return false;
+}
+
+void nfs4_drop_owner_id(struct nfs_client *clp)
+{
+	if (clp->cl_owner_id)
+		rhltable_remove(&nfs4_owner_id, &clp->cl_owner_id_hash,
+				nfs4_owner_id_params);
+}
+
 static int
 nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 {
@@ -6289,6 +6374,8 @@ nfs4_init_nonuniform_client_string(struct nfs_client *c=
lp)
 	rcu_read_unlock();
=20
 	clp->cl_owner_id =3D str;
+	if (!nfs4_record_owner_id(clp))
+		return -EADDRINUSE;
 	return 0;
 }
=20
@@ -6331,6 +6418,8 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
 			  clp->rpc_ops->version, clp->cl_minorversion,
 			  clp->cl_rpcclient->cl_nodename);
 	clp->cl_owner_id =3D str;
+	if (!nfs4_record_owner_id(clp))
+		return -EADDRINUSE;
 	return 0;
 }
=20
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f5a62c0d999b..a5cd5c2d6dac 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2276,6 +2276,10 @@ int nfs4_discover_server_trunking(struct nfs_client *c=
lp,
 	case -EINTR:
 	case -ERESTARTSYS:
 		break;
+	case -EADDRINUSE: /* cl_owner_id not unique */
+		dprintk("NFS: client id \"%s\" is used in other network namespace\n",
+			clp->cl_owner_id);
+		break;
 	case -ETIMEDOUT:
 		if (clnt->cl_softrtry)
 			break;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d09bcfd7db89..62f6d15c2bf9 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -280,11 +280,17 @@ static int __init init_nfs_v4(void)
 	if (err)
 		goto out2;
=20
+	err =3D nfs4_init_owner_id_hash();
+	if (err)
+		goto out3;
+
 #ifdef CONFIG_NFS_V4_2
 	nfs42_ssc_register_ops();
 #endif
 	register_nfs_version(&nfs_v4);
 	return 0;
+out3:
+	nfs4_unregister_sysctl();
 out2:
 	nfs_idmap_quit();
 out1:
@@ -298,6 +304,8 @@ static void __exit exit_nfs_v4(void)
 	/* Not called in the _init(), conditionally loaded */
 	nfs4_pnfs_v3_ds_connect_unload();
=20
+	nfs4_destroy_owner_id_hash();
+
 	unregister_nfs_version(&nfs_v4);
 #ifdef CONFIG_NFS_V4_2
 	nfs4_xattr_cache_exit();
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ca0959e51e81..a9da00b6aeb6 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/rhashtable-types.h>
=20
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -84,6 +85,7 @@ struct nfs_client {
=20
 	/* Client owner identifier */
 	const char *		cl_owner_id;
+	struct rhlist_head	cl_owner_id_hash;
=20
 	u32			cl_cb_ident;	/* v4.0 callback identifier */
 	const struct nfs4_minor_version_ops *cl_mvops;
--=20
2.35.1

