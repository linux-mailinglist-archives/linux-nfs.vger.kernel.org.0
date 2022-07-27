Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A615831F3
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 20:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiG0S0d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiG0S0S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 14:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 017A85F995
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658942683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=59a68hhB40gg7/2Eee9itzx8Y4+NPHJlgSmCf/90q8g=;
        b=ME+pihdfNSzikvoDljvgqVTYjkhYhO1CvsawUyvzTHa2R+/aD+IZgV4zkD99oFD6Pa9uJ4
        j9huUGaeS3bey57G2Vu9l4rj+h/EvbO5HBjRXsGitT5LpZfRoVb0/qKdXbP/vqmlUnsQAe
        h9RHkKQ5lRSwkh/Ct99T01TXJoi2qFc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-fioBfGjqOTSWD0CKkcF2Dg-1; Wed, 27 Jul 2022 13:24:41 -0400
X-MC-Unique: fioBfGjqOTSWD0CKkcF2Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64EAB1C0336B
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 17:24:41 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5257F1121314
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 17:24:41 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc-statd.service: Stop rpcbind and rpc.stat in an exit race
Date:   Wed, 27 Jul 2022 13:24:41 -0400
Message-Id: <20220727172441.6524-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Benjamin Coddington <bcodding@redhat.com>

When `systemctl stop rpcbind.socket` is run, the dependency means
that systemd first sends SIGTERM to rpcbind, then sigterm to rpc.statd.

On SIGTERM, rpcbind tears down /var/run/rpcbind.sock.  However,
rpc-statd on SIGTERM attempts to unregister from rpcbind

systemd needs to wait for rpc.statd to exit before sending
SIGTERM to rpcbind

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2100395
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/rpc-statd.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
index 095629f2..392750da 100644
--- a/systemd/rpc-statd.service
+++ b/systemd/rpc-statd.service
@@ -5,7 +5,7 @@ Conflicts=umount.target
 Requires=nss-lookup.target rpcbind.socket
 Wants=network-online.target
 Wants=rpc-statd-notify.service
-After=network-online.target nss-lookup.target rpcbind.socket
+After=network-online.target nss-lookup.target rpcbind.service
 
 PartOf=nfs-utils.service
 IgnoreOnIsolate=yes
-- 
2.34.1

