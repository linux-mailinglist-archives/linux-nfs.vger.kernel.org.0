Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E579165E32
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2020 14:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBTNGd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Feb 2020 08:06:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34418 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgBTNGd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Feb 2020 08:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582203992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g9Y+jsuv8YiH9Ipyq7t0skm9Xq64VOkJVEbrX2A/HbE=;
        b=SxnRHc4LLzFIBZgNJnl1Lv9v77K4qa9v8M3XzpZXHY4hb0KyJAGvCrTYQCO2HvuBDNOvgD
        fncgX5YHlsNgkKhv/tYnE4VDV08z8ZOO2TlLk1bEJ0QvEMT9BpIqpiTZV3c1YawA0u8TyS
        bEGc92eLdjAsg48kaseWh7BP1wCsDpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283--1QdaoA8PDOpQt21MVqMDQ-1; Thu, 20 Feb 2020 08:06:28 -0500
X-MC-Unique: -1QdaoA8PDOpQt21MVqMDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5238017CC;
        Thu, 20 Feb 2020 13:06:27 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-124-62.rdu2.redhat.com [10.10.124.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA0328CCC5;
        Thu, 20 Feb 2020 13:06:26 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id A6E5A1A2C3F; Thu, 20 Feb 2020 08:06:20 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     ps@pks.im, dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't hard-code the fs_type when submounting
Date:   Thu, 20 Feb 2020 08:06:20 -0500
Message-Id: <20200220130620.3547817-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hard-coding the fstype causes "nfs4" mounts to appear as "nfs",
which breaks scripts that do "umount -at nfs4".

Reported-by: Patrick Steinhardt <ps@pks.im>
Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index ad6077404947..f3ece8ed3203 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -153,7 +153,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	/* Open a new filesystem context, transferring parameters from the
 	 * parent superblock, including the network namespace.
 	 */
-	fc =3D fs_context_for_submount(&nfs_fs_type, path->dentry);
+	fc =3D fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry)=
;
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
=20
--=20
2.24.1

