Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4D2D64DE
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Dec 2020 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgLJSZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 13:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393077AbgLJSZr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Dec 2020 13:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607624661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DwSjVZ31M0o+MSYLUzgCwNcvAuTwKwfMLG/EPNfVm/U=;
        b=VeN5rk1wydyoI0bNrlJPVZdJJRbSkZOGYi4BiiLgdIxE9ZdFqQ91Dq+KySIzTrLiyyO02p
        k4ZvPUlYf+CMq4bXgnBUogBRLHj03QAZgV9Qd88a+9Oo9xduOgmp49L386nhFg9u3OY/6t
        6yoqLcHTj206Tb9BCMnAQ9Lk9stlw2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-U0ATLqsPMDWLBN4ZdtBE-Q-1; Thu, 10 Dec 2020 13:24:19 -0500
X-MC-Unique: U0ATLqsPMDWLBN4ZdtBE-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3420618C89DD
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 18:24:18 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-179.phx2.redhat.com [10.3.113.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E37D95D6D3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 18:24:17 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] exportfs: Ingnore export failures in nfs-server.serivce unit
Date:   Thu, 10 Dec 2020 13:24:52 -0500
Message-Id: <20201210182452.20898-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With some recent commits, exportfs will continue on trying to
export filesystems even when an entry is invalid or does
not exist, but will still have a non-zero exit to report
the error.

This situation should not stop the nfs-server service
from comingup so nfs-server.service file should
ignore these types of failures

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/nfs-server.service | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index 06c1adb..b432f91 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -21,13 +21,13 @@ After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
 [Service]
 Type=oneshot
 RemainAfterExit=yes
-ExecStartPre=/usr/sbin/exportfs -r
+ExecStartPre=-/usr/sbin/exportfs -r
 ExecStart=/usr/sbin/rpc.nfsd
 ExecStop=/usr/sbin/rpc.nfsd 0
 ExecStopPost=/usr/sbin/exportfs -au
 ExecStopPost=/usr/sbin/exportfs -f
 
-ExecReload=/usr/sbin/exportfs -r
+ExecReload=-/usr/sbin/exportfs -r
 
 [Install]
 WantedBy=multi-user.target
-- 
2.28.0

