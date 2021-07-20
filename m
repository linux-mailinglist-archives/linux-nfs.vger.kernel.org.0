Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B323D03D9
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhGTUqD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jul 2021 16:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234558AbhGTUpq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jul 2021 16:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626816383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=STi09l/S/lHR78y3a36RM5q8ubxL5HfhU9uiATF0vS0=;
        b=GWQfJjuL5/CocncplVJsEsjby7x/NR7Z9jeiOX8RokdiaQD6iFEl+eMJhbzflfr042XEUJ
        YtKZXCiskn9iRrjIycZmE2JGqM0dTZEB1IGX/5BshBx1KaD02TVtCMs39ZrjNVrEVXETfq
        FQIVqBOwLK1vHd4USn2pr6RemSAYD+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-8UMweuyOMW6oEqEVb5DJMw-1; Tue, 20 Jul 2021 17:26:15 -0400
X-MC-Unique: 8UMweuyOMW6oEqEVb5DJMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB3AC804301
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jul 2021 21:26:12 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-216.phx2.redhat.com [10.3.114.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B6CD69CB8
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jul 2021 21:26:12 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] mount.nfs: Fix the sloppy option processing
Date:   Tue, 20 Jul 2021 17:26:11 -0400
Message-Id: <20210720212611.332856-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new mount API broke how the sloppy option is parsed.
So the option processing needs to be moved up in
the mount.nfs command.

The option needs to be the first option in the string
that is passed into the kernel with the -s mount(8)
and/or the -o sloppy is used.

Commit 92b664ef fixed the process of the -s flag
and this version fixes the -o sloppy processing
as well works when libmount-mount is and is not
enabled plus cleans up the mount options passed
to the kernel.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/nfs.man   |  7 +++++++
 utils/mount/stropts.c | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index f98cb47d..f1b76936 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -555,6 +555,13 @@ using the FS-Cache facility. See cachefilesd(8)
 and <kernel_source>/Documentation/filesystems/caching
 for detail on how to configure the FS-Cache facility.
 Default value is nofsc.
+.TP 1.5i
+.B sloppy
+The
+.B sloppy
+option is an alternative to specifying
+.BR mount.nfs " -s " option.
+
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index 82b054a5..fa67a66f 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -339,11 +339,19 @@ static int nfs_verify_lock_option(struct mount_options *options)
 
 static int nfs_insert_sloppy_option(struct mount_options *options)
 {
-	if (!sloppy || linux_version_code() < MAKE_VERSION(2, 6, 27))
+	if (linux_version_code() < MAKE_VERSION(2, 6, 27))
 		return 1;
 
-	if (po_insert(options, "sloppy") == PO_FAILED)
-		return 0;
+	if (po_contains(options, "sloppy")) {
+		po_remove_all(options, "sloppy");
+		sloppy++;
+	}
+
+	if (sloppy) {
+		if (po_insert(options, "sloppy") == PO_FAILED)
+			return 0;
+	}
+
 	return 1;
 }
 
-- 
2.31.1

