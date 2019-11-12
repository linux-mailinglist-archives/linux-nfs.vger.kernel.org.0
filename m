Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A8F9942
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLTBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 14:01:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726952AbfKLTBt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 14:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573585308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k/hnq3/fW/qgmBi4iP95zyWmQjHxmDKK3flFUTul5T4=;
        b=E13vTFclv1jU4r7gI7oradIrb1rtV+mLCkdYoloWNMtk/07AAYjahHgxeAQUC1G7huIlMK
        hBHJmZF3mrYLeZgELDOUK/ny6oX/JFY35ZgpLIBWybrnjMRmv8P1s0nRYWMPuWHX9L1HqJ
        xsQw0rpZ6SSR7omlbxwduyzeIfn1NQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-BRX-MoWtO4aWGSdXq6Vxhg-1; Tue, 12 Nov 2019 14:01:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B22B31007272;
        Tue, 12 Nov 2019 19:01:44 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-210.rdu2.redhat.com [10.10.122.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4761328DD0;
        Tue, 12 Nov 2019 19:01:44 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id DAB9D208EC; Tue, 12 Nov 2019 14:01:43 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     jamie@audible.transient.net, linux-nfs@vger.kernel.org
Subject: [PATCH v3] nfsd: Fix cld_net->cn_tfm initialization
Date:   Tue, 12 Nov 2019 14:01:43 -0500
Message-Id: <20191112190143.12624-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BRX-MoWtO4aWGSdXq6Vxhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't assign an error pointer to cld_net->cn_tfm, otherwise an oops will
occur in nfsd4_remove_cld_pipe().

Also, move the initialization of cld_net->cn_tfm so that it occurs after
the check to see if nfsdcld is running.  This is necessary because
nfsd4_client_tracking_init() looks for -ETIMEDOUT to determine whether
to use the "old" nfsdcld tracking ops.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index cdc75ad4438b..c35c0ebaf722 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1578,6 +1578,7 @@ nfsd4_cld_tracking_init(struct net *net)
 =09struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
 =09bool running;
 =09int retries =3D 10;
+=09struct crypto_shash *tfm;
=20
 =09status =3D nfs4_cld_state_init(net);
 =09if (status)
@@ -1586,11 +1587,6 @@ nfsd4_cld_tracking_init(struct net *net)
 =09status =3D __nfsd4_init_cld_pipe(net);
 =09if (status)
 =09=09goto err_shutdown;
-=09nn->cld_net->cn_tfm =3D crypto_alloc_shash("sha256", 0, 0);
-=09if (IS_ERR(nn->cld_net->cn_tfm)) {
-=09=09status =3D PTR_ERR(nn->cld_net->cn_tfm);
-=09=09goto err_remove;
-=09}
=20
 =09/*
 =09 * rpc pipe upcalls take 30 seconds to time out, so we don't want to
@@ -1607,6 +1603,12 @@ nfsd4_cld_tracking_init(struct net *net)
 =09=09status =3D -ETIMEDOUT;
 =09=09goto err_remove;
 =09}
+=09tfm =3D crypto_alloc_shash("sha256", 0, 0);
+=09if (IS_ERR(tfm)) {
+=09=09status =3D PTR_ERR(tfm);
+=09=09goto err_remove;
+=09}
+=09nn->cld_net->cn_tfm =3D tfm;
=20
 =09status =3D nfsd4_cld_get_version(nn);
 =09if (status =3D=3D -EOPNOTSUPP)
--=20
2.17.2

