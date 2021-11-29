Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFB46207D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 20:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhK2Tc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 14:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233134AbhK2Tay (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 14:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638214056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBgSlszn2LBtYiF++zGChTSxau/bOicc0H3QN6KbH+Y=;
        b=PJwfqNeiTqT3scjgUWImKe6KfBNoesb6DguE6zVo5XGEex4IgX/kaNhEPbTzwFOK5w8vTa
        EyO3GttwC7c9bHU1LKLhPGZ+aqBSsb6+zQVbZuBnDhmYcZ8svlApsAa4DqGzjKO3ERTAW8
        6Vvxw80CG0sS6XUTyscgLfRHj3K5K5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-zn4arutVPHi4t0bZlxP-ew-1; Mon, 29 Nov 2021 14:27:34 -0500
X-MC-Unique: zn4arutVPHi4t0bZlxP-ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B50CD1015DA0
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:33 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6456579452
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:33 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH RFC 2/3] nfs.man: Remove references to NFS v2 from the man pages
Date:   Mon, 29 Nov 2021 14:27:30 -0500
Message-Id: <20211129192731.783466-3-steved@redhat.com>
In-Reply-To: <20211129192731.783466-1-steved@redhat.com>
References: <20211129192731.783466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

