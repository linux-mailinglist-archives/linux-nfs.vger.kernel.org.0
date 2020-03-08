Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65A17D5D6
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Mar 2020 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgCHTWZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Mar 2020 15:22:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgCHTWZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Mar 2020 15:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583695344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k+06c3ftd6Dz8n0ftVlHdIoiiu2oDYVfjVRVmvoZXe8=;
        b=PtDc1jSa+8/EP/0FrVo3MzN2BXagmi5L8hF1cG3rF4BrIbu3qfxRt2pq/y/wiw7+MzkIOa
        0RILzh/SJ5yTGbyZBBkIAMCZHo9uz9mFUsrWBjhUQNBiW7Rofj8cb27k/rhKcZ1lFCc7/j
        LQji4qXVxjH9Md5hb0QWaEAxKdrZZjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-SiArl8Q1N92AFF0AuaBQjg-1; Sun, 08 Mar 2020 15:22:21 -0400
X-MC-Unique: SiArl8Q1N92AFF0AuaBQjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C68413EA
        for <linux-nfs@vger.kernel.org>; Sun,  8 Mar 2020 19:22:20 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-118-58.phx2.redhat.com [10.3.118.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C81E78F341
        for <linux-nfs@vger.kernel.org>; Sun,  8 Mar 2020 19:22:16 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] gssd: ignore pipe files that do not exist
Date:   Sun,  8 Mar 2020 15:22:14 -0400
Message-Id: <20200308192214.25071-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As part commit e0eb6ebb which cleaned up the
dnotify to inotify conversion (commit 55197c98)
ignore pipe files that don't exist

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/gssd/gssd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index c38dedb..588da0f 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -493,8 +493,8 @@ gssd_get_clnt(struct topdir *tdi, const char *name)
 	clp->wd =3D inotify_add_watch(inotify_fd, clp->relpath, IN_CREATE | IN_=
DELETE);
 	if (clp->wd < 0) {
 		if (errno !=3D ENOENT)
-			printerr(0, "ERROR: inotify_add_watch failed for %s: %s\n",
-			 	clp->relpath, strerror(errno));
+			printerr(0, "ERROR: %s: inotify_add_watch failed for %s: %s\n",
+			 	__FUNCTION__, clp->relpath, strerror(errno));
 		goto out;
 	}
=20
@@ -523,8 +523,9 @@ gssd_scan_clnt(struct clnt_info *clp)
=20
 	clntfd =3D openat(pipefs_fd, clp->relpath, O_RDONLY);
 	if (clntfd < 0) {
-		printerr(0, "ERROR: can't openat %s: %s\n",
-			 clp->relpath, strerror(errno));
+		if (errno !=3D ENOENT)
+			printerr(0, "ERROR: %s: can't openat %s: %s\n",
+			 	__FUNCTION__, clp->relpath, strerror(errno));
 		return -1;
 	}
=20
@@ -588,8 +589,8 @@ gssd_get_topdir(const char *name)
=20
 	tdi->wd =3D inotify_add_watch(inotify_fd, name, IN_CREATE);
 	if (tdi->wd < 0) {
-		printerr(0, "ERROR: inotify_add_watch failed for top dir %s: %s\n",
-			 tdi->name, strerror(errno));
+		printerr(0, "ERROR: %s: inotify_add_watch failed for top dir %s: %s\n"=
,
+			 __FUNCTION__, tdi->name, strerror(errno));
 		free(tdi);
 		return NULL;
 	}
@@ -616,8 +617,9 @@ gssd_scan_topdir(const char *name)
=20
 	dfd =3D openat(pipefs_fd, tdi->name, O_RDONLY);
 	if (dfd < 0) {
-		printerr(0, "ERROR: can't openat %s: %s\n",
-			 tdi->name, strerror(errno));
+		if (errno !=3D ENOENT)
+			printerr(0, "ERROR: %s: can't openat %s: %s\n",
+			 	__FUNCTION__, tdi->name, strerror(errno));
 		return;
 	}
=20
--=20
2.24.1

