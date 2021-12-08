Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B146D837
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhLHQed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhLHQed (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638981061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBgSlszn2LBtYiF++zGChTSxau/bOicc0H3QN6KbH+Y=;
        b=Z/fxPXBRvE26Mx/Nfm/FyWqCQuutT0Kb/3XW+M6QJ9/TUZJ9akm5JUeKiY7vO3eEJjIIJU
        cshQ/vWHF8QhPU3oDKfpvp5FulR3vCR7eWU1y0BJPYQnNBBCmrWWF0c9OFTVHr2vsaw/pp
        k8FCilugDzK/gcy6wzeXCJQ2QlRoqAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-D-uE8N7zNL-j__ZanZkCaQ-1; Wed, 08 Dec 2021 11:30:59 -0500
X-MC-Unique: D-uE8N7zNL-j__ZanZkCaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29262801AAB
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:59 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.2.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D30902B178
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:58 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/3] nfs.man: Remove references to NFS v2 from the man pages
Date:   Wed,  8 Dec 2021 11:30:56 -0500
Message-Id: <20211208163057.954500-3-steved@redhat.com>
In-Reply-To: <20211208163057.954500-1-steved@redhat.com>
References: <20211208163057.954500-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/mount.nfs.man |  2 +-
 utils/mount/nfs.man       | 20 +++-----------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/utils/mount/mount.nfs.man b/utils/mount/mount.nfs.man
index 0409c96f..a78a3b0d 100644
--- a/utils/mount/mount.nfs.man
+++ b/utils/mount/mount.nfs.man
@@ -27,7 +27,7 @@ can mount all NFS file system versions.  Under earlier Linux kernel versions,
 .BR mount.nfs4
 must be used for mounting NFSv4 file systems while
 .BR mount.nfs
-must be used for NFSv3 and v2.
+must be used for NFSv3.
 
 .SH OPTIONS
 .TP
diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 57a693fd..d9f34df3 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -12,7 +12,7 @@ created by Sun Microsystems in 1984. NFS was developed
 to allow file sharing between systems residing
 on a local area network.
 Depending on kernel configuration, the Linux NFS client may
-support NFS versions 2, 3, 4.0, 4.1, or 4.2.
+support NFS versions 3, 4.0, 4.1, or 4.2.
 .P
 The
 .BR mount (8)
@@ -954,11 +954,6 @@ file. See
 .BR nfsmount.conf(5)
 for details.
 .SH EXAMPLES
-To mount an export using NFS version 2,
-use the
-.B nfs
-file system type and specify the
-.B nfsvers=2
 mount option.
 To mount using NFS version 3,
 use the
@@ -985,13 +980,6 @@ reasonable defaults for NFS behavior.
 	server:/export	/mnt	nfs	defaults	0 0
 .fi
 .P
-Here is an example from an /etc/fstab file for an NFS version 2 mount over UDP.
-.P
-.nf
-.ta 8n +16n +6n +6n +30n
-	server:/export	/mnt	nfs	nfsvers=2,proto=udp	0 0
-.fi
-.P
 This example shows how to mount using NFS version 4 over TCP
 with Kerberos 5 mutual authentication.
 .P
@@ -1084,7 +1072,7 @@ and
 can safely be allowed to default to the largest values supported by
 both client and server, independent of the network's MTU size.
 .SS "Using the mountproto mount option"
-This section applies only to NFS version 2 and version 3 mounts
+This section applies only to NFS version 3 mounts
 since NFS version 4 does not use a separate protocol for mount
 requests.
 .P
@@ -1487,7 +1475,7 @@ the use of the
 mount option.
 .SS "Using file locks with NFS"
 The Network Lock Manager protocol is a separate sideband protocol
-used to manage file locks in NFS version 2 and version 3.
+used to manage file locks in NFS version 3.
 To support lock recovery after a client or server reboot,
 a second sideband protocol --
 known as the Network Status Manager protocol --
@@ -1907,8 +1895,6 @@ RFC 768 for the UDP specification.
 .br
 RFC 793 for the TCP specification.
 .br
-RFC 1094 for the NFS version 2 specification.
-.br
 RFC 1813 for the NFS version 3 specification.
 .br
 RFC 1832 for the XDR specification.
-- 
2.31.1

