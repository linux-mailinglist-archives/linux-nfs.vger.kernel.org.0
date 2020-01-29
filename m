Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBB14CDC6
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA2PrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 10:47:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgA2PrQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 10:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580312835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ZU2PWW+aEL0mF+GQoH2Y43Kx7XYMF9rs6T5DwJw30I=;
        b=RqjjWewOK2kosfvE+R1B8xUVDgoR7JjElxWKRbo8dwKAfc42lm6gUevh4vwMPheUAhGW+F
        2kdHJuQBh62YQXM1uZsRwWYJCcLLKP4m5q2S+i4K6bphl5xq8VkuJv+P/H2ZG4aEhO9IiF
        DhZuh0SUMNttcd5GVORr236d7AOae/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-CXPQkCkkMAaO7aFc1yvvGg-1; Wed, 29 Jan 2020 10:47:07 -0500
X-MC-Unique: CXPQkCkkMAaO7aFc1yvvGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9A11034B04
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 15:47:06 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED1FBCFDEF
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 15:47:05 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount option
Date:   Wed, 29 Jan 2020 10:47:02 -0500
Message-Id: <20200129154703.6204-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a description of the 'nconnect' mount option on the 'nfs' generic
manpage.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/nfs.man | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 6ba9cef..84462cd 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -369,6 +369,23 @@ using an automounter (refer to
 .BR automount (8)
 for details).
 .TP 1.5i
+.BR nconnect=3D n
+When using a connection oriented protocol such as TCP, it may
+sometimes be advantageous to set up multiple connections between
+the client and server. For instance, if your clients and/or servers
+are equipped with multiple network interface cards (NICs), using multipl=
e
+connections to spread the load may improve overall performance.
+In such cases, the
+.BR nconnect
+option allows the user to specify the number of connections
+that should be established between the client and server up to
+a limit of 16.
+.IP
+Note that the
+.BR nconnect
+option may also be used by some pNFS drivers to decide how many
+connections to set up to the data servers.
+.TP 1.5i
 .BR rdirplus " / " nordirplus
 Selects whether to use NFS v3 or v4 READDIRPLUS requests.
 If this option is not specified, the NFS client uses READDIRPLUS request=
s
--=20
2.21.1

