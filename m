Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31A165045
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2020 21:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSUwU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Feb 2020 15:52:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726713AbgBSUwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Feb 2020 15:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582145539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wrkiBu0h5uAOt+If2s2SgxKOtzeWd4zR2AHvODxt2Rw=;
        b=Ov2bdGKTig80yAf/OIBCYMUbgkW/AqCLuD4ZHBmnFPhaJfH6zwqnzj5VsywC2202efODP4
        1b1LUmKol86/9Wn3NQzOyXx/CZvMFv8eQmlq+fZUNY9/FttuTsRC1gLbD0YDYPC8Phwa8T
        FMbtEmJqZO3vfk9Ppi8LcJgPxPN08Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-q9cm9U08NACdf6wawAXWOA-1; Wed, 19 Feb 2020 15:52:17 -0500
X-MC-Unique: q9cm9U08NACdf6wawAXWOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5707D1005510;
        Wed, 19 Feb 2020 20:52:16 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-124-62.rdu2.redhat.com [10.10.124.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D4A15C13C;
        Wed, 19 Feb 2020 20:52:16 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 4DCCE1A2C35; Wed, 19 Feb 2020 15:52:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: set the server_scope during service startup
Date:   Wed, 19 Feb 2020 15:52:15 -0500
Message-Id: <20200219205215.3429408-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, nfsd4_encode_exchange_id() encodes the utsname nodename
string in the server_scope field.  In a multi-host container
environemnt, if an nfsd container is restarted on a different host than
it was originally running on, clients will see a server_scope mismatch
and will not attempt to reclaim opens.

Instead, set the server_scope while we're in a process context during
service startup, so we get the utsname nodename of the current process
and store that in nfsd_net.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/netns.h   | 1 +
 fs/nfsd/nfs4xdr.c | 3 ++-
 fs/nfsd/nfssvc.c  | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 2baf32311e00..c6d95700105e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -172,6 +172,7 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
=20
 	struct shrinker		nfsd_reply_cache_shrinker;
+	char			server_scope[UNX_MAXNODENAME+1];
 };
=20
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9761512674a0..209174ee431a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4005,10 +4005,11 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres=
 *resp, __be32 nfserr,
 	int major_id_sz;
 	int server_scope_sz;
 	uint64_t minor_id =3D 0;
+	struct nfsd_net *nn =3D net_generic(SVC_NET(resp->rqstp), nfsd_net_id);
=20
 	major_id =3D utsname()->nodename;
 	major_id_sz =3D strlen(major_id);
-	server_scope =3D utsname()->nodename;
+	server_scope =3D nn->server_scope;
 	server_scope_sz =3D strlen(server_scope);
=20
 	p =3D xdr_reserve_space(xdr,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3b77b904212d..c4e00979aca4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -749,6 +749,9 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
 	if (nrservs =3D=3D 0 && nn->nfsd_serv =3D=3D NULL)
 		goto out;
=20
+	strlcpy(nn->server_scope, utsname()->nodename,
+		sizeof(nn->server_scope));
+
 	error =3D nfsd_create_serv(net);
 	if (error)
 		goto out;
--=20
2.24.1

