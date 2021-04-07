Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF2356E45
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhDGOQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 10:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232839AbhDGOQN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 10:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617804963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A4nUehrQQeQG3SHiV5bZynIabwm46q8oe+eV6IRO3+s=;
        b=FvxwBTVNbld5xU00XKwb1Z6KaRiSp3VXEPXd+qMA4kbHTr28WoBOOkqOkR9X6Gniq4ffRb
        kTjFTcJnxOsevzGUVJcMSPANcgwBENdCNc0Nqhe7cF2+owDsM/din7MM/AQoZIVLW5NZuk
        4hTBRZbJKfGNNpIem+3W69yOhLwW7ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-UjD0uLdLPM-bu6IC-6d-eA-1; Wed, 07 Apr 2021 10:16:01 -0400
X-MC-Unique: UjD0uLdLPM-bu6IC-6d-eA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D851883525
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 14:16:00 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371D419C78
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 14:16:00 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS server should enable RDMA by default
Date:   Wed,  7 Apr 2021 10:18:10 -0400
Message-Id: <20210407141810.33710-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Product is shipped with NFS/RDMA disabled by default.
An extra step is needed when setting up an NFS server
to support NFS/RDMA clients.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1931565

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 nfs.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs.conf b/nfs.conf
index 9042d27d..31994f61 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -72,9 +72,9 @@
 # vers4.0=y
 # vers4.1=y
 # vers4.2=y
-# rdma=n
-# rdma-port=20049
-#
+rdma=y
+rdma-port=20049
+
 [statd]
 # debug=0
 # port=0
-- 
2.30.2

