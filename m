Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89A1F31BA
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2019 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKGOpi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Nov 2019 09:45:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727779AbfKGOph (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Nov 2019 09:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573137936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0+t9gJ7D0EDjJw8VJhNCnBUpQVliO4mUQY4dCK4kz1c=;
        b=etHNHbYkItqkOExmv2oLgk3fd0sKL3nFgWSYrD9KaUZ8r78eYJwLW/110N9Bcc9bEWZO/K
        felwwuiECNdnpHu5eERh8Fx9Ou6hObidhMnbruyVqbmMlIU3GEVdzfy6vE4jMDOWe5n4Un
        Yk9/UGJmYPURHnMJiYtiQp8iV+hUj7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-cijGXGMzPHuuYvelCnfkuA-1; Thu, 07 Nov 2019 09:45:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFA661800D6B;
        Thu,  7 Nov 2019 14:45:31 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDA95D9E5;
        Thu,  7 Nov 2019 14:45:31 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 0300E10C30F1; Thu,  7 Nov 2019 16:56:12 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        zhangxiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS4: Fix race to cl_confirm for v4.0 mount
Date:   Thu,  7 Nov 2019 16:56:12 -0500
Message-Id: <dfda8b5526136f03d108940f69256393dd4aa0a8.1573163645.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cijGXGMzPHuuYvelCnfkuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After commit f02f3755dbd1 ("NFS4: Fix v4.0 client state corruption when
mount") I have reports that sometimes all open() calls fail with -EPERM.
It appears that a race between the SETCLIENTID in trunking discovery and
another superflous SETCLIENTID triggered by immediately running the state
manager causes the nfs_client cl_confirm value to be stored in the wrong
order.

It doesn't really make sense to invoke the state manager just to clear the
NFS4CLNT_LEASE_EXPIRED flag.  The flag has historically been used to signal
that a new client still needs to perform a SETCLIENTID before creating
state, but now that we have trunking discovery that flag is unnecessary.

Remove the flag, remove the call to schedule the state manager from
trunking discovery.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: f02f3755dbd1 ("NFS4: Fix v4.0 client state corruption when mount")
Cc: stable@vger.kernel.org #v5.2
---
 fs/nfs/nfs4client.c | 1 -
 fs/nfs/nfs4state.c  | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index da6204025a2d..56cb3613082d 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -215,7 +215,6 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_c=
lient_initdata *cl_init)
 =09INIT_DELAYED_WORK(&clp->cl_renewd, nfs4_renew_state);
 =09INIT_LIST_HEAD(&clp->cl_ds_clients);
 =09rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS client");
-=09clp->cl_state =3D 1 << NFS4CLNT_LEASE_EXPIRED;
 =09clp->cl_minorversion =3D cl_init->minorversion;
 =09clp->cl_mvops =3D nfs_v4_minor_ops[cl_init->minorversion];
 =09clp->cl_mig_gen =3D 1;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cad4e064b328..e1d5dc4a31d7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -180,10 +180,6 @@ int nfs40_discover_server_trunking(struct nfs_client *=
clp,
 =09=09/* Sustain the lease, even if it's empty.  If the clientid4
 =09=09 * goes stale it's of no use for trunking discovery. */
 =09=09nfs4_schedule_state_renewal(*result);
-
-=09=09/* If the client state need to recover, do it. */
-=09=09if (clp->cl_state)
-=09=09=09nfs4_schedule_state_manager(clp);
 =09}
 out:
 =09return status;
--=20
2.20.1

