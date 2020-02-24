Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716CD16B276
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2020 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBXVae (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Feb 2020 16:30:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728260AbgBXV3o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Feb 2020 16:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582579781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5bk5pZCgs6VtxAuf9W+wz0QczBhsK7k4FVOWw2Wd+jI=;
        b=EC5WQ/dvV9cIgVLAUQbqb7ptxTLkpegdybVFrlZQFEqJrfeA3HIireASz9BOWxJZlg1uUi
        W9Nl1Ez7P/btuMdZ2UV9q5zpItiA7d7+s2jFBwuMkjQhcLC1NkdiRDZiVVc5jwQU29Msv3
        PgJvyiCopqVUgiYp7qsktaqQRjHg12E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-p_VuCA2SNw6gZe65-77JjA-1; Mon, 24 Feb 2020 16:29:34 -0500
X-MC-Unique: p_VuCA2SNw6gZe65-77JjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C1DDB68;
        Mon, 24 Feb 2020 21:29:33 +0000 (UTC)
Received: from f31-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EF961CB;
        Mon, 24 Feb 2020 21:29:33 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     trondmy@hammerspace.com
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: add minor version to nfs_server_key for fscache
Date:   Mon, 24 Feb 2020 16:29:32 -0500
Message-Id: <20200224212932.16287-1-dwysocha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

An NFS client that mounts multiple exports from the same NFS
server with higher NFSv4 versions disabled (i.e. 4.2) and without
forcing a specific NFS version results in fscache index cookie
collisions and the following messages:
[  570.004348] FS-Cache: Duplicate cookie detected

Each nfs_client structure should have its own fscache index cookie,
so add the minorversion to nfs_server_key.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200145
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/client.c     | 1 +
 fs/nfs/fscache.c    | 2 ++
 fs/nfs/nfs4client.c | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 989c30c98511..f1ff3076e4a4 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -153,6 +153,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_=
client_initdata *cl_init)
 	if ((clp =3D kzalloc(sizeof(*clp), GFP_KERNEL)) =3D=3D NULL)
 		goto error_0;
=20
+	clp->cl_minorversion =3D cl_init->minorversion;
 	clp->cl_nfs_mod =3D cl_init->nfs_mod;
 	if (!try_module_get(clp->cl_nfs_mod->owner))
 		goto error_dealloc;
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 52270bfac120..1abf126c2df4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -31,6 +31,7 @@ static DEFINE_SPINLOCK(nfs_fscache_keys_lock);
 struct nfs_server_key {
 	struct {
 		uint16_t	nfsversion;		/* NFS protocol version */
+		uint32_t	minorversion;		/* NFSv4 minor version */
 		uint16_t	family;			/* address family */
 		__be16		port;			/* IP port */
 	} hdr;
@@ -55,6 +56,7 @@ void nfs_fscache_get_client_cookie(struct nfs_client *c=
lp)
=20
 	memset(&key, 0, sizeof(key));
 	key.hdr.nfsversion =3D clp->rpc_ops->version;
+	key.hdr.minorversion =3D clp->cl_minorversion;
 	key.hdr.family =3D clp->cl_addr.ss_family;
=20
 	switch (clp->cl_addr.ss_family) {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 0cd767e5c977..0bd77cc1f639 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -216,7 +216,6 @@ struct nfs_client *nfs4_alloc_client(const struct nfs=
_client_initdata *cl_init)
 	INIT_LIST_HEAD(&clp->cl_ds_clients);
 	rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS client");
 	clp->cl_state =3D 1 << NFS4CLNT_LEASE_EXPIRED;
-	clp->cl_minorversion =3D cl_init->minorversion;
 	clp->cl_mvops =3D nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen =3D 1;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
--=20
2.24.1

