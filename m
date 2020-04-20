Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91C81B0AF0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgDTMv4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 08:51:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729206AbgDTMvy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 08:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587387112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qI4LH96Te2D61UkMMiu56eI+whpozLCjxv2Sx2J1tLs=;
        b=OAdnvoOUUhPKmWvDzvfS4AG+b13krnEf7pUG9nQ2u3pxuIWAvhn06V14y1WQtsFZThYiK5
        bhr+RCFyvd1gt/bIMPVQeZyZHKkNEP/rX8SB2TwMbZ8HbNqOnb7hdefudaxwI/V8n4j2ht
        vwgxA2dj78OrtDhuPW8U2+xlGoQ9nOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Ml-2KNMWM828K23lPn3ExQ-1; Mon, 20 Apr 2020 08:51:48 -0400
X-MC-Unique: Ml-2KNMWM828K23lPn3ExQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162BF1005510;
        Mon, 20 Apr 2020 12:51:47 +0000 (UTC)
Received: from max.home.com (ovpn-114-63.ams2.redhat.com [10.36.114.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5EB15DA7C;
        Mon, 20 Apr 2020 12:51:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "akpm@osdl.org" <akpm@osdl.org>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "okir@suse.de" <okir@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Date:   Mon, 20 Apr 2020 14:51:41 +0200
Message-Id: <20200420125141.18002-1-agruenba@redhat.com>
In-Reply-To: <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn> <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am Mo., 20. Apr. 2020 um 14:15 Uhr schrieb Trond Myklebust <trondmy@hamme=
rspace.com>:
> I don't really see any alternative to adding a 'dfalloc' to track the
> allocated dfacl separately.

Something like the attached patch should work as well.

Thanks,
Andreas

---
 fs/nfs/nfs3acl.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index c5c3fc6e6c60..f1581f11c220 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -253,37 +253,41 @@ int nfs3_proc_setacls(struct inode *inode, struct p=
osix_acl *acl,
=20
 int nfs3_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
-	struct posix_acl *alloc =3D NULL, *dfacl =3D NULL;
+	struct posix_acl *orig =3D acl, *dfacl =3D NULL;
 	int status;
=20
 	if (S_ISDIR(inode->i_mode)) {
 		switch(type) {
 		case ACL_TYPE_ACCESS:
-			alloc =3D dfacl =3D get_acl(inode, ACL_TYPE_DEFAULT);
-			if (IS_ERR(alloc))
-				goto fail;
+			dfacl =3D get_acl(inode, ACL_TYPE_DEFAULT);
+			status =3D PTR_ERR(dfacl);
+			if (IS_ERR(dfacl))
+				goto out;
 			break;
=20
 		case ACL_TYPE_DEFAULT:
 			dfacl =3D acl;
-			alloc =3D acl =3D get_acl(inode, ACL_TYPE_ACCESS);
-			if (IS_ERR(alloc))
-				goto fail;
+			acl =3D get_acl(inode, ACL_TYPE_ACCESS);
+			status =3D PTR_ERR(acl);
+			if (IS_ERR(acl))
+				goto out;
 			break;
 		}
 	}
=20
 	if (acl =3D=3D NULL) {
-		alloc =3D acl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
-		if (IS_ERR(alloc))
-			goto fail;
+		acl =3D posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+		status =3D PTR_ERR(acl);
+		if (IS_ERR(acl))
+			goto out;
 	}
 	status =3D __nfs3_proc_setacls(inode, acl, dfacl);
-	posix_acl_release(alloc);
+out:
+	if (acl !=3D orig)
+		posix_acl_release(acl);
+	if (dfacl !=3D orig)
+		posix_acl_release(dfacl);
 	return status;
-
-fail:
-	return PTR_ERR(alloc);
 }
=20
 const struct xattr_handler *nfs3_xattr_handlers[] =3D {

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
--=20
2.25.3

