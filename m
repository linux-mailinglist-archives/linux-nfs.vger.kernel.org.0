Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD7614CDC5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgA2PrK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 10:47:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgA2PrK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 10:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580312829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmS5cJ70b8059t69VzCcVW7xFuXd/e/NtOVGp4Hf8UQ=;
        b=Y2z43ng1PZnsPB+5aaHTkyW7l6U2CNCRYaI7qsOG6KY7UCwY/4MhExbhZFsYOdOsrOY1zj
        g14Gm2WcBnDPEytru5DWLoTfXfsS0T3bFV8Inn6uqZmwdQb22APC6dRoEPPr948QUAB/+N
        FKS27Df5u94g/aRaGFTm0nX5sFwSKE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-muW5GPGgMY6ryp2VGaqqKA-1; Wed, 29 Jan 2020 10:47:07 -0500
X-MC-Unique: muW5GPGgMY6ryp2VGaqqKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E2B58010D8
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 15:47:06 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBB2CFDEC
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 15:47:06 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] manpage: Add a description of the 'softreval' / 'nosoftreval' mount option
Date:   Wed, 29 Jan 2020 10:47:03 -0500
Message-Id: <20200129154703.6204-2-steved@redhat.com>
In-Reply-To: <20200129154703.6204-1-steved@redhat.com>
References: <20200129154703.6204-1-steved@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a description of the 'softreval' / 'nosoftreval' mount options on
the 'nfs' generic manpage.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/nfs.man | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 84462cd..6f79c63 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -121,6 +121,36 @@ option may mitigate some of the risks of using the
 .B soft
 option.
 .TP 1.5i
+.BR softreval " / " nosoftreval
+In cases where the NFS server is down, it may be useful to
+allow the NFS client to continue to serve up paths and
+attributes from cache after
+.B retrans
+attempts to revalidate that cache have timed out.
+This may, for instance, be helpful when trying to unmount a
+filesystem tree from a server that is permanently down.
+.IP
+It is possible to combine
+.BR softreval
+with the
+.B soft
+mount option, in which case operations that cannot be served up
+from cache will time out and return an error after
+.B retrans
+attempts. The combination with the default
+.B hard
+mount option implies those uncached operations will continue to
+retry until a response is received from the server.
+.IP
+Note: the default mount option is
+.BR nosoftreval
+which disallows fallback to cache when revalidation fails, and
+instead follows the behavior dictated by the
+.B hard
+or
+.B soft
+mount option.
+.TP 1.5i
 .BR intr " / " nointr
 This option is provided for backward compatibility.
 It is ignored after kernel 2.6.25.
--=20
2.21.1

