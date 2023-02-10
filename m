Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA369169F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Feb 2023 03:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBJCRz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Feb 2023 21:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBJCRy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Feb 2023 21:17:54 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C61C5BF;
        Thu,  9 Feb 2023 18:17:50 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675995468;
        bh=rkwFmuk97XmYAP67uQy3myJltj8b8CRC14v+nyiSF8M=;
        h=From:Date:Subject:To:Cc:From;
        b=kbepRX6VAFjTPSV6Ehjbu5uc5Yl6UCD3AMQDhcEAJsQcYcnTSPpesqAK/UkLTwQbP
         j51ySsB33cPCq23SSn7fvcTtRJJ64GPOUEjeMu45U1mC5sBdT4L6LKDMB44k6psJJV
         L8DyBCeNwy7QnBRANGdXp+yCdlbkGH3qG/s9zV9k=
Date:   Fri, 10 Feb 2023 02:17:45 +0000
Subject: [PATCH] NFS: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230210-kobj_type-nfs-v1-1-5078835dbb42@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEip5WMC/x2N0QrCMAwAf2Xk2UAbGQN/RUTamrroyEYzRRn7d
 4OPd3DcBsZN2ODUbdD4LSazOsRDB2VMemeUmzNQoGOgGPA558d1/S6MWg1jX8Iw1EJ9JfAmJ2P
 MLWkZvdLXNLlcGlf5/Cfny77/AHBKitt0AAAA
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675995466; l=1401;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rkwFmuk97XmYAP67uQy3myJltj8b8CRC14v+nyiSF8M=;
 b=yGWD8rWUBw3L/Lmp/qQp6rkMsCv0GYjI21pUY98vA9bhde/fZ+yPvCQOkuqhr33mr2xGryidE
 UJLH0+d+ElyB5R9nxfeM8ECKCTER87B1CBNPUBCsYqjvfuj+HVJIe21
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/nfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 0cbcd2dfa732..791eaf42a8a1 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -31,7 +31,7 @@ static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
 	return &net_ns_type_operations;
 }
 
-static struct kobj_type nfs_netns_object_type = {
+static const struct kobj_type nfs_netns_object_type = {
 	.release = nfs_netns_object_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.child_ns_type = nfs_netns_object_child_ns_type,
@@ -144,7 +144,7 @@ static struct attribute *nfs_netns_client_attrs[] = {
 };
 ATTRIBUTE_GROUPS(nfs_netns_client);
 
-static struct kobj_type nfs_netns_client_type = {
+static const struct kobj_type nfs_netns_client_type = {
 	.release = nfs_netns_client_release,
 	.default_groups = nfs_netns_client_groups,
 	.sysfs_ops = &kobj_sysfs_ops,

---
base-commit: e544a07438522ab3688416e6e2e34bf0ee6d8755
change-id: 20230210-kobj_type-nfs-15c077fc25f2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

