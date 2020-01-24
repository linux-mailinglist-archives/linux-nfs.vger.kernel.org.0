Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5AAE148691
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbgAXOJj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 09:09:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43940 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387482AbgAXOJj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jan 2020 09:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579874978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxTERPClpWKWO75L5Ftin2yPor8S0fx4JN8JgtIE5Qw=;
        b=Q3jTbexxNDopYRwYMbpsrA1wwyMeezbA7sHW95ib2G5HeztNcPJKthSFb+QaaAr7hzUraH
        of2Gm8zo00uaruy/nqZPVoHweXzsCDiXiF1NklMHUeQsGIK7BEC6JLKjBViFd0vu/k2GOy
        1DVKzMjvc3aa9v7DOqCVeMH0cAkojqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-OkKqfcxuNKe9f_kt0Xw9_A-1; Fri, 24 Jan 2020 09:09:34 -0500
X-MC-Unique: OkKqfcxuNKe9f_kt0Xw9_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA2BD800E21;
        Fri, 24 Jan 2020 14:09:32 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6565F5C290;
        Fri, 24 Jan 2020 14:09:31 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6525010C1FC7; Fri, 24 Jan 2020 09:09:31 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Revalidate once when holding a delegation
Date:   Fri, 24 Jan 2020 09:09:31 -0500
Message-Id: <c65905b1e2fdaddc6271cbf510d7e30c8790de63.1579874894.git.bcodding@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we skip lookup revalidataion while holding a delegation, we might miss
that the file has changed directories on the server.  This can happen if
the file is moved in between the client caching a dentry and obtaining a
delegation.  That can be reproduced on a single system with this bash:

mkdir -p /exports/dir{1,2}
exportfs -o rw localhost:/exports
mount -t nfs -ov4.1,noac localhost:/exports /mnt/localhost

touch /exports/dir1/fubar

cat /mnt/localhost/dir1/fubar
mv /mnt/localhost/dir{1,2}/fubar

mv /exports/dir{2,1}/fubar

cat /mnt/localhost/dir1/fubar
mv /mnt/localhost/dir{1,2}/fubar

In this example, the final `mv` will stat source and destination and find
they are the same dentry.

To fix this without giving up the increased lookup performance that holdi=
ng
a delegation provides, let's revalidate the dentry only once after
obtaining a delegation by placing a magic value in the dentry's verifier.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..81a5a28d0015 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1073,6 +1073,7 @@ int nfs_neg_need_reval(struct inode *dir, struct de=
ntry *dentry,
 	return !nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU);
 }
=20
+#define NFS_DELEGATION_VERF 0xfeeddeaf
 static int
 nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 			   struct inode *inode, int error)
@@ -1133,6 +1134,7 @@ nfs_lookup_revalidate_dentry(struct inode *dir, str=
uct dentry *dentry,
 	struct nfs_fh *fhandle;
 	struct nfs_fattr *fattr;
 	struct nfs4_label *label;
+	unsigned long verifier;
 	int ret;
=20
 	ret =3D -ENOMEM;
@@ -1154,6 +1156,11 @@ nfs_lookup_revalidate_dentry(struct inode *dir, st=
ruct dentry *dentry,
 	if (nfs_refresh_inode(inode, fattr) < 0)
 		goto out;
=20
+	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+		verifier =3D NFS_DELEGATION_VERF;
+	else
+		verifier =3D nfs_save_change_attribute(dir);
+
 	nfs_setsecurity(inode, fattr, label);
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
=20
@@ -1167,6 +1174,15 @@ nfs_lookup_revalidate_dentry(struct inode *dir, st=
ruct dentry *dentry,
 	return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
 }
=20
+static int nfs_delegation_matches_dentry(struct inode *dir,
+			struct dentry *dentry, struct inode *inode)
+{
+	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ) &&
+		dentry->d_time =3D=3D NFS_DELEGATION_VERF)
+		return 1;
+	return 0;
+}
+
 /*
  * This is called every time the dcache has a lookup hit,
  * and we should check whether we can really trust that
@@ -1197,7 +1213,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct =
dentry *dentry,
 		goto out_bad;
 	}
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_delegation_matches_dentry(dir, dentry, inode))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* Force a full look up iff the parent directory has changed */
@@ -1635,7 +1651,7 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct=
 dentry *dentry,
 	if (inode =3D=3D NULL)
 		goto full_reval;
=20
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+	if (nfs_delegation_matches_dentry(dir, dentry, inode))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
=20
 	/* NFS only supports OPEN on regular files */
--=20
2.20.1

