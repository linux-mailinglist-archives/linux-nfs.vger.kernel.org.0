Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B181168843
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 21:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBUUVn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 15:21:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726483AbgBUUVn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 15:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582316502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fKXHNJzsXBh9TaU48K4X0hmLun2V6XXcrEjaWTz6BBM=;
        b=EN++kYgJitctrzomvoqB9nKZfRZWWF3gmjV50lPiRHABDUhSb24qAxZI4N4W2E312KIl7Y
        cyWVNSCY2Wcwh8plM/4hIlTKgs0M1GqQNMxhCbPv1h+lGqGfkC/rSiR+ss/xWZfV2Av82l
        aRLzfimbKG+5AyhdG+BJVPg+0QXRL0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-4AtRXSu3MI6RoE4I0WfIEQ-1; Fri, 21 Feb 2020 15:21:40 -0500
X-MC-Unique: 4AtRXSu3MI6RoE4I0WfIEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F44E6125F;
        Fri, 21 Feb 2020 20:21:39 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-123-59.rdu2.redhat.com [10.10.123.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 627435D9E2;
        Fri, 21 Feb 2020 20:21:39 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id AB79C1A00A4; Fri, 21 Feb 2020 15:21:38 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     ps@pks.im, dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Ensure the fs_context has the correct fs_type before mounting
Date:   Fri, 21 Feb 2020 15:21:38 -0500
Message-Id: <20200221202138.3744133-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is necessary because unless userspace explicitly requests fstype
"nfs4" (either via "mount -t nfs4" or by calling the "mount.nfs4" helper
directly), the fstype will default to "nfs".

This was fine on older kernels because the super_block->s_type was set
via mount_info->nfs_mod->nfs_fs, which was set when parsing the mount
options and subsequently passed in the "type" argument of sget().

After commit f2aedb713c28 ("NFS: Add fs_context support."), sget_fc(),
which has no "type" argument, is called instead.  In sget_fc(), the
super_block->s_type is set via fs_context->fs_type, which was set when
the filesystem context was initially created.

Reported-by: Patrick Steinhardt <ps@pks.im>
Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/fs_context.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index e1b938457ab9..b616263b0eb6 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1240,6 +1240,13 @@ static int nfs_fs_context_validate(struct fs_conte=
xt *fc)
 		}
 		ctx->nfs_mod =3D nfs_mod;
 	}
+
+	/* Ensure the filesystem context has the correct fs_type */
+	if (fc->fs_type !=3D ctx->nfs_mod->nfs_fs) {
+		module_put(fc->fs_type->owner);
+		__module_get(ctx->nfs_mod->nfs_fs->owner);
+		fc->fs_type =3D ctx->nfs_mod->nfs_fs;
+	}
 	return 0;
=20
 out_no_device_name:
--=20
2.24.1

