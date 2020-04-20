Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9061B0D68
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgDTNv6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 09:51:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728453AbgDTNv5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 09:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587390716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=00MEmElFq0InaxZeBkM2hq8Ej0A8kJ9QIciCtrGjSuQ=;
        b=YWyYOqzveo+SOa8o9G3YZBMG+ha8f6nUczjJnz8ds4ZAAMvd5CmMlM4JYL92ebZB4znyna
        C3RxJ36talO6IjnjhS/EYI3iuCKtFWhE3kWoCRFaouxnlk4qjKfFDsYhddjGqMlW+d79ab
        XQEG61eKEkWK+vbCWQPym8WjRQZa4vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-CborrHU8Moqzqf41xip6Ww-1; Mon, 20 Apr 2020 09:51:54 -0400
X-MC-Unique: CborrHU8Moqzqf41xip6Ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8779BA0CC8;
        Mon, 20 Apr 2020 13:51:52 +0000 (UTC)
Received: from max.home.com (ovpn-114-63.ams2.redhat.com [10.36.114.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7546310013A1;
        Mon, 20 Apr 2020 13:51:49 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "okir@suse.de" <okir@suse.de>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "akpm@osdl.org" <akpm@osdl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>
Subject: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Date:   Mon, 20 Apr 2020 15:51:47 +0200
Message-Id: <20200420135147.21572-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs3_set_acl keeps track of the acl it allocated locally to determine if =
an acl
needs to be released at the end.  This results in a memory leak when the
function allocates an acl as well as a default acl.  Fix by releasing acl=
s
that differ from the acl originally passed into nfs3_set_acl.

Fixes: b7fa0554cf1b ("[PATCH] NFS: Add support for NFSv3 ACLs")
Reported-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/nfs/nfs3acl.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index c5c3fc6e6c60..26c94b32d6f4 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -253,37 +253,45 @@ int nfs3_proc_setacls(struct inode *inode, struct p=
osix_acl *acl,
=20
 int nfs3_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
-	struct posix_acl *alloc =3D NULL, *dfacl =3D NULL;
+	struct posix_acl *orig =3D acl, *dfacl =3D NULL, *alloc;
 	int status;
=20
 	if (S_ISDIR(inode->i_mode)) {
 		switch(type) {
 		case ACL_TYPE_ACCESS:
-			alloc =3D dfacl =3D get_acl(inode, ACL_TYPE_DEFAULT);
+			alloc =3D get_acl(inode, ACL_TYPE_DEFAULT);
 			if (IS_ERR(alloc))
 				goto fail;
+			dfacl =3D alloc;
 			break;
=20
 		case ACL_TYPE_DEFAULT:
-			dfacl =3D acl;
-			alloc =3D acl =3D get_acl(inode, ACL_TYPE_ACCESS);
+			alloc =3D get_acl(inode, ACL_TYPE_ACCESS);
 			if (IS_ERR(alloc))
 				goto fail;
+			dfacl =3D acl;
+			acl =3D alloc;
 			break;
 		}
 	}
=20
 	if (acl =3D=3D NULL) {
-		alloc =3D acl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		alloc =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
 		if (IS_ERR(alloc))
 			goto fail;
+		acl =3D alloc;
 	}
 	status =3D __nfs3_proc_setacls(inode, acl, dfacl);
-	posix_acl_release(alloc);
+out:
+	if (acl !=3D orig)
+		posix_acl_release(acl);
+	if (dfacl !=3D orig)
+		posix_acl_release(dfacl);
 	return status;
=20
 fail:
-	return PTR_ERR(alloc);
+	status =3D PTR_ERR(alloc);
+	goto out;
 }
=20
 const struct xattr_handler *nfs3_xattr_handlers[] =3D {

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
--=20
2.25.3

