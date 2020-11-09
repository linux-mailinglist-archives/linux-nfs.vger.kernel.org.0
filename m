Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C972AC54C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKITrA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:47:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729336AbgKITrA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604951219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e/sUsU6njVUBxVP1Ths/8wIGJ6VIw5RF5YWlZJiPyXA=;
        b=GPfQ+PVWypYNRjWLMmPXG/ajm+WJvzwBuzrQ4BsWvuhU8/6dIN6/Suac2u04/hrZ0HffTA
        FWEa7YjTWSNQinMw3Pm74DVvEqf3CnrNga9V0ZLmjrymtw2BxwTPetf2w1d4r4lad9qCcs
        +/MM+0awP3cmKI0+IOYWnd5B/4J7G18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-6sy00VzUOdSzPUNA4EOnVQ-1; Mon, 09 Nov 2020 14:46:56 -0500
X-MC-Unique: 6sy00VzUOdSzPUNA4EOnVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5D857204
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 19:46:55 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-68.phx2.redhat.com [10.3.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D35E62A14
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 19:46:55 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs-v4client.target: NFSv4 only client target.
Date:   Mon,  9 Nov 2020 14:47:00 -0500
Message-Id: <20201109194700.255314-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To allow v4 only clients, create an systemd
nfs-client target that does not "Wants" a
rpc-statd notify

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1886634
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/nfs-v4client.target | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 systemd/nfs-v4client.target

diff --git a/systemd/nfs-v4client.target b/systemd/nfs-v4client.target
new file mode 100644
index 0000000..3d1064e
--- /dev/null
+++ b/systemd/nfs-v4client.target
@@ -0,0 +1,12 @@
+[Unit]
+Description=NFS client services
+Before=remote-fs-pre.target
+Wants=remote-fs-pre.target
+
+# GSS services dependencies and ordering
+Wants=auth-rpcgss-module.service
+After=rpc-gssd.service rpc-svcgssd.service gssproxy.service
+
+[Install]
+WantedBy=multi-user.target
+WantedBy=remote-fs.target
-- 
2.26.2

