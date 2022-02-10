Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CE4B12E5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbiBJQgs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 11:36:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiBJQgs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 11:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5A53C26
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644511007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwhPf12ZS4Dv/hMPMkY6fckUiE4Jg26UwiKSTI1F4Hw=;
        b=Aov2cznw2nZ6heGxNMjjhpSPaW5NzC0IcR/57az/2bOkibM1++PXVsV0BQb5PIaOMSBTvs
        NHrOv0CB6LdyBi+gkJmnQ936CCWZDrCl9ELgVN2oCdJyuHTXPLr9SaZpqxOJa9FLgATF9j
        xt6aGfQZdjFIfTy+BMqPvaU02XmpXNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-4yzAfZfvOd-lEaJwvXdWUQ-1; Thu, 10 Feb 2022 11:36:46 -0500
X-MC-Unique: 4yzAfZfvOd-lEaJwvXdWUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99A018C8C06
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 16:36:45 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83085106C0C5;
        Thu, 10 Feb 2022 16:36:45 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 133B510C30F1; Thu, 10 Feb 2022 11:36:45 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsuuid: add some example udev rules
Date:   Thu, 10 Feb 2022 11:36:45 -0500
Message-Id: <c99674bbff8508580b232c09d7a593ba1dea6959.1644510803.git.bcodding@redhat.com>
In-Reply-To: <54b6fa955bed073464243e1af6b7faf468468255.1644510803.git.bcodding@redhat.com>
References: <54b6fa955bed073464243e1af6b7faf468468255.1644510803.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Provide several variations on the use of the nfsuuid tool in a udev rule in
order to automagically uniquify NFSv4 clients.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 tools/nfsuuid/example_udev.rules | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/nfsuuid/example_udev.rules

diff --git a/tools/nfsuuid/example_udev.rules b/tools/nfsuuid/example_udev.rules
new file mode 100644
index 000000000000..31117387ac59
--- /dev/null
+++ b/tools/nfsuuid/example_udev.rules
@@ -0,0 +1,28 @@
+# This is a sample udev rules file that demonstrates how to get udev
+# to set a unique but persistent client id uniquifier for the kernel
+# NFS client.  The NFS client exposes a sysfs entry that can be used to
+# "uniquify" a client.  Values written to this entry are used to create
+# the client's identifier to distinguish a client from all other clients
+# that may claim state from a particular server.  Clients typically use
+# several sources of information to generate a client ID such as hostname,
+# and NFS version numbers, however these values may collide in certain
+# sitations.
+#
+# These examples use the `nfsuuid` helper available from nfs-utils, see
+# the man page nfsuuid(8).
+#
+# Write the default output of `nfsuuid` to /sys/fs/nfs/net/nfs_client/identifier
+# This either creates a new, random uuid or returns one previously saved:
+# KERNEL=="nfs_client", ATTR{identifier}=="(null)", PROGRAM="/usr/bin/nfsuuid", ATTR{identifier}="%c"
+#
+# Generate a new, random uuid on every boot:
+# KERNEL=="nfs_client", ATTR{identifier}=="(null)", PROGRAM="/usr/bin/nfsuuid -rf/dev/null", ATTR{identifier}="%c"
+#
+# Generate a deterministic uuid based on /etc/machine-id, or return the previously saved one:
+# KERNEL=="nfs_client", ATTR{identifier}=="(null)", PROGRAM="/usr/bin/nfsuuid machine", ATTR{identifier}="%c"
+#
+# Always use a deterministic uuid based on /etc/machine-id:
+# KERNEL=="nfs_client", ATTR{identifier}=="(null)", PROGRAM="/usr/bin/nfsuuid -r machine", ATTR{identifier}="%c"
+#
+# Generate a new, random uuid or return the one previously saved in /var/nfs/client_id:
+# KERNEL=="nfs_client", ATTR{identifier}=="(null)", PROGRAM="/usr/bin/nfsuuid -f/var/nfs/client_id", ATTR{identifier}="%c"
-- 
2.31.1

