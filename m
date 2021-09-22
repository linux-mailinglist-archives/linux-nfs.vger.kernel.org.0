Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB71C414D35
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhIVPhp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236400AbhIVPho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632324973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xm50amDwEdJyT+MqX3sDHBl8pNMiVQt1LghCgwuKR2A=;
        b=OVMBVbaf0c4sgOb52x7QMUb5w0vEYHcpB4qHMWkqUT2N0+ozQyXM9gXmlCQL6Gu9Vy2x9e
        nKmmYCB3d2LUYipcB8+eJzwVo2fCox6F14X3GEoTxQzmf7jblmyqvvoLv4g6W5z8eQXp3X
        szxofDQWLShNXX3qunWwQIRhobDPVao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-npSN3F-2OE6RkDl6JKiywg-1; Wed, 22 Sep 2021 11:36:12 -0400
X-MC-Unique: npSN3F-2OE6RkDl6JKiywg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817A39126B
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 15:36:11 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-242.phx2.redhat.com [10.3.114.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B56610013C1
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 15:36:11 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] mountd: only do NFSv4 logging on supported kernels.
Date:   Wed, 22 Sep 2021 11:36:10 -0400
Message-Id: <20210922153610.60548-2-steved@redhat.com>
In-Reply-To: <20210922153610.60548-1-steved@redhat.com>
References: <20210922153610.60548-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1979816
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/export/v4clients.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/support/export/v4clients.c b/support/export/v4clients.c
index dd985463..5e4f1058 100644
--- a/support/export/v4clients.c
+++ b/support/export/v4clients.c
@@ -10,6 +10,7 @@
 #include <sys/inotify.h>
 #include <errno.h>
 #include "export.h"
+#include "version.h"
 
 /* search.h declares 'struct entry' and nfs_prot.h
  * does too.  Easiest fix is to trick search.h into
@@ -23,6 +24,8 @@ static int clients_fd = -1;
 
 void v4clients_init(void)
 {
+	if (linux_version_code() < MAKE_VERSION(5, 3, 0))
+		return;
 	if (clients_fd >= 0)
 		return;
 	clients_fd = inotify_init1(IN_NONBLOCK);
-- 
2.31.1

