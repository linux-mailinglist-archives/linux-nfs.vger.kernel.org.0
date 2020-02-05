Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D880153265
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBEOCA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 09:02:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbgBEOCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 09:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580911319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoMY6NAzEtkugf9WlTQhFAnfFiqkKAex1f0Cty9yx/I=;
        b=haM252pjoygBhuWnL4TbTJmQME+XBloq0aXAJPNMidmRlE+UCM5PjosPnYfTHbiLg9qIXt
        rFZzNWyBROzQ1K6KNdRqOkXwPBqaerl0TA+0AB6y7jgqjKPJKzYZuzR8pbzodqqdNHbYxF
        EZ8k4Yqy05Z7rScX2nHIlYPSoxLXPhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-rQpBONrdO-asbiA-OaVYYA-1; Wed, 05 Feb 2020 09:01:56 -0500
X-MC-Unique: rQpBONrdO-asbiA-OaVYYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCA29800D5C;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6426289E81;
        Wed,  5 Feb 2020 14:01:55 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id EC5A210C1FC9; Wed,  5 Feb 2020 09:01:54 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4: Fix races between open and dentry revalidation
Date:   Wed,  5 Feb 2020 09:01:53 -0500
Message-Id: <c594c55e683648cfa73a93bb11072befd496b6e1.1580910601.git.bcodding@redhat.com>
In-Reply-To: <1fb737c85fdfc56abe19cac56c04b6b9bf4287d8.1580910601.git.bcodding@redhat.com>
References: <cover.1580910601.git.bcodding@redhat.com> <1fb737c85fdfc56abe19cac56c04b6b9bf4287d8.1580910601.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

We want to make sure that we revalidate the dentry if and only if
we've done an OPEN by filename.
In order to avoid races with remote changes to the directory on the
server, we want to save the verifier before calling OPEN. The exception
is if the server returned a delegation with our OPEN, as we then
know that the filename can't have changed on the server.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@gmail.com>
Tested-by: Benjamin Coddington <bcodding@gmail.com>
---
 fs/nfs/nfs4file.c |  1 -
 fs/nfs/nfs4proc.c | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index be4eb720d5b6..1297919e0fce 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -87,7 +87,6 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (inode !=3D d_inode(dentry))
 		goto out_drop;
=20
-	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 	nfs_file_set_open_context(filp, ctx);
 	nfs_fscache_open_file(inode, filp);
 	err =3D 0;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 95d07a3dc5d1..6616a575711e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2974,10 +2974,13 @@ static int _nfs4_open_and_get_state(struct nfs4_o=
pendata *opendata,
 	struct dentry *dentry;
 	struct nfs4_state *state;
 	fmode_t acc_mode =3D _nfs4_ctx_to_accessmode(ctx);
+	struct inode *dir =3D d_inode(opendata->dir);
+	unsigned long dir_verifier;
 	unsigned int seq;
 	int ret;
=20
 	seq =3D raw_seqcount_begin(&sp->so_reclaim_seqcount);
+	dir_verifier =3D nfs_save_change_attribute(dir);
=20
 	ret =3D _nfs4_proc_open(opendata, ctx);
 	if (ret !=3D 0)
@@ -3005,8 +3008,19 @@ static int _nfs4_open_and_get_state(struct nfs4_op=
endata *opendata,
 			dput(ctx->dentry);
 			ctx->dentry =3D dentry =3D alias;
 		}
-		nfs_set_verifier(dentry,
-				nfs_save_change_attribute(d_inode(opendata->dir)));
+	}
+
+	switch(opendata->o_arg.claim) {
+	default:
+		break;
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
+	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
+		if (!opendata->rpc_done)
+			break;
+		if (opendata->o_res.delegation_type !=3D 0)
+			dir_verifier =3D nfs_save_change_attribute(dir);
+		nfs_set_verifier(dentry, dir_verifier);
 	}
=20
 	/* Parse layoutget results before we check for access */
--=20
2.20.1

